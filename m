Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CCDC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B6D20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="h1ZtvarE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731883AbfETPFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:05:03 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:36326 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730766AbfETPFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:05:03 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 8A1CD2E0DEA;
        Mon, 20 May 2019 18:04:59 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id KkTuObDBpt-4xw8k6Hn;
        Mon, 20 May 2019 18:04:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1558364699; bh=5HmOILETjzeXZbaJdi2prYfiHQR4W+XSnjSsNfqogWs=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=h1ZtvarEGyz/IiM1TOMJn785bkkxUNwA8BwDKDAbV2BjpHpaaK0z6MXuZD199xywF
         pwk4EX2If2tNGaS0SQMBF2F1MsaoafLxm0ziCqCBHJIFS12SCoeK2mYBA57XpeRqrt
         NTcVYxMawpwNFlhvjfIKs/gQjQeaxW+6GJ1Sn71Y=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:549d:5089:9cee:dbd0])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id hp0qYEXyEw-4xdig3SX;
        Mon, 20 May 2019 18:04:59 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC] time: validate watchdog clocksource using second best
 candidate
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <155790645605.1933.906798561802423361.stgit@buzz>
 <alpine.DEB.2.21.1905181712000.3019@nanos.tec.linutronix.de>
 <602b155f-4108-2865-3f1c-4e63d73405ed@yandex-team.ru>
 <alpine.DEB.2.21.1905182023520.3019@nanos.tec.linutronix.de>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <19c9be09-5d79-bdc2-ed80-88ce3b9a15a2@yandex-team.ru>
Date:   Mon, 20 May 2019 18:04:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905182023520.3019@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.2019 21:26, Thomas Gleixner wrote:
> On Sat, 18 May 2019, Konstantin Khlebnikov wrote:
> 
>> On 18.05.2019 18:17, Thomas Gleixner wrote:
>>> On Wed, 15 May 2019, Konstantin Khlebnikov wrote:
>>>
>>>> Timekeeping watchdog verifies doubtful clocksources using more reliable
>>>> candidates. For x86 it likely verifies 'tsc' using 'hpet'. But 'hpet'
>>>> is far from perfect too. It's better to have second opinion if possible.
>>>>
>>>> We're seeing sudden jumps of hpet counter to 0xffffffff:
>>>
>>> On which kind of hardware? A particular type of CPU or random ones?
>>
>> In general this is very rare event.
>>
>> This exact pattern have been seen ten times or so on several servers with
>> Intel(R) Xeon(R) CPU E5-2660 v4 @ 2.00GHz
>> (this custom built platform with chipset Intel C610)
>>
>> and haven't seen for previous generation
>> Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
>> (this is another custom built platform)
> 
> Same chipset? Note the HPET is part of the chipset not of the CPU.

Almost the same. Intel C600.

> 
>> Link was in patch: https://lore.kernel.org/patchwork/patch/667413/
> 
> Hmm. Not really helpful either.
> 
>>>> This patch uses second reliable clocksource as backup for validation.
>>>> For x86 this is usually 'acpi_pm'. If watchdog and backup are not consent
>>>> then other clocksources will not be marked as unstable at this iteration.
>>>
>>> The mess you add to the watchdog code is unholy and that's broken as there
>>> is no guarantee for acpi_pm (or any other secondary watchdog) being
>>> available.
>>
>> ACPI power management timer is a pretty standard x86 hardware.
> 
> Used to be.
> 
>> But my patch should work for any platform with any second reliable
>> clocksource.
> 
> Which is close to zero if PM timer is not exposed.
> 
>> If there is no second clocksource my patch does noting:
>> watchdog_backup stays NULL and backup_consent always true.
> 
> That still does not justify the extra complexity for a few custom built
> systems.

 >
 > Aside of that this leaves the HPET in a half broken state. HPET is not only
 > used as a clock event device it's also exposed by HPET device. So no, if we
 > figure out that HPET is broken on some platforms we have to blacklist and
 > disable it completely and not just duct tape the place which exposes the
 > wreckage.
 >

If re-reading helps then HPET is fine.
This is temporary failure, probably bus issue.


I'll add re-reading with debug logging and try to collect more information this year.
