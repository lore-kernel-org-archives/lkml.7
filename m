Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F14C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A1724650
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO0H+/B3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgACBWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:22:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40223 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACBWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:22:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id s21so15733170plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 17:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bU5ftLS707p9emizE3edIYm0K+YhoKgbEoXph++J77w=;
        b=eO0H+/B3YNkJ+haDdGN+fbtIbWIn/p6bpiH1PwpZe9t6uL1eeyp65FzJJdyYY7HhSf
         WaE84+UaWzceahHQgxKS4dWCNHCM4F60SfK3s1hBJumBaVWsdDdwoUT9PnAXb+Jt38fN
         zzBf9HFVU++uSOgJOfZQ6il2XER4J7l6y3GGV8RRgYf05/Md+lnvK9jARlCDS0FVogdt
         AFgR6GMTtHFVUPwPSTGG/dND07TYubmNhV/jeEw7F6hknKMXKUIZnqhAgm0DfxB9um5c
         DYT39amJJcWHMZiMFooMMxg7aPZpFrGF7KyaazDjW1tMBcmD51qG3A9H0P1QiqoZNeeg
         Xuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bU5ftLS707p9emizE3edIYm0K+YhoKgbEoXph++J77w=;
        b=T90lXZxLFaox5BkaC/MeUfzqFUvEKwi22qHIcNmwpNs9Z42SL9nIAxlL+R5jM4RvTn
         IcwtTfrN4sfWiCS2vSchJrkFlLrvhEO1ip94q0qSU44n+8JwtPTtmrTYCbs1h4hOwbQj
         uFkcyIReR7YNpgDsRnifZ6dqAQen7b9b/wRrf4o/uLwfy78vpq0cesHAy2jucV3IUHOd
         0NH9TKbETRMXxA9O97ib/6tOwCliCNKbPSNDKdgDUIqAN/kpDnh4MirWDS6Y+la3yALN
         b7JTfvDK+lpKh4F0gPP0O6KKIBXlewapJQ3Q/qXaEixrNqMwCzAIATQUD2x+KLNuSRd4
         wn0A==
X-Gm-Message-State: APjAAAUBPsy7GFwpCGFvW2txVc/yEoD8ZJboXVRQ8m9HSDqOp9Womw39
        WqYup5BJxB4Sv73qWvBiyzU=
X-Google-Smtp-Source: APXvYqyATFbZFIEDnNWcj+zkkjNdcQQxHVjcQ54l21Dfx1AnlJiuOJM+y/3cLzl1opelaNTSrfJXFQ==
X-Received: by 2002:a17:90a:a88d:: with SMTP id h13mr23480887pjq.48.1578014560241;
        Thu, 02 Jan 2020 17:22:40 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u23sm65044792pfm.29.2020.01.02.17.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 17:22:39 -0800 (PST)
Date:   Thu, 2 Jan 2020 17:22:38 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: atmel: switch to using devm_fwnode_gpiod_get()
Message-ID: <20200103012238.GA3648@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_fwnode_get_index_gpiod_from_child() is going away as the name is
too unwieldy, let's switch to using the new devm_fwnode_gpiod_get().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 8d6be90a6fe8a..849bd5f16492d 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1578,9 +1578,8 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
 
 	nand->numcs = numcs;
 
-	gpio = devm_fwnode_get_index_gpiod_from_child(nc->dev, "det", 0,
-						      &np->fwnode, GPIOD_IN,
-						      "nand-det");
+	gpio = devm_fwnode_gpiod_get(nc->dev, of_fwnode_hanlde(np),
+				     "det", GPIOD_IN, "nand-det");
 	if (IS_ERR(gpio) && PTR_ERR(gpio) != -ENOENT) {
 		dev_err(nc->dev,
 			"Failed to get detect gpio (err = %ld)\n",
@@ -1624,9 +1623,10 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
 			nand->cs[i].rb.type = ATMEL_NAND_NATIVE_RB;
 			nand->cs[i].rb.id = val;
 		} else {
-			gpio = devm_fwnode_get_index_gpiod_from_child(nc->dev,
-							"rb", i, &np->fwnode,
-							GPIOD_IN, "nand-rb");
+			gpio = devm_fwnode_gpiod_get_index(nc->dev,
+							   of_fwnode_handle(np),
+							   "rb", i, GPIOD_IN,
+							   "nand-rb");
 			if (IS_ERR(gpio) && PTR_ERR(gpio) != -ENOENT) {
 				dev_err(nc->dev,
 					"Failed to get R/B gpio (err = %ld)\n",
@@ -1640,10 +1640,10 @@ static struct atmel_nand *atmel_nand_create(struct atmel_nand_controller *nc,
 			}
 		}
 
-		gpio = devm_fwnode_get_index_gpiod_from_child(nc->dev, "cs",
-							      i, &np->fwnode,
-							      GPIOD_OUT_HIGH,
-							      "nand-cs");
+		gpio = devm_fwnode_gpiod_get_index(nc->dev,
+						   of_fwnode_handle(np),
+						   "cs", i, GPIOD_OUT_HIGH,
+						   "nand-cs");
 		if (IS_ERR(gpio) && PTR_ERR(gpio) != -ENOENT) {
 			dev_err(nc->dev,
 				"Failed to get CS gpio (err = %ld)\n",
-- 
2.24.1.735.g03f4e72817-goog


-- 
Dmitry
