Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30385C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E2725BE7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191625;
	bh=IPghI0RmVykeJr4nnKCP1kF2boj4VSlS5RPM9XtrRCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jk9yzNAGEZHwho/sP80RmJlOuXiNaTWL9iEZiJOJTCug6cPPyeTO/Wij2Ec9MQr5/
	 ZJrqUOQmEpoucIR0znnFw6OFPlhH9naTAg+YBUoVc5JM8YHnHK07IAw3VRCyM63Olz
	 2EYfoNTTmfne0J5UkJb5+ntNDhKQWv4+2h1o2JHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfE3ErE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfE3DLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:35 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FCC82449A;
        Thu, 30 May 2019 03:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185895;
        bh=IPghI0RmVykeJr4nnKCP1kF2boj4VSlS5RPM9XtrRCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQXTs7EFhA49c7fXb1dr7lbQlPQk0S6BXynIOL4LqZ9LPeyH9SVFQ8ySyCrgCRHZZ
         PlSy3DPj1Xh0YKexsyIW++jZpZO3R15xjufbVbCHBX7ikYOrhnTrDwA1Jwn93b5/1d
         vRdWEzRr9xPiKmuL+Aq+mG1uXFc2QlwJEzzEcvlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanley Chu <stanley.chu@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 259/405] scsi: ufs: Avoid configuring regulator with undefined voltage range
Date:   Wed, 29 May 2019 20:04:17 -0700
Message-Id: <20190530030554.064456881@linuxfoundation.org>
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

[ Upstream commit 3b141e8cfd54ba3e5c610717295b2a02aab26a05 ]

For regulators used by UFS, vcc, vccq and vccq2 will have voltage range
initialized by ufshcd_populate_vreg(), however other regulators may have
undefined voltage range if dt-bindings have no such definition.

In above undefined case, both "min_uV" and "max_uV" fields in ufs_vreg
struct will be zero values and these values will be configured on
regulators in different power modes.

Currently this may have no harm if both "min_uV" and "max_uV" always keep
"zero values" because regulator_set_voltage() will always bypass such
invalid values and return "good" results.

However improper values shall be fixed to avoid potential bugs.  Simply
bypass voltage configuration if voltage range is not defined.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Acked-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 58e0bd1dac9b4..5ba49c8cd2a36 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7048,12 +7048,15 @@ static int ufshcd_config_vreg(struct device *dev,
 	name = vreg->name;
 
 	if (regulator_count_voltages(reg) > 0) {
-		min_uV = on ? vreg->min_uV : 0;
-		ret = regulator_set_voltage(reg, min_uV, vreg->max_uV);
-		if (ret) {
-			dev_err(dev, "%s: %s set voltage failed, err=%d\n",
+		if (vreg->min_uV && vreg->max_uV) {
+			min_uV = on ? vreg->min_uV : 0;
+			ret = regulator_set_voltage(reg, min_uV, vreg->max_uV);
+			if (ret) {
+				dev_err(dev,
+					"%s: %s set voltage failed, err=%d\n",
 					__func__, name, ret);
-			goto out;
+				goto out;
+			}
 		}
 
 		uA_load = on ? vreg->max_uA : 0;
-- 
2.20.1



