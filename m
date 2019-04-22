Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F51C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3D5204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963314;
	bh=+k+o2ok35qIOJqYoebmTJFG/yzV9ffoigKvIExKuR7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xvF7iqd9Jvk+qpDg5vP88eKOYMoplNQLG+f2jyzuubcB+zFjafyyNQZdnzPZtP/TJ
	 AKG+Yqr2Z+vcT2hRnNuAKVLu2P4wA9Js1mnG5l7c/ayOnoFzdxpxXdls6ClLAqB5ab
	 Dmy+7LQxKIYAV6juD5+RAKLwngxGmx5XHv+cZSZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbfDVTqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbfDVTqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9601218FF;
        Mon, 22 Apr 2019 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962404;
        bh=+k+o2ok35qIOJqYoebmTJFG/yzV9ffoigKvIExKuR7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5G1IaSyEn6LFIhBYTUPUN71mMi/a+qU7ATx5JDoFb+BLjE89YYwt7DefMsZfgMo7
         CSt7LtoufGJm5TiHmUk+m6y4AWp1h52pnCyMXm6eZEzqtMdZTV0B0icy0stlY6Sgql
         cRN3LBzoYH4NWSUMRcaVTd6Kvesx/tKYgTB0zlRM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Douglas Miller <dougmill@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 41/68] net: ibm: fix possible object reference leak
Date:   Mon, 22 Apr 2019 15:44:49 -0400
Message-Id: <20190422194516.11634-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit be693df3cf9dd113ff1d2c0d8150199efdba37f6 ]

The call to ehea_get_eth_dn returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/net/ethernet/ibm/ehea/ehea_main.c:3163:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 3154, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Douglas Miller <dougmill@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index 03f64f40b2a3..506f78322d74 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -3161,6 +3161,7 @@ static ssize_t ehea_probe_port(struct device *dev,
 
 	if (ehea_add_adapter_mr(adapter)) {
 		pr_err("creating MR failed\n");
+		of_node_put(eth_dn);
 		return -EIO;
 	}
 
-- 
2.19.1

