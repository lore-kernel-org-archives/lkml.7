Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F45BC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89FB20659
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aFa6mpYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfKHNBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:01:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44444 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfKHNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id v4so4390160lfd.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c6cX64DMSTf/KsycxtOgXNPxmcIGKLx/O+3SoX0LMUM=;
        b=aFa6mpYIjn6zAblZVHGQgXXQoRxCga8U3ftmm9BhSW3mk4UWih+KrACx3+tf0MJlpP
         SNfdCuV08yx20a+qynyU5vFYSa4M3OrSAteQlBeLbFzBvXmlTls7gwFWJ1TuyBz4t59s
         xlGRr9NkLpL2PcAqG+7nsK57V4bmDPlz26g24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6cX64DMSTf/KsycxtOgXNPxmcIGKLx/O+3SoX0LMUM=;
        b=P8yxMCz2QZ5nYcCbH/f9J3OPTz9IYbgn75bJU2maHq08O70DjT1cQtUEbpab+C2T2Q
         2BzWgh5uooGtuw7CcaWc+9+dLi3HVzPd8ctMIAgm0ZGSQl8rPxbdbr4HS+lnSVXORzwT
         9NbtUWm4QJ9o85sNSwIVAMnPjrzUFHfSx2iw+VvzpaQKI9pO4+RFjJgnNCBLwcdinaqW
         0wezK7BzjT3uTD1EBPoRQ8f7cm8rqbDrQ4qnX/WEYxEkynU6I4kTr9oVs79d6jsB+opb
         MajmpgC4iXyAWCy4ShbW1su/EInuUueXwaQYIIsfBISaYsF/sqjCyrmhbCa15lXaIRXr
         twDg==
X-Gm-Message-State: APjAAAU6IoWL1VA4t56TQEjAuKxIDQNEYHFb7GkovNpSfrPUe9YCApSF
        AnypDcovPKXcfPhcbPIY28SXfQ==
X-Google-Smtp-Source: APXvYqznOw6lo5cGgyHeltKKm9nZ7shPdmuCfT4xK4W+urGBD8V7imnlpwojsYejoGypQvcmn7GOCg==
X-Received: by 2002:ac2:55a3:: with SMTP id y3mr6602659lfg.108.1573218100653;
        Fri, 08 Nov 2019 05:01:40 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:40 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 10/47] soc: fsl: qe: remove pointless sysfs registration in qe_ic.c
Date:   Fri,  8 Nov 2019 14:00:46 +0100
Message-Id: <20191108130123.6839-11-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
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

