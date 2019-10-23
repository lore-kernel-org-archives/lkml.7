Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698F6CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7992064B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="F8jWViMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404146AbfJWKSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:18:40 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:46992 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390958AbfJWKSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:18:40 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 293DA2E14B7;
        Wed, 23 Oct 2019 13:18:37 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id P7kym57Gho-Ia9i1lfW;
        Wed, 23 Oct 2019 13:18:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1571825917; bh=M1LPUNXuPj92nk6gO+Jq09s/UTjS5Xp9XfhjCZyU6EE=;
        h=In-Reply-To:Message-ID:Date:References:To:From:Subject:Cc;
        b=F8jWViMWY3xLplan0RJIMJxkVomFocvAsPZwV1aOX9Isibqr8Si7Oj5R3Dx6RRwgM
         N9SKJpX9r3e43ynJ1nWZb02WDihJhw/8/tHivoow1o1roe4EhWmqCHfTy+UaAMICe+
         s2IVPCDF0iUjsnh1+uG/CnwY1qj+Udvj0qnGjfAA=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d43:d63f:7907:141a])
        by iva4-c987840161f8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id znfnrCRttR-IaWC2xbJ;
        Wed, 23 Oct 2019 13:18:36 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC] time: validate watchdog clocksource using second best
 candidate
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arseny Smalyuk <smalukav@yandex-team.ru>
References: <155790645605.1933.906798561802423361.stgit@buzz>
 <alpine.DEB.2.21.1905181712000.3019@nanos.tec.linutronix.de>
 <602b155f-4108-2865-3f1c-4e63d73405ed@yandex-team.ru>
 <alpine.DEB.2.21.1905182023520.3019@nanos.tec.linutronix.de>
 <19c9be09-5d79-bdc2-ed80-88ce3b9a15a2@yandex-team.ru>
Message-ID: <6fd42b2b-e29a-1fd6-03d1-e9da9192e6c5@yandex-team.ru>
Date:   Wed, 23 Oct 2019 13:18:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <19c9be09-5d79-bdc2-ed80-88ce3b9a15a2@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2019 18.04, Konstantin Khlebnikov wrote:
> On 18.05.2019 21:26, Thomas Gleixner wrote:
>> On Sat, 18 May 2019, Konstantin Khlebnikov wrote:
>>
>>> On 18.05.2019 18:17, Thomas Gleixner wrote:
>>>> On Wed, 15 May 2019, Konstantin Khlebnikov wrote:
>>>>
>>>>> Timekeeping watchdog verifies doubtful clocksources using more reliable
>>>>> candidates. For x86 it likely verifies 'tsc' using 'hpet'. But 'hpet'
>>>>> is far from perfect too. It's better to have second opinion if possible.
>>>>>
>>>>> We're seeing sudden jumps of hpet counter to 0xffffffff:
>>>>
>>>> On which kind of hardware? A particular type of CPU or random ones?
>>>
>>> In general this is very rare event.
>>>
>>> This exact pattern have been seen ten times or so on several servers with
>>> Intel(R) Xeon(R) CPU E5-2660 v4 @ 2.00GHz
>>> (this custom built platform with chipset Intel C610)
>>>
>>> and haven't seen for previous generation
>>> Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
>>> (this is another custom built platform)
>>
>> Same chipset? Note the HPET is part of the chipset not of the CPU.
> 
> Almost the same. Intel C600.
> 
>>
>>> Link was in patch: https://lore.kernel.org/patchwork/patch/667413/
>>
>> Hmm. Not really helpful either.
>>
>>>>> This patch uses second reliable clocksource as backup for validation.
>>>>> For x86 this is usually 'acpi_pm'. If watchdog and backup are not consent
>>>>> then other clocksources will not be marked as unstable at this iteration.
>>>>
>>>> The mess you add to the watchdog code is unholy and that's broken as there
>>>> is no guarantee for acpi_pm (or any other secondary watchdog) being
>>>> available.
>>>
>>> ACPI power management timer is a pretty standard x86 hardware.
>>
>> Used to be.
>>
>>> But my patch should work for any platform with any second reliable
>>> clocksource.
>>
>> Which is close to zero if PM timer is not exposed.
>>
>>> If there is no second clocksource my patch does noting:
>>> watchdog_backup stays NULL and backup_consent always true.
>>
>> That still does not justify the extra complexity for a few custom built
>> systems.
> 
>  >
>  > Aside of that this leaves the HPET in a half broken state. HPET is not only
>  > used as a clock event device it's also exposed by HPET device. So no, if we
>  > figure out that HPET is broken on some platforms we have to blacklist and
>  > disable it completely and not just duct tape the place which exposes the
>  > wreckage.
>  >
> 
> If re-reading helps then HPET is fine.
> This is temporary failure, probably bus issue.
> 
> 
> I'll add re-reading with debug logging and try to collect more information this year.

Good news, everyone! We've found conditions when HPET counter returns '-1'.

clocksource: timekeeping watchdog on CPU21: Marking clocksource 'tsc' as unstable because the skew is too large:
clocksource:                       'hpet' wd_now: ffffffff wd_last: 40bc1ee3 mask: ffffffff
clocksource:                       'tsc' cs_now: 919b39935acdaa cs_last: 919b3957c0ec24 mask: ffffffffffffffff
clocksource: Switched to clocksource hpet

This happens when user-space does inappropriate access to directly mapped HPET.
For example dumping whole "vvar" area: memcpy(buf, addr("vvar"), 0x3000).

In our case sequence was triggered by bug in "atop" crashed at "\n" in task comm. =)

In upstream everything is fine. Direct access to HPET was sealed in 4.7 (we seen bug in 4.4)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ed95e52d902035e39a715ff3a314a893a96e5b7

Kudos to Arseny Smalyuk for (accidental) reproducing and investigation.

---

#include <stdio.h>
#include <string.h>

char tmp[0x3000];

int main() {
     void* vvar = NULL;
     FILE* fp = fopen("/proc/self/maps", "r");

     char buf[4096];
     while (fgets(buf, 4096, fp)) {
         size_t slen = strlen(buf);
         if (slen > 0 && buf[slen - 1] == '\n') {
             --slen;
         }
         if (slen > 6 && !memcmp(buf + slen - 6, "[vvar]", 6)) {
             sscanf(buf, "%p", &vvar);
             break;
         }
     }

     fclose(fp);

     memcpy(tmp, vvar, 0x3000);
     return 0;
}
