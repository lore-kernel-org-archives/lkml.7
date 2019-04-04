Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B658C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CAB2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371637;
	bh=EekUVwjSsK9PzSI90GZ8qZGvSCRavBt6X5AyfJO5qBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PUW723YF6BL//r2SVQvfM6KDlMIbkG+0cyE8hKeauVHxj9yp7aZuK3rZy9oLv4IXP
	 ubCx9by85y/QA8QiGE+QZ8MW8Fka4KJFszSl6APw/k4IrDi3Jw/UvrTX3/M8jvsFlG
	 LmuhaISLqyijUCYqstWlaIcwo+dgIE4O4LUgoAp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfDDJx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbfDDIw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:52:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A4C20882;
        Thu,  4 Apr 2019 08:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367977;
        bh=EekUVwjSsK9PzSI90GZ8qZGvSCRavBt6X5AyfJO5qBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xH/7RHKmBqBZ7/SOMw9cEtbjaHZZlzeVgtb1H1jOGq/tgvI7CODPtI7LA7z5lhoNo
         TmbyGMOjrDWESGBKKZLG2MVh/p8BSGBJJ2GSn88Zg0iSbeQCnABljYIqh/h8SdEGVg
         RzDowZFfwjI6WmFv3CA3F/JjLLO4qQdokt5xp/KY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 83/91] regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting
Date:   Thu,  4 Apr 2019 10:48:07 +0200
Message-Id: <20190404084540.250598625@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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



