Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E14C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87F62085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R2wmn5hN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfHLGzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:55:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfHLGzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eEfsk4EIgD1L3eONBAIGTr4XnmTT1gDDgePxeJqg1wA=; b=R2wmn5hN/weRd4e+LwDhydnvol
        gkkWeIjKfxiPT0Lp/8s6mwrXTcjHaw/pf6k38+Ma5jT40E7Wa20uaJg4eV+hdMFd5W24TGKw0+Ru2
        7p5z0Yh3vGvFqBftx36NbzrwrzdJa5Oi6y15kVA4GFIkgCtdo2M4FXybyDGddvDHY2qsKJe+PSrhC
        OGa7ZUEuMFX90RoYtsIoYHtXWnYDAUuFSPHftSjmuRLIe0Xlz01QV0/74JsYF9S0iKgczzj4LqRIF
        804yIWIbpYcan0QlA/Igk1+crSS4zdTvlYqTdB5IHCIBjNB+p1H0qQwVer1M47cdDsgbJhxOJxfLH
        IsXw+FpA==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hx4Ex-0000Fd-LI; Mon, 12 Aug 2019 06:55:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ia64/kprobes: remove the unused ia64_get_bsp_cfm function
Date:   Mon, 12 Aug 2019 08:55:23 +0200
Message-Id: <20190812065524.19959-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812065524.19959-1-hch@lst.de>
References: <20190812065524.19959-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/kprobes.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 5de801a2c0f0..b8356edbde65 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -979,32 +979,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	return ret;
 }
 
-struct param_bsp_cfm {
-	unsigned long ip;
-	unsigned long *bsp;
-	unsigned long cfm;
-};
-
-static void ia64_get_bsp_cfm(struct unw_frame_info *info, void *arg)
-{
-	unsigned long ip;
-	struct param_bsp_cfm *lp = arg;
-
-	do {
-		unw_get_ip(info, &ip);
-		if (ip == 0)
-			break;
-		if (ip == lp->ip) {
-			unw_get_bsp(info, (unsigned long*)&lp->bsp);
-			unw_get_cfm(info, (unsigned long*)&lp->cfm);
-			return;
-		}
-	} while (unw_unwind(info) >= 0);
-	lp->bsp = NULL;
-	lp->cfm = 0;
-	return;
-}
-
 unsigned long arch_deref_entry_point(void *entry)
 {
 	return ((struct fnptr *)entry)->ip;
-- 
2.20.1

