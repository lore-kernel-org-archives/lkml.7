Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4BDC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA892184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIzOpVBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbfHZUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:00:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35004 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732784AbfHZUAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:00:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so15139857qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gitDgFWFiAYObukIncRSKd/yXSxIJk3TvsvI290/qpE=;
        b=oIzOpVBUIqARd9JSnQKGSgho33n8HXF2OOd7R0omV7BwwD25PhxIL3stBWornrozZF
         WzlALopXzBZ4rNYOM4KvOE8t3g59UDIgDxaRZJ4QRXLvoEyjq5FKaBjGEQiGY8OULRRu
         OxAGCWUw4pWCzyzcIwZrJU8fUZW56+ACHmPRXAIbWCkEcDWGIomyhD1kCK9hFcdTOgfS
         cCknx4o2c9HCNb/msQvOPHCA8OmpexJ9JUxijeXcVL9HUYsobTa4YNVvythBmZh/BAfP
         1UIKoEj5GCgg7uhMigiIxbNePJSfCdqAWUImWE9zfNduNQXqGD1R11av8oRtWwDOOqj7
         FBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gitDgFWFiAYObukIncRSKd/yXSxIJk3TvsvI290/qpE=;
        b=YvLKLI8bnZ9oIg8J4NhtuV967lM5QVsYY9w5wbF5aYW2LsCJsODcvqQHWH9v13PpN8
         czqYa+FDO7ta5lwQf/1hi4ZPKY7awEG3btmy34YMOD5IjAnc6kUC7wO6ru9YtJQUQpJh
         /9N1e/C2e0gzon+jftX+L913R0mRShllm525i3ofP4nG5vOYgebMXrgRloc5PE0Q5anh
         xGBhFx7nWwucWKTyvTuc1dmK3w/gKnQo3RXqD83rUwccdOIuYSL6q2+uq+oxwuTQgkMW
         jmJlmFWHPx51V5Vpinj4YOzFQLK10rinNdmH9VUX90EwvM8N0P2R2daDWqzLvSlhAkgN
         tGYw==
X-Gm-Message-State: APjAAAWK0TzS8zR2388Mun7yIP3ce0i/+dqXxIcu9NF90HQwJ6nnijqm
        m853LsKTHe7x2GwXtZIRVbI=
X-Google-Smtp-Source: APXvYqx+npWZxLi5RVoB/r0dxsKSw3thcAXr+4bhSJrIlPweDmqSsBRnOLgADnGU+RGN9y54jdtzAQ==
X-Received: by 2002:a05:620a:7c8:: with SMTP id 8mr17339442qkb.424.1566849608340;
        Mon, 26 Aug 2019 13:00:08 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id o21sm6588663qkk.100.2019.08.26.13.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 13:00:07 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     kdasu.kdev@gmail.com
Cc:     Claire Lin <claire.lin@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: brcmnand: Fix ecc chunk calculation for erased page bitfips
Date:   Mon, 26 Aug 2019 15:57:56 -0400
Message-Id: <1566849476-41546-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claire Lin <claire.lin@broadcom.com>

In brcmstb_nand_verify_erased_page(), fix ecc chunk pointer calculation
while correcting erased page bitflip.

Fixes: 02b88eea9f9c ("mtd: brcmnand: Add check for erased page bitflips")
Signed-off-by: Claire Lin <claire.lin@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 33310b8..15ef30b 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1792,6 +1792,7 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 	int bitflips = 0;
 	int page = addr >> chip->page_shift;
 	int ret;
+	void *ecc_chunk;
 
 	if (!buf)
 		buf = nand_get_data_buf(chip);
@@ -1804,7 +1805,9 @@ static int brcmstb_nand_verify_erased_page(struct mtd_info *mtd,
 		return ret;
 
 	for (i = 0; i < chip->ecc.steps; i++, oob += sas) {
-		ret = nand_check_erased_ecc_chunk(buf, chip->ecc.size,
+		ecc_chunk = buf + chip->ecc.size * i;
+		ret = nand_check_erased_ecc_chunk(ecc_chunk,
+						  chip->ecc.size,
 						  oob, sas, NULL, 0,
 						  chip->ecc.strength);
 		if (ret < 0)
-- 
1.9.0.138.g2de3478

