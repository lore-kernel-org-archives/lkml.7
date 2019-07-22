Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B743CC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9169B222F9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WXncvnAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfGVJlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:41:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfGVJlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uuCke/m1jxxr5tTC/Z7FAkFIKWk99JBUnhxnHFx1S5k=; b=WXncvnAfRIhXiNhfTvFgzTSrF
        ZeDnrZaWqROY3q3TyF6+hGQSvWWIqJD7MeOQoMk2WZfLDNomf3R8pV6dpv5+mvmHXTpeI0UX4RNUb
        hkDTyr1coiXAyEeAdPb4CXbPQALKGS57XYw9PzDyGdU9Z+CS1erUFKlVunUphg5QtGfA11SuI7rsd
        ChVghFzuHlEUhYWDLVjXggS1uDOscMM3UYgK2ZtbOaIG4ZTTXfRKdD6YE+r6yOBrLNmlIcVbvsbhg
        1PjGys38TyqD6c6dJsU1JVr/v3+VJT097jYWFnAFx4U9ZFuPcYA01JJmQi4DL3qInrz7U/mzTF/F+
        z7WiJCYBg==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpUpF-0001Az-4X; Mon, 22 Jul 2019 09:41:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     dan.j.williams@intel.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memremap: move from kernel/ to mm/
Date:   Mon, 22 Jul 2019 11:41:43 +0200
Message-Id: <20190722094143.18387-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memremap.c implements MM functionality for ZONE_DEVICE, so it really
should be in the mm/ directory, not the kernel/ one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Sending for applying just after -rc1 preferably to avoid conflicts
later in the merge window

 kernel/Makefile           | 1 -
 mm/Makefile               | 1 +
 {kernel => mm}/memremap.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {kernel => mm}/memremap.c (100%)

diff --git a/kernel/Makefile b/kernel/Makefile
index a8d923b5481b..ef0d95a190b4 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -111,7 +111,6 @@ obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
 
 obj-$(CONFIG_HAS_IOMEM) += iomem.o
-obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_RSEQ) += rseq.o
 
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
diff --git a/mm/Makefile b/mm/Makefile
index 338e528ad436..d0b295c3b764 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -102,5 +102,6 @@ obj-$(CONFIG_FRAME_VECTOR) += frame_vector.o
 obj-$(CONFIG_DEBUG_PAGE_REF) += debug_page_ref.o
 obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o
 obj-$(CONFIG_PERCPU_STATS) += percpu-stats.o
+obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
diff --git a/kernel/memremap.c b/mm/memremap.c
similarity index 100%
rename from kernel/memremap.c
rename to mm/memremap.c
-- 
2.20.1

