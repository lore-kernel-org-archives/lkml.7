Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C58C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DC627BF3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="by27SEQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfFCGb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:31:26 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:52898 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726383AbfFCGb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:31:26 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6F9E3C012D;
        Mon,  3 Jun 2019 06:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559543466; bh=S6XqWpH4MyQCGODhZ07+wgc8TpVvc44BrU/RDAxQsfU=;
        h=From:To:Cc:Subject:Date:From;
        b=by27SEQsokEScbmzC9Q0rNiP+bZKxS5iyiRJe7Pe0uOvbX3tHplq+TQZQkfvqGfjO
         xMphLTG5F+So0LflyRCUpFOKy6VtbxzJs+SrUs8WqJ2iQtzzdCF9WNYksmQrZpqw6i
         fbUtVy8uvewAF5/NFAdv/p/xXpW/W0vKPq6CJSU6mgGdAqm+4UBOahzYZ9GRxVdXRX
         MV6K3Pw/u/9UjrMO4XR9l1Llqj1Me/n3lBzrU/tPk1jWFBawmqSqj7KIA11cW/q3bD
         AR41Vt1KHLgkOWB6zJZkdJEVRS/Zj8HOmqJZLrDUOMTNveqECa/RbgOLG06CpwmWmO
         qVGsjY+3Ok31g==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id 36CC2A022E;
        Mon,  3 Jun 2019 06:31:22 +0000 (UTC)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] ARC: build: Try to guess CROSS_COMPILE with cc-cross-prefix
Date:   Mon,  3 Jun 2019 09:31:19 +0300
Message-Id: <20190603063119.36544-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a long time we used to hard-code CROSS_COMPILE prefix
for ARC until it started to cause problems, so we decided to
solely rely on CROSS_COMPILE externally set by a user:
commit 40660f1fcee8 ("ARC: build: Don't set CROSS_COMPILE in arch's Makefile").

While it works perfectly fine for build-systems where the prefix
gets defined anyways for us human beings it's quite an annoying
requirement especially given most of time the same one prefix
"arc-linux-" is all what we need.

It looks like finally we're getting the best of both worlds:
 1. W/o cross-toolchain we still may install headers, build .dtb etc
 2. W/ cross-toolchain get the kerne built with only ARCH=arc

Inspired by [1] & [2].

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-May/005788.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc2b47b55f17

A side note: even though "cc-cross-prefix" does its job it pollutes
console with output of "which" for all the prefixes it didn't manage to find
a matching cross-compiler for like that:
| # ARCH=arc make defconfig
| which: no arceb-linux-gcc in (~/.local/bin:~/bin:/usr/bin:/usr/sbin)
| *** Default configuration is based on 'nsim_hs_defconfig'

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index e2b991f75bc5..9cfd2ba7a12d 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -8,6 +8,10 @@
 
 KBUILD_DEFCONFIG := nsim_hs_defconfig
 
+ifeq ($(CROSS_COMPILE),)
+CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux-)
+endif
+
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
 cflags-$(CONFIG_ISA_ARCOMPACT)	+= -mA7
 cflags-$(CONFIG_ISA_ARCV2)	+= -mcpu=hs38
-- 
2.16.2

