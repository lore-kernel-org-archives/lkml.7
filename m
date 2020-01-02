Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506A6C32764
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D8720863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vi6uFeK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgABDKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:10:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39354 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgABDKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 22:10:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so14346155plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 19:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3ZeFLW0tZfqHlZISm5iQNQKhwN5szM40SC3+DB7Jec=;
        b=Vi6uFeK8FQWUpxh9kg+TRm+rbSbuHhbmk1YAT+cd52UcYzvsmrZ4GP4Q+iXx/+ldGu
         GbwH1UiGd0FdOoOGsVNn0BtoWIJRdm8OGWDbrjqbD7hAZ6d/dpy7pauLt2E6Qjc+NdLM
         tUuercAKxUjqHbyY+vqAijC3hOLEGrrwfuGQ8aW9dSNUw+j/Xx8RHX0T/YChcH9rX8XI
         qRoIXCaB1kdarijD5CqXfyhZfESddv2UA3Yk7legVOaMGMAJrNWhbmH0QW3kqx2Sc/XS
         xQLqrlvoCKY90UGMZPbHw/fBPqyGuwLse8b66izIFK4Izf5MkUE4onLL2qm6S2dq8U9j
         b+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i3ZeFLW0tZfqHlZISm5iQNQKhwN5szM40SC3+DB7Jec=;
        b=s8Fyo5p4aNp66ePC3W1Lym8XfvYFoVacIfyCi/H4fmNwLbW34wn8spFI+S81sAGypx
         HMjVFqm5itBe7foKAmVzDSQLWNpY9yeJxNC3Xgphb3/yxG3sZjf6yKlhzbjFOS5VH13Z
         oAZkgnfKwLsjJdp17kix7D/WnTuczAVibD5i2R8rE34O7kMUuDCVTIB/8HQ34CNWE8OU
         H72Vp8su4We0CSAh8WEOkajYTjWfeP1776rQtlS/wiz5jxvS8mntB0rb4SX2iQT6NtiS
         W69K1w9rL+ozq5kwJRBiKFOAT5k3lrpiuWC1fIXHK+pnfcIKDS/SiCTrHkJRC5d95iuv
         HDZA==
X-Gm-Message-State: APjAAAXqNCYTYyAJqIKfIBSchmseXSxBSC/szWcH/0PCBWuqbKozBBwW
        J+LBF3cOE5imxUBEpSnlIbSo7w==
X-Google-Smtp-Source: APXvYqz6/qqGIg9+6XCIhwTyqx31euuHN1nfJJLRxO61z1RD9MygdXVLOHdb/HUCTEAi+bfmk9MVoQ==
X-Received: by 2002:a17:90a:1a0d:: with SMTP id 13mr17092503pjk.129.1577934614654;
        Wed, 01 Jan 2020 19:10:14 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id r2sm56108919pgv.16.2020.01.01.19.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 19:10:14 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH] riscv: gcov: enable gcov for RISC-V
Date:   Thu,  2 Jan 2020 11:09:54 +0800
Message-Id: <20200102030954.41225-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables GCOV code coverage measurement on RISC-V.
Lightly tested on QEMU and Hifive Unleashed board, seems to work as
expected.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 Documentation/features/debug/gcov-profile-all/arch-support.txt | 2 +-
 arch/riscv/Kconfig                                             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index 059d58a549c7..6fb2b0671994 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -23,7 +23,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: | TODO |
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d8efbaa78d67..a31169b02ec0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -64,6 +64,7 @@ config RISCV
 	select SPARSEMEM_STATIC if 32BIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
+	select ARCH_HAS_GCOV_PROFILE_ALL
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
-- 
2.24.1

