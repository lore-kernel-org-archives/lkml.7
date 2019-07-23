Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65013C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3353F2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knb890tL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfGWKvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:51:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36931 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfGWKvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:51:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id i70so8501690pgd.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jm2/Tbw4B4zstU0h2P6RYJHis2wJ6Yr3E6kmAH8ZdX0=;
        b=knb890tLTtH5u8TukfNmfGs/kMAWpqH2ol9dctEtoqEiRkdLG0UAsHEIvJ2NspeRfC
         678kP7kMaPyjGK0wUvrcQfGojwoKqyqL8rXbyTpemgtso7VRd9CVz0zMghI9RXb6S6CE
         w0RJM88ocytI+46rz4oXAiT5sOJCerDnHj3KZ9N3vCQpPzlAUNEKKeE7KVFXPaeCd8Zm
         kMTebjBvUHyXz94VqvojnnlxOZYqkoXcrwYNk5LcVFGTLoZkGOkxmHwIh97S9Uhfe9fv
         9C9mCBTsxj4xu0U+dnEeTHwifa9eHdbOuaKwxOj3t13HpxOS797MTuRZVWE56taOg7l/
         6EQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jm2/Tbw4B4zstU0h2P6RYJHis2wJ6Yr3E6kmAH8ZdX0=;
        b=ZPNI+ZP3VhgknJVTGWS1xdvwgrVofJGl47mLJoHOfZsqobbqhFJlVqIcKbM5S71qYz
         /OWmVPG46XyKj51Zq/jokrgsMW5daPbNzThtZ+Mf1Kj6Bq7sc67fA9o/moqJ3DzbCyvr
         lMWQjKcNJFAl84dIQlDAEyjBDLqjs2ZsuKJcoBdVXXPdDZ5xKXQWgTEnIID8R/4nLQXr
         kY95DvnEPRz0sEVqrIXu5dKZ6bjk59HL3Cqq9s88L3xfZxI7Jiems1znulfuESIUB9L5
         +G2SsPrLPlOfjoLdyUFGsAB+ncW10kCC0ysTZ4zXDEpdfEXTmVQP28nILwfzlv3hiuQ4
         BRqg==
X-Gm-Message-State: APjAAAXdyf7xj3bVGjqFuGHwz0kKQgHO3AEBf8x5sOJsJ9V0cF7B849Q
        a9YMk1zEqU0tWjmd9ivQvCI=
X-Google-Smtp-Source: APXvYqwKmGmYQ9nEGl2Qf51DrNOjeXuDGijmqjLVSaPhP8mZj38hCzWdq3XGsSGvc0fUkGGOs7wfAA==
X-Received: by 2002:a63:5811:: with SMTP id m17mr5433746pgb.237.1563879079184;
        Tue, 23 Jul 2019 03:51:19 -0700 (PDT)
Received: from localhost.localdomain ([122.163.0.39])
        by smtp.gmail.com with ESMTPSA id o130sm69922173pfg.171.2019.07.23.03.51.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:51:18 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     miquel.raynal@bootlin.com, kishon@ti.com,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] phy: marvell: phy-mvebu-a3700-comphy: Add of_node_put() before return
Date:   Tue, 23 Jul 2019 16:21:08 +0530
Message-Id: <20190723105108.8306-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each iteration of for_each_available_child_of_node puts the previous
node, but in the case of a return from the middle of the loop, there is
no put, thus causing a memory leak. Hence add an of_node_put before the
return in two places.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
index 8812a104c233..0ebac46435bd 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
@@ -277,13 +277,17 @@ static int mvebu_a3700_comphy_probe(struct platform_device *pdev)
 		}
 
 		lane = devm_kzalloc(&pdev->dev, sizeof(*lane), GFP_KERNEL);
-		if (!lane)
+		if (!lane) {
+			of_node_put(child);
 			return -ENOMEM;
+		}
 
 		phy = devm_phy_create(&pdev->dev, child,
 				      &mvebu_a3700_comphy_ops);
-		if (IS_ERR(phy))
+		if (IS_ERR(phy)) {
+			of_node_put(child);
 			return PTR_ERR(phy);
+		}
 
 		lane->dev = &pdev->dev;
 		lane->mode = PHY_MODE_INVALID;
-- 
2.19.1

