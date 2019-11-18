Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C70C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFA220862
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Hs8PX4sV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKRLYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:24:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34740 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfKRLYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so19017784wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UljkrHErTTnMZOnzGC3cVx/3LEJEQ4UWt74UluMX0lk=;
        b=Hs8PX4sVJIwwkhMnX/i23yvXVKgiBAZ0EflioICFlUiNZBktVM50OF+N1SRAhov5c3
         bEK5SKUGxm13GFe25nWAeNF04u+FVpabTehtOzibHm8/2w1qxPg65sxQcTApGI7GMrCs
         Sdfak0xZuyoukt02m38D386ldKNHrflp0r1yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UljkrHErTTnMZOnzGC3cVx/3LEJEQ4UWt74UluMX0lk=;
        b=d6DjCtO+rY6P41iEu6EO/qUQP4H5uGxhNByJ0MMRnc9nxDsqmrW6iNrlsgKHUeoU72
         YxGvyXgXkhpaYLpHg064fIReQg2rp5bZaTaF249Js1j/lznCfus0nennp+QRu8PlBZId
         cv31plAY1aNCUIScozGRUP/0xdMMDxqqW4/61/t8GL1n/03bjH6NICv7YSSBwYr231gK
         pR/angZaisFnQ3fvmkkwFkAU62oYeXK0gAOM21r9TWcz8szEBjAY7/2MxnLpQfiHKQQ5
         2iPZSA43qclIIEJy0XGyCWSEdVBq1e8to0NXaLEeKDFXagw+PajQ+qAf1WaEEgNIAIhZ
         /oUw==
X-Gm-Message-State: APjAAAWF5zWcE854uZy92l06e/+HpQdQ4mZbce3zyvfVajW5PHeCLHsD
        RRsY7SrmUDnyXUfiJiTqq2Fk/w==
X-Google-Smtp-Source: APXvYqx1qUmVxbnUojGI2hh8REIAqzLfraBuKrR6T3lZNpWA7RXt75BGBSItMF5rI/cMRCq9gCkq5A==
X-Received: by 2002:adf:e3c4:: with SMTP id k4mr10747487wrm.356.1574076243541;
        Mon, 18 Nov 2019 03:24:03 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:03 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 25/48] soc: fsl: qe: qe_io.c: use of_property_read_u32() in par_io_init()
Date:   Mon, 18 Nov 2019 12:23:01 +0100
Message-Id: <20191118112324.22725-26-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is necessary for this to work on little-endian hosts.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_io.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index 61dd8eb8c0fe..11ea08e97db7 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -28,7 +28,7 @@ int par_io_init(struct device_node *np)
 {
 	struct resource res;
 	int ret;
-	const u32 *num_ports;
+	u32 num_ports;
 
 	/* Map Parallel I/O ports registers */
 	ret = of_address_to_resource(np, 0, &res);
@@ -36,9 +36,8 @@ int par_io_init(struct device_node *np)
 		return ret;
 	par_io = ioremap(res.start, resource_size(&res));
 
-	num_ports = of_get_property(np, "num-ports", NULL);
-	if (num_ports)
-		num_par_io_ports = *num_ports;
+	if (!of_property_read_u32(np, "num-ports", &num_ports))
+		num_par_io_ports = num_ports;
 
 	return 0;
 }
-- 
2.23.0

