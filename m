Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DA9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44078218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="o6gRf6Ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfCUIjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:39:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33273 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfCUIjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:39:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id b12so3767636pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jdTds9m3BwISuuRkImEuLt5zXSu8lVHtfiu0HjxIbdY=;
        b=o6gRf6FtO6sNScUDSW7Dvy4XkfhtGcmox3V1Cw6e9TtDKiRuUCGegac1PlLTNlYCoZ
         +4iDreN+2rcNWtodJjPG8UUUZIibwXBLFA+Xz/nL9qlrnQE54/8hpi/cxQggn6Mh9dfl
         tL0BvGRIZ38sD8RZnqk69tHZVUwPzSqGDZcGkNctvaN6h9ekvq6Vtd4W0iI8XkjVLa/9
         jhj3/kNdPQWvsJASvKrHB01U92XE924LalpV8VcYZKnMIFWFP1hjvhUe3Xr0dW6josQD
         MW9j9APEcNS/nLLcS/SUdSklIgMUfGkBgwKSufYjKmMO5OIJi5rrYuvMrK9KjQ2mJ0Iu
         8/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jdTds9m3BwISuuRkImEuLt5zXSu8lVHtfiu0HjxIbdY=;
        b=DC/KwPLndTX+MYozMsSdFL2RBdNRt8k4V4Qi4GqqMNbxgFSL1ABUNT8NU1s9Vfvmaj
         iPu6CHEX5fZjyNWDT9jOACYzunH2aLr8qvgLQj2bnAok3hreZFVW+HjS8KoVJK61gGhE
         fJ2DRNjCQRYkS9DIeMbGpejWXIA1vrrug4LvUgox7QR5lZx6lOXLH8DweXStmd8navrg
         sIbwU+XaRYDsh53vRiZtawJ0QHwnY0D52iZJR/cjeCEFz6CCBJaRXLHCwohJr49qIeXJ
         7UbdAFeFtZbmMioTq5XfTcC4u/9W8geOparr25jcRNiP0dazJXQsSxChF1HIIgeNwL2+
         Nqvg==
X-Gm-Message-State: APjAAAWPuRvZDvRL12eitfCqdneUfFtilaWkASSP7NZNWcnDkEFjMO80
        zD87Sz1itn3zEsaFdb6iwH2jHw==
X-Google-Smtp-Source: APXvYqyqf7E9FLdVgIud3pXSKWHkFPV5Ss5H9enD4BrTCZaCSMfgmJs+Jt4bCMKgYrrodNUspRH8kA==
X-Received: by 2002:a65:6203:: with SMTP id d3mr2251807pgv.109.1553157570924;
        Thu, 21 Mar 2019 01:39:30 -0700 (PDT)
Received: from localhost.localdomain (118-171-142-96.dynamic-ip.hinet.net. [118.171.142.96])
        by smtp.gmail.com with ESMTPSA id 184sm5474938pff.149.2019.03.21.01.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 01:39:30 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        "Andrew F . Davis" <afd@ti.com>, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RESEND] regulator: tps65086: Fix tps65086_ldoa1_ranges for selector 0xB
Date:   Thu, 21 Mar 2019 16:39:19 +0800
Message-Id: <20190321083919.6334-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selector 0xB (1011) should be 2.6V rather than 2.7V, fit ix.

Table 5-4. LDOA1 Output Voltage Options
VID Bits VOUT VID Bits VOUT VID Bits VOUT VID Bits VOUT
0000     1.35 0100     1.8  1000     2.3  1100     2.85
0001     1.5  0101     1.9  1001     2.4  1101     3.0
0010     1.6  0110     2.0  1010     2.5  1110     3.3
0011     1.7  0111     2.1  1011     2.6  1111     Not Used

Fixes: d2a2e729a666 ("regulator: tps65086: Add regulator driver for the TPS65086 PMIC")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Andrew F. Davis <afd@ti.com>
---
This patch was sent on https://lkml.org/lkml/2019/3/4/349
With Andrew's Acked.

 drivers/regulator/tps65086-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65086-regulator.c b/drivers/regulator/tps65086-regulator.c
index 45e96e154690..5a5e9b5bf4be 100644
--- a/drivers/regulator/tps65086-regulator.c
+++ b/drivers/regulator/tps65086-regulator.c
@@ -90,8 +90,8 @@ static const struct regulator_linear_range tps65086_buck345_25mv_ranges[] = {
 static const struct regulator_linear_range tps65086_ldoa1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1350000, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(1500000, 0x1, 0x7, 100000),
-	REGULATOR_LINEAR_RANGE(2300000, 0x8, 0xA, 100000),
-	REGULATOR_LINEAR_RANGE(2700000, 0xB, 0xD, 150000),
+	REGULATOR_LINEAR_RANGE(2300000, 0x8, 0xB, 100000),
+	REGULATOR_LINEAR_RANGE(2850000, 0xC, 0xD, 150000),
 	REGULATOR_LINEAR_RANGE(3300000, 0xE, 0xE, 0),
 };
 
-- 
2.17.1

