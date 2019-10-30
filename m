Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25104CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E619B21835
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572451079;
	bh=owHE3ZeIOv3rXmhivjkG2BGzQ+rYjTJYyoFrtT9JlVk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=W5gTr8vwlSSF2ZpUcDbxiWJCo6XFcqr1tpcoLaEZWUZc7bsbmTNmu6Kcs7wnJbQrZ
	 8/+a9MO5PGZXa7HaNGGMPUeIHERIuSo4+awiDZNqzE2UogqlH6C9k0oOZud/TzDeTE
	 D4I3UYgqGejBUS/gD1BhfeTvVWsNJX8Y67celBqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfJ3P55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfJ3P54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:57:56 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17DE6222CE;
        Wed, 30 Oct 2019 15:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572451075;
        bh=owHE3ZeIOv3rXmhivjkG2BGzQ+rYjTJYyoFrtT9JlVk=;
        h=From:To:Cc:Subject:Date:From;
        b=IHSi62tN1Y3pNQ2dtfbPo7EZg05WzycYwqNxRwj4VD+8dXd6ljGZX0X+F6GyG+3iV
         N5dacZloPe9SQjQdQlEEG4sjHa8b8o7bM/wYzgh9WeIlKcjEgM1loRPO/oWUQ1kLMp
         lfhnCohR1wZ03HpwZPqFLvZ4+KyRKqSiMNtcD0pA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>, Nishanth Menon <nm@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 01/13] regulator: ti-abb: Fix timeout in ti_abb_wait_txdone/ti_abb_clear_all_txdone
Date:   Wed, 30 Oct 2019 11:57:39 -0400
Message-Id: <20191030155751.10960-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit f64db548799e0330897c3203680c2ee795ade518 ]

ti_abb_wait_txdone() may return -ETIMEDOUT when ti_abb_check_txdone()
returns true in the latest iteration of the while loop because the timeout
value is abb->settling_time + 1. Similarly, ti_abb_clear_all_txdone() may
return -ETIMEDOUT when ti_abb_check_txdone() returns false in the latest
iteration of the while loop. Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20190929095848.21960-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/ti-abb-regulator.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index d2f9942987535..6d17357b3a248 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -173,19 +173,14 @@ static int ti_abb_wait_txdone(struct device *dev, struct ti_abb *abb)
 	while (timeout++ <= abb->settling_time) {
 		status = ti_abb_check_txdone(abb);
 		if (status)
-			break;
+			return 0;
 
 		udelay(1);
 	}
 
-	if (timeout > abb->settling_time) {
-		dev_warn_ratelimited(dev,
-				     "%s:TRANXDONE timeout(%duS) int=0x%08x\n",
-				     __func__, timeout, readl(abb->int_base));
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	dev_warn_ratelimited(dev, "%s:TRANXDONE timeout(%duS) int=0x%08x\n",
+			     __func__, timeout, readl(abb->int_base));
+	return -ETIMEDOUT;
 }
 
 /**
@@ -205,19 +200,14 @@ static int ti_abb_clear_all_txdone(struct device *dev, const struct ti_abb *abb)
 
 		status = ti_abb_check_txdone(abb);
 		if (!status)
-			break;
+			return 0;
 
 		udelay(1);
 	}
 
-	if (timeout > abb->settling_time) {
-		dev_warn_ratelimited(dev,
-				     "%s:TRANXDONE timeout(%duS) int=0x%08x\n",
-				     __func__, timeout, readl(abb->int_base));
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	dev_warn_ratelimited(dev, "%s:TRANXDONE timeout(%duS) int=0x%08x\n",
+			     __func__, timeout, readl(abb->int_base));
+	return -ETIMEDOUT;
 }
 
 /**
-- 
2.20.1

