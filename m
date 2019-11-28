Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD5C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687CF21774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Nb+BtkNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfK1O5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:57:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45824 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfK1O5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so28798044ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BSlK9oe7tFf//4Qy2NfrnF4d5nSvsXgepmZkqSuzx3I=;
        b=Nb+BtkNbxW1BFcECDh6UFX0iJiRNDoxBTj+VizTAjinoSja93AqETCqS4cEavhjWkU
         3iE4Cmjv5xaW+1gHMEVlLUsnwNGjzQuPN/YY1M3er+gz3s6Fv9ckj1/4W2+YczmawVgE
         C7r/S6KFnTAvFtE/Z0rVuqdYCbgkcXiYE2CNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSlK9oe7tFf//4Qy2NfrnF4d5nSvsXgepmZkqSuzx3I=;
        b=qAbPVynYvkOikj02i5Iakdi/hSEUUdGeuptAERVo+3TtUeklT/Rg3qEOMJ0F1SDmqP
         mSlLH6/vfr831zUnGIdXwR+UkxCNRz3T6XOXlBQl2J0KKwRwz4XF23QpNpUedJG1LUoc
         /LukIyAM0ddqXfBBfsrXG7xiLnpihMZK3HSLaU9AU0BBOyGHhMPqtZYC+259vMWw/zUz
         f71MMD1yruJbVPz3Qd/AtUJxulT8stUTW0f43v4/gZ/7hP2+m6NWUY5r5wfGkNbIM+Le
         4B4USQ2G0kxm6k/GoVvezc4poPbzLHzQ/3eqpImnxd/5r5OI0kXuzOOlXGm7tQKPk6T9
         w1jw==
X-Gm-Message-State: APjAAAX7KpFQ1Gsn698RylHqQX6W5gD4uKZ2eSm9BexH94oTWRcseJar
        O2SMpcwj4pUfwoLcZiWC3tVdqA==
X-Google-Smtp-Source: APXvYqy4JS+AOt1j8qqH5QrK5A1msfYt3pqh9XYlcQjLvsA4Cy/8OwTNm2hhTB7Om9p+bADuYHPpqg==
X-Received: by 2002:a2e:96cc:: with SMTP id d12mr34338565ljj.210.1574953056036;
        Thu, 28 Nov 2019 06:57:36 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:35 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 24/49] soc: fsl: qe: qe_io.c: access device tree property using be32_to_cpu
Date:   Thu, 28 Nov 2019 15:55:29 +0100
Message-Id: <20191128145554.1297-25-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to apply be32_to_cpu to make this work correctly on
little-endian hosts.

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_io.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index 99aeb01586bd..61dd8eb8c0fe 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -142,7 +142,7 @@ int par_io_of_config(struct device_node *np)
 {
 	struct device_node *pio;
 	int pio_map_len;
-	const unsigned int *pio_map;
+	const __be32 *pio_map;
 
 	if (par_io == NULL) {
 		printk(KERN_ERR "par_io not initialized\n");
@@ -167,9 +167,15 @@ int par_io_of_config(struct device_node *np)
 	}
 
 	while (pio_map_len > 0) {
-		par_io_config_pin((u8) pio_map[0], (u8) pio_map[1],
-				(int) pio_map[2], (int) pio_map[3],
-				(int) pio_map[4], (int) pio_map[5]);
+		u8 port        = be32_to_cpu(pio_map[0]);
+		u8 pin         = be32_to_cpu(pio_map[1]);
+		int dir        = be32_to_cpu(pio_map[2]);
+		int open_drain = be32_to_cpu(pio_map[3]);
+		int assignment = be32_to_cpu(pio_map[4]);
+		int has_irq    = be32_to_cpu(pio_map[5]);
+
+		par_io_config_pin(port, pin, dir, open_drain,
+				  assignment, has_irq);
 		pio_map += 6;
 		pio_map_len -= 6;
 	}
-- 
2.23.0

