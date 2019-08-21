Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A603C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5C3206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DrmJcYu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfHUEOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 00:14:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45856 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfHUEOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:14:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id w26so513208pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 21:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ct/vcfqX294xnImjewrmDMG+pNu8phs+mheV9IoXqXA=;
        b=DrmJcYu9mQkQ+5oXyRM9YqgXYA0IMMSiWznW5HVNzzMJ7ZV0GEzazOoMN6L5eiLmcJ
         cYAa9F/vsLCVlLq75If9r/eW75gmVC5de/ALXLQHXE5wAgEmN2+EanhC5XNg9Yyd44w7
         D5nqrXJeT1pbW9bi9iEn0ISOPHcFxNde3UV/dmGNpgE0GFhQVYQ5Y4sWjzHth8/dYrxh
         kk4jdkPx4SF+lRqREUhytqk6W6orEntQWFKrvd7DnmuGzYew2VX4icnkCrgwsKYsoXuq
         h/24DG9iI62yoeJ6AQ+P3YVuOZb5PJTUYw4y/9aQYmI+CHlmQ7qpwNFf+K1GnCvE1bZz
         LKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Ct/vcfqX294xnImjewrmDMG+pNu8phs+mheV9IoXqXA=;
        b=rMLdK1Q1eEGz6rv8GkPvWBvJlSdQYf6bfpehZ5fZ8aSql5WiV+/uw7cHk79yNPxnGE
         6Yr2gXrKWtBnlV14IRYg5HeGTcss93TxDCL38rDWVYRg1q+mMV67q+L6CkNntnfgHqK2
         /Kk0WW30s05P0FMSKJQBISsGwDIAptXBI2nSDqVodWM4iZBkRImz8SfHDrOMxj1l8JuV
         SpqN/8UUVdSluN5Vopv+cEqvceNCQEqIPmEQtI5dW+loRCuLC8QGEYUZEoiIonO1O7/s
         RqBMzAClR7yljcyETMKBLNVUFGOREy6d+eB/O7lpTYbkDa1EtWcViN9hcHBhrrHpAOjm
         Rd6A==
X-Gm-Message-State: APjAAAXo6Te2eS7z8h3GdCjK1z06kyWHlQxQ0TraG0E0hVLtPz8o+PuQ
        +22pOgYQ4ADFlvXgkgGqQH7yE/CZDWQ=
X-Google-Smtp-Source: APXvYqyTnwrp6dMD25VYpFUckTpU2oPfnP6GLcw49ySJC+PsfTX2cQkXPs52ILKSDbS02wHzdCRHEw==
X-Received: by 2002:a62:dbc6:: with SMTP id f189mr4364709pfg.237.1566360885909;
        Tue, 20 Aug 2019 21:14:45 -0700 (PDT)
Received: from [172.20.2.243] (64-71-28-71.static.wiline.com. [64.71.28.71])
        by smtp.gmail.com with ESMTPSA id p3sm1336423pjo.3.2019.08.20.21.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 21:14:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 15/15] riscv: disable the EFI PECOFF header for M-mode
From:   Troy Benjegerdes <troy.benjegerdes@sifive.com>
In-Reply-To: <20190813154747.24256-16-hch@lst.de>
Date:   Tue, 20 Aug 2019 21:14:41 -0700
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BF39A0F-558D-40E0-880D-27829486F9F0@sifive.com>
References: <20190813154747.24256-1-hch@lst.de>
 <20190813154747.24256-16-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 13, 2019, at 8:47 AM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> No point in bloating the kernel image with a bootloader header if
> we run bare metal.

I would say the same for S-mode. EFI booting should be an option, not
a requirement. I have M-mode U-boot working with bootelf to start BBL,
and at some point, I=E2=80=99m hoping we can have a M-mode linux kernel =
be
the SBI provider for S-mode kernels, which seem most logical to me
to start using the vmlinux elf binaries using something like kexec()

>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/riscv/kernel/head.S | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 670e5cacb24e..09fcf3d000c0 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -16,6 +16,7 @@
>=20
> __INIT
> ENTRY(_start)
> +#ifndef CONFIG_M_MODE
> 	/*
> 	 * Image header expected by Linux boot-loaders. The image header =
data
> 	 * structure is described in asm/image.h.
> @@ -47,6 +48,7 @@ ENTRY(_start)
>=20
> .global _start_kernel
> _start_kernel:
> +#endif /* CONFIG_M_MODE */
> 	/* Mask all interrupts */
> 	csrw CSR_XIE, zero
> 	csrw CSR_XIP, zero
> --=20
> 2.20.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

