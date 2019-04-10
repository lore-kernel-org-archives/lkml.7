Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719D4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4908F20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbfDJOJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:09:08 -0400
Received: from ns.iliad.fr ([212.27.33.1]:58866 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731448AbfDJOJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:09:07 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id CBDCD20777;
        Wed, 10 Apr 2019 16:09:05 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id B3061202B9;
        Wed, 10 Apr 2019 16:09:05 +0200 (CEST)
Subject: Re: [PATCH 23/23] watchdog: tangox_wdt: Convert to use device managed
 functions and other improvements
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mans Rullgard <mans@mansr.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
 <1554830641-9247-24-git-send-email-linux@roeck-us.net>
 <6ebee4d6-c650-c322-a966-4269d54da9be@free.fr>
 <c875ddd9-13f4-c6d4-4537-21b80000b9b5@roeck-us.net>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <6f8ec860-42ff-d33a-9a58-626d2fa4e7c8@free.fr>
Date:   Wed, 10 Apr 2019 16:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c875ddd9-13f4-c6d4-4537-21b80000b9b5@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Apr 10 16:09:05 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2019 15:37, Guenter Roeck wrote:

> On 4/10/19 6:04 AM, Marc Gonzalez wrote:
>
>> On 09/04/2019 19:24, Guenter Roeck wrote:
>>
>>> Use device managed functions to simplify error handling, reduce
>>> source code size, improve readability, and reduce the likelihood of bugs.
>>> Other improvements as listed below.
>>>
>>> The conversion was done automatically with coccinelle using the
>>> following semantic patches. The semantic patches and the scripts
>>> used to generate this commit log are available at
>>> https://github.com/groeck/coccinelle-patches
>>>
>>> - Drop assignments to otherwise unused variables
>>> - Drop unnecessary braces around conditional return statements
>>> - Drop empty remove function
>>> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
>>> - Replace stop on remove with call to watchdog_stop_on_unregister()
>>> - Use devm_watchdog_register_driver() to register watchdog device
>>
>> No devm_clk_prepare() in mainline? :-(
>>
>> https://lore.kernel.org/patchwork/patch/755487/
> 
> We went through that several times and never succeeded. This was the major
> reason why I didn't submit this series earlier since I was hoping for it
> to appear at some point. Unfortunately, someone always objected, typically
> with comments along the line that it could be misused, or citing individual
> examples where the current code in some driver is wrong and should be fixed
> instead.
> 
> This isn't really a technical argument: Everything can be misused, and all
> code has bugs. Neither is a reason to reject a new useful API. As such, one
> has to assume that after refuting such arguments, and even after fixing all
> bugs in existing code, the opponents of the new API will come up with other
> reasons to reject it.
> 
> At the end, I gave up trying. Feel free to try yourself; I most definitely
> won't try it anymore. Using devm_add_action_or_reset() is a bit more clumsy,
> but works just as well.

Hello Guenter,

I am saddened to read about your frustration. I might give it a try, if Dmitry
doesn't feel like giving it another shot.

Regards.
