Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A25C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81195218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355096;
	bh=ijJWrPsLshffVG4EdDtDAmNhnR7vNho8Y8kZW7fmGOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DvxmbKwUgkhA6Qj8UB7Aw/LNbiRQiF9szXmVGZbth4pZxwMiX9TWn29Mowdog9UU7
	 bY7gLhI6mcmOhHGHgjqH711Pzi3epFLpxoP3ZWhg574peWDfLQJ6dsFypvrBOj7FQM
	 xmgQLIPvzOGbrP178Ee0ocWDRiTCm6qrZwZFYUWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfDOTEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbfDOTEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:04:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36BFF218A1;
        Mon, 15 Apr 2019 19:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355092;
        bh=ijJWrPsLshffVG4EdDtDAmNhnR7vNho8Y8kZW7fmGOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kkf4pb/qJ6aqc1UI3x2gpa1CtuNOn7V1e2MHRPvbOxDrF67YvxYJnPWlCmEaT/GX+
         DgDAGvWipgX+DbhZrMlfemNAHwyp24WWZZ5rSdj/8w/61vnC8VhltqD6qgPYMk53j5
         HF0jR4UiA+v7Vdx4+ULUPcruowL8dqjFbQNY0VTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Wang Li <wangli39@baidu.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 010/101] net: ethtool: not call vzalloc for zero sized memory request
Date:   Mon, 15 Apr 2019 20:58:08 +0200
Message-Id: <20190415183740.916616196@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/ethtool.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index aeabc4831fca..7cc97f43f138 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -1863,11 +1863,16 @@ static int ethtool_get_strings(struct net_device *dev, void __user *useraddr)
 	WARN_ON_ONCE(!ret);
 
 	gstrings.len = ret;
-	data = vzalloc(array_size(gstrings.len, ETH_GSTRING_LEN));
-	if (gstrings.len && !data)
-		return -ENOMEM;
 
-	__ethtool_get_strings(dev, gstrings.string_set, data);
+	if (gstrings.len) {
+		data = vzalloc(array_size(gstrings.len, ETH_GSTRING_LEN));
+		if (!data)
+			return -ENOMEM;
+
+		__ethtool_get_strings(dev, gstrings.string_set, data);
+	} else {
+		data = NULL;
+	}
 
 	ret = -EFAULT;
 	if (copy_to_user(useraddr, &gstrings, sizeof(gstrings)))
@@ -1963,11 +1968,15 @@ static int ethtool_get_stats(struct net_device *dev, void __user *useraddr)
 		return -EFAULT;
 
 	stats.n_stats = n_stats;
-	data = vzalloc(array_size(n_stats, sizeof(u64)));
-	if (n_stats && !data)
-		return -ENOMEM;
 
-	ops->get_ethtool_stats(dev, &stats, data);
+	if (n_stats) {
+		data = vzalloc(array_size(n_stats, sizeof(u64)));
+		if (!data)
+			return -ENOMEM;
+		ops->get_ethtool_stats(dev, &stats, data);
+	} else {
+		data = NULL;
+	}
 
 	ret = -EFAULT;
 	if (copy_to_user(useraddr, &stats, sizeof(stats)))
@@ -2007,16 +2016,21 @@ static int ethtool_get_phy_stats(struct net_device *dev, void __user *useraddr)
 		return -EFAULT;
 
 	stats.n_stats = n_stats;
-	data = vzalloc(array_size(n_stats, sizeof(u64)));
-	if (n_stats && !data)
-		return -ENOMEM;
 
-	if (dev->phydev && !ops->get_ethtool_phy_stats) {
-		ret = phy_ethtool_get_stats(dev->phydev, &stats, data);
-		if (ret < 0)
-			return ret;
+	if (n_stats) {
+		data = vzalloc(array_size(n_stats, sizeof(u64)));
+		if (!data)
+			return -ENOMEM;
+
+		if (dev->phydev && !ops->get_ethtool_phy_stats) {
+			ret = phy_ethtool_get_stats(dev->phydev, &stats, data);
+			if (ret < 0)
+				goto out;
+		} else {
+			ops->get_ethtool_phy_stats(dev, &stats, data);
+		}
 	} else {
-		ops->get_ethtool_phy_stats(dev, &stats, data);
+		data = NULL;
 	}
 
 	ret = -EFAULT;
-- 
2.19.1



