Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2505CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D6A222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="iVxQpCnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395211AbfJRF3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:29:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44296 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393371AbfJRF3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:29:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so4722353wrl.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1L7f/uGvROZCVtz1Hvo5nsOEYV/tzFdc7Jvsq90u0ec=;
        b=iVxQpCnYqNXc4Cij1up0Y1wu0M6UegLV1122D9YlF8s9T2CDAYVt1sC9yaAZtO+IXa
         2DQxUapTjWzwHwSN/u70Xw8pbrnPcLYlice8p0PbOlMUIVXKl7eCZJxosYm8gz/41SyY
         qRKUtYfv9DTZHhE/hjTH3xJl6jWx3RjDZYlKHdPCy0/FJYmnmMq5YSOdultPUTvZuF+2
         2l3Y9KB4MrVL3Mgp+wy3fbOPNqGQt0/UiTyJdKQYs1yNC2PbeTXLOTK59Pkgou1rtR2d
         tBBjbvQmRJxtcj6wp52J2zr1QHOqrbSfOua8Ivs6yTu+iYgTKsn0NUstWAz/qysDqT/G
         KUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1L7f/uGvROZCVtz1Hvo5nsOEYV/tzFdc7Jvsq90u0ec=;
        b=U0d2D51ivrhGXO9+uyAdtEu3yoJQ2f/Wkjo7IYuGE+XlF7o48oCe/aWLd4gLBdeavM
         N/SCu92JwIvsvmsWq39VH4ZsWzotR2wyg4MHLo2tafnk0P/ljGVrdNc7RzYMobvF9Fkm
         U+7bY6noP/efmz3OAYcSxwts69756jDMYN1wHJirX8VV5tE6mCNGNZfn7o73z7erQ7vu
         xSlD/vkZCqciQU0PauMVWhXz5xaXqy98dyXCWnlFnc5m1GIjOEGvpJlxG+EfPMwx8lIj
         Wsp6pLvJ9CqxM0S8vFY4rwouBlRnQC/jkwex8sUG8cRw9JZ912w6ZxoIqPc4nYTjnjPj
         x+aw==
X-Gm-Message-State: APjAAAUzZWihTBrEbU0XBRV+z7GzB3AaYB0S0Ymlza2qfuwlKW850Sqo
        fHPwOxiBkzDMTs91ZFrDdiVQRxi5JRnXD5qG5427tY6p9Bg=
X-Google-Smtp-Source: APXvYqxzmddrHUI9HqFZ9O/ss44G8uvOHzcgCjU4n2xlXZo3KwPjpnG8lAZNMu2zdDfMWUcl2LR7kj0WtZ4S9n7osVQ=
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr5350499wrr.251.1571367672210;
 Thu, 17 Oct 2019 20:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-11-hch@lst.de>
In-Reply-To: <20191017173743.5430-11-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:31:01 +0530
Message-ID: <CAAhSdy2Sb+aizuNtKvindH1yowey-_uvJw9jGf=QGAgPMJsDWw@mail.gmail.com>
Subject: Re: [PATCH 10/15] riscv: read the hart ID from mhartid on boot
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> From: Damien Le Moal <Damien.LeMoal@wdc.com>
>
> When in M-Mode, we can use the mhartid CSR to get the ID of the running
> HART. Doing so, direct M-Mode boot without firmware is possible.
>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/csr.h | 1 +
>  arch/riscv/kernel/head.S     | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 0dae5c361f29..d0b5113e1a54 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -81,6 +81,7 @@
>  #define SIE_SEIE               (_AC(0x1, UL) << IRQ_S_EXT)
>
>  /* symbolic CSR names: */
> +#define CSR_MHARTID            0xf14
>  #define CSR_MSTATUS            0x300
>  #define CSR_MIE                        0x304
>  #define CSR_MTVEC              0x305
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 679e63d29edb..583784cb3a32 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -50,6 +50,14 @@ _start_kernel:
>         csrw CSR_XIE, zero
>         csrw CSR_XIP, zero
>
> +#ifdef CONFIG_RISCV_M_MODE
> +       /*
> +        * The hartid in a0 is expected later on, and we have no firmware
> +        * to hand it to us.
> +        */
> +       csrr a0, CSR_MHARTID
> +#endif
> +
>         /* Load the global pointer */
>  .option push
>  .option norelax
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
