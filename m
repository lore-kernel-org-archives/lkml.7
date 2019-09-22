Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3EAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F363320882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179305;
	bh=SLxjNf84mAviyJIDDDeYg9vbSXlaZiy8tJqwyFdeBKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vA9GHNQT3/RgRkiDq9vv3AzLx7vM3Fb3MaywyBS/A/cFtrcAOPFmOHMKc6i/h9Vrk
	 pBLKxu8MkUH/xVn72ouXDacUT8aASbIXbQNo/IXO26WJuKPTTOEqOnFE9CLHPm7goJ
	 I+vnN09RIl8hRMRNHskd1cQLVFwHAMTYVko+5EEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438896AbfIVS7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393724AbfIVS7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:59:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9A921479;
        Sun, 22 Sep 2019 18:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178777;
        bh=SLxjNf84mAviyJIDDDeYg9vbSXlaZiy8tJqwyFdeBKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zwZwvbA1BUxG5osEEhPgOal5n21P9X3ABp8ksx6eSR8AvxQeKSGO21hW4LtHqTGei
         U2Zo5I6GWoRFP6tcjvO5CKzBmXB94Zs65KiEMKkkEM+FlBctftGzYKisAkMn66/moY
         6Asxvmz73GHdsrAbFn10PdUsrcw6JMrgt626s/eM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 02/60] regulator: lm363x: Fix off-by-one n_voltages for lm3632 ldo_vpos/ldo_vneg
Date:   Sun, 22 Sep 2019 14:58:35 -0400
Message-Id: <20190922185934.4305-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185934.4305-1-sashal@kernel.org>
References: <20190922185934.4305-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit 1e2cc8c5e0745b545d4974788dc606d678b6e564 ]

According to the datasheet https://www.ti.com/lit/ds/symlink/lm3632a.pdf
Table 20. VPOS Bias Register Field Descriptions VPOS[5:0]
Sets the Positive Display Bias (LDO) Voltage (50 mV per step)
000000: 4 V
000001: 4.05 V
000010: 4.1 V
....................
011101: 5.45 V
011110: 5.5 V (Default)
011111: 5.55 V
....................
100111: 5.95 V
101000: 6 V
Note: Codes 101001 to 111111 map to 6 V

The LM3632_LDO_VSEL_MAX should be 0b101000 (0x28), so the maximum voltage
can match the datasheet.

Fixes: 3a8d1a73a037 ("regulator: add LM363X driver")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20190626132632.32629-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/lm363x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index f53e63301a205..e71117d7217bc 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -33,7 +33,7 @@
 
 /* LM3632 */
 #define LM3632_BOOST_VSEL_MAX		0x26
-#define LM3632_LDO_VSEL_MAX		0x29
+#define LM3632_LDO_VSEL_MAX		0x28
 #define LM3632_VBOOST_MIN		4500000
 #define LM3632_VLDO_MIN			4000000
 
-- 
2.20.1

