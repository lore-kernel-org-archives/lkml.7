Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739BEC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F8120833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558007157;
	bh=KFdnEqrWENvRuxS/6olHE2piTxs1Uw9mDdItEAg4WkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PjpqNTRKzFuPbfP3FvsJUOMKbNDcAhTAUJyw4Xo59fI7eoPj/GEKBVXtQ8lbvuF+1
	 TdzXllUuTEHNSTsOJv01T3rEVr6gjPlWEd1PsDJLk1npWHpxvd8ONA7eWGtfRWrPnB
	 iyHQv86F2bQf5gLA9NJn8J+hrN3xYnqMVwus7o1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfEPLp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbfEPLkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:40:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2129E20833;
        Thu, 16 May 2019 11:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558006847;
        bh=KFdnEqrWENvRuxS/6olHE2piTxs1Uw9mDdItEAg4WkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFAyyxRqshEYgAbObv1e3jKhbqVCBgXthf7V9fttijTZQ1Q3p9lno2ruU/8TtkrPE
         cFO89V8BI8pzwAwTmtvL152ogQX8EjQccdPeSALdKydfhp4rhCgSLxPE5/q0Uw599T
         cygySzllHE7zodd71FGoIIkMdFgL709W2smVcwoM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Mukesh Ojha <mojha@codeaurora.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 15/25] net: ieee802154: fix missing checks for regmap_update_bits
Date:   Thu, 16 May 2019 07:40:18 -0400
Message-Id: <20190516114029.8682-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516114029.8682-1-sashal@kernel.org>
References: <20190516114029.8682-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 22e8860cf8f777fbf6a83f2fb7127f682a8e9de4 ]

regmap_update_bits could fail and deserves a check.

The patch adds the checks and if it fails, returns its error
code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/mcr20a.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 04891429a5542..fe4057fca83d8 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -539,6 +539,8 @@ mcr20a_start(struct ieee802154_hw *hw)
 	dev_dbg(printdev(lp), "no slotted operation\n");
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
 				 DAR_PHY_CTRL1_SLOTTED, 0x0);
+	if (ret < 0)
+		return ret;
 
 	/* enable irq */
 	enable_irq(lp->spi->irq);
@@ -546,11 +548,15 @@ mcr20a_start(struct ieee802154_hw *hw)
 	/* Unmask SEQ interrupt */
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL2,
 				 DAR_PHY_CTRL2_SEQMSK, 0x0);
+	if (ret < 0)
+		return ret;
 
 	/* Start the RX sequence */
 	dev_dbg(printdev(lp), "start the RX sequence\n");
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
 				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
-- 
2.20.1

