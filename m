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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4EAC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55F22171F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3E972zn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbfGWKxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:53:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35988 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfGWKxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:53:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so18958019pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRPq9XaNcT+ppHuuRkrXvfvqNsKD4XqL3Jl/CtvboRc=;
        b=U3E972znjDWJoE7LPOC8sp594Gpi5J56kUbBCxoj9G39Hc7r7bTNK+TCVHqnwyW3Lo
         mzSQkOrPsC5BlJWMV6+aKN2uThmE4lfBx6ioSln2dv6Yg7kN1BAkByrRCL8dqK+eZTST
         kaYoDdiv7m2mJFIkvoiuOsw3NHDynT7h8JQgijZklQF4WubSjaSazbDJTVsc6WPs/nTl
         2ZcizpAO1i3CNF+D0vRlfei0Lm9tMN9qRw6CBlGVp+x8deVCUH5Eme70dqZPLm3ulJVc
         FsC6ebMxZUPTgcCv6cWAs3OfY36QC1vtXz0yMGR7/Pk8roFKvh2xRlLnb6/vhLskkswI
         ARlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lRPq9XaNcT+ppHuuRkrXvfvqNsKD4XqL3Jl/CtvboRc=;
        b=WyMuD+p6QGnLPEOsbftw/JphnvvmtFfytl+sJxtoZobhb2IDI9LSXpcYxeMpQDdI7c
         g0Ah9ddNi78Byrv9SA86rzz8n4f5LYh5Y+x8dhhWWa/i3JAG17f2c8laBkdiN+i0P5+Z
         YdaTqPOKau6xx7oaxbdu2M7DSES5IEU2/bBv/NXlybYAeenZYAXqFYYQ9N/kB8tgav9T
         vzS1gZn7I/eKx7yc0e4cp+LOAdUmln+WX7Yvr3TMvM2+Pbk4LYjaDbHufwPKB729gGkj
         WRD5OraUv2QVXsU37exQxFJ6hflcZAGpfCMoieYClv/fhDWYupvbWcwJDDAG1Q7Espn1
         Pn5Q==
X-Gm-Message-State: APjAAAUwKUnmF81sewV+cjb5pkMpkljNOx8XM5ocSgFypsZGsUX5sd3O
        TE6Mz/CixzgJ4mUMa3V0hJiNRIvo
X-Google-Smtp-Source: APXvYqyvQFKQl1qVATVnEsilRaMwc2kmS57CYli/UvPrxxZzlOoxZ5z778gQw7KO3BG6gbU+qwEvLQ==
X-Received: by 2002:a63:f807:: with SMTP id n7mr78345023pgh.119.1563879218400;
        Tue, 23 Jul 2019 03:53:38 -0700 (PDT)
Received: from localhost.localdomain ([122.163.0.39])
        by smtp.gmail.com with ESMTPSA id q7sm52009357pff.2.2019.07.23.03.53.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:53:37 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     kishon@ti.com, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] phy: marvell: phy-mvebu-cp110-comphy: Add of_node_put() before return
Date:   Tue, 23 Jul 2019 16:23:27 +0530
Message-Id: <20190723105327.8370-1-nishkadg.linux@gmail.com>
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
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index d98e0451f6a1..f7a16dc6e171 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -626,12 +626,16 @@ static int mvebu_comphy_probe(struct platform_device *pdev)
 		}
 
 		lane = devm_kzalloc(&pdev->dev, sizeof(*lane), GFP_KERNEL);
-		if (!lane)
+		if (!lane) {
+			of_node_put(child);
 			return -ENOMEM;
+		}
 
 		phy = devm_phy_create(&pdev->dev, child, &mvebu_comphy_ops);
-		if (IS_ERR(phy))
+		if (IS_ERR(phy)) {
+			of_node_put(child);
 			return PTR_ERR(phy);
+		}
 
 		lane->priv = priv;
 		lane->mode = PHY_MODE_INVALID;
-- 
2.19.1

