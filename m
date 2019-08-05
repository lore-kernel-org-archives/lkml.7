Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628B2C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CEC20880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="TBYaLnvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfHEMDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:03:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42293 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfHEMDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:03:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id h18so80626496qtm.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j+OOtxkfEfsCK+bkwVyH+Wrr9sjpuA5wVJQ8qaeLaG8=;
        b=TBYaLnvGsJaDv7jiG19ScDPJmW9OgDM79TzWpDDPQxX3q+If+vRmSGDqnxgd2sC5Ma
         ndDWvheXkytYiOyfIbWbxatjvKcCOE36Nc+UhP2sshiQcUFXOlU6FFfNepLfvuxYm2Td
         63LMmv2G8tm7S1NbJ0kBJESQDmcA4TUsBtqA5M9fO5eSGImoPumUm7/WKYC1G069jjkZ
         g78Xvb+sNqn5bWJGxzmtjRfAFRA1p4dI2t9uDLRhJwziVvOWOPHzbd3l/p6goCZ5uDPU
         PEqSwsY9YVdxNJd6AArrrivHw2yl4ZnkBgrcQRsGZy6CXbJRiGFsXYgiGrdAg63tlq1l
         8Ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j+OOtxkfEfsCK+bkwVyH+Wrr9sjpuA5wVJQ8qaeLaG8=;
        b=TVC3kXgVhBNKQ0b6o3F17+L57kPVgpwWjPaZWdMK6tncQfa/mkpMeNhT6im93hDvPN
         9MH/JbsfNciYAEAUemCqIZY4NRimxxTlNqqQ8CVVaG8/jI3phy637QTWEqOAGm3/+nb6
         5fwjd+yz408Uln2c1qIwiIAfGNS0juhRCgU7GXu8REX0VUDKvqy4+VOavl52cQ9wsxTp
         XwaT5sTXLDKl4RBw0hoUfbHUeD41JW+5WWy5RFvxQAWHxiLTvOOVftaLI4/VSNjUlyl7
         DwrXZzHT6cqatZhzfsFQ7qnQHN8+lECPNPMdem2SSdAlXgoCev9MtKYaNCba/WrMIjLr
         w00w==
X-Gm-Message-State: APjAAAW0aARqy0ComeCnEG8Y/BNJ9BtoxMb+Ahd07e0pXvgYmf86dagq
        yEWAisoxXm0F/o5xb2+Z6NdP3A==
X-Google-Smtp-Source: APXvYqzOSVBcFDIV7CsRZVixng9NNq7mvrlLrDMHbhCcQyx4q4EUHo6mZMgAFcCFJO3IxGNBqrcpWA==
X-Received: by 2002:ac8:1195:: with SMTP id d21mr70621555qtj.278.1565006591714;
        Mon, 05 Aug 2019 05:03:11 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z18sm34006404qki.110.2019.08.05.05.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 05:03:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] arm64/prefetch: fix a -Wtype-limits warning
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190805100059.4gml6c4kclz2iin3@willie-the-truck>
Date:   Mon, 5 Aug 2019 08:03:10 -0400
Cc:     Catalin Marinas <catalin.marinas@arm.com>, rrichter@cavium.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BDD11CC0-DC23-4D3A-B9EB-9A985EC53A30@lca.pw>
References: <20190803003358.992-1-cai@lca.pw>
 <20190805100059.4gml6c4kclz2iin3@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 5, 2019, at 6:00 AM, Will Deacon <will@kernel.org> wrote:
>=20
> On Fri, Aug 02, 2019 at 08:33:58PM -0400, Qian Cai wrote:
>> The commit d5370f754875 ("arm64: prefetch: add alternative pattern =
for
>> CPUs without a prefetcher") introduced MIDR_IS_CPU_MODEL_RANGE() to =
be
>> used in has_no_hw_prefetch() with rv_min=3D0 which generates a =
compilation
>> warning from GCC,
>>=20
>> In file included from ./arch/arm64/include/asm/cache.h:8,
>>                from ./include/linux/cache.h:6,
>>                from ./include/linux/printk.h:9,
>>                from ./include/linux/kernel.h:15,
>>                from ./include/linux/cpumask.h:10,
>>                from arch/arm64/kernel/cpufeature.c:11:
>> arch/arm64/kernel/cpufeature.c: In function 'has_no_hw_prefetch':
>> ./arch/arm64/include/asm/cputype.h:59:26: warning: comparison of
>> unsigned expression >=3D 0 is always true [-Wtype-limits]
>> _model =3D=3D (model) && rv >=3D (rv_min) && rv <=3D (rv_max);  \
>>                         ^~
>> arch/arm64/kernel/cpufeature.c:889:9: note: in expansion of macro
>> 'MIDR_IS_CPU_MODEL_RANGE'
>> return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX,
>>        ^~~~~~~~~~~~~~~~~~~~~~~
>>=20
>> Fix it by making "rv" a "s32".
>>=20
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>>=20
>> v2: Use "s32" for "rv", so "variant 0/revision 0" can be covered.
>>=20
>> arch/arm64/include/asm/cputype.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm64/include/asm/cputype.h =
b/arch/arm64/include/asm/cputype.h
>> index e7d46631cc42..d52fe8651c2d 100644
>> --- a/arch/arm64/include/asm/cputype.h
>> +++ b/arch/arm64/include/asm/cputype.h
>> @@ -54,7 +54,7 @@
>> #define MIDR_IS_CPU_MODEL_RANGE(midr, model, rv_min, rv_max)		=
\
>> ({									=
\
>> 	u32 _model =3D (midr) & MIDR_CPU_MODEL_MASK;			=
\
>> -	u32 rv =3D (midr) & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);	=
\
>> +	s32 rv =3D (midr) & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);	=
\
>=20
> Hmm, but this really isn't a signed quantity: it's two fields =
extracted
> from an ID register. I think the code is fine. Are you explicitly =
enabling
> -Wtype-limits somehow?

Yes, it is useful to catch unintended developer mistakes or simply =
optimize wasted instructions of
checking like in,

919aef44d73d (=E2=80=9Cx86/efi: fix a -Wtype-limits compilation =
warning=E2=80=9D)

5a82bdb48f04 (=E2=80=9Cx86/cacheinfo: Fix a -Wtype-limits warning=E2=80=9D=
)

It is normal to fix a false positive this way as in other mainline =
commits,

ec6335586953 (=E2=80=9Cx86/apic: Silence -Wtype-limits compiler =
warnings=E2=80=9D)

Once those false-positives are under control, the warning flag could be =
then enabled by default in
the future.

