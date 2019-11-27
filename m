Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ADBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53CD20869
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574891021;
	bh=QI1gw+r06sE5VELa9ZX/A+y3EYDXLyXaTUSzj6BhIYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ms8rplpTMonj85LRa77GJ/vOJs6uuIWKKKIpVIgl0r/xUL8UZHKFT43hrUgdLEiU+
	 x3YR20SnrKzbsaJhXdP+Ps6TrYfVUifw/mhnbW8VHutGh2JllvI/DD3FQMsVTyhA3C
	 xZSsHbCignf/1864Tbtln35PT27kn6SHTEqHWhwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfK0Vnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728742AbfK0Uib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:38:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4760F21569;
        Wed, 27 Nov 2019 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887110;
        bh=QI1gw+r06sE5VELa9ZX/A+y3EYDXLyXaTUSzj6BhIYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Im5dkBPWaT8LKF9kU3BFkVPLBrumljK4OpmmTxTjsRg5K20FEq6hmEF1883C44AEr
         MqdL7RRPX0wHyQo3+m3NrOpt4F8dmYBrKEKAseHTP0hj8x6w6+tq6hgo77mT82ASob
         vbvDM4E3y1cUnR2q+wMHqkvhMb4YSKLEYs+hrHsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gerd W. Haeussler" <gerd.haeussler@cesys-it.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 074/132] ntb_netdev: fix sleep time mismatch
Date:   Wed, 27 Nov 2019 21:31:05 +0100
Message-Id: <20191127203008.618703311@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Mason <jdmason@kudzu.us>

[ Upstream commit a861594b1b7ffd630f335b351c4e9f938feadb8e ]

The tx_time should be in usecs (according to the comment above the
variable), but the setting of the timer during the rearming is done in
msecs.  Change it to match the expected units.

Fixes: e74bfeedad08 ("NTB: Add flow control to the ntb_netdev")
Suggested-by: Gerd W. Haeussler <gerd.haeussler@cesys-it.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ntb_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index a9acf71568555..03009f1becddc 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -236,7 +236,7 @@ static void ntb_netdev_tx_timer(unsigned long data)
 	struct ntb_netdev *dev = netdev_priv(ndev);
 
 	if (ntb_transport_tx_free_entry(dev->qp) < tx_stop) {
-		mod_timer(&dev->tx_timer, jiffies + msecs_to_jiffies(tx_time));
+		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 	} else {
 		/* Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
-- 
2.20.1



