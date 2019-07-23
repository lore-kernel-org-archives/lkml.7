Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A4DC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7752E20840
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="QvJYTeqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbfGWQcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:32:10 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:18442 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388018AbfGWQcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:32:10 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 45tP9M1bw0zB2;
        Tue, 23 Jul 2019 18:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1563899447; bh=o3M1CtF2BvaPXosh3zfBJwNiMGsyfhOJLOLYgB0QEc4=;
        h=Date:From:Subject:To:Cc:From;
        b=QvJYTeqpG4B2ux+3qU07fmfRfIXnZBdm2ves7Cden3WOiFdTRoPgzyqS8X6FfIBRS
         6jxgsqei7NOMj+FinTlqV20+uwmSM0GU0lrozzsQm7aAzzV8zKI3afxeqRJlKnukmw
         9gdcD4ON8eaBIgqvQbY6sdrblVsczlvit7Yjyk37Q/ehGqP25DBkD/fYqa87xA8jxi
         w05dQnwWAtFXNslehCSmWkPjz/endmCtaxvXgwxWKMZjSF66oz1Vq+zdN7nZu4DmXh
         k1Yk1gLIfH5Euz53SYhgfCASfRH2m07eKPS9x+MjdT2eft0jr9lBhxKltKRxtxKNoh
         REyykk9MlBG0Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Tue, 23 Jul 2019 18:32:06 +0200
Message-Id: <12b1fe419e93dfe663990009bf1b2fbf630e9934.1563898936.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/2] regulator: act8865: rename fixed LDO ops
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename act8865_ldo_ops to act8865_fixed_ldo_ops to make room for
variable-output LDO ops change.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 v2: split ops rename from main patch

 drivers/regulator/act8865-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index cf72d7c6b8c9..c9fb858e6947 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -227,7 +227,7 @@ static const struct regulator_ops act8865_ops = {
 	.is_enabled		= regulator_is_enabled_regmap,
 };
 
-static const struct regulator_ops act8865_ldo_ops = {
+static const struct regulator_ops act8865_fixed_ldo_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
@@ -281,7 +281,7 @@ static const struct regulator_desc act8600_regulators[] = {
 		.of_match = of_match_ptr("LDO_REG9"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id = ACT8600_ID_LDO9,
-		.ops = &act8865_ldo_ops,
+		.ops = &act8865_fixed_ldo_ops,
 		.type = REGULATOR_VOLTAGE,
 		.n_voltages = 1,
 		.fixed_uV = 3300000,
@@ -294,7 +294,7 @@ static const struct regulator_desc act8600_regulators[] = {
 		.of_match = of_match_ptr("LDO_REG10"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id = ACT8600_ID_LDO10,
-		.ops = &act8865_ldo_ops,
+		.ops = &act8865_fixed_ldo_ops,
 		.type = REGULATOR_VOLTAGE,
 		.n_voltages = 1,
 		.fixed_uV = 1200000,
-- 
2.20.1

