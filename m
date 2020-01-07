Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74711C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F3E214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgAGRsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:48:21 -0500
Received: from sauhun.de ([88.99.104.3]:53350 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbgAGRsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:48:20 -0500
Received: from localhost (p5486CF8B.dip0.t-ipconnect.de [84.134.207.139])
        by pokefinder.org (Postfix) with ESMTPSA id 3D5822C3951;
        Tue,  7 Jan 2020 18:48:18 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] i2c: powermac: convert to use i2c_new_client_device()
Date:   Tue,  7 Jan 2020 18:47:39 +0100
Message-Id: <20200107174748.9616-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/i2c/busses/i2c-powermac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
index 504f5bf0e625..973e5339033c 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -240,8 +240,8 @@ static void i2c_powermac_create_one(struct i2c_adapter *adap,
 
 	strncpy(info.type, type, sizeof(info.type));
 	info.addr = addr;
-	newdev = i2c_new_device(adap, &info);
-	if (!newdev)
+	newdev = i2c_new_client_device(adap, &info);
+	if (IS_ERR(newdev))
 		dev_err(&adap->dev,
 			"i2c-powermac: Failure to register missing %s\n",
 			type);
@@ -359,8 +359,8 @@ static void i2c_powermac_register_devices(struct i2c_adapter *adap,
 		info.irq = irq_of_parse_and_map(node, 0);
 		info.of_node = of_node_get(node);
 
-		newdev = i2c_new_device(adap, &info);
-		if (!newdev) {
+		newdev = i2c_new_client_device(adap, &info);
+		if (IS_ERR(newdev)) {
 			dev_err(&adap->dev, "i2c-powermac: Failure to register"
 				" %pOF\n", node);
 			of_node_put(node);
-- 
2.20.1

