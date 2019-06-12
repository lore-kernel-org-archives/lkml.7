Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1473FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47B9215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BOmO6lDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440106AbfFLPkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:40:16 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:34942 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437271AbfFLPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:40:15 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 42C24C01A0;
        Wed, 12 Jun 2019 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560354015; bh=pvTXvShOkDkcabUJaF7cigaaTHRjDDl6UwPsgQ3D7r0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=BOmO6lDqZD8eKQIlUCuzCYxtY+m3FpnkrcdJUjzK1olLlcfA6Kj+YfMY0N5V6QA0P
         CAZI1zCsWZJpRZ0Z40v/kqmbu70P6UtQfLPk6MvNvSwiGwneP8U8Kb+yJcudw6GBRg
         WVAjC0hpW0NgEI80wVg/Pf7XVz21/iWKEXseHTTB44JsOea8vCxKhm9p6IjZxUTr2v
         r4daaAfRNpVTukMwAo6D8mM78lkYgcvVsti1tq/bbv7g+Qis09R9Xnh350q832yYaT
         M88ck51ho5dohsERNBqg06v9hnc6ZJ39zQVIEYpbewpbxnrLLONPhxXKUnaaJiEMdS
         G6yO513UTuWIg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D962CA007B;
        Wed, 12 Jun 2019 15:40:14 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Jun 2019 08:40:14 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Jun 2019 21:10:11 +0530
Received: from [10.10.161.35] (10.10.161.35) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Jun 2019 21:10:24 +0530
Subject: Re: [PATCH] ARC: build: Try to guess CROSS_COMPILE with
 cc-cross-prefix
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.arc
References: <20190603063119.36544-1-abrodkin@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A2522AB4@us01wembx1.internal.synopsys.com>
 <CY4PR1201MB012022B3EBC7F7C2788E7B06A1140@CY4PR1201MB0120.namprd12.prod.outlook.com>
 <CAK7LNAQ-NBUuB6duaQP138Jx7y0UpgqaD=wYtRC2G_c5_H=EJg@mail.gmail.com>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 mQINBFEffBMBEADIXSn0fEQcM8GPYFZyvBrY8456hGplRnLLFimPi/BBGFA24IR+B/Vh/EFk
 B5LAyKuPEEbR3WSVB1x7TovwEErPWKmhHFbyugdCKDv7qWVj7pOB+vqycTG3i16eixB69row
 lDkZ2RQyy1i/wOtHt8Kr69V9aMOIVIlBNjx5vNOjxfOLux3C0SRl1veA8sdkoSACY3McOqJ8
 zR8q1mZDRHCfz+aNxgmVIVFN2JY29zBNOeCzNL1b6ndjU73whH/1hd9YMx2Sp149T8MBpkuQ
 cFYUPYm8Mn0dQ5PHAide+D3iKCHMupX0ux1Y6g7Ym9jhVtxq3OdUI5I5vsED7NgV9c8++baM
 7j7ext5v0l8UeulHfj4LglTaJIvwbUrCGgtyS9haKlUHbmey/af1j0sTrGxZs1ky1cTX7yeF
 nSYs12GRiVZkh/Pf3nRLkjV+kH++ZtR1GZLqwamiYZhAHjo1Vzyl50JT9EuX07/XTyq/Bx6E
 dcJWr79ZphJ+mR2HrMdvZo3VSpXEgjROpYlD4GKUApFxW6RrZkvMzuR2bqi48FThXKhFXJBd
 JiTfiO8tpXaHg/yh/V9vNQqdu7KmZIuZ0EdeZHoXe+8lxoNyQPcPSj7LcmE6gONJR8ZqAzyk
 F5voeRIy005ZmJJ3VOH3Gw6Gz49LVy7Kz72yo1IPHZJNpSV5xwARAQABtCpWaW5lZXQgR3Vw
 dGEgKGFsaWFzKSA8dmd1cHRhQHN5bm9wc3lzLmNvbT6JAj4EEwECACgCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheABQJbBYpwBQkLx0HcAAoJEGnX8d3iisJeChAQAMR2UVbJyydOv3aV
 jmqP47gVFq4Qml1weP5z6czl1I8n37bIhdW0/lV2Zll+yU1YGpMgdDTHiDqnGWi4pJeu4+c5
 xsI/VqkH6WWXpfruhDsbJ3IJQ46//jb79ogjm6VVeGlOOYxx/G/RUUXZ12+CMPQo7Bv+Jb+t
 NJnYXYMND2Dlr2TiRahFeeQo8uFbeEdJGDsSIbkOV0jzrYUAPeBwdN8N0eOB19KUgPqPAC4W
 HCg2LJ/o6/BImN7bhEFDFu7gTT0nqFVZNXlOw4UcGGpM3dq/qu8ZgRE0turY9SsjKsJYKvg4
 djAaOh7H9NJK72JOjUhXY/sMBwW5vnNwFyXCB5t4ZcNxStoxrMtyf35synJVinFy6wCzH3eJ
 XYNfFsv4gjF3l9VYmGEJeI8JG/ljYQVjsQxcrU1lf8lfARuNkleUL8Y3rtxn6eZVtAlJE8q2
 hBgu/RUj79BKnWEPFmxfKsaj8of+5wubTkP0I5tXh0akKZlVwQ3lbDdHxznejcVCwyjXBSny
 d0+qKIXX1eMh0/5sDYM06/B34rQyq9HZVVPRHdvsfwCU0s3G+5Fai02mK68okr8TECOzqZtG
 cuQmkAeegdY70Bpzfbwxo45WWQq8dSRURA7KDeY5LutMphQPIP2syqgIaiEatHgwetyVCOt6
 tf3ClCidHNaGky9KcNSQ
Message-ID: <a6bf38d6-4b0c-d83c-f62b-329b023bc1a1@synopsys.com>
Date:   Wed, 12 Jun 2019 08:40:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQ-NBUuB6duaQP138Jx7y0UpgqaD=wYtRC2G_c5_H=EJg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.35]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 4:17 AM, Masahiro Yamada wrote:
> Hi.
> 
> On Tue, Jun 4, 2019 at 2:49 AM Alexey Brodkin
> <Alexey.Brodkin@synopsys.com> wrote:
>>
>> Hi Vineet,
>>
>>> -----Original Message-----
>>> From: Vineet Gupta <vgupta@synopsys.com>
>>> Sent: Monday, June 3, 2019 7:25 PM
>>> To: Alexey Brodkin <abrodkin@synopsys.com>; linux-snps-arc@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org; Masahiro Yamada <yamada.masahiro@socionext.com>
>>> Subject: Re: [PATCH] ARC: build: Try to guess CROSS_COMPILE with cc-cross-prefix
>>>
>>> On 6/2/19 11:31 PM, Alexey Brodkin wrote:
>>>> For a long time we used to hard-code CROSS_COMPILE prefix
>>>> for ARC until it started to cause problems, so we decided to
>>>> solely rely on CROSS_COMPILE externally set by a user:
>>>> commit 40660f1fcee8 ("ARC: build: Don't set CROSS_COMPILE in arch's Makefile").
>>>>
>>>> While it works perfectly fine for build-systems where the prefix
>>>> gets defined anyways for us human beings it's quite an annoying
>>>> requirement especially given most of time the same one prefix
>>>> "arc-linux-" is all what we need.
>>>>
>>>> It looks like finally we're getting the best of both worlds:
>>>>  1. W/o cross-toolchain we still may install headers, build .dtb etc
>>>>  2. W/ cross-toolchain get the kerne built with only ARCH=arc
>>>>
>>>> Inspired by [1] & [2].
>>>>
>>>> [1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-May/005788.html
>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc2b47b55f17
>>>>
>>>> A side note: even though "cc-cross-prefix" does its job it pollutes
>>>> console with output of "which" for all the prefixes it didn't manage to find
>>>> a matching cross-compiler for like that:
>>>> | # ARCH=arc make defconfig
>>>> | which: no arceb-linux-gcc in (~/.local/bin:~/bin:/usr/bin:/usr/sbin)
>>>> | *** Default configuration is based on 'nsim_hs_defconfig'
> 
> 
> I just noticed this patch is queued on top of v5.2-rc4.
> (2bc42bfba9b247abd)
> 
> This 'side note' is no longer needed or reproducible
> because -rc4 contains my fix-up (913ab9780fc0212).

But 2bc42bfba9b247abd was to address my complaint that we need to specify
CROSS_COMPILE prefix on cmdline.

When doing the needful Alexey found the "noise" when a prefix didn't exist, which
913ab9780fc0212 address.

So these seem like orthogonal to me - that is unless I got the wired crossed somewhow.

> 
> I do not know if the ARC maitainer is happy to rebase.

I would happily do that on next rc if that is infact needed.


