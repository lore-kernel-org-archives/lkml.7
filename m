Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CE1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85E2218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354980;
	bh=zNdLVdzahmNhp/Do/aeElOZd3or5toZWZOGereNie1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xYKpTStNgA5wY1NddB4SNszdRaMyZpa7hvh9wqr/uTF5I9ppPYWqBBGlmysfGf78k
	 vzaZPFLT9tYrJj1p7jIMrP7tXL4v+PahkPClSWKAfqcGMP6zk8vi1PCXoGBWWjMNyb
	 RoPBzuABGIhSnrv9l/YdjCLSR2UA1CcxWH6EFisU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfDOTC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfDOTCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:02:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 130812087C;
        Mon, 15 Apr 2019 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354974;
        bh=zNdLVdzahmNhp/Do/aeElOZd3or5toZWZOGereNie1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ihb90o82ZyHGcbwCT/ZobKTwYUBb2JKk8vxMIvXTcuGXfMg1O0eqCLJaEYLuQwcW8
         xBi/RkWGhWiNyNKD+gFrNRu1GdmkBHOZQjJC6g/avWHCu3kquajE+31yGEYJeV50Vt
         JSDcW1oTwsRLW/IkXEN3A9skPlOjpW9C6yMaKdQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Wang Li <wangli39@baidu.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 35/69] net: ethtool: not call vzalloc for zero sized memory request
Date:   Mon, 15 Apr 2019 20:58:53 +0200
Message-Id: <20190415183732.029772029@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 3d8830266ffc28c16032b859e38a0252e014b631 ]

NULL or ZERO_SIZE_PTR will be returned for zero sized memory
request, and derefencing them will lead to a segfault

so it is unnecessory to call vzalloc for zero sized memory
request and not call functions which maybe derefence the
NULL allocated memory

this also fixes a possible memory leak if phy_ethtool_get_stats
returns error, memory should be freed before exit

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Wang Li <wangli39@baidu.com>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/ethtool.c |   43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -1815,11 +1815,15 @@ static int ethtool_get_strings(struct ne
 	WARN_ON_ONCE(!ret);
 
 	gstrings.len = ret;
-	data = vzalloc(gstrings.len * ETH_GSTRING_LEN);
-	if (gstrings.len && !data)
-		return -ENOMEM;
+	if (gstrings.len) {
+		data = vzalloc(gstrings.len * ETH_GSTRING_LEN);
+		if (!data)
+			return -ENOMEM;
 
-	__ethtool_get_strings(dev, gstrings.string_set, data);
+		__ethtool_get_strings(dev, gstrings.string_set, data);
+	} else {
+		data = NULL;
+	}
 
 	ret = -EFAULT;
 	if (copy_to_user(useraddr, &gstrings, sizeof(gstrings)))
@@ -1915,11 +1919,14 @@ static int ethtool_get_stats(struct net_
 		return -EFAULT;
 
 	stats.n_stats = n_stats;
-	data = vzalloc(n_stats * sizeof(u64));
-	if (n_stats && !data)
-		return -ENOMEM;
-
-	ops->get_ethtool_stats(dev, &stats, data);
+	if (n_stats) {
+		data = vzalloc(n_stats * sizeof(u64));
+		if (!data)
+			return -ENOMEM;
+		ops->get_ethtool_stats(dev, &stats, data);
+	} else {
+		data = NULL;
+	}
 
 	ret = -EFAULT;
 	if (copy_to_user(useraddr, &stats, sizeof(stats)))
@@ -1955,13 +1962,17 @@ static int ethtool_get_phy_stats(struct
 		return -EFAULT;
 
 	stats.n_stats = n_stats;
-	data = vzalloc(n_stats * sizeof(u64));
-	if (n_stats && !data)
-		return -ENOMEM;
-
-	mutex_lock(&phydev->lock);
-	phydev->drv->get_stats(phydev, &stats, data);
-	mutex_unlock(&phydev->lock);
+	if (n_stats) {
+		data = vzalloc(n_stats * sizeof(u64));
+		if (!data)
+			return -ENOMEM;
+
+		mutex_lock(&phydev->lock);
+		phydev->drv->get_stats(phydev, &stats, data);
+		mutex_unlock(&phydev->lock);
+	} else {
+		data = NULL;
+	}
 
 	ret = -EFAULT;
 	if (copy_to_user(useraddr, &stats, sizeof(stats)))


