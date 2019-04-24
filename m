Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5FCC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A7D218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125982;
	bh=t7rpxoBKrWheMC0pUuOqCb+HqqWBs0Xd9ZYY+72GMqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jh2srzPU2bW3osvcvtRpWBKb+i3jvQSdzsoEO2q3lTgx16UA8QXSkSJAYnFXOm/v3
	 u82Tw6bKPyiaRfXN7L6cc3QnyULeAdKghiv1ro3gEcLhejb6oc3wQV1U67qliusj6f
	 ByvJBWgOpGSEhviPXRpR61WsddUKzLHmnWZGXsgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbfDXRNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387766AbfDXRM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:12:59 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2F2B218FE;
        Wed, 24 Apr 2019 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125978;
        bh=t7rpxoBKrWheMC0pUuOqCb+HqqWBs0Xd9ZYY+72GMqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4oQG5IVMHBdVC2+EXmpmngzOpIdPvkp8nIJfVIOQ2VV/qfOe33yBWy/u5y3MTKKj
         RkXljX6+4e6c3VV05+nph3UiOFcccsk6YZv8sb8QpfJUEMytpuy9Yx9EZ+ftyqEZrw
         Gwnqk9pIdQjgBaC1FfjYmnsjhFsgswBil1MFLn8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Wang Li <wangli39@baidu.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 050/104] net: ethtool: not call vzalloc for zero sized memory request
Date:   Wed, 24 Apr 2019 19:09:07 +0200
Message-Id: <20190424170901.472691221@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
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
@@ -1257,17 +1257,22 @@ static int ethtool_get_strings(struct ne
 
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
 
@@ -1355,17 +1360,21 @@ static int ethtool_get_stats(struct net_
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
 


