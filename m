Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F5EC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6822921927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930722;
	bh=v1yNhTOsqAm3uZEOsgpYLV4Ie7ENMR7gHDELRe4toq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cb/5gf0516l5kPcBbOSZg04Ie5FyE6djmJ523DyjaI5nXFUlCsltkiHXKl1IPBIa5
	 HJOTt8rVgeavA8jqvoq5p4mf3jvZkh12rf7exqKKZLzxgjHLk+E8rNa/YMCx39vl9S
	 ACf1qR5OdAVDJTgjdcKVt2kZ9kAiypCTBmX4W0Iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404945AbfISWFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404932AbfISWFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:05:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30231218AF;
        Thu, 19 Sep 2019 22:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930716;
        bh=v1yNhTOsqAm3uZEOsgpYLV4Ie7ENMR7gHDELRe4toq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CvXlxjvxZgti+xssTIoBLKO9eCC3nJrr4JTyzOv3kWs998uk3JQ07uiHWlolMjpy/
         kiJZPIVehfZzIUHIz/Dq/JQX16UGUJYvRHRbcqzQMIP7rAoBseRELEMDs7abGP5oax
         inrZO688WjRVvk4ZkD4YRLiD0FpARh1u5po88aZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe ROULLIER <christophe.roullier@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 10/21] net: stmmac: Hold rtnl lock in suspend/resume callbacks
Date:   Fri, 20 Sep 2019 00:03:11 +0200
Message-Id: <20190919214703.531020037@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214657.842130855@linuxfoundation.org>
References: <20190919214657.842130855@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 19e13cb27b998ff49f07e399b5871bfe5ba7e3f0 ]

We need to hold rnl lock in suspend and resume callbacks because phylink
requires it. Otherwise we will get a WARN() in suspend and resume.

Also, move phylink start and stop callbacks to inside device's internal
lock so that we prevent concurrent HW accesses.

Fixes: 74371272f97f ("net: stmmac: Convert to phylink and remove phylib logic")
Reported-by: Christophe ROULLIER <christophe.roullier@st.com>
Tested-by: Christophe ROULLIER <christophe.roullier@st.com>
Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4451,10 +4451,12 @@ int stmmac_suspend(struct device *dev)
 	if (!ndev || !netif_running(ndev))
 		return 0;
 
-	phylink_stop(priv->phylink);
-
 	mutex_lock(&priv->lock);
 
+	rtnl_lock();
+	phylink_stop(priv->phylink);
+	rtnl_unlock();
+
 	netif_device_detach(ndev);
 	stmmac_stop_all_queues(priv);
 
@@ -4558,9 +4560,11 @@ int stmmac_resume(struct device *dev)
 
 	stmmac_start_all_queues(priv);
 
-	mutex_unlock(&priv->lock);
-
+	rtnl_lock();
 	phylink_start(priv->phylink);
+	rtnl_unlock();
+
+	mutex_unlock(&priv->lock);
 
 	return 0;
 }


