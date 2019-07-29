Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE47C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E761B21773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429278;
	bh=tzF3dBTTCnPCPooP6vi1/rbCELf+dBO/NrCJBH4Whj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dT9Q3xc4Y6JlJR5kgrVMT7E+HUAt0L6fM1iKIw4Ysu97p1MgGwXEhojB8/48/GBro
	 Lm3msWEKEH/fZI6PYQX/twnfcy5v5oWGC4w82sG15i0MUi0yUdXbU5rfvvJLBmjhpQ
	 9MpSTnPD+/ie8F4DvBBV5g7LJEeCDZXeQIOPvRiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbfG2TlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389301AbfG2TlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:41:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57CCD2054F;
        Mon, 29 Jul 2019 19:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429268;
        bh=tzF3dBTTCnPCPooP6vi1/rbCELf+dBO/NrCJBH4Whj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBXvxnCGEDbdR5eqJrO+qqUJk05tuMU3q5cdptPK/pHLzVVrxrNG+vjaAjuwALBuC
         QsTlXTj0E4zlS384L2JOPH1+ZyZsigwEZ2VRCiRu0eU2oEJ6m9iPXA+l3bRAg8bqLv
         WqSrzdUVAJKprefk5TfVFD2mx4A1KJ22ziocePl8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/113] powerpc/cacheflush: fix variable set but not used
Date:   Mon, 29 Jul 2019 21:22:12 +0200
Message-Id: <20190729190706.452249457@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 04db3ede40ae4fc23a5c4237254c4a53bbe4c1f2 ]

The powerpc's flush_cache_vmap() is defined as a macro and never use
both of its arguments, so it will generate a compilation warning,

lib/ioremap.c: In function 'ioremap_page_range':
lib/ioremap.c:203:16: warning: variable 'start' set but not used
[-Wunused-but-set-variable]

Fix it by making it an inline function.

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/cacheflush.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index d5a8d7bf0759..b189f7aee222 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -32,9 +32,12 @@
  * not expect this type of fault. flush_cache_vmap is not exactly the right
  * place to put this, but it seems to work well enough.
  */
-#define flush_cache_vmap(start, end)		do { asm volatile("ptesync" ::: "memory"); } while (0)
+static inline void flush_cache_vmap(unsigned long start, unsigned long end)
+{
+	asm volatile("ptesync" ::: "memory");
+}
 #else
-#define flush_cache_vmap(start, end)		do { } while (0)
+static inline void flush_cache_vmap(unsigned long start, unsigned long end) { }
 #endif
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-- 
2.20.1



