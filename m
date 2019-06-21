Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA8CC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944F720665
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eIkfdIS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfFUQkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:40:10 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:60112 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:40:10 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x5LGdXbA030778;
        Sat, 22 Jun 2019 01:39:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x5LGdXbA030778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561135174;
        bh=ozhNqk/jJbRlOJsA1fVCfpWIUlNkHQWb4qUWtLdFnnk=;
        h=From:To:Cc:Subject:Date:From;
        b=eIkfdIS+O26Z2YOKvyyUQPDJEfS8R4Fhs0ivGILBOqSQUUm5uWKbiPvKnX/+WtwFg
         bR6tU9HZ4+pLdiRnLxprJkokHFgCtkFoMktC1DDnmtum2THZ3CVntvFIDae0PqQwJz
         UKsDDf8vlHPw6lhKvHOC5bPX9K+MKp9Zup6GlavY83airXFt5PwUrWGHKBwQLMLuVU
         kmDNdZ4svkbDbE9jeS3mqKjBXcv5ohpvAiAgS9EWfEq5D4E5/eDRtcyqvkzithnuhb
         xtCZFMEJe7KxegEtkFkx2ypPYLJzg/fgwsSocOPsVDT+rg+2BXnDFsGwl+LcF3XH9e
         bZh+TEYRkfgHg==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] kbuild: compile-test global headers to ensure they are self-contained
Date:   Sat, 22 Jun 2019 01:39:31 +0900
Message-Id: <20190621163931.19397-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make as many headers self-contained as possible so that they can be
included without relying on a specific include order.

This commit compiles only a few headers, but it is a good start point.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile         |  1 +
 include/Makefile | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 include/Makefile

diff --git a/Makefile b/Makefile
index c23f5e8381ad..82c1722dd9e9 100644
--- a/Makefile
+++ b/Makefile
@@ -610,6 +610,7 @@ drivers-y	:= drivers/ sound/
 drivers-$(CONFIG_SAMPLES) += samples/
 net-y		:= net/
 libs-y		:= lib/
+libs-$(CONFIG_HEADER_TEST) += include/
 core-y		:= usr/
 virt-y		:= virt/
 endif # KBUILD_EXTMOD
diff --git a/include/Makefile b/include/Makefile
new file mode 100644
index 000000000000..68a76ac732c3
--- /dev/null
+++ b/include/Makefile
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# extend the test coverage when existing errors are fixed
+
+header-test += linux/w*.h
+header-test += linux/x*.h
+header-test += linux/y*.h
+header-test += ras/*.h
+header-test += soc/at91/*.h
+header-test += soc/bcm2835/*.h
+header-test += soc/mediatek/*.h
+header-test += soc/sa1100/*.h
+
+all-headers = $(patsubst $(srctree)/include/%,%,\
+	    $(wildcard $(addprefix $(srctree)/include/, $(header-test))))
+
+# Do not include directly
+no-header-test += linux/compiler-clang.h
+no-header-test += linux/compiler-gcc.h
+no-header-test += linux/patchkey.h
+no-header-test += linux/rwlock_api_smp.h
+no-header-test += linux/spinlock_types_up.h
+no-header-test += linux/spinlock_up.h
+no-header-test += linux/wimax/debug.h
+no-header-test += rdma/uverbs_named_ioctl.h
+
+# Conditionally included
+no-header-test += linux/byteorder/big_endian.h
+no-header-test += linux/byteorder/little_endian.h
+
+header-test-y = $(filter-out $(no-header-test), $(all-headers))
-- 
2.17.1

