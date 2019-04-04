Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377C6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04827206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371196;
	bh=iX2jgEps/dyBJ2LUYyyoY34KUGz4HrCahPJNsGCRQrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EwYHqY7VesK/ZXrOQ2kDRMlZMIYajplDOPEgeX6dEkxp7nhCGcA0CCTt8bBT4b5UW
	 UmZbWQaTkxVzCPpin7P04xBwzHM7ZhFbUwbU7sLs7lTIN4SC7kOrKXZTxoPTtWX5X+
	 lggPeikTCHEqgwgsM48M4HXVJN4YX4voF6Hc5xAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbfDDJqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729743AbfDDI6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:58:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 595E0217D9;
        Thu,  4 Apr 2019 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368299;
        bh=iX2jgEps/dyBJ2LUYyyoY34KUGz4HrCahPJNsGCRQrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mx2pTgmlSIAQ13uUgV4ZbSB8/aOC9+F2TEbBxKpFujFnqXi0kt+avmnbtMxZZdW7O
         PKuZMQTTBPS/YPxqEbcbkSBay2qiqqgjH3F54OPz5H8SkQWPgDt5xWEYrQcp1sHLgq
         LOQC5cjVSEk8jMYtW3CXHo79kaw6F11WBTDtmbLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 111/121] regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting
Date:   Thu,  4 Apr 2019 10:48:19 +0200
Message-Id: <20190404084551.282346547@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f01a7beb6791f1c419424c1a6958b7d0a289c974 ]

The act8600_sudcdc_voltage_ranges setting does not match the datasheet.

The problems in below entry:
  REGULATOR_LINEAR_RANGE(19000000, 191, 255, 400000),

1. The off-by-one min_sel causes wrong volatage calculation.
   The min_sel should be 192.
2. According to the datasheet[1] Table 7. (on page 43):
   The selector 248 (0b11111000) ~ 255 (0b11111111) are 41.400V.

Also fix off-by-one for ACT8600_SUDCDC_VOLTAGE_NUM.

[1] https://active-semi.com/wp-content/uploads/ACT8600_Datasheet.pdf

Fixes: df3a950e4e73 ("regulator: act8865: Add act8600 support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/act8865-regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 7652477e6a9d..39e8d60df060 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -131,7 +131,7 @@
  * ACT8865 voltage number
  */
 #define	ACT8865_VOLTAGE_NUM	64
-#define ACT8600_SUDCDC_VOLTAGE_NUM	255
+#define ACT8600_SUDCDC_VOLTAGE_NUM	256
 
 struct act8865 {
 	struct regmap *regmap;
@@ -222,7 +222,8 @@ static const struct regulator_linear_range act8600_sudcdc_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 0, 63, 0),
 	REGULATOR_LINEAR_RANGE(3000000, 64, 159, 100000),
 	REGULATOR_LINEAR_RANGE(12600000, 160, 191, 200000),
-	REGULATOR_LINEAR_RANGE(19000000, 191, 255, 400000),
+	REGULATOR_LINEAR_RANGE(19000000, 192, 247, 400000),
+	REGULATOR_LINEAR_RANGE(41400000, 248, 255, 0),
 };
 
 static struct regulator_ops act8865_ops = {
-- 
2.19.1



