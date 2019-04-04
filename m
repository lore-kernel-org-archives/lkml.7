Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8455FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B5A2184B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 23:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="X85PTrta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfDDX3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 19:29:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35375 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbfDDX3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 19:29:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so1964574plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 16:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:cc:from:to:message-id;
        bh=ysBJe5T5Y1DNorw+ljzDdrTof4pVRsltKWZ9RRcQ+JA=;
        b=X85PTrta713pYoHXMV8rg4P7tAx4rI5qrMQGY7EJD1vjQnluwEfFjvuw7CE/jKuayJ
         lxUjphJC2kisV9ytsTUcnKRAsAHoKz+hxDhcaq2X3eDbAAnhCVY2usuzooUVSNB4VCCH
         61BW8fyKGzPqX+fnlR5x5j3dnR2KW+MXVzeqYZnF42MOS5OTxRPFzyxWJ0dOPatW9R35
         Lw2ADcF4LisunURbSbRHfgllgTreWWIJuxjPIg86xoeoa4yZdAKlzW7mVz4Zv9CaK5bT
         7SNhF/2jqtMHIzZQiotQAUdVsq7pufTUlPrCcytQSGWuLKqMfU5HuoorROhWzi70X0GU
         02bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=ysBJe5T5Y1DNorw+ljzDdrTof4pVRsltKWZ9RRcQ+JA=;
        b=lzNeCRiKxtXRBoMla5YXv7kyuPBhWvCH6cZ5IpuatyWto2lIazANaE6zYvvn4BVZWq
         5zy8bXcAsWxh+GY1X2o3sl+DlLrotxBCjT4nm+1ZzKQnHtFH+4StEicz+I9/SIHlecLH
         ANEJsm8O3AoFtaJ6onJVaIjld3WyTCGkL+6rSiabt18CVkj2N9EBCsfBQRdD4sw0jCdC
         tch4fVvEfwk25Rix5yCnosqMtxFbaUICl4sGyqad7hEIZ0LLrUJQHM4xhavn/sYhVlRN
         RpvHPKtUDwf8Kw4Dn/CQ5NY6+5cnBB8/5yp/h6bzNYE5T6h9BDzNmoBvqog0+WO556SZ
         WEHQ==
X-Gm-Message-State: APjAAAX2Xgv+UgmtECJtF5rk6+KURiIN7eHVkAauMB/X3vgdi5Oz7bfZ
        09vsu2DFr0DqXqvOsZZhmzd72g==
X-Google-Smtp-Source: APXvYqy+Pr5PD8r7eabECAPPq8z1YqCN0boq1W2Nd0eJsQ7St2yoK3qNiN2e0uXlDzIETFAmlqa2dw==
X-Received: by 2002:a17:902:e48f:: with SMTP id cj15mr9275505plb.256.1554420585422;
        Thu, 04 Apr 2019 16:29:45 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g2sm28586872pfd.134.2019.04.04.16.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 16:29:44 -0700 (PDT)
Date:   Thu, 04 Apr 2019 16:29:44 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Apr 2019 16:26:00 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for 5.1-rc4
CC:      linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-2bff106e-098e-4cc8-bdb6-48f05d1065d9@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.1-rc4

for you to fetch changes up to da4ed37873918eeb4e8db7f0cf55e0a7e18788c3:

  RISC-V: Use IS_ENABLED(CONFIG_CMODEL_MEDLOW) (2019-03-28 23:18:51 -0700)

----------------------------------------------------------------
RISC-V Patches for 5.1-rc4

I dropped the ball a bit here: these patches should all probably have
been part of rc2, but I wanted to get around to properly testing them in
the various configurations (qemu32, qeum64, unleashed) first.
Unfortunately I've been traveling and didn't have time to actually do
that, but since these fix concrete bugs and pass my old set of tests I
don't want to delay the fixes any longer.

There are four independent fixes here:

* A fix for the rv32 port that corrects the 64-bit user accesor's fixup
  label address.
* A fix for a regression introduced during the merge window that broke
  medlow configurations at run time.  This patch also includes a fix
  that disables ftrace for the same set of functions, which was found by
  inspection at the same time.
* A modification of the memory map to avoid overlapping the FIXMAP and
  VMALLOC regions on systems with small memory maps.
* A fix to the module handling code to use the correct syntax for
  probing Kconfig entries.

These have passed my standard test flow, but I didn't have time to
expand that like I said I would.

----------------------------------------------------------------
Alan Kao (1):
      riscv: fix accessing 8-byte variable from RV32

Anup Patel (2):
      RISC-V: Always compile mm/init.c with cmodel=medany and notrace
      RISC-V: Fix FIXMAP_TOP to avoid overlap with VMALLOC area

Joe Perches (1):
      RISC-V: Use IS_ENABLED(CONFIG_CMODEL_MEDLOW)

 arch/riscv/include/asm/fixmap.h  |  2 +-
 arch/riscv/include/asm/uaccess.h |  2 +-
 arch/riscv/kernel/Makefile       |  3 ---
 arch/riscv/kernel/module.c       |  2 +-
 arch/riscv/kernel/setup.c        |  8 --------
 arch/riscv/mm/Makefile           |  6 ++++++
 arch/riscv/mm/init.c             | 28 ++++++++++++++++++++++++++++
 7 files changed, 37 insertions(+), 14 deletions(-)
