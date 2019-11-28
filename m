Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A516BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0D321771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="K2wEiOKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfK1O7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:59:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42484 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfK1O5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id e28so4647807ljo.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nzzyzsivy+YcXl/jyzCYf1SBk8p4BrEyK9ScDwPsYTY=;
        b=K2wEiOKx+dAnA20pPj/gC7k2WKFK03JPBFAMB2+x1KJ6IuQ/uzYy9NIfORoCqtv3pO
         dWqQg66agfm4ME7e+/iKZAKKQcUv7xPOdFY+K30U/ZIKEFr2OWIUlEL30xH0BCtMLQa4
         fBZ6XqpmIXYhwdW204OYq/yNppQkLMCsU8gWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nzzyzsivy+YcXl/jyzCYf1SBk8p4BrEyK9ScDwPsYTY=;
        b=B0yCp/iHJbdefbX8UUvq98HZYF3L0udVwfyJmX+lljsVWwyD1XbkwXzb8yyna+YyhM
         SZW0bRe3Xey+ySuyrh1Z3pGBGyoUNy+9kCLlmStsUegClF5modzlzUTeeFkRL/QaqwNu
         LnuDcXChH6B8GPuSHNhhPkTRvYCVskcI/JXsgS77e2mt+g96UZNqmj3aWQi7n80p/0VN
         vBB+TjAe6HfsUMEAWCzwcdzeKUOV1T6OzGtTzjJnNnLCvIt02EstE5+7WYrWotsKo7za
         rDTyP+9RAR+UIj+837CJypO2NadbOeWGtVD3AgCvh6Z9uAbvwxEA6YIf0yXqQPSwRKM5
         syFQ==
X-Gm-Message-State: APjAAAVkJsJvT2ItViF+9co/DMYQNe+hXTD7zbp730BeT4fz/uWkzIw2
        AO7HYgaSxwz69jdO0/BIa+uYZQ==
X-Google-Smtp-Source: APXvYqxcCZp9VC/hOwbAbqHS7Mi8diiPVBeVRdJba1gvlZ6qtvTT24K8z3rdfj6gIFE8XPjaG9eObw==
X-Received: by 2002:a2e:9f4d:: with SMTP id v13mr35083259ljk.78.1574953054971;
        Thu, 28 Nov 2019 06:57:34 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:34 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 23/49] soc: fsl: qe: qe_io.c: don't open-code of_parse_phandle()
Date:   Thu, 28 Nov 2019 15:55:28 +0100
Message-Id: <20191128145554.1297-24-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_io.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index f6b10f38b2f4..99aeb01586bd 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -141,7 +141,6 @@ EXPORT_SYMBOL(par_io_data_set);
 int par_io_of_config(struct device_node *np)
 {
 	struct device_node *pio;
-	const phandle *ph;
 	int pio_map_len;
 	const unsigned int *pio_map;
 
@@ -150,14 +149,12 @@ int par_io_of_config(struct device_node *np)
 		return -1;
 	}
 
-	ph = of_get_property(np, "pio-handle", NULL);
-	if (ph == NULL) {
+	pio = of_parse_phandle(np, "pio-handle", 0);
+	if (pio == NULL) {
 		printk(KERN_ERR "pio-handle not available\n");
 		return -1;
 	}
 
-	pio = of_find_node_by_phandle(*ph);
-
 	pio_map = of_get_property(pio, "pio-map", &pio_map_len);
 	if (pio_map == NULL) {
 		printk(KERN_ERR "pio-map is not set!\n");
-- 
2.23.0

