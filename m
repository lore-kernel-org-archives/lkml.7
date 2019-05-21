Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DA6C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A402173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfEUHwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:52:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45634 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfEUHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:52:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AD99C2841E1
Subject: Re: [PATCH v4 1/3] platform/chrome: cros_ec_spi: Move to real time
 priority for transfers
To:     Guenter Roeck <groeck@google.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190515164814.258898-1-dianders@chromium.org>
 <20190515164814.258898-2-dianders@chromium.org>
 <CABXOdTeCtwFSOvHbBTaSqjv0+rzfbc2mVm=PjtZgid_xRAwwtA@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <1ad86217-67b6-bb39-f4ea-ddefaa57c560@collabora.com>
Date:   Tue, 21 May 2019 09:52:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABXOdTeCtwFSOvHbBTaSqjv0+rzfbc2mVm=PjtZgid_xRAwwtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/5/19 19:02, Guenter Roeck wrote:
> On Wed, May 15, 2019 at 9:48 AM Douglas Anderson <dianders@chromium.org> wrote:
>>
>> In commit 37a186225a0c ("platform/chrome: cros_ec_spi: Transfer
>> messages at high priority") we moved transfers to a high priority
>> workqueue.  This helped make them much more reliable.
>>
>> ...but, we still saw failures.
>>
>> We were actually finding ourselves competing for time with dm-crypt
>> which also scheduled work on HIGHPRI workqueues.  While we can
>> consider reverting the change that made dm-crypt run its work at
>> HIGHPRI, the argument in commit a1b89132dc4f ("dm crypt: use
>> WQ_HIGHPRI for the IO and crypt workqueues") is somewhat compelling.
>> It does make sense for IO to be scheduled at a priority that's higher
>> than the default user priority.  It also turns out that dm-crypt isn't
>> alone in using high priority like this.  loop_prepare_queue() does
>> something similar for loopback devices.
>>
>> Looking in more detail, it can be seen that the high priority
>> workqueue isn't actually that high of a priority.  It runs at MIN_NICE
>> which is _fairly_ high priority but still below all real time
>> priority.
>>
>> Should we move cros_ec_spi to real time priority to fix our problems,
>> or is this just escalating a priority war?  I'll argue here that
>> cros_ec_spi _does_ belong at real time priority.  Specifically
>> cros_ec_spi actually needs to run quickly for correctness.  As I
>> understand this is exactly what real time priority is for.
>>
>> There currently doesn't appear to be any way to use the standard
>> workqueue APIs with a real time priority, so we'll switch over to
>> using using a kthread worker.  We'll match the priority that the SPI
>> core uses when it wants to do things on a realtime thread and just use
>> "MAX_RT_PRIO - 1".
>>
>> This commit plus the patch ("platform/chrome: cros_ec_spi: Request the
>> SPI thread be realtime") are enough to get communications very close
>> to 100% reliable (the only known problem left is when serial console
>> is turned on, which isn't something that happens in shipping devices).
>> Specifically this test case now passes (tested on rk3288-veyron-jerry):
>>
>>   dd if=/dev/zero of=/var/log/foo.txt bs=4M count=512&
>>   while true; do
>>     ectool version > /dev/null;
>>   done
>>
>> It should be noted that "/var/log" is encrypted (and goes through
>> dm-crypt) and also passes through a loopback device.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> 

Added to the for-next branch for the autobuilders to play with, if all goes well
will be queued in chrome-platform-5.3

Thanks,
 Enric
