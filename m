Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E714ACA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBD321D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Lujjlyr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440321AbfJYMlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:41:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46867 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440298AbfJYMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so1599290lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KpsQXq8uXz3AjuC8zFugbFdIMVLEeL/wAcaNezuzQIg=;
        b=Lujjlyr+AfXRRl+wGvn8Qvihn/KN8LWCqi4kolwlKQZ7qjqldAl04AGkDa5+2tsD/r
         yj6GGSKX09NBG8L94vYyMd0K4TnZcW1MStdU1wA1BSIa87qLvQlGrwuQZ4FYy9GlPjE4
         1nHwzz11Ni13Hg5j85JaC31Bke/wlaf4zEK5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KpsQXq8uXz3AjuC8zFugbFdIMVLEeL/wAcaNezuzQIg=;
        b=ilMAnMj85i4+uNGwNbPJPfD3/J5YTMwe2sxcm60wBfSS09R3Wg7M+cWgEMCislwYor
         /imdvEiAeKARDWOU67kzlMGxp2x+ijJAAu+04sHQA0msavLwnXiaAg692h7UfLVW46EJ
         8+rJO0PTEr+E21carL1Wj8U7I7jnNIMGKgZUW3DXAUvaEC0RGQhjjBqWQcaIUOLOCpw/
         tWGxGeaMbTtIL/fTiw206I7iexZDCKxb3/UfIJsvLiMxvT7TA4Smpcfd1DfvL/DuCipt
         hTq0Xy2H1q0mLBBKAODyIjQ2YEvPoMmMRmegy/vLGO4RYRoc80c4gxSQgRdrkuI3TSYb
         5mCg==
X-Gm-Message-State: APjAAAVmR+HE6GXMPSKtppzMO5jRaSAU1RM+ULa4ASU0nXo2qTFkrvrD
        z7o0z45Bw7Yfoejxt6dycOy9gw==
X-Google-Smtp-Source: APXvYqzQ4jZPtompIQ6wN1YvHfqQ3rKdaVk4lJJ+494PK+/61L3WRbLUt2K3EJ0JdAgAc1tvXnRrhg==
X-Received: by 2002:a19:5e53:: with SMTP id z19mr2490404lfi.111.1572007267800;
        Fri, 25 Oct 2019 05:41:07 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:06 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 04/23] soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
Date:   Fri, 25 Oct 2019 14:40:39 +0200
Message-Id: <20191025124058.22580-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
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
index 60bf047001be..bcdec37b25ca 100644
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
+	ret = readx_poll_timeout_atomic(ioread32be, &qe_immr->cp.cecr, val,
+					(val & QE_CR_FLG) == 0, 0, 100);
+	/* On timeout, ret is -ETIMEDOUT, otherwise it will be 0. */
 	spin_unlock_irqrestore(&qe_lock, flags);
 
-	return ret == 1;
+	return ret == 0;
 }
 EXPORT_SYMBOL(qe_issue_cmd);
 
-- 
2.23.0

