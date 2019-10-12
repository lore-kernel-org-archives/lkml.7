Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF440C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 17:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4F5206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 17:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="V+O9w7oC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfJLRin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 13:38:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41736 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfJLRin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 13:38:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so7944936pfh.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=QGULoH50CkpFs9ZPMN0T6KllCcRA7SCxuzqckP0gnTU=;
        b=V+O9w7oCvmWLh3i5Tt0HokYwr5aCEtbOMnxkQh93haiqG5tRmpJfBrSzTUhVOxw/qy
         MflYyC4yaUd0QkBmtIwVAbVdHDMAh9G34f78PCPTVqZ3LTnl+A3Ck152ZhHolai0umvH
         x+eRt/AO8CJaK5Uy4i5F/INQbp4XOqa3GnZ3QPaZL/70qM0JDady/u6cd+19cWwFjyNi
         hdOO4BtOo0e2T2XegKd+48X4G3l8hYqAG58/idv+ZLFVj4jGsBewv8PDocnXa+NoFxs/
         0zxEvBunmH7620m0WrKWFi2l8gPMC4sVs3MtCPF1lZTd7xcwvALMruFnhPQ8sHQ/DTSk
         bQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=QGULoH50CkpFs9ZPMN0T6KllCcRA7SCxuzqckP0gnTU=;
        b=Jt5D7i9+7fON5jfuLYKrfV093ceYT1ZB37ve317GHWJjpsFGAhMLAiptVoIGAcl4qq
         PMV1NekyieZfn0espi4R2hpWFN7zJwjWcs/KZlQlMo7CIGB7KthPKpFVQsumT3oabDRn
         jLcsnrNL7zbonExx9A90KhT37Q2x+XnD2c3rP4+2hTu4Ws3N/dcB9H72lboeniKNhfaD
         wasfH/S47U7dmjh4qMddjw88zrr9FLxN543Y5QyoutNpRNfanhu26afaLRilubqzvgzW
         cXq7gud1q72Mqhtlaav6nAAzO6HRBbzmI5AmhD7xFx5ZNNvhdXI2TxMlz8bkVn2pZUNf
         Esvg==
X-Gm-Message-State: APjAAAWRbWszj/LXsF69Su6571KFHagB+G+/q9IEqZV7SGjlD7LncA2q
        WPJNqVRA13fFNGTrSv1ZYNM2oQ==
X-Google-Smtp-Source: APXvYqzW1OO3P+m0WSPdYkvU5HibLfM3ibywisk4ThgutqOLNgBG8iO4E+dx0Lx0Ub7yrHG07c1Xnw==
X-Received: by 2002:a17:90a:338c:: with SMTP id n12mr24412467pjb.24.1570901922575;
        Sat, 12 Oct 2019 10:38:42 -0700 (PDT)
Received: from localhost ([192.55.54.60])
        by smtp.gmail.com with ESMTPSA id m12sm16808019pff.66.2019.10.12.10.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 10:38:41 -0700 (PDT)
Date:   Sat, 12 Oct 2019 10:38:41 -0700 (PDT)
X-Google-Original-Date: Sat, 12 Oct 2019 10:38:01 PDT (-0700)
Subject:     Re: [PATCH v2 2/2] RISC-V: defconfig: Enable Goldfish RTC driver
In-Reply-To: <20190925063706.56175-3-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Greg KH <gregkh@linuxfoundation.org>, rkir@google.com,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-edb410db-fdd1-46f6-84c3-ae3b843f7e3a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019 23:38:08 PDT (-0700), Anup Patel wrote:
> We have Goldfish RTC device available on QEMU RISC-V virt machine
> hence enable required driver in RV32 and RV64 defconfigs.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/configs/defconfig      | 3 +++
>  arch/riscv/configs/rv32_defconfig | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 3efff552a261..57b4f67b0c0b 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -73,7 +73,10 @@ CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SPI=y
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_GOLDFISH=y
>  CONFIG_VIRTIO_MMIO=y
> +CONFIG_GOLDFISH=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
>  CONFIG_AUTOFS4_FS=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 7da93e494445..50716c1395aa 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -69,7 +69,10 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_GOLDFISH=y
>  CONFIG_VIRTIO_MMIO=y
> +CONFIG_GOLDFISH=y
>  CONFIG_SIFIVE_PLIC=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
> -- 
> 2.17.1

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

IIRC there was supposed to be a follow-up to your QEMU patch set to rebase it 
on top of a refactoring of their RTC code, but I don't see it in my inbox.  LMK 
if I missed it, as QEMU's soft freeze is in a few weeks and I'd like to make 
sure I get everything in.

Additionally: we should refactor our Kconfig to have some sort of 
CONFIG_SOC_VIRT that selects this stuff, like we have the CONFIG_SOC_SIFIVE.  
This will explicitly document why devices are in the defconfig, avoid 
duplicating a bunch of stuff between defconfigs, and provide an example of how 
we support multiple SOCs in a single image.

I don't see why either of these should block merging the patch, though.
