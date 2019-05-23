Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58B1C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40D320879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640196;
	bh=8DzaXU7SRJekdLbqReNh6QlLY7B/bqwH9I8btBJlcRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lRFvKg7TER9HtfP31eBJDt9j7WF6PKhrvlZdTLh9/d3ZPFWNISjT+TMA7tsNv+1wa
	 iLwoBPz5ECQFhLFPeHA4neh5g+TkhPki1HTaNfrnnkYGBhXQp/2oVeqy2S3MAGWwcu
	 gwdgXutcO3Y39xD2joZu1ZcDAB4HQrSAm/fqY8Xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391100AbfEWTZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391066AbfEWTZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:25:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B56BF206BA;
        Thu, 23 May 2019 19:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639519;
        bh=8DzaXU7SRJekdLbqReNh6QlLY7B/bqwH9I8btBJlcRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETWrjLupOs5jNtkNJdyHgWXIjUtLdIhAjZOtK4bkDRlKqH3hj55rut7xE57lmjDiK
         CU1I3A44vaNhVj5jqxCsvLFtdagUWyll72J3QYsEpeG6YCUFA96mXitwK3V9IfLQpM
         pntkeG9jIATpw14b7JnjCzcSbKw+pNZdzOOZ+ee4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 118/139] net: ieee802154: fix missing checks for regmap_update_bits
Date:   Thu, 23 May 2019 21:06:46 +0200
Message-Id: <20190523181735.056351348@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index c589f5ae75bb5..8bb53ec8d9cf2 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -533,6 +533,8 @@ mcr20a_start(struct ieee802154_hw *hw)
 	dev_dbg(printdev(lp), "no slotted operation\n");
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
 				 DAR_PHY_CTRL1_SLOTTED, 0x0);
+	if (ret < 0)
+		return ret;
 
 	/* enable irq */
 	enable_irq(lp->spi->irq);
@@ -540,11 +542,15 @@ mcr20a_start(struct ieee802154_hw *hw)
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



