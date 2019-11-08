Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12554C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEAE2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="jCP7ncOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfKHNBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:01:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40361 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbfKHNBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:39 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so6130459ljg.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLof2Ot2O0jJsk//b5zfFITAj/UOtVeGro1UsWAolSk=;
        b=jCP7ncOrlS9V+R3cn5ptO3MSbytb9V/nOEyYaHDdTAuICV+rBxthP4W2CHez0HZDiS
         Yx5Ju4fDxbp0NxnFiHEjo5QTOyvtFvHRctjxQAvjU2l7kKTy29JWehdL20U6Iybx6HD2
         osrcSPnJAZYtH6b9nc/143h02+9RvjyefOv2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLof2Ot2O0jJsk//b5zfFITAj/UOtVeGro1UsWAolSk=;
        b=HdPzV2fpCXC8FgDpEJ3dkqbUf1htcqzIzdXhqAG3kJYMFnOaesW1u27yxbKS4YdMeT
         2u0uqRM8ECeY/6VgtlzmG/YeakFDh0gO85mv7Z6LtQ4ldvK4s5VUaKt7sWvHQGzuEneb
         Uvbox0jhxopOZA4E36JjF4/aoal7t/vNiGmK+ATu7xkTzYcFmO1g5GdDnlKjIbPz9G3I
         bjD2ExhJigsmbReSjcsTl7i55hSFs+qqCLEBH2mT9kkEPZIZ1Dz4kh4wg5+ZS78R2bKt
         6TxZ3K+y8x+W/sfXiHfOqSXHD9r23hZjcfSpXNYZZ1Gdtd0IOHBOTonGDAN8kjJ0WM0k
         vQ2A==
X-Gm-Message-State: APjAAAW825FdSNcnWl5r4/VWvMGZRwZXPJfMPFi17HlfVp62ulsfkZn8
        bpZ/3q4dt2NdPMFvy8OYSw9zYQ==
X-Google-Smtp-Source: APXvYqwznZFGp1Fw3DbicIfyzdwRL4WKmsCqwntFcEZldqkryvHNh+dxThjls+WNtclCmbq6A/BMZw==
X-Received: by 2002:a2e:9610:: with SMTP id v16mr6626644ljh.219.1573218095535;
        Fri, 08 Nov 2019 05:01:35 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:35 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 06/47] soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
Date:   Fri,  8 Nov 2019 14:00:42 +0100
Message-Id: <20191108130123.6839-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing QE to be built for architectures other
than ppc, use the generic readx_poll_timeout_atomic() helper from
iopoll.h rather than the ppc-only spin_event_timeout().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 456bd7416876..85737e6f5b62 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
+#include <linux/iopoll.h>
 #include <linux/crc32.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of_platform.h>
@@ -108,7 +109,8 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
 {
 	unsigned long flags;
 	u8 mcn_shift = 0, dev_shift = 0;
-	u32 ret;
+	u32 val;
+	int ret;
 
 	spin_lock_irqsave(&qe_lock, flags);
 	if (cmd == QE_RESET) {
@@ -135,13 +137,12 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
 	}
 
 	/* wait for the QE_CR_FLG to clear */
-	ret = spin_event_timeout((qe_ioread32be(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
-				 100, 0);
-	/* On timeout (e.g. failure), the expression will be false (ret == 0),
-	   otherwise it will be true (ret == 1). */
+	ret = readx_poll_timeout_atomic(qe_ioread32be, &qe_immr->cp.cecr, val,
+					(val & QE_CR_FLG) == 0, 0, 100);
+	/* On timeout, ret is -ETIMEDOUT, otherwise it will be 0. */
 	spin_unlock_irqrestore(&qe_lock, flags);
 
-	return ret == 1;
+	return ret == 0;
 }
 EXPORT_SYMBOL(qe_issue_cmd);
 
-- 
2.23.0

