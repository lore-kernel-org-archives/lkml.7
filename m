Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D081C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10032064A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfDDPAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:00:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59010 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfDDPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:00:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D0C8D265A8A
Subject: Re: [PATCH v3] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
To:     Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Randall Spangler <rspangler@chromium.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190403203137.203582-1-dianders@chromium.org>
 <20190403210436.GS112750@google.com>
 <CAD=FV=Whd4upxDDOrmVt=HgjEiGNuL2FccOfezpAFsy5yB55JA@mail.gmail.com>
 <20190403211943.GT112750@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <b54ef6c0-512a-19ff-e4f3-6963dfe9e8bd@collabora.com>
Date:   Thu, 4 Apr 2019 17:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190403211943.GT112750@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thanks for sending this patch upstream.

On 3/4/19 23:19, Matthias Kaehlcke wrote:
> On Wed, Apr 03, 2019 at 02:08:40PM -0700, Doug Anderson wrote:
>> Hi,
>>
>> On Wed, Apr 3, 2019 at 2:04 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>>>> +static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
>>>
>>> nit: the fact that a high priority workqueue is used is an
>>> implementation detail, since the driver has no function to perform a
>>> transfer with 'normal'/low priority there is no need to distinguish
>>> between the two cases. In this sense I'd be inclined to remove the
>>> 'high_pri' from the function names.
>>>
>>> Sorry for not mentioning this earlier, I focussed on other
>>> details, anyway it's just a nit.
>>
>> I still kinda like having the "high_pri" in there since the point of
>> this function is to transfer the work onto the high priority
>> workqueue.  It's not an exported function so having the implementation
>> detail leak into the name isn't a bad thing, is it?
> 
> IMO the long name with details mostly irrelevant to the caller (they
> want to do a 'normal' transfer, the function should do the right thing
> to get that done) is more distracting than helpful. But yeah, this is
> definitely 'nit/bikeshed' territory ;-)
> 
>> ...so unless someone else thinks the name should change or you feel
>> strongly about it I won't plan to change the name.
> 
> no strong feelings on my side, just wanted to mention it.
> 

Tested on veyron-jaq, veyron-minnie and peach-pi (well with peach-pi I didn't
reproduce the issue but at least I know doesn't breaks anything)

I'll add this patch to the chrome-platform for-next branch for the auto-builders
to play with and launch some few more automated tests. If all goes well I'll
queue this patch to chrome-platform-5.2.

Thanks,
 Enric
