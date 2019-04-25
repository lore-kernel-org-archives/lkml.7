Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D22C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B508206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4W5YP5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbfDYUXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:23:52 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:38147 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfDYUXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:23:51 -0400
Received: by mail-vk1-f201.google.com with SMTP id u20so501768vku.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lYPpgNkuYL/UXj4RzVEQzfR0g2A/fW/hCvtNkvFYhqw=;
        b=J4W5YP5UnwpMpQ7LVf49jdjMSKa9+TuqygYeYA8m199Sy706j9bCaFoaW6REUEL60B
         tZuOIxsYM2/aCpfr2t5gMx7YhggQxwv2blHrirMWWiDu50yONbFztn48AtU2UODSPGVS
         vPbjNf4bJr8Cn0z79ZRoac5OP8wZ80a6udaUKfLKCChSr3LMAPeVRle3y29B6ZXK9Gr5
         5J55EauRa13oECD0SgvdFqtAQtGvL1eLkeFN/0QZW2eHguVFV7NWNiM1WY9n5O/8fBaR
         D8iKa64i3vNymuRFQqGljC5MgakHoHvJJhRLo6HoNTBrT57fsT1LfiiLh44S/olVrCK8
         /1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lYPpgNkuYL/UXj4RzVEQzfR0g2A/fW/hCvtNkvFYhqw=;
        b=QFcn76BbGzAuuzVeZobMEyjc8oQwezJaBgT3C7Dz+NVHwcRuFQK1uuU0ON5QOC9OGQ
         zO7WpOXzhfgm3M/4EW2p2RI4KOS8g4HavvDH3JQ4S2tyA5dXYOEB0UpasghqemSuQqwd
         2rpaznNtvOplaOKcharZ1qqMECZEKlGOYp/q9O36P3nIKCemQ7IfcLuFP5DgKhKGsheO
         iisH1S5DEaa3U4J8jkEWFZOiTGz2RXT57QAngj2NZ/+pkr7WPzaxT3YWpRo2iQ8gsxet
         IefmeKav2Tji3Loyeq8qMjoep+9KhxX6Iw5nnBDqkqRe5Sjwrq/GedWLz6ERpMBZNAqp
         swFw==
X-Gm-Message-State: APjAAAVixTNnIqM5WGqINHXrTu4Px5u47l4lS49FCWSUgqnPkTFfVarT
        /2x2/H7/AQxURCQFoEDQj1dpitv4T5Nq
X-Google-Smtp-Source: APXvYqz43J3gj3FJFFk7eWuLDdCsAkB5ssgtC9kn39T9R/ELLx03D9K4hl9FLDXZyDblK1hN4tRBtaVQSWf0
X-Received: by 2002:a67:f30f:: with SMTP id p15mr22276944vsf.158.1556223830537;
 Thu, 25 Apr 2019 13:23:50 -0700 (PDT)
Date:   Thu, 25 Apr 2019 13:23:47 -0700
Message-Id: <20190425202347.83880-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] fixup! drivers/misc: Add Aspeed P2A control driver
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        joel@jms.id.au, andrew@aj.id.au
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        arm@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup compiler warnings:
 - 108 warning: ISO C90 forbids mixed declarations and code
 - 264 warning: unused variable 'value'
 - 335 warning: unused variable 'res'

Signed-off-by: Patrick Venture <venture@google.com>
---
 drivers/misc/aspeed-p2a-ctrl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/aspeed-p2a-ctrl.c b/drivers/misc/aspeed-p2a-ctrl.c
index c0521b2ffc6a..9736821972ef 100644
--- a/drivers/misc/aspeed-p2a-ctrl.c
+++ b/drivers/misc/aspeed-p2a-ctrl.c
@@ -99,13 +99,14 @@ static void aspeed_p2a_disable_bridge(struct aspeed_p2a_ctrl *p2a_ctrl)
 
 static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	unsigned long vsize;
 	struct aspeed_p2a_user *priv = file->private_data;
 	struct aspeed_p2a_ctrl *ctrl = priv->parent;
 
 	if (ctrl->mem_base == 0 && ctrl->mem_size == 0)
 		return -EINVAL;
 
-	unsigned long vsize = vma->vm_end - vma->vm_start;
+	vsize = vma->vm_end - vma->vm_start;
 	pgprot_t prot = vma->vm_page_prot;
 
 	if (vma->vm_pgoff + vsize > ctrl->mem_base + ctrl->mem_size)
@@ -261,7 +262,6 @@ static int aspeed_p2a_open(struct inode *inode, struct file *file)
 static int aspeed_p2a_release(struct inode *inode, struct file *file)
 {
 	int i;
-	u32 value;
 	u32 bits = 0;
 	bool open_regions = false;
 	struct aspeed_p2a_user *priv = file->private_data;
@@ -332,7 +332,7 @@ static int aspeed_p2a_ctrl_probe(struct platform_device *pdev)
 {
 	struct aspeed_p2a_ctrl *misc_ctrl;
 	struct device *dev;
-	struct resource *res, resm;
+	struct resource resm;
 	struct device_node *node;
 	int rc = 0;
 
-- 
2.21.0.593.g511ec345e18-goog

