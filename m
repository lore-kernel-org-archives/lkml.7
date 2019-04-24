Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DDEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CB021909
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126366;
	bh=XBnV7yUkTta6EYtZvwVDzOoXMmsyTzKA37ZvjCVQq48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G7P+Nn0LtyBuZPtFtUjd/BAbn70+mt8oROwV0iQWY90ECdgfa1wQvYDktgKGDC2kw
	 zziRCu3zPyk5vjBzGUf0ztQz6Wt44xAqqLUcvVyZM30DKJbsY6O49zO8hysHQEhxvt
	 wm3fxsdlJFAsvOEZvUqKQrtL/WnsDuziECUCGJLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbfDXRTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388985AbfDXRTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:22 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C68EC20835;
        Wed, 24 Apr 2019 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126361;
        bh=XBnV7yUkTta6EYtZvwVDzOoXMmsyTzKA37ZvjCVQq48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyUo0Dgq+5Lu3OxaO2BiIIT6Ed8F6J8uR2qXxrMB/L1H1OFyYsPjgzcANww4QvpMX
         OEZ7YRLivm2oh+WkRNiLPRwyruERoixR997dgz6hUyxmQyQD1pcPAjGJs9aIzsyvIc
         HmPIfcrhVYOePZzdHym241gIveYpOf2wNr/Il1UE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Wang Li <wangli39@baidu.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 085/168] net: ethtool: not call vzalloc for zero sized memory request
Date:   Wed, 24 Apr 2019 19:08:49 +0200
Message-Id: <20190424170928.830672805@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
 net/core/ethtool.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -1287,17 +1287,22 @@ static int ethtool_get_strings(struct ne
 
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
 
@@ -1385,17 +1390,21 @@ static int ethtool_get_stats(struct net_
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
 


