Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F8EC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6894820B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAPiArlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfEGUwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:52:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44377 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfEGUwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:52:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id z16so8891871pgv.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FZCsu76ETp0rZ0rXi+vAgG1DHkuU4ZJZHgq+GTX/TeU=;
        b=YAPiArlNMJBDkaS6R4dyKdz6IW6HPGijvrYEY77nrpT0RtiYVI/ag+5Pu2wgUGwo42
         Dt62ElIE2Cj70zDg5l5U2dA3F8NwPho09EZ5kMdemAVcRAkryb8UIgjiSoQtTrodY6wS
         pB8y1FCEB+FaYbuySFo7uKAwbJlOzBIbrWgtjrvXpsvWxIZ+x/s9o+qedboWmJrnvhE0
         sTh++leHrUsJiCUPsLhrIpADXMoMdIr7AmGKE1hdhAQDfrLfMyx+qwGbfvu8AzTqav4C
         Co2wU+rVb5/IzT2tJ95tS+CzpzS95zpLpFaa2i+ieZj+0XV7oL6YJPPpR9ViZMAhZEBN
         WjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FZCsu76ETp0rZ0rXi+vAgG1DHkuU4ZJZHgq+GTX/TeU=;
        b=ew1DBOL1lzjFGrNa4FslV8lqxZNmM6ZPWpohObj44LLr1x6Og2bvSZQaJAWx77bRrc
         8UIFSLxVmv7QqENDRRkyv7wREwKPTW8WUzQ7kCay1Yhr48U0dKIeSw4s/YCZTUoDWo6B
         gaksZ7rS3tWxPUL0pTFjBRoLxXtlVOjYaHlLyXCOKtiYRZjSgc/9xv3Nb3HtlSx6Dl4S
         cP1nx1LLOVsocoEA/PJWcjv9PtdIitSCgJ8W+Qsn66CnfMOUgSWUXtoPGT8FW/O8cVD/
         kXtekwHqcIoB9sN1KyodOh0wqcaHYc6MDcKm9Bvry8HM8rtXkxx/ghkCZ3RPd+Yvr0jn
         UL+A==
X-Gm-Message-State: APjAAAVDIwX9CUxC6PbsEjbknf6XG8/NZpOCz3MLvNWcncTnJrsZzwHF
        TEYC/jWFXmTuCmdYmGRL90A=
X-Google-Smtp-Source: APXvYqwWbLNioOJ3VoiOYrPTtL15jPigps8VxBp1q1jIpMmqAM8LVIWhwtY4EDHxbahQvfobdasYwQ==
X-Received: by 2002:a65:5181:: with SMTP id h1mr42672849pgq.167.1557262353965;
        Tue, 07 May 2019 13:52:33 -0700 (PDT)
Received: from localhost ([2601:640:2:82fb:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id n184sm13459640pfn.21.2019.05.07.13.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 13:52:32 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] arm64: don't trash config with compat symbol if COMPAT is disabled
Date:   Tue,  7 May 2019 13:52:28 -0700
Message-Id: <20190507205228.8186-1-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <ynorov@marvell.com>

ARCH_WANT_COMPAT_IPC_PARSE_VERSION is selected unconditionally. It
makes little sense if kernel is compiled without COMPAT support.
Fix it.

This patch makes no functional changes since all existing code which
is guarded with ARCH_WANT_COMPAT_IPC_PARSE_VERSION is also guarded
with COMPAT.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 305b50f8f791..38e6dc6a50c8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -65,7 +65,7 @@ config ARM64
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG
 	select ARCH_SUPPORTS_NUMA_BALANCING
-	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
+	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
-- 
2.17.1

