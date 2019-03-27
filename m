Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92549C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55189206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712856;
	bh=of2eTPTkMjpc3I0KMTDfwO1Bw8tBfv80avLTaHEo+lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XPAc/2TNTDPZGR4K57QhoJom00N+f12RwA3f6UoP0GGs9rPJgabZ2GRvnbRKXA3Fh
	 fyozw/qWgTk2hdEJaCY2A7D7BJ697ujX+c3tTu+JgDpWFrrwmPLMYWEzd2bpFxyHum
	 P4sgbVFm8fnpBXeFCb3lINikWWd5jCCcDaQsJ9No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390190AbfC0SRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389924AbfC0SPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72F1921741;
        Wed, 27 Mar 2019 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710553;
        bh=of2eTPTkMjpc3I0KMTDfwO1Bw8tBfv80avLTaHEo+lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAl+diBo4bYHZB+YHdCipaN+xhKG61eFO3ck40MJ3IpVo1UewOkN9tSzCH2shcL4P
         Nikhm0mwSbllFRaBoqhq/VZPG459JHyqlDQ2W1Ta1KhNWcxdtaEC4JwhBgqZEgUo5D
         f2JpEdWKfJHPHyEyUjA8UiN4LbSckK41p1FWaXCg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 174/192] regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting
Date:   Wed, 27 Mar 2019 14:10:06 -0400
Message-Id: <20190327181025.13507-174-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

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
index 21e20483bd91..e0239cf3f56d 100644
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

