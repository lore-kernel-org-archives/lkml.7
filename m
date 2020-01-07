Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504BFC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310B6214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgAGRsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:48:38 -0500
Received: from sauhun.de ([88.99.104.3]:53364 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbgAGRsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:48:22 -0500
Received: from localhost (p5486CF8B.dip0.t-ipconnect.de [84.134.207.139])
        by pokefinder.org (Postfix) with ESMTPSA id 0FF7A2C394D;
        Tue,  7 Jan 2020 18:48:21 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] i2c: i2c-core-of: convert to use i2c_new_client_device()
Date:   Tue,  7 Jan 2020 18:47:44 +0100
Message-Id: <20200107174748.9616-11-wsa+renesas@sang-engineering.com>
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

 drivers/i2c/i2c-core-of.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index e4d296b40baa..6787c1f71483 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -75,11 +75,10 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	if (ret)
 		return ERR_PTR(ret);
 
-	client = i2c_new_device(adap, &info);
-	if (!client) {
+	client = i2c_new_client_device(adap, &info);
+	if (IS_ERR(client))
 		dev_err(&adap->dev, "of_i2c: Failure registering %pOF\n", node);
-		return ERR_PTR(-EINVAL);
-	}
+
 	return client;
 }
 
-- 
2.20.1

