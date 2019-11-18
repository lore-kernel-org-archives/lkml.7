Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F4C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45772068D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cUCcyumy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfKRLXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:23:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44511 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfKRLXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id f2so18982439wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c6cX64DMSTf/KsycxtOgXNPxmcIGKLx/O+3SoX0LMUM=;
        b=cUCcyumyZWoue8UKqpho89r5qAqWtZm3cCD3s6yvL1ZAIjEdjV/iA1g+uot/suUr76
         mgN3wnD109p+/BxYSQtR3MRIfynOlo8CHLqvYM/2VL//6doQaKXUzW0bBOXQIlKfDkVt
         bE2Zy1hsnKS6iQJLp7YN42rV8yqYAwM8H+ou4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6cX64DMSTf/KsycxtOgXNPxmcIGKLx/O+3SoX0LMUM=;
        b=VZsAdHkoEVMx0RHMZyNZoaBa028I5/eWBwDEVxawmaSoOKopGliVPEZ2zeKLxyRQ25
         lGothvvap7GNPr3F0fhwtQU1AAbD2LnX6ssNeYq34C/M+l8/55brcWv7NYlxn1u++of1
         pthth5W4Z0XBsszpvacC+E5F1Ob/appjo8UyBGAz+jxlR3JRaWAnAKHAXW96s9xLrSzI
         ROEWcY+N/gHXXxuGHSCOubAJrXqg4yVXbjPetulq70FAe0GE+DtEyJ3xIFVyjPpBELJ9
         wybtXGjarNZwnyE09pJWMRACfX7RFuvkGyijgJT4yMu8fpUldsgkLD7FP0iSVfjR4CPk
         JilQ==
X-Gm-Message-State: APjAAAXcm+aV0zYf3ZoPCikNXPNLCukmY7Pxg+ua55vCmtZKS2WfOGTN
        Qp1KQjg8oMYywm8HxykpbQiSnQ==
X-Google-Smtp-Source: APXvYqxKtQ/L0jtybhpqM+fbDm+9z0zHRS37cs3RGG+HQSXfkyGVUGkwSkFQQXJyDBhH+RoV9eP+Og==
X-Received: by 2002:a5d:55c7:: with SMTP id i7mr30697760wrw.64.1574076222980;
        Mon, 18 Nov 2019 03:23:42 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:42 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 10/48] soc: fsl: qe: remove pointless sysfs registration in qe_ic.c
Date:   Mon, 18 Nov 2019 12:22:46 +0100
Message-Id: <20191118112324.22725-11-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point in registering with sysfs when that doesn't actually
allow any interaction with the device or driver (no uevents, no sysfs
files that provide information or allow configuration, no nothing).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 4b03060d8079..f170926ce4d1 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -474,34 +474,3 @@ int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
 
 	return 0;
 }
-
-static struct bus_type qe_ic_subsys = {
-	.name = "qe_ic",
-	.dev_name = "qe_ic",
-};
-
-static struct device device_qe_ic = {
-	.id = 0,
-	.bus = &qe_ic_subsys,
-};
-
-static int __init init_qe_ic_sysfs(void)
-{
-	int rc;
-
-	printk(KERN_DEBUG "Registering qe_ic with sysfs...\n");
-
-	rc = subsys_system_register(&qe_ic_subsys, NULL);
-	if (rc) {
-		printk(KERN_ERR "Failed registering qe_ic sys class\n");
-		return -ENODEV;
-	}
-	rc = device_register(&device_qe_ic);
-	if (rc) {
-		printk(KERN_ERR "Failed registering qe_ic sys device\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-subsys_initcall(init_qe_ic_sysfs);
-- 
2.23.0

