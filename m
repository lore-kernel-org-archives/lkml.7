Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01763C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2D821670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eLgckxV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfFZQAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:00:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36226 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfFZQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:00:10 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so4520966ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kGEtXo3mcNd4IAFNcQTSEQcFyR6hqGozQP+AV6BIM/E=;
        b=eLgckxV+4aPd/Xz9pBfQVGxxIpGAvoaspFRDSxNhACU9S2gzDkMZ2XTOybgu0ylQ8F
         Bq6/obcmKgtSFRPd7T+vpaJ2S+hpsnWgUxzuiLsXhw3PGkJtYM38sGcthKd/N93tV7d6
         jndhatV0E6DOz2caDI6Rm/VxJPgssoPhRGsWBtP0CNvvdWS5nO+3QsyTXzYrSIuRvhrD
         zAC3cVotAu+bNz/3tu3rG5OYU+KaklvJj4Ks5bK8emfuq6RaG0F6bpXIdyEj+GXKIB6N
         B3o2MjZ4aQILJGsjr3vsGbcsdaDnD4ADI4vwd7ZudWlDqF8+yOpuGp3Fm9dNByzPuT3x
         /nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kGEtXo3mcNd4IAFNcQTSEQcFyR6hqGozQP+AV6BIM/E=;
        b=JKY2+DOIYRFxU/gnKTSZAjbCJNqws4qZtoavcLuMPB4pVCGjr3kH968nW8JOJSNpu5
         yrDgkA/2oZv2o6gU4T3hU2NLTuNZf3bSUe4UxUq6ztAbjumZlbyDHvefxFPmJZiE2RH5
         8bRAhXIAFbBYb8Z/8TP2bZblTg1RMK0OsRzqLsepR+hZaV5XT/mbK6dbwFDcNYmM51RN
         AkG7RwTZldRETYt6vzOvgTS6EctD/efh5JAE29BhhWUNgYMbjkRNeTuiEoJxVxWjPZAv
         3kEXqomkckuDXgdrGUzKsFYaCyV1cjPYIZVGEO3dAGR84ISS9mkXqx/nLqackgN1UQQH
         x/Aw==
X-Gm-Message-State: APjAAAXPSaGbrmYQ5fKk4HV0wPHN+up+b8sz4947IPI6FU80H5K01yon
        f0wkdJiIFkpZp22JkSIL92IkRw==
X-Google-Smtp-Source: APXvYqwZaz/o5gjHX1cqzZGpMAcOkrb7NL9kB7CfbPP+u9dhieGDvTv0dBDfsOn3v3ZVfxJPKT+Epw==
X-Received: by 2002:a02:9991:: with SMTP id a17mr5637479jal.1.1561564810126;
        Wed, 26 Jun 2019 09:00:10 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id p3sm19523375iog.70.2019.06.26.09.00.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 09:00:09 -0700 (PDT)
Date:   Wed, 26 Jun 2019 09:00:08 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] RISC-V: defconfig: enable MMC & SPI for RISC-V
In-Reply-To: <20190625225636.9288-1-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1906260858130.21507@viisi.sifive.com>
References: <20190625225636.9288-1-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019, Atish Patra wrote:

> Currently, riscv upstream defconfig doesn't let you boot
> through userspace if rootfs is on the SD card.
> 
> Let's enable MMC & SPI drivers as well so that one can boot
> to the user space using default config in upstream kernel.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Thanks.  The patch also enables CONFIG_DEVTMPFS_MOUNT, but doesn't mention 
it, so the following is what I've queued for v5.2-rc.  Let me know if you 
object to it.


- Paul


From: Atish Patra <atish.patra@wdc.com>
Date: Tue, 25 Jun 2019 15:56:36 -0700
Subject: [PATCH] RISC-V: defconfig: enable MMC & SPI for RISC-V

Currently, riscv upstream defconfig doesn't let you boot
through userspace if rootfs is on the SD card.

Let's enable MMC & SPI drivers as well so that one can boot
to the user space using default config in upstream kernel.

While here, enable automatic mounting of devtmpfs to simplify
kernel testing with minimal root filesystems. (pjw)

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
[paul.walmsley@sifive.com: mention the DEVTMPFS_MOUNT change in the
 patch description]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 4f02967e55de..04944fb4fa7a 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -69,6 +69,7 @@ CONFIG_VIRTIO_MMIO=y
 CONFIG_CLK_SIFIVE=y
 CONFIG_CLK_SIFIVE_FU540_PRCI=y
 CONFIG_SIFIVE_PLIC=y
+CONFIG_SPI_SIFIVE=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=y
@@ -84,4 +85,8 @@ CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_PRINTK_TIME=y
+CONFIG_SPI=y
+CONFIG_MMC_SPI=y
+CONFIG_MMC=y
+CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_RCU_TRACE is not set
-- 
2.20.1

