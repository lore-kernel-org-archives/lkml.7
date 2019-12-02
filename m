Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB401C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B65920684
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UfZaszdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfLBXcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:32:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41727 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLBXcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:32:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so650446pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
         :content-transfer-encoding;
        bh=o06lgG0tbiBem1KuBqWESWrb7RuUV1hyoJ5l340yHf0=;
        b=UfZaszdFLAzU9lqis/04uLaNQOGalGN0XtylJjNzuMlZ+Vuz1H9ct5/5IDGAKMPmmZ
         jyd9L+7uJe8rFXXJpPwRGH/JMvDMGNJ+0nTOoCi2oMIim1QCG0c138ACgXeJpSkgWENV
         l9at+Fjq2FnanNBfIsbU+4AiW/D0dGsN5JJ1q+GKDhgmUnDlptalCLJ1L/vSiUo13FnT
         mfj63HJIO+zOXYiVmbg9ibQLm/Sf3TRTO69ZQeylE1JtjJ1FBjt4hK1+Jb38seILPOTv
         cfClYcb+GWBFD1kHuZ6wLXSIO2npwwsb13IG/t9Gq1MdsFb5A6740x1+h7CY1Aga14R1
         zqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
         :mime-version:content-transfer-encoding;
        bh=o06lgG0tbiBem1KuBqWESWrb7RuUV1hyoJ5l340yHf0=;
        b=rRzd0Ui+C5Z0b8vuPEFvQ0Po475GR4Z7TdCpa4AvxoPc6QBC1ewsKWVvXr/taK74v8
         746Qt+DObIY/T8bxZPuFU26NOQXWUrtSPCVyusmIbV4CtVCmZFpCy+VdZ+jwx+aqGxqP
         ayCL4J/C8V/eF/aH8Ivp3FYJjcr+fwXPhIICnrRcZEdUPkGApKmD7A796i7x/5XwNFXE
         9gMkn2HSiOD6dTR1jlZYNO1YlUbr0LFjtkQSfqfc+y9jlF+jwNnleFeIDGTncB0Ri2DD
         isSBWhyTr1xmLpJE8BO0YJm50/m6lyg9MHcuPY5nRAYnJMLsHTM9NJu/YW0LZQe/HTuw
         ghpw==
X-Gm-Message-State: APjAAAWgYwpf8kwa9oNUbCafvuMPspuompHYBJs1iyOItuStQIKUlYM7
        5ADOof4NhYswzDNBKujGBnBT2w==
X-Google-Smtp-Source: APXvYqy7d5bllSF6TvcxZGbVMZeENZSrHPudZDq5WuZx0m0RcmGMhys+fX1CkKjw809tCk4M7XML+Q==
X-Received: by 2002:a63:9d8f:: with SMTP id i137mr1845412pgd.33.1575329570047;
        Mon, 02 Dec 2019 15:32:50 -0800 (PST)
Received: from localhost ([2620:15c:211:200:12cb:e51e:cbf0:6e3f])
        by smtp.gmail.com with ESMTPSA id u65sm614527pfb.35.2019.12.02.15.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:32:49 -0800 (PST)
Date:   Mon, 02 Dec 2019 15:32:49 -0800 (PST)
X-Google-Original-Date: Mon, 02 Dec 2019 15:24:10 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH 1/4] RISC-V: Add kconfig option for QEMU virt machine
In-Reply-To: <20191125132147.97111-2-anup.patel@wdc.com>
CC:     palmer@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        Anup Patel <Anup.Patel@wdc.com>, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-db354582-74fd-45db-974e-3cece2ad6ab2@palmerdabbelt.mtv.corp.google.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2019 05:22:23 PST (-0800), Anup Patel wrote:
> We add kconfig option for QEMU virt machine and select all
> required VIRTIO drivers using this kconfig option.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/Kconfig.socs | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 536c0ef4aee8..62383951bf2e 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -10,4 +10,24 @@ config SOC_SIFIVE
>         help
>           This enables support for SiFive SoC platform hardware.
>
> +config SOC_VIRT
> +       bool "QEMU Virt Machine"
> +       select VIRTIO_PCI
> +       select VIRTIO_BALLOON
> +       select VIRTIO_MMIO
> +       select VIRTIO_CONSOLE
> +       select VIRTIO_NET
> +       select NET_9P_VIRTIO
> +       select VIRTIO_BLK
> +       select SCSI_VIRTIO
> +       select DRM_VIRTIO_GPU
> +       select HW_RANDOM_VIRTIO
> +       select RPMSG_CHAR
> +       select RPMSG_VIRTIO
> +       select CRYPTO_DEV_VIRTIO
> +       select VIRTIO_INPUT
> +       select SIFIVE_PLIC
> +       help
> +         This enables support for QEMU Virt Machine.
> +
>  endmenu

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
