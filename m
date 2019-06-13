Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB931C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F500208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390775AbfFMQEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:04:53 -0400
Received: from ns.iliad.fr ([212.27.33.1]:42792 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390588AbfFMQEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:04:43 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 6CBC320AC3;
        Thu, 13 Jun 2019 18:04:42 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id ED4C220514;
        Thu, 13 Jun 2019 18:04:41 +0200 (CEST)
Subject: Re: [PATCH v1] iopoll: Tweak readx_poll_timeout sleep range
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
References: <c2e6af51-5676-3715-6666-c3f18df7b992@free.fr>
 <CAK8P3a1_WvHYW243MR5-NdFm3cSt+cVGM5EJmOM8uiQMQ3vQjQ@mail.gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <a732f522-5e65-3ac4-de04-802ef5455747@free.fr>
Date:   Thu, 13 Jun 2019 18:04:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1_WvHYW243MR5-NdFm3cSt+cVGM5EJmOM8uiQMQ3vQjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jun 13 18:04:42 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2019 14:42, Arnd Bergmann wrote:

> On Thu, Jun 13, 2019 at 2:16 PM Marc Gonzalez wrote:
>
>> Chopping max delay in 4 seems excessive. Let's just cut it in half.
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> ---
>> When max_us=100, old_min was 26 us; new_min would be 50 us
>> Was there a good reason for the 1/4th?
>> Is new_min=0 a problem? (for max=1)
> 
> You normally want a large enough range between min and max. I don't
> see anything wrong with a factor of four.

Hmmm, I expect the typical use-case to be:
"HW manual states operation X completes in 100 µs.
Let's call usleep_range(100, foo); before hitting the reg."

And foo needs to be a "reasonable" value: big enough to be able
to merge several requests, low enough not to wait too long after
the HW is ready.

In this case, I'd say usleep_range(100, 200); makes sense.

Come to think of it, I'm not sure min=26 (or min=50) makes sense...
Why wait *less* than what the user specified?

>> @@ -47,7 +47,7 @@
>>                         break; \
>>                 } \
>>                 if (__sleep_us) \
>> -                       usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
>> +                       usleep_range(__sleep_us / 2, __sleep_us); \
>>         } \
> 
> You are also missing the '+1' now, so this breaks with __sleep_us=1.

It was on purpose.

usleep_range(0, 1); is not well-defined?
(I tried looking at the source, got lost down the rabbit hole.)

Regards.
