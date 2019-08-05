Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC9C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0292720856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RqwbRbC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfHELrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:47:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40188 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHELrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:47:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so59790859qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f6szPwFxDbpw2ZKmmxnSTt1g2JfUNMH6l68GeeOqbeA=;
        b=RqwbRbC7E5abtgOFsm6t0AUynjZ5rcKHbVCBlFTqcoqhjs1n6baAcFt2AY6zQmZ1+t
         7SMSJNHRsENlBL6IBLyyFYpT4K7w3+NQ/KEaZE5Hy8X+Be2g5XWIxgB1NBdVfnWiSNkQ
         4CyWvaVZ8LtJQ4E9KuXtr3NTmQdEgJ9eZFCPaO3vfkwHe+utjx/SZdzrEF6yGr1fyYrg
         hrCP23mOcWm8Z52VVAnpVGmAbugX7ng3H9nSnlKe9NaukWZGsP6lb3glRR+gvOrHhzQI
         ivuMQr1uNox+6GlUM5NVIqdUd7mMaVkYc/fH+ngflkjr2r2TRA4Xp1u/TXQVcNX0jFhS
         f+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f6szPwFxDbpw2ZKmmxnSTt1g2JfUNMH6l68GeeOqbeA=;
        b=ohhlBDNn5nq23a4D131B2d/DW7exXFerfIj177SZ2SV5e/ouf3ZPHRxGziraQSr/1v
         4vuVWnVNgonbe15j9WhSR/xKUjK3t8JWNOHczVf801alzMb2VdqMVOR2U/sUVXLSiJ+A
         qyXlO0k5wBujOErXUmLwcb5q4ptbnrIeRt3h3AsbKRQbpGW9RI+1lxRATJZzle5rKskD
         osPOAcGo2BucMWzl13GIhYnkpy5Ow7J3KFLMGwPxzFZocTusRWSF2cKhIGPvvCsfAYhw
         AI8RrBnnknh5yZUtNJ2DvP/lEZqtdrHq9Lgx49LCHNcjtXNVhTOv61TAclI3F4H9S5s+
         e/iw==
X-Gm-Message-State: APjAAAVD4gQlaQxbjCt1cHvTIjKlfXrhwimc54iuulWCKEJkv5fxVCyP
        AkJp3BMbJWOWcTkZ84VVAIiKsg==
X-Google-Smtp-Source: APXvYqxBgJKy9z+rqeTuFeh91T3hyxcm65GKukJYybRFBiubRkqGyQNhtog1NgVCEZqmvJ2S7OX4yg==
X-Received: by 2002:a05:620a:1537:: with SMTP id n23mr95501333qkk.441.1565005658834;
        Mon, 05 Aug 2019 04:47:38 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z4sm40873036qtd.60.2019.08.05.04.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 04:47:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] arm64/cache: fix -Woverride-init compiler warnings
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190805095256.ocgdb2yfhnbdz6kw@willie-the-truck>
Date:   Mon, 5 Aug 2019 07:47:37 -0400
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <771C4B4C-6D79-419D-9778-5DE1BFC67FBE@lca.pw>
References: <1564759944-2197-1-git-send-email-cai@lca.pw>
 <20190805095256.ocgdb2yfhnbdz6kw@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 5, 2019, at 5:52 AM, Will Deacon <will@kernel.org> wrote:
>=20
> On Fri, Aug 02, 2019 at 11:32:24AM -0400, Qian Cai wrote:
>> The commit 155433cb365e ("arm64: cache: Remove support for =
ASID-tagged
>> VIVT I-caches") introduced some compiation warnings from GCC,
>>=20
>> arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
>> overwritten [-Woverride-init]
>>  [ICACHE_POLICY_VIPT]  =3D "VIPT",
>>                          ^~~~~~
>> arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
>> 'icache_policy_str[2]')
>> arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
>> overwritten [-Woverride-init]
>>  [ICACHE_POLICY_PIPT]  =3D "PIPT",
>>                          ^~~~~~
>> arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
>> 'icache_policy_str[3]')
>> arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
>> overwritten [-Woverride-init]
>>  [ICACHE_POLICY_VPIPT]  =3D "VPIPT",
>>                           ^~~~~~~
>> arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
>> 'icache_policy_str[0]')
>>=20
>> because it initializes icache_policy_str[0 ... 3] twice.
>>=20
>> Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged =
VIVT I-caches")
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>> arch/arm64/kernel/cpuinfo.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/arm64/kernel/cpuinfo.c =
b/arch/arm64/kernel/cpuinfo.c
>> index 876055e37352..193b38da8d96 100644
>> --- a/arch/arm64/kernel/cpuinfo.c
>> +++ b/arch/arm64/kernel/cpuinfo.c
>> @@ -34,10 +34,10 @@
>> static struct cpuinfo_arm64 boot_cpu_data;
>>=20
>> static char *icache_policy_str[] =3D {
>> -	[0 ... ICACHE_POLICY_PIPT]	=3D "RESERVED/UNKNOWN",
>> +	[ICACHE_POLICY_VPIPT]		=3D "VPIPT",
>> +	[ICACHE_POLICY_VPIPT + 1]	=3D "RESERVED/UNKNOWN",
>> 	[ICACHE_POLICY_VIPT]		=3D "VIPT",
>> 	[ICACHE_POLICY_PIPT]		=3D "PIPT",
>> -	[ICACHE_POLICY_VPIPT]		=3D "VPIPT",
>=20
> I really don't like this patch. Using "[0 ... MAXIDX] =3D <default>" =
is a
> useful idiom and I think the code is more error-prone the way you have
> restructured it.
>=20
> Why are you passing -Woverride-init to the compiler anyway? There's =
only
> one Makefile that references that option, and it's specific to a =
pinctrl
> driver.

Those extra warnings can be enabled by =E2=80=9Cmake W=3D1=E2=80=9D. =
=E2=80=9C-Woverride-init =E2=80=9C seems to be useful
to catch potential developer mistakes with unintented =
double-initializations. It is normal to
start to fix the most of false-positives first before globally enabling =
the flag by default just like
=E2=80=9C-Wimplicit-fallthrough=E2=80=9D mentioned in,

https://lwn.net/Articles/794944/

