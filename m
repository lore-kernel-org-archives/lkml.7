Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A279C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5477B252F1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190040;
	bh=M+rwiQC1uIg8UKPRB2v+M6onIb7LceG5Q5XWTBBUPvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NvgS7LOIOkImV6JicrdG0gFnD/aCgnP2yxt1MFYsLiXmoUokQn3IQQFMP74zXYTMr
	 I/7Egk4BQSLF3FP7gjR2dzIud5fjeuoXGRcgrT/laTTk/Ou5IbOPo53zFMPqPQrhf1
	 5+2CwaPfHS7cOfZABbiY/mps6LhcqaDNUagBjopc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfE3DPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbfE3DMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:40 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA46F23C5A;
        Thu, 30 May 2019 03:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185960;
        bh=M+rwiQC1uIg8UKPRB2v+M6onIb7LceG5Q5XWTBBUPvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGHvDLoMU0WoMeincPNZdMOEk5DP6Q+R4BUruGuAUABbFIal60zVq0USqDF5m2uOX
         qJmcfcMShGOkl5DBSzXpWirME9+n0xSYscogaWB7vy3xhVZ3vHJcKR5rur3g5KW8co
         RRV+adhGW0T1OJ+aCY4BUiWVpBVDWKDnmsa4o038=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 379/405] regulator: ltc3676: Fix notifier mutex lock warning
Date:   Wed, 29 May 2019 20:06:17 -0700
Message-Id: <20190530030559.909313032@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 769fc8d4182c1d1875db7859852afeb436714c5c ]

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: 37b918a034fe ("regulator: Add LTC3676 support")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/ltc3676.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index e6d66e492b851..4be90c78c7209 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -285,17 +285,23 @@ static irqreturn_t ltc3676_isr(int irq, void *dev_id)
 	if (irqstat & LTC3676_IRQSTAT_THERMAL_WARN) {
 		dev_warn(dev, "Over-temperature Warning\n");
 		event = REGULATOR_EVENT_OVER_TEMP;
-		for (i = 0; i < LTC3676_NUM_REGULATORS; i++)
+		for (i = 0; i < LTC3676_NUM_REGULATORS; i++) {
+			regulator_lock(ltc3676->regulators[i]);
 			regulator_notifier_call_chain(ltc3676->regulators[i],
 						      event, NULL);
+			regulator_unlock(ltc3676->regulators[i]);
+		}
 	}
 
 	if (irqstat & LTC3676_IRQSTAT_UNDERVOLT_WARN) {
 		dev_info(dev, "Undervoltage Warning\n");
 		event = REGULATOR_EVENT_UNDER_VOLTAGE;
-		for (i = 0; i < LTC3676_NUM_REGULATORS; i++)
+		for (i = 0; i < LTC3676_NUM_REGULATORS; i++) {
+			regulator_lock(ltc3676->regulators[i]);
 			regulator_notifier_call_chain(ltc3676->regulators[i],
 						      event, NULL);
+			regulator_unlock(ltc3676->regulators[i]);
+		}
 	}
 
 	/* Clear warning condition */
-- 
2.20.1



