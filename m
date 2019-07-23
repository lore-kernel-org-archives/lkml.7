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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DFAC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60AD22513
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFRe9yqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfGWKti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:49:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36484 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbfGWKth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:49:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so19240884pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PaKr0cKMyAMbxH4E21XrY6gVVY8VgDaZGXDVqfVaPKI=;
        b=TFRe9yquqg8Peo0OXTizXKupWPaxzss8ZBIC0a/Jc6OSatHlAPFz45h3RyLVNRHTLD
         EvZ1K18FI+/W4T+fx8/lQFxLaj3jFufNG9DEdRjrDtIUtV+g8oU2ib1naBILnhS3cK02
         mC7lTi+D2FTMAd8lZJJMCYK3M3XwLAw7nsRCJbsC56SfJyrW5CZVcqZ0R8OSwc7Q6gDW
         feHg78r7P0vSZpfbD1PqqK/5UJlGPjQN3rMTS6EpQmvl41rft+y3Hsz9/oMOGDPEzp/V
         pk/1Krjw0za6kFS0DnPXFdgPV9KGCaSgMfuUzgB7TLP8BEiqzksmtHKPGJ2p4HWKUnqs
         HNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PaKr0cKMyAMbxH4E21XrY6gVVY8VgDaZGXDVqfVaPKI=;
        b=ESVyZ4xHlJleLstr+9CrkMN6GNS4EKEhcCYD6RZhe/MwuWqVhi5rrDZYOkgVtmGtPR
         xJhwvWZNugeqq69l4gMREO/0/w+AMH41OH+8UVVTQJ7ZSKXJBe9T1QrpneFhdiRpGe6b
         104EQbyvszeqzSIIf6JiEVhWXFSGcX1KQsgB6hI5/ojHIqok2njtcTuHSrtSOZHjBETU
         NYjX7KpPMzcdQeukWZ94TAhPL+JlwuKaj33ytmNE6POrKcO95EBQsEN9bQsHKJguZ3m1
         KQMC5zipMEGtm3GTcHRqwv9mAk7+znX6wTPONKXhWDAmGLDtcQBOozjk1P+zphkFMU3Z
         ng4A==
X-Gm-Message-State: APjAAAWqLsNOv5CDDXTa1a7131zfvJTsyqNOFLMwZeNx+e73btZ2l1b0
        6/0KUt5Gw76uCf6DXxUJdc4=
X-Google-Smtp-Source: APXvYqxHsdukCA+O9iUTa29WbVMRx69zB5fWnnDeqXvTnlu03AHqqUvNaaOfb850HB9n0RVe2l6A+A==
X-Received: by 2002:a63:6904:: with SMTP id e4mr15449455pgc.321.1563878976901;
        Tue, 23 Jul 2019 03:49:36 -0700 (PDT)
Received: from localhost.localdomain ([122.163.0.39])
        by smtp.gmail.com with ESMTPSA id b37sm69067763pjc.15.2019.07.23.03.49.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:49:36 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     kishon@ti.com, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] phy: marvell: phy-armada38x-comphy: Add of_node_put() before return
Date:   Tue, 23 Jul 2019 16:19:19 +0530
Message-Id: <20190723104919.8198-1-nishkadg.linux@gmail.com>
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
return.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/phy/marvell/phy-armada38x-comphy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/marvell/phy-armada38x-comphy.c b/drivers/phy/marvell/phy-armada38x-comphy.c
index 3e00bc679d4e..6960dfd8ad8c 100644
--- a/drivers/phy/marvell/phy-armada38x-comphy.c
+++ b/drivers/phy/marvell/phy-armada38x-comphy.c
@@ -200,8 +200,10 @@ static int a38x_comphy_probe(struct platform_device *pdev)
 		}
 
 		phy = devm_phy_create(&pdev->dev, child, &a38x_comphy_ops);
-		if (IS_ERR(phy))
+		if (IS_ERR(phy)) {
+			of_node_put(child);
 			return PTR_ERR(phy);
+		}
 
 		priv->lane[val].base = base + 0x28 * val;
 		priv->lane[val].priv = priv;
-- 
2.19.1

