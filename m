Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1443BC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 17:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0BE2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 17:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="p/A5osod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfERRxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 13:53:32 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:41412 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728337AbfERRxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 13:53:32 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 0404F2E0A08;
        Sat, 18 May 2019 20:53:29 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 54vWVqcd4G-rS0mMCtj;
        Sat, 18 May 2019 20:53:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1558202008; bh=2Na3aZIHWPhYafymUlsMXFaNb8PBXDNnOv14maVCKog=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=p/A5osodo5llEGV2/QwvoFAIbzLD1sn0bC/xzasjVPvdfmuurmertOZsrR7Uju/EA
         jGXGOYY1+XHBcUn/Y37RbeLVpCsHgCOK4yD4sAud4tlFtFhGpSOHn58GutXpDRsfe5
         VKFsFkWhNMPQ/zRJpYwDApF0RBRPhzFAvH+hWToc=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:0:3713::1:8])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id kQqN4rdwLk-rSdamr3E;
        Sat, 18 May 2019 20:53:28 +0300
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
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <602b155f-4108-2865-3f1c-4e63d73405ed@yandex-team.ru>
Date:   Sat, 18 May 2019 20:53:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905181712000.3019@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.2019 18:17, Thomas Gleixner wrote:
> On Wed, 15 May 2019, Konstantin Khlebnikov wrote:
> 
>> Timekeeping watchdog verifies doubtful clocksources using more reliable
>> candidates. For x86 it likely verifies 'tsc' using 'hpet'. But 'hpet'
>> is far from perfect too. It's better to have second opinion if possible.
>>
>> We're seeing sudden jumps of hpet counter to 0xffffffff:
> 
> On which kind of hardware? A particular type of CPU or random ones?

In general this is very rare event.

This exact pattern have been seen ten times or so on several servers with
Intel(R) Xeon(R) CPU E5-2660 v4 @ 2.00GHz
(this custom built platform with chipset Intel C610)

and haven't seen for previous generation
Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
(this is another custom built platform)

So, this might be not related to cpu model.

> 
>> timekeeping watchdog on CPU56: Marking clocksource 'tsc' as unstable because the skew is too large:
>> 'hpet' wd_now: ffffffff wd_last: 19ec5720 mask: ffffffff
>> 'tsc' cs_now: 69b8a15f0aed cs_last: 69b862c9947d mask: ffffffffffffffff
>>
>> Shaohua Li reported the same case three years ago.
>> His patch backlisted this exact value and re-read hpet counter.
> 
> Can you provide a reference please? Preferrably a lore.kernel.org/... URL

Link was in patch: https://lore.kernel.org/patchwork/patch/667413/

> 
>> This patch uses second reliable clocksource as backup for validation.
>> For x86 this is usually 'acpi_pm'. If watchdog and backup are not consent
>> then other clocksources will not be marked as unstable at this iteration.
> 
> The mess you add to the watchdog code is unholy and that's broken as there
> is no guarantee for acpi_pm (or any other secondary watchdog) being
> available.

ACPI power management timer is a pretty standard x86 hardware.
But my patch should work for any platform with any second reliable clocksource.

If there is no second clocksource my patch does noting:
watchdog_backup stays NULL and backup_consent always true.

> 
> If the only wreckaged value is always ffffffff then I rather reread the
> hpet in that case. But not in the watchdog code, we need to do that in the
> HPET code as this affects any other HPET user as well.
> 
> Thanks,
> 
> 	tglx
> 
