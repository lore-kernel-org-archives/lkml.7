Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F404CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B3520842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BfBvPqT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHLPg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:36:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46437 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLPg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:36:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so41901653otk.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SpVDrjvk0esyF9nfi14Gtm3oms4DcxHW/Qvgatp0oR0=;
        b=BfBvPqT1d5Tmm728CwJnqdt1AuAqlPYluJ26znILoC3rHojNwJJi63xaK77vqBnwY0
         jC4hczUEyNpbGRmlYm3O7RHbxJ+HQmPFjnGIiHu9/DRnBWVhV0zuIUoZfYWv/meg6OTu
         6zQamXD5eI3R/N1ZwTV/J8GEDVsbnCwMuMqkNcZE7aWFMu7I1MwCGZASh8Ojv53mSMhS
         DHVCWaNWvYJd4GJ2uKcpe5rtMSHZyoaVwAJuybJ1/inGLETiGCOb6xi6965XpbLncq5b
         Kvf+tfOL7HLl2WT7NdjsuqlR0n+p1XPxYSK4jnadNN4ddU5zu/yWjwl7Pa5COcAYGemB
         JYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SpVDrjvk0esyF9nfi14Gtm3oms4DcxHW/Qvgatp0oR0=;
        b=ZCB8+2aU0zIiWucbr4Dlym+OoyjiYV77ENeUNl4b9z9QfVVE+ULYx6fZve8aEXQx/X
         kRLSo1oHDOGTb2m0BKIhHSL7+YDfAdRgNovTWc9lMf+uWBRtHNL8CUZxE2DotlMszGU1
         ei+sQSPo977tIYcNCm/TIAyr7Bt6QvFxAVsh1faTrCMA1qnd01BqSnf2fhPyT2vjfX6p
         ArZVNPjtm9z6x9rZJvtCYgU8HY5tBxQJpTR3vqoqQaECTjZ8CkiCOr18Ybx+bWySmWwL
         45qMT29+mxJfaLXFSV0tws5fz4fF27MHHvD/q3wGVdsOX0bW/abLm18ZPvFjKb5KZuM8
         d5GQ==
X-Gm-Message-State: APjAAAU0AVrUTcuEF92qXtr8KBgm2wF1a+lhZRqVCJH+WZzqPvZgMuTz
        7BDuEs9ZAl15IGnL9KJSrPQMbZct61k=
X-Google-Smtp-Source: APXvYqwvupGumFy7/McNZbWws2KK2uLWsFlbx7JImUAvZ/mtHsjUtks/0Vo5Bkkt2LcKvn/BSXX+EA==
X-Received: by 2002:a05:6638:637:: with SMTP id h23mr20742737jar.59.1565624187149;
        Mon, 12 Aug 2019 08:36:27 -0700 (PDT)
Received: from [192.168.1.138] ([216.160.37.230])
        by smtp.gmail.com with ESMTPSA id f1sm10078047ioh.73.2019.08.12.08.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 08:36:26 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <20190810014309.20838-1-atish.patra@wdc.com>
Date:   Mon, 12 Aug 2019 10:36:25 -0500
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Allison Randal <allison@lohutok.net>,
        ron minnich <rminnich@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <118B0DE7-EDCC-4947-88E5-7FF133A757D8@sifive.com>
References: <20190810014309.20838-1-atish.patra@wdc.com>
To:     Atish Patra <atish.patra@wdc.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 9, 2019, at 8:43 PM, Atish Patra <atish.patra@wdc.com> wrote:
>=20
> In RISC-V, tlb flush happens via SBI which is expensive.
> If the target cpumask contains a local hartid, some cost
> can be saved by issuing a local tlb flush as we do that
> in OpenSBI anyways.

Is there anything other than convention and current usage that prevents
the kernel from natively handling TLB flushes without ever making the =
SBI
call?

Someone is eventually going to want to run the linux kernel in machine =
mode,
likely for performance and/or security reasons, and this will require =
flushing TLBs
natively anyway.


>=20
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
> arch/riscv/include/asm/tlbflush.h | 33 +++++++++++++++++++++++++++----
> 1 file changed, 29 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/tlbflush.h =
b/arch/riscv/include/asm/tlbflush.h
> index 687dd19735a7..b32ba4fa5888 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -8,6 +8,7 @@
> #define _ASM_RISCV_TLBFLUSH_H
>=20
> #include <linux/mm_types.h>
> +#include <linux/sched.h>
> #include <asm/smp.h>
>=20
> /*
> @@ -46,14 +47,38 @@ static inline void remote_sfence_vma(struct =
cpumask *cmask, unsigned long start,
> 				     unsigned long size)
> {
> 	struct cpumask hmask;
> +	struct cpumask tmask;
> +	int cpuid =3D smp_processor_id();
>=20
> 	cpumask_clear(&hmask);
> -	riscv_cpuid_to_hartid_mask(cmask, &hmask);
> -	sbi_remote_sfence_vma(hmask.bits, start, size);
> +	cpumask_clear(&tmask);
> +
> +	if (cmask)
> +		cpumask_copy(&tmask, cmask);
> +	else
> +		cpumask_copy(&tmask, cpu_online_mask);
> +
> +	if (cpumask_test_cpu(cpuid, &tmask)) {
> +		/* Save trap cost by issuing a local tlb flush here */
> +		if ((start =3D=3D 0 && size =3D=3D -1) || (size > =
PAGE_SIZE))
> +			local_flush_tlb_all();
> +		else if (size =3D=3D PAGE_SIZE)
> +			local_flush_tlb_page(start);
> +		cpumask_clear_cpu(cpuid, &tmask);
> +	} else if (cpumask_empty(&tmask)) {
> +		/* cpumask is empty. So just do a local flush */
> +		local_flush_tlb_all();
> +		return;
> +	}
> +
> +	if (!cpumask_empty(&tmask)) {
> +		riscv_cpuid_to_hartid_mask(&tmask, &hmask);
> +		sbi_remote_sfence_vma(hmask.bits, start, size);
> +	}
> }
>=20
> -#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
> -#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
> +#define flush_tlb_all() remote_sfence_vma(NULL, 0, -1)
> +#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, (addr) + =
PAGE_SIZE)
> #define flush_tlb_range(vma, start, end) \
> 	remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - =
(start))
> #define flush_tlb_mm(mm) \
> --=20
> 2.21.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

