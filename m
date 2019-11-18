Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373E3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0BA2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TWX9iBpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKRLYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41415 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfKRLYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id b18so17545817wrj.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1C8bi+Glp22eU2mPHcIIhRfHNSQMvhbk1zxbdzRB++Q=;
        b=TWX9iBpwdpSNUgpJ/cUdC3Epzue8lAUKQth8hP+iX2zCk3JnB67JdPmo2cnMyzbduE
         aMo8BAZYKyCe25eCCHhnVtjFsg6NdBfAYdBSLpK6akVSb6dEwTAoUQ0168Nhq2K9wUQW
         zPnEeNERzqbndvpDwZzJpYA4bOmnl+GKVAuj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1C8bi+Glp22eU2mPHcIIhRfHNSQMvhbk1zxbdzRB++Q=;
        b=BfbGYep0AKzbRhbzEFbPft/4QZvqRxErBz4g5n54EvXj+oszfQFGK+tsliSyEn/jf1
         WIqryLGiB3Kl/XOuiO1j/VaCeehEWdrYBQkNOmUETjj30b3yJfr0rHBTMr17DE5Buo9+
         /A+Asyra9deKyaqHbhOtoROmZmiL992wMu5aJ8YsJS7D9le6HXw7VjRJ5GrUkEu1tsED
         8NWp3W9WV41WVybeD59HBpFekhJQ6VzUnjXdnSS81Sje3z8/ZLGBv5PEiFZBro16y6CB
         tjhomuRSRHFk+5D/TJt6ypzpA1yK3qLtbMzPhQ8yOpgovd8Bv1cBujBiEhHKU4saNPg5
         xITA==
X-Gm-Message-State: APjAAAV4/3U7Sew2tYu99q+oCXXiBTY2cKm5jACTVli66bF6r7j32MqK
        uaaaNaSwZynrNlKWZTB333qFqu9iKxSwdg==
X-Google-Smtp-Source: APXvYqyU40TIEBeeNT1xotdOz5OkMurLXXVSorlX6DaEtGjrmXTvcB0yK0PqCzhmSIW/U7/u5ZYHhA==
X-Received: by 2002:adf:d091:: with SMTP id y17mr30844295wrh.182.1574076240560;
        Mon, 18 Nov 2019 03:24:00 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:00 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 23/48] soc: fsl: qe: qe_io.c: don't open-code of_parse_phandle()
Date:   Mon, 18 Nov 2019 12:22:59 +0100
Message-Id: <20191118112324.22725-24-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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

