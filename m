Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317D1C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A2A218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239362;
	bh=owHE3ZeIOv3rXmhivjkG2BGzQ+rYjTJYyoFrtT9JlVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HiKvu8bQFkykLMK95g+JA/NcqBYupYjB/o6LZAUg68ejyog/M7TR2tJ7e5I53Ty6I
	 jnM4mtRJnUTx/TfGZL4CDDrqh/ZuxM1U2hpg2h+Bh2sIZkJiHbyNX2nbfLzZh+LMPf
	 lsA02RmKyzH0jX6raS1HMuAPxf2O2EM/II2OZ7do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfKHS4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:56:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387848AbfKHSzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:55:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0BB5218AE;
        Fri,  8 Nov 2019 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239348;
        bh=owHE3ZeIOv3rXmhivjkG2BGzQ+rYjTJYyoFrtT9JlVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oakz9beQXkFsMB4WGOtcYvCUcS4gBwr6mNrFWooshVsayv8mUSVtYQSX+Ko+dtpkn
         ljm1cqqqpQizUdBGKHJScfTZQAkfa2s1T7/T7hbpsLWg5IdYN9tpv+rA2SeKeOErlN
         MAdKE3oDt5+qd8reR1locLtdPs6omYjOYqZduV70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Nishanth Menon <nm@ti.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 01/34] regulator: ti-abb: Fix timeout in ti_abb_wait_txdone/ti_abb_clear_all_txdone
Date:   Fri,  8 Nov 2019 19:50:08 +0100
Message-Id: <20191108174620.512838356@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174618.266472504@linuxfoundation.org>
References: <20191108174618.266472504@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



