Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC78C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD36205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UPXo+6HR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfDPRYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:24:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45264 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPRYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:24:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so10646285plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:cc:from:to:message-id;
        bh=YpGvq/4oL3U/yzzNTEZXc9rKkrlrHrkxbsUqZXLRLyY=;
        b=UPXo+6HRHxeuvNJHDbiyIH+rrtLJeWbMcNTKdu1SG0tj0RUml6cLQTHWcUn6eRMZ9o
         Iv35M8aWqk7RUHlxmRwcDa6LExTPkJqUD5D1OUdJciIomLGLZOnzhqqk9zs2o7L0xraB
         48i/5m0t/welDxRxCCKZqWdAwx71UFSp0LwKhvvvA25Q0m6P0N57480Pv/8QF4CheGya
         EHwB1R4tlnIjHpSK18YP9lkD60pC0bsKqjzButcyR1/0gfFjDUI/GXB0i6IvDz0bGRW+
         xfGQR35LtG6xPbh0Y57+CHBqOb1LvK87Y987vac2NabhwfEbqc4Heb0D+bPHocvV7TEL
         OuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=YpGvq/4oL3U/yzzNTEZXc9rKkrlrHrkxbsUqZXLRLyY=;
        b=cV5g65M+tK4E3frE1Q8cAtHMQkveMscu9cZvo4deymCsRYWGrlKmHEimzGEWKWk4ID
         AUWCrGxkPcWosVDGinDiG8MF51GtDE55bkN0B18Gjj/JRXP5IGuHiJ5JGMQiEkUpxj+b
         Bx5nEEbleS35OwRmpexiJNb4KOjGu70WbMx/dwK7WFIsd+8mvDnacT+kLzCQhtpCRWWM
         pQDbEgpNuVJBSHlCM6Nl80iZ5lDhZCgiW9YXVA0cmD21KGQ/+OSBWz7XDIkAx5505cud
         3g9WLFzc9k6oxS4ZGF5iJW7Yg9YUwM1y1PRdyPu8fdX6Sl4G1NGN4aBdIdHe8tp/4wFf
         82Hw==
X-Gm-Message-State: APjAAAX9D23JwYZgmakUqGVZdemDSrkktu5OGp1fGp9OzkTe1OWia26/
        hixoIBk38bXQFkakbyzwk35dCqih2mb68A==
X-Google-Smtp-Source: APXvYqyfPj3ItENNvOHVzcT++xfVwXSuMHxRiNKBvmjDPjKPS8nha4+oikPZojs8BWiNh/M3j+QaCA==
X-Received: by 2002:a17:902:b94a:: with SMTP id h10mr84224398pls.82.1555435487369;
        Tue, 16 Apr 2019 10:24:47 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c18sm142471563pfc.0.2019.04.16.10.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:24:46 -0700 (PDT)
Date:   Tue, 16 Apr 2019 10:24:46 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Apr 2019 10:24:43 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for 5.1-rc6
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-c5019c5a-5f6a-43a2-b376-6a29a824e260@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.1-rc6

for you to fetch changes up to f05badde4e20d2e0f8c39d07a6873b2bfb0754f8:

  RISC-V: Fix Maximum Physical Memory 2GiB option for 64bit systems (2019-04-10 09:41:40 -0700)

----------------------------------------------------------------
RISC-V Patches for 5.1-rc6

This tag contains an assortment of RISC-V-related fixups that we found
after rc4.  They're all really unrelated:

* The addition of a 32-bit defconfig, to emphasize testing the 32-bit
  port.
* A device tree bindings patch, which is pre-work for some patches that
  target 5.2.
* A fix to support booting on systems with more physical memory than the
  maximum supported by the kernel.

These work for me when merged into Linus' master from this morning,
which has no conflicts.

----------------------------------------------------------------
Anup Patel (2):
      RISC-V: Add separate defconfig for 32bit systems
      RISC-V: Fix Maximum Physical Memory 2GiB option for 64bit systems

Paul Walmsley (1):
      dt-bindings: clock: sifive: add FU540-C000 PRCI clock constants

 arch/riscv/configs/rv32_defconfig             | 84 +++++++++++++++++++++++++++
 arch/riscv/mm/init.c                          |  8 +++
 include/dt-bindings/clock/sifive-fu540-prci.h | 18 ++++++
 3 files changed, 110 insertions(+)
 create mode 100644 arch/riscv/configs/rv32_defconfig
 create mode 100644 include/dt-bindings/clock/sifive-fu540-prci.h
