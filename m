Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9F8CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D94A222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="XF8lRfpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410093AbfJRMw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:52:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45701 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408106AbfJRMwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:52:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id v8so4050438lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WqY3EZbKbSCMoeBriPS6VskekmvRpOlr9LtT3vYdVX4=;
        b=XF8lRfpSpXS43H8bXGLZxjGol569DjdpudtIDqLtYNaQX5nW/mNgEslchokWcYdbBT
         gZwtqZAGgisTwryr+nlyFucbhWiB56hccjVc9yC9gh4PhbNPAnAPL5uoWxrY+tN0edmW
         KqRirxHWM8yqGHgnHVp/yCKwpRJqIGeRL4JTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WqY3EZbKbSCMoeBriPS6VskekmvRpOlr9LtT3vYdVX4=;
        b=TwbvxWxKVEQM/GtGyds/fRnwedF2wmcv1sxeBBrJ+hp2rd/5r0TQ56xFBvINe6Gf2G
         3jSYupamOrJm8HsNiFR2+4OLi5nr5ux7ZTTff07IYpbkWahKI+biv00AC9X8fHbJ+KUU
         ng6lQ121BYr/3MEJ+RPWyXzK31Iy3+28L51WjmAMED1mdttRrN9KsyG2AHj3Pf8HR2Cm
         /8EK8FvdCsACuTT3HHuEtd4QEgLlpvoqt9uuE9VPvFxAXQsNM7xsiQ1/GAIPQ/aFIGWj
         TNPkorUMzsPmQY/3s6tzNN3ad8gvcy7MS/RHDOq+9OluExe+3vWVJD86m1nmfktWb8d/
         iCJw==
X-Gm-Message-State: APjAAAWHJJl5/RQC5uN0ux68CFWMKfiFy+RpYq7COa79+HfSySjw4Nb8
        79oG/X5yZenc5tmBLRCrg6kbEKFVRZ2Ov1cl
X-Google-Smtp-Source: APXvYqzfr8d1XGwlHtnCPHMvgh/gDAKdPrDLe/e9yGmcnVUmiy2hG/ezT9PzT3PwhiN1YF3sXeWfXw==
X-Received: by 2002:ac2:51d9:: with SMTP id u25mr6183432lfm.19.1571403168378;
        Fri, 18 Oct 2019 05:52:48 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m17sm7454792lje.0.2019.10.18.05.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:52:46 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
Date:   Fri, 18 Oct 2019 14:52:31 +0200
Message-Id: <20191018125234.21825-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
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
index 60bf047001be..d18b25a685ca 100644
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
-	ret = spin_event_timeout((ioread32be(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
-				 100, 0);
-	/* On timeout (e.g. failure), the expression will be false (ret == 0),
-	   otherwise it will be true (ret == 1). */
+	ret = readx_poll_timeout_atomic(ioread32be, &qe_immr->cp.cecr, val, (val & QE_CR_FLG) == 0,
+					0, 100);
+	/* On timeout, ret is -ETIMEDOUT, otherwise it will be 0. */
 	spin_unlock_irqrestore(&qe_lock, flags);
 
-	return ret == 1;
+	return ret == 0;
 }
 EXPORT_SYMBOL(qe_issue_cmd);
 
-- 
2.20.1

