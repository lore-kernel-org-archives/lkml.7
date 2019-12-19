Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6431EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7E5222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="zvB2lCZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLSGzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:55:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44490 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfLSGzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:55:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so4774389wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 22:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4frcXPE7kM7xRryyvIHRVLemANbFnBo0wH9ezz/ZFmY=;
        b=zvB2lCZyj1NChC1MxfsZhHaATJiuMNQ5+778PFst5skVIxOK5XT7tAAeP0sP7A03/M
         rZd8YIwH21dApPsd0vdmqrsFNilohwMaOzNc6vjZZ89Vb1ka9nML0uU7JINmmwrNadbI
         rGlxPDvZQngLDhcCJOV9i5Hfft0lYn2avY9mb6nEW6PHVnioNGYemGDngL/zRemX78Tf
         foM/r3wu7pDNNArTEkOFUncGT6/7sbZuZvvQScHCSsYaApCpgN8/wE4e22+iYqM9o7BV
         7ix2XBA+OHU9zthE8F9ArKkjJsu7ALDjGFayiPp8iFD+XG7L1GSaktxO0quGhuDUaJz9
         8DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4frcXPE7kM7xRryyvIHRVLemANbFnBo0wH9ezz/ZFmY=;
        b=X0rpWu0HnmlNjSoK4/myH5dPsrn9H4KU1E6Rt8f5/UGCLn7GAyIP59CnW/DyNwv9t3
         +sKLqbeCF8Ne6DmeMng405K2F9I8rI8xRB2E9Wwljtts6KS9okas12QU8idTnRs1Td0x
         7s21dyWmlEsLZD4KNvquvv4x97CTUqj/sFBLqQmsBkT7iWuq1ZfqGkO1ORUYMicrT+5q
         qfeWo5io7goAL/SShKZIuYkH4Mso897PhHoOyhSsbHxrYRuxL4cj8t0OcZ7kiSh0oF0H
         S0GHyUSMCf8Vj+/LPp4ypxbVwBz4E1tyXf6De2weB2Cq++ZK9M9MH1ZcjZRYY6D1cgYE
         HUsg==
X-Gm-Message-State: APjAAAUH+ccUQARUPZB/acLC7Y5EgDVKRL55+thj4HCCuoXZZd58SR8E
        EO65Salitwu+GLXb4DBzgmls+Tti1UwpDjlg6pnKDg==
X-Google-Smtp-Source: APXvYqxTwfrl/KntorZw5YmG2v3v1ZZUz7rSdH9YRwTxTtcicDtegULMqsWzYh2MeZ1M2PwB6zTx9PBjb5oUVmXKDRE=
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr7253204wrn.251.1576738548456;
 Wed, 18 Dec 2019 22:55:48 -0800 (PST)
MIME-Version: 1.0
References: <20191218213918.16676-1-atish.patra@wdc.com> <20191218213918.16676-4-atish.patra@wdc.com>
In-Reply-To: <20191218213918.16676-4-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 19 Dec 2019 12:25:36 +0530
Message-ID: <CAAhSdy2BAcaV1tcSFiJnwX5bggAD2FcLvUg-VrxtPP2KqU3cMw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] RISC-V: Add SBI v0.2 extension definitions
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 3:09 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Few v0.1 SBI calls are being replaced by new SBI calls that follows
> v0.2 calling convention.
>
> This patch just defines these new extensions.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 1aeb4bb7baa8..9612133213ba 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -21,6 +21,9 @@ enum sbi_ext_id {
>         SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
>         SBI_EXT_0_1_SHUTDOWN = 0x8,
>         SBI_EXT_BASE = 0x10,
> +       SBI_EXT_TIME = 0x54494D45,
> +       SBI_EXT_IPI = 0x735049,
> +       SBI_EXT_RFENCE = 0x52464E43,
>  };
>
>  enum sbi_ext_base_fid {
> @@ -33,6 +36,24 @@ enum sbi_ext_base_fid {
>         SBI_EXT_BASE_GET_MIMPID,
>  };
>
> +enum sbi_ext_time_fid {
> +       SBI_EXT_TIME_SET_TIMER = 0,
> +};
> +
> +enum sbi_ext_ipi_fid {
> +       SBI_EXT_IPI_SEND_IPI = 0,
> +};
> +
> +enum sbi_ext_rfence_fid {
> +       SBI_EXT_RFENCE_REMOTE_FENCE_I = 0,
> +       SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> +       SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> +       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> +       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
> +       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> +       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> --
> 2.24.0
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
