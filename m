Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790D6C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AD7218FE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354074;
	bh=/djra96ESKAR8279YAcz6FaVbmTLbnPyz9Fu0HNKhRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jwG/0KvaYDLmDoID8IO1dVV5GCaBWN6I0EajC2NYOIsfb2p0fXjzeO9UtLOwW+x+2
	 NXE1Uwiy9UZdN1dbo/H70R+XQR/qvoNdX79EGEYLihZyS5fhfbbNc2vTPAhduVqJEr
	 Kola11uksPELL57tvGpecVowbYK5w6iAI/yH6Z9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfDOSrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfDOSru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7B1B2087C;
        Mon, 15 Apr 2019 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354069;
        bh=/djra96ESKAR8279YAcz6FaVbmTLbnPyz9Fu0HNKhRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wLs2R1Qt5nSH2HROH5ByxlIqZffJWFthK7euRMDU4pfzjZYLK/2o10Qehu4P9exmt
         tmGXCbLVsboJFgIxT7057WrIL0mn6s9UcmWet0TWvXyVaBJA9lYq8Z0xDkxl4J09qg
         MmCYFTLgJuFN84uO4+CPfAUvBJUIqlQRcMSPTx4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Wang Li <wangli39@baidu.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 61/76] net: ethtool: not call vzalloc for zero sized memory request
Date:   Mon, 15 Apr 2019 20:44:25 +0200
Message-Id: <20190415183725.347326538@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
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
 net/core/ethtool.c |   49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -1801,17 +1801,22 @@ static int ethtool_get_strings(struct ne
 
 	gstrings.len = ret;
 
-	data = kcalloc(gstrings.len, ETH_GSTRING_LEN, GFP_USER);
-	if (!data)
-		return -ENOMEM;
+	if (gstrings.len) {
+		data = kcalloc(gstrings.len, ETH_GSTRING_LEN, GFP_USER);
+		if (!data)
+			return -ENOMEM;
 
-	__ethtool_get_strings(dev, gstrings.string_set, data);
+		__ethtool_get_strings(dev, gstrings.string_set, data);
+	} else {
+		data = NULL;
+	}
 
 	ret = -EFAULT;
 	if (copy_to_user(useraddr, &gstrings, sizeof(gstrings)))
 		goto out;
 	useraddr += sizeof(gstrings);
-	if (copy_to_user(useraddr, data, gstrings.len * ETH_GSTRING_LEN))
+	if (gstrings.len &&
+	    copy_to_user(useraddr, data, gstrings.len * ETH_GSTRING_LEN))
 		goto out;
 	ret = 0;
 
@@ -1899,17 +1904,21 @@ static int ethtool_get_stats(struct net_
 		return -EFAULT;
 
 	stats.n_stats = n_stats;
-	data = kmalloc(n_stats * sizeof(u64), GFP_USER);
-	if (!data)
-		return -ENOMEM;
+	if (n_stats) {
+		data = kmalloc(n_stats * sizeof(u64), GFP_USER);
+		if (!data)
+			return -ENOMEM;
 
-	ops->get_ethtool_stats(dev, &stats, data);
+		ops->get_ethtool_stats(dev, &stats, data);
+	} else {
+		data = NULL;
+	}
 
 	ret = -EFAULT;
 	if (copy_to_user(useraddr, &stats, sizeof(stats)))
 		goto out;
 	useraddr += sizeof(stats);
-	if (copy_to_user(useraddr, data, stats.n_stats * sizeof(u64)))
+	if (n_stats && copy_to_user(useraddr, data, n_stats * sizeof(u64)))
 		goto out;
 	ret = 0;
 
@@ -1938,19 +1947,23 @@ static int ethtool_get_phy_stats(struct
 		return -EFAULT;
 
 	stats.n_stats = n_stats;
-	data = kmalloc_array(n_stats, sizeof(u64), GFP_USER);
-	if (!data)
-		return -ENOMEM;
-
-	mutex_lock(&phydev->lock);
-	phydev->drv->get_stats(phydev, &stats, data);
-	mutex_unlock(&phydev->lock);
+	if (n_stats) {
+		data = kmalloc_array(n_stats, sizeof(u64), GFP_USER);
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
 		goto out;
 	useraddr += sizeof(stats);
-	if (copy_to_user(useraddr, data, stats.n_stats * sizeof(u64)))
+	if (n_stats && copy_to_user(useraddr, data, n_stats * sizeof(u64)))
 		goto out;
 	ret = 0;
 


