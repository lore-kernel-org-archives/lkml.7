Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844C1FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFDD2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZJaCGSD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfKHNCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:02:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44281 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbfKHNCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id g3so6103960ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1C8bi+Glp22eU2mPHcIIhRfHNSQMvhbk1zxbdzRB++Q=;
        b=ZJaCGSD/arZGUVVsA5xq44Wxb64fr04WyEwSqeiMjW/L1bVDA+aRYM5sWnLo9sepTk
         TEYKJVX4TsUvrSj/LBfKdVrHXqqZUd2PojOxysRopWU2rsgOWmwVffTPBZ9VIs+RV9VH
         MU/RAqLHFpt23mFgSHXKebqI6NeVbe7jcxiAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1C8bi+Glp22eU2mPHcIIhRfHNSQMvhbk1zxbdzRB++Q=;
        b=Mgtz/f1BLb+4e7spbgczAKuCvm/xTyBsDKyy+w+Cye4EndPHe1aX35u+2J9hB/6HeL
         ldtGGlsxqxIu+2hNb/QA0vW1st29H/SJMw2p42h1LNOkQPYBKFGKjNMkkcKz7Uw2hwt6
         zVaXpiQzNO3Sv5TbbUmf/mMOGetsUuub28h08VmTjtVYhBjZMcfxybJPzhFx808xxsLJ
         fxxHL00LIi2voRx872EXVIg8X65gDNPlqGcNPDaKagF64pakd4YfQ+01eUppo+8mOn8V
         GpvCRXE1/pWdZMmRSmlbBkGCEUGt7e0Q/gV9Mhfl0rLaA66v4wieid1Ei5BGaQXrUhah
         sZ/Q==
X-Gm-Message-State: APjAAAXt+0Q0ULpO/KWcLf5nkHQRE6LDZoTjKUsA5VjeG70W8CyLXvx6
        40TZP5v8cZ2tbxHmatIffzryEA==
X-Google-Smtp-Source: APXvYqwWLpxibry98XoXovz1dothFdNyuvaZNGn+39NnRK53Lft+7SISDG4Rx9pkkMNEWGx3k3O/UQ==
X-Received: by 2002:a2e:884c:: with SMTP id z12mr6614926ljj.41.1573218117142;
        Fri, 08 Nov 2019 05:01:57 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:56 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 23/47] soc: fsl: qe: qe_io.c: don't open-code of_parse_phandle()
Date:   Fri,  8 Nov 2019 14:00:59 +0100
Message-Id: <20191108130123.6839-24-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

