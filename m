Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CF3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47B320821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbxmi97p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfDPIqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:46:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41254 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfDPIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:46:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id t30so15340680lfd.8;
        Tue, 16 Apr 2019 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xKigAcx4Ds/SUltxh5aj3lsI7Bl/GTQxoinEaIjaoWw=;
        b=Lbxmi97pZ5qgWBdJoMtopySOJgPUP8bg+ZQC2udKcCvpB3UAg1ymNykdY7ser5KYcE
         iV8ty6bL+RR9GQzCzsu6cdpWTmAsalcaET4+b6Enq7vG0qqfsDqJbZaMi7TFzr9X9tbA
         jPdCnDYOJSy9wJg+BDPk+O0IVDomhtx67MCvhKIKtq8O02DY1ZyexY7FykICKnABcYNZ
         sFIIjh/uMhZ2+Fz7G3na3BlICxRELA+Y4Ul0piIIFpUeLl3zh+aswb6S5oDh7VGAf5JT
         HxYkJXTco5zzHFtutLCNlh1qsL7Wg1oBy7tTeY22c5k/0SEKnXt6IXOY/RMBKa+amJaL
         rjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xKigAcx4Ds/SUltxh5aj3lsI7Bl/GTQxoinEaIjaoWw=;
        b=pPWcfDxp/P5evDOLJJYbJNhDQ/8RFUN+ZPF0iocYPORwFh9bra9b71EtfDAtHu1WTv
         vDdUtnjki54ebW6pOktJZKMsSisPP7lM8Lnne6ai/rkXCG0Ivk+UMjIK8xD6RazUZ+ac
         +Y1K70/z9ohqLdDkq2ZWzRF+5q4MLVAS3um+DGcVvX1LF+V+v9tj2SujuZtKKCR9uLzb
         BJ2NKFqQfHV75ddm7U6TyNsP41gQQJGuXlY1Eatar/If7J8l0cU/lfdRd+sH2n6FZUTs
         PIq60665Md5jtRhNuD6ITkofAPyZpZ8MGIvJ8Q3P7nRYtzFgWOp669CRl82B6vuhtLA6
         zW/A==
X-Gm-Message-State: APjAAAUVRH+81QregsEYUVU4edyfsfkglo57qeovCn+lVmxxZ3qx37Vx
        4ppLzYhFTgXFBiIlbaz/GbZ8hSleHjBYVg==
X-Google-Smtp-Source: APXvYqwsvLLxcXMEJqWZ51UkkOJaNw27DZ6E+yMp7MRtST9ED+jTDbN/LaF8th190dh7wv75nqO7XA==
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr34332149lfl.57.1555404379813;
        Tue, 16 Apr 2019 01:46:19 -0700 (PDT)
Received: from localhost.localdomain (62-167-31.netrun.cytanet.com.cy. [62.228.167.31])
        by smtp.gmail.com with ESMTPSA id b25sm10145505lje.71.2019.04.16.01.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 01:46:19 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     rogerq@ti.com
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: memory: This patch fix the following checkpatch warning.
Date:   Tue, 16 Apr 2019 11:46:12 +0300
Message-Id: <1555404372-3582-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch hardcoded function name with a reference to __func__ making the
code more maintainable

WARNING: Prefer using '"%s...", __func__' to using function's name, in a
string

Use pr_warn instead of printk

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ...
then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/memory/omap-gpmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index f629759..685f422 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -795,7 +795,7 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t,
 #endif
 
 	gpmc_cs_bool_timings(cs, &t->bool_timings);
-	gpmc_cs_show_timings(cs, "after gpmc_cs_set_timings");
+	gpmc_cs_show_timings(cs, "%s", __func__);
 
 	return 0;
 }
@@ -1033,7 +1033,7 @@ void gpmc_cs_free(int cs)
 
 	spin_lock(&gpmc_mem_lock);
 	if (cs >= gpmc_cs_num || cs < 0 || !gpmc_cs_reserved(cs)) {
-		printk(KERN_ERR "Trying to free non-reserved GPMC CS%d\n", cs);
+		pr_err("Trying to free non-reserved GPMC CS%d\n", cs);
 		BUG();
 		spin_unlock(&gpmc_mem_lock);
 		return;
-- 
2.7.4

