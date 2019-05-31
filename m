Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6264C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B778D26BAF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfEaP07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:26:59 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:48418 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaP07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:26:59 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hWjQl-0007CM-Nl from George_Davis@mentor.com ; Fri, 31 May 2019 08:26:55 -0700
Received: from localhost (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 31 May
 2019 08:26:53 -0700
From:   "George G. Davis" <george_davis@mentor.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        <linux-kbuild@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "George G. Davis" <george_davis@mentor.com>
Subject: [RFC][PATCH] Makefile: Fix checkstack.pl arm64 wrong or unknown architecture
Date:   Fri, 31 May 2019 11:26:11 -0400
Message-ID: <1559316388-19565-1-git-send-email-george_davis@mentor.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following error occurs for the `make ARCH=arm64 checkstack` case:

aarch64-linux-gnu-objdump -d vmlinux $(find . -name '*.ko') | \
perl ./scripts/checkstack.pl arm64
wrong or unknown architecture "arm64"

Fix the above error by setting `CHECKSTACK_ARCH := aarch64` for the
ARCH=arm64 case.

Signed-off-by: George G. Davis <george_davis@mentor.com>
---
 Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 11358153d8f2..3e615e8553c0 100644
--- a/Makefile
+++ b/Makefile
@@ -1695,7 +1695,11 @@ PHONY += checkstack kernelrelease kernelversion image_name
 ifeq ($(ARCH), um)
 CHECKSTACK_ARCH := $(SUBARCH)
 else
-CHECKSTACK_ARCH := $(ARCH)
+	ifeq ($(ARCH), arm64)
+		CHECKSTACK_ARCH := aarch64
+	else
+		CHECKSTACK_ARCH := $(ARCH)
+	endif
 endif
 checkstack:
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
-- 
2.7.4

