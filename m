Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BB6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACF021019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687979;
	bh=HDhcxhXNknPHihsIQT8hw1gJMc1Et8FSxWyaqAWlWck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AZqLBjC8s7/ZdaHI2hXY2AYh5tkT4fn0IhLd4/Rw2o6B/lFKk7r9zOXsOLzsIfpvT
	 1nTL1fd/sw1rGsydiyhaiouQ6IWVbWDcRjCEIbaYC6krUEqxLpaBS5l6qQIswokNrK
	 MEDw44lsZB7kz83Gj4PKZEJklgWWfY8NKmRrJu0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCDI0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:26:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfCDI0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:26:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D1F20863;
        Mon,  4 Mar 2019 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687975;
        bh=HDhcxhXNknPHihsIQT8hw1gJMc1Et8FSxWyaqAWlWck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=of1D3VLoX7Xb5ZvS2ETsFSNXvo8mS03AhclUN3b9k/Li+6gdpvMzMyPJ1e4iEpFWS
         FXxba4g2tpPmK1++iI12lxP/d7QbdPw119xjESZC8VQKGeVstY2lmfoaTunjxleD/1
         DXof6Q45Tz26+tjBl7XpaNMNwWlrCzAzgZ/BexqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Hu <weh@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 35/52] hv_netvsc: Fix ethtool change hash key error
Date:   Mon,  4 Mar 2019 09:22:33 +0100
Message-Id: <20190304081619.153940486@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081617.159014799@linuxfoundation.org>
References: <20190304081617.159014799@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b4a10c750424e01b5e37372fef0a574ebf7b56c3 ]

Hyper-V hosts require us to disable RSS before changing RSS key,
otherwise the changing request will fail. This patch fixes the
coding error.

Fixes: ff4a44199012 ("netvsc: allow get/set of RSS indirection table")
Reported-by: Wei Hu <weh@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
[sl: fix up subject line]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/rndis_filter.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 17025d46bdac8..fc1d5e14d83e9 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -711,8 +711,8 @@ rndis_filter_set_offload_params(struct net_device *ndev,
 	return ret;
 }
 
-int rndis_filter_set_rss_param(struct rndis_device *rdev,
-			       const u8 *rss_key)
+static int rndis_set_rss_param_msg(struct rndis_device *rdev,
+				   const u8 *rss_key, u16 flag)
 {
 	struct net_device *ndev = rdev->ndev;
 	struct rndis_request *request;
@@ -741,7 +741,7 @@ int rndis_filter_set_rss_param(struct rndis_device *rdev,
 	rssp->hdr.type = NDIS_OBJECT_TYPE_RSS_PARAMETERS;
 	rssp->hdr.rev = NDIS_RECEIVE_SCALE_PARAMETERS_REVISION_2;
 	rssp->hdr.size = sizeof(struct ndis_recv_scale_param);
-	rssp->flag = 0;
+	rssp->flag = flag;
 	rssp->hashinfo = NDIS_HASH_FUNC_TOEPLITZ | NDIS_HASH_IPV4 |
 			 NDIS_HASH_TCP_IPV4 | NDIS_HASH_IPV6 |
 			 NDIS_HASH_TCP_IPV6;
@@ -766,9 +766,12 @@ int rndis_filter_set_rss_param(struct rndis_device *rdev,
 
 	wait_for_completion(&request->wait_event);
 	set_complete = &request->response_msg.msg.set_complete;
-	if (set_complete->status == RNDIS_STATUS_SUCCESS)
-		memcpy(rdev->rss_key, rss_key, NETVSC_HASH_KEYLEN);
-	else {
+	if (set_complete->status == RNDIS_STATUS_SUCCESS) {
+		if (!(flag & NDIS_RSS_PARAM_FLAG_DISABLE_RSS) &&
+		    !(flag & NDIS_RSS_PARAM_FLAG_HASH_KEY_UNCHANGED))
+			memcpy(rdev->rss_key, rss_key, NETVSC_HASH_KEYLEN);
+
+	} else {
 		netdev_err(ndev, "Fail to set RSS parameters:0x%x\n",
 			   set_complete->status);
 		ret = -EINVAL;
@@ -779,6 +782,16 @@ int rndis_filter_set_rss_param(struct rndis_device *rdev,
 	return ret;
 }
 
+int rndis_filter_set_rss_param(struct rndis_device *rdev,
+			       const u8 *rss_key)
+{
+	/* Disable RSS before change */
+	rndis_set_rss_param_msg(rdev, rss_key,
+				NDIS_RSS_PARAM_FLAG_DISABLE_RSS);
+
+	return rndis_set_rss_param_msg(rdev, rss_key, 0);
+}
+
 static int rndis_filter_query_device_link_status(struct rndis_device *dev,
 						 struct netvsc_device *net_device)
 {
-- 
2.19.1



