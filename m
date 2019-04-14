Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1BDC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA8920848
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7MVRoLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfDNSmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:42:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33537 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfDNSmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:42:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so13552653ljc.0;
        Sun, 14 Apr 2019 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z6P1P/q1HdO2lVh8z8dlbaMZRQkRDeJvJLHxflkj9dU=;
        b=j7MVRoLWCKzP+s0UIa79OW5yY/xar2I67+nGvoNb44Avf24G/azn0FoD6n4b8pTQYV
         GYTzoqHvPsNLDr+L089X4AqQ3RNgyRnukFqJ7M6DZQx+YRFSjdyzO2GkR7lXDSAmZ8iF
         DFvel7VXHvL2Y3PYfT+zq27+DEvw+3suWPTOUHlrjyMJQYK275IT9WGCpPJI5Z5xzqTS
         Zy6z4Lp0LcEKOqVCt+T0Upc8V0jmUg/de26TeRs+pbR+V71tfAzGkje7Nms/HATrjpEH
         ALKNiTpmf1jAwyw48Ffe2UDLCywjp8PDk2Aw6wvKKJfh0wzgTjLvciFsl7z0vY+0g52V
         79tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z6P1P/q1HdO2lVh8z8dlbaMZRQkRDeJvJLHxflkj9dU=;
        b=NaNpGdgOx1rpNYR5ONFoN+ImGTYq5/udvYb1VvakswkUQnli0jk9GPySJbvbFtUoQN
         NIJn1IqDCd5k/D/+07Lvs+luNlgKJnX2ogf8lAg3DtK1b+tPmdg0DbECqMGmcyKtvsj5
         npa8A66Ihm1eHC5XkeTzcm7GRG6jNEwp92pJrafE4bZiJGpPLiw5XPoaEzc/s3LFa314
         ekPHhsIwNDLqwFlptpabLaNCHXKGnCmt8nU05MgmCFxo4nZ1ez1/qsgHSqmznQ8FwDPr
         UonugUD6XQOdFgs8JX3854+mxrS4sm3cbWnnBrJ6Pkh1j3GOim1NDqkD7d4xFjoGcQni
         JTBA==
X-Gm-Message-State: APjAAAVgWKCfmpTBrWMucXkML8i+HOJ8DrFBWAIVQoQ6ySabRdU0hGNk
        Fferkfhbila/iAEbX81YukD5iUg6io5xtw==
X-Google-Smtp-Source: APXvYqy3zpK45RTnrY9oTC4Me7lHNieYtDguqQ607RKlhQ44/1zdJKzl4nTfwaQxn7sxDhvsxRcaAw==
X-Received: by 2002:a2e:8347:: with SMTP id l7mr36536467ljh.17.1555267317895;
        Sun, 14 Apr 2019 11:41:57 -0700 (PDT)
Received: from localhost.localdomain (46-243-146.internethome.cytanet.com.cy. [46.199.243.146])
        by smtp.gmail.com with ESMTPSA id f15sm1434301lfa.89.2019.04.14.11.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Apr 2019 11:41:57 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     bp@alien8.de
Cc:     mchehab@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCHv1] drivers: edac: This patch fix the following checkpatch warning.
Date:   Sun, 14 Apr 2019 21:41:50 +0300
Message-Id: <1555267310-21510-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pr_warn instead of printk

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ...
        then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/edac/x38_edac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
index cc779f3..4c855c0 100644
--- a/drivers/edac/x38_edac.c
+++ b/drivers/edac/x38_edac.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/edac.h>
+#include <linux/netdevice.h>
 
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include "edac_module.h"
@@ -260,7 +261,7 @@ static void __iomem *x38_map_mchbar(struct pci_dev *pdev)
 	u.mchbar &= X38_MCHBAR_MASK;
 
 	if (u.mchbar != (resource_size_t)u.mchbar) {
-		printk(KERN_ERR
+		pr_err(
 			"x38: mmio space beyond accessible range (0x%llx)\n",
 			(unsigned long long)u.mchbar);
 		return NULL;
@@ -268,7 +269,7 @@ static void __iomem *x38_map_mchbar(struct pci_dev *pdev)
 
 	window = ioremap_nocache(u.mchbar, X38_MMR_WINDOW_SIZE);
 	if (!window)
-		printk(KERN_ERR "x38: cannot map mmio space at 0x%llx\n",
+		pr_err("x38: cannot map mmio space at 0x%llx\n",
 			(unsigned long long)u.mchbar);
 
 	return window;
-- 
2.7.4

