Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B88FC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A2F21841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="khOrw03v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfDKInX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:43:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34135 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:43:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so3203651pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8xoHECi6lj7fMC6tlsVhg7Jcmo6YyCWRR0WfAwqgJ48=;
        b=khOrw03vIb9UhZ7m0LIMjh4FpXvNpVedmeIX+eIZd69A78F3wEmeOyGWBR6WLdXDHZ
         Lj+IFe947TWb83tZEtXX3mapIuvgjmAKyndroSokHQRqvs8IbuvTMh5LMLACkJW+s+sV
         IHud4aUHgQVV6tfxX0Z9j9FOYfi/BfSoPgy3ykhlwugRVBX7Xr64gMSNMyTOEBei/sdC
         8mi8e57qyJwAUY/XPbuSfouThQ0saZd4r+y+5IvVicryVUbhwdjOhfxjymKnaV91qnng
         dVoORxbXRIxal0PljwbqY/yfZ38uoQf3ErZlOwcfEZRuKKmJxxKLKbdbxxEUuoa+3S/t
         kung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8xoHECi6lj7fMC6tlsVhg7Jcmo6YyCWRR0WfAwqgJ48=;
        b=Ncu/aYnZiy81DE/Cmv3KMHfYiP13ynoyY9Ht5lpi43qjWa/wNX6Pvzu11PXbsLN/rU
         gcEtil8LSVcuwgQUQ1PUVjlHWsQ1NcxJ+JpPGDdVbe+PDkhiBC18y9KxXqoluzy4iaZW
         cnsqAyurj46Y+cDrspaLmI5TN4+gHlzCB2BcLxqtF33j3Yp3DN99rMpmqe/vsjUmVhfD
         qwjM/T9llhPBveCqXwhRzPlm8Pvi0AEsQx8gAC/oDG+dTBW/5rEwfk8NfNLXWhnpZ36o
         yylQ21rkOCl10HlIrmHCOvBC7xGw7YpKlezUIcYX4lF4+REvGF8PnKk2onAkW6wMs0dB
         hJdw==
X-Gm-Message-State: APjAAAUvyX8qwthItLH6eNWAljXuR7c3T3v9GoZriKLYOEm970YYDb4y
        njsmCAhhEE0j1Y1ZKjoiaJSny22idtg=
X-Google-Smtp-Source: APXvYqyYvQWd9nBI49eomlPWKSMm8VTV/dyQjRJQ5df52R3gT77jdsPHvxMTagDv7ckO6TyTtxEGvg==
X-Received: by 2002:a63:1918:: with SMTP id z24mr43751274pgl.406.1554972201211;
        Thu, 11 Apr 2019 01:43:21 -0700 (PDT)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a3sm61699456pfn.182.2019.04.11.01.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 01:43:20 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 1/6] arch: riscv: add support for building DTB files from DT source data
Date:   Thu, 11 Apr 2019 01:42:59 -0700
Message-Id: <20190411084304.5072-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to ARM64, add support for building DTB files from DT source
data for RISC-V boards.

This patch starts with the infrastructure needed for SiFive boards.
Boards from other vendors would add support here in a similar form.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
---
 arch/riscv/Kconfig           | 2 ++
 arch/riscv/Kconfig.platforms | 8 ++++++++
 arch/riscv/boot/dts/Makefile | 2 ++
 3 files changed, 12 insertions(+)
 create mode 100644 arch/riscv/Kconfig.platforms
 create mode 100644 arch/riscv/boot/dts/Makefile

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index eb56c82d8aa1..10e818816017 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -127,6 +127,8 @@ config ARCH_RV64I
 
 endchoice
 
+source "arch/riscv/Kconfig.platforms"
+
 # We must be able to map all physical memory into the kernel, but the compiler
 # is still a bit more efficient when generating code if it's setup in a manner
 # such that it can only map 2GiB of memory.
diff --git a/arch/riscv/Kconfig.platforms b/arch/riscv/Kconfig.platforms
new file mode 100644
index 000000000000..bd3d2642bcff
--- /dev/null
+++ b/arch/riscv/Kconfig.platforms
@@ -0,0 +1,8 @@
+menu "Platform selection"
+
+config ARCH_SIFIVE
+        bool "SiFive platforms"
+        help
+          This enables direct support for SiFive SoC platform hardware.
+
+endmenu
diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
new file mode 100644
index 000000000000..dcc3ada78455
--- /dev/null
+++ b/arch/riscv/boot/dts/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+subdir-y += sifive
-- 
2.20.1

