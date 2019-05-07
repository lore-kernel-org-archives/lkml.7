Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E36CC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0006F20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207288;
	bh=cpAQRyQizKc+uI1xsCT+jLz2R7htXM93DFsEV8hVXZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hI5TbDtG4wAvCclLRT4ITt3W3NbVqkoVO+RmHz7a5hFaD7MgJHqltctx2F+jmivdm
	 FLb0sbJvbOqltalAaBPWOFhGV0I4SWRQR846vaqxTDmtCfaroqJxq6xeqTVD3L2EAN
	 aLsdcVAqAMPjOY42Lg+3xgPHwZyk1Ng4Vw6r2uJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfEGFeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfEGFek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:34:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7156021479;
        Tue,  7 May 2019 05:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207279;
        bh=cpAQRyQizKc+uI1xsCT+jLz2R7htXM93DFsEV8hVXZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IggPmiHQhFz/MMju6cpjbzeNvh2Nlo1oqV2L47nthNdfz0D2AU1ND56fXYD++vX8d
         7PXGBIsF2IMXltpUG+KwpUjyODisb9P+ygsR4+iVrX3DInYry3CZDYMkqkliJseB6V
         ApJV/3JynkY01VlBK1OsEfbZF3kJwxfGKFZztDKs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Anastasov <ja@ssi.bg>, Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org
Subject: [PATCH AUTOSEL 5.0 62/99] ipvs: do not schedule icmp errors from tunnels
Date:   Tue,  7 May 2019 01:31:56 -0400
Message-Id: <20190507053235.29900-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Anastasov <ja@ssi.bg>

[ Upstream commit 0261ea1bd1eb0da5c0792a9119b8655cf33c80a3 ]

We can receive ICMP errors from client or from
tunneling real server. While the former can be
scheduled to real server, the latter should
not be scheduled, they are decapsulated only when
existing connection is found.

Fixes: 6044eeffafbe ("ipvs: attempt to schedule icmp packets")
Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 235205c93e14..df112b27246a 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1647,7 +1647,7 @@ ip_vs_in_icmp(struct netns_ipvs *ipvs, struct sk_buff *skb, int *related,
 	if (!cp) {
 		int v;
 
-		if (!sysctl_schedule_icmp(ipvs))
+		if (ipip || !sysctl_schedule_icmp(ipvs))
 			return NF_ACCEPT;
 
 		if (!ip_vs_try_to_schedule(ipvs, AF_INET, skb, pd, &v, &cp, &ciph))
-- 
2.20.1

