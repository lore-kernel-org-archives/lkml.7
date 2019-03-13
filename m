Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13174C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD95213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504437;
	bh=KJYQwHA5LQTN/mrdT8k2cDairrT/Oqac4sMvz3SrSX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dvbYRLu1+1K0dBOwINPtzjQ9MwhhZyQBsYjvhM5luSdk5amVob4dXyn/sMaEeC5i6
	 nDnSb9D/iy56C9vhIlIK5G++io85maYYJ365yr+b+25BLpP4kC85SPnigFayj0q9ox
	 YiofWCP0gKCNJdqKsjv0ITtUcJBPGfGoX0aOYHMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfCMTN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbfCMTNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:13:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B8162173C;
        Wed, 13 Mar 2019 19:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504420;
        bh=KJYQwHA5LQTN/mrdT8k2cDairrT/Oqac4sMvz3SrSX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRIZsbci447ZV9wHObz9D4o5ZpgOciY730Jz/GgfBYtNHeDKejT3PEkuPAFexZbVN
         pxXeA4jn6EFXF8rVvuEVWWUoS3Oi8bZES887To3YpHh3E2XwrDkCEPL12IMd9upT3z
         udrS0R89bITwFHjDsCl7+xXaUeCcfDKXB2ynETZY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tobias Brunner <tobias@strongswan.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/48] xfrm: Fix inbound traffic via XFRM interfaces across network namespaces
Date:   Wed, 13 Mar 2019 15:12:20 -0400
Message-Id: <20190313191250.158955-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Brunner <tobias@strongswan.org>

[ Upstream commit 660899ddf06ae8bb5bbbd0a19418b739375430c5 ]

After moving an XFRM interface to another namespace it stays associated
with the original namespace (net in `struct xfrm_if` and the list keyed
with `xfrmi_net_id`), allowing processes in the new namespace to use
SAs/policies that were created in the original namespace.  For instance,
this allows a keying daemon in one namespace to establish IPsec SAs for
other namespaces without processes there having access to the keys or IKE
credentials.

This worked fine for outbound traffic, however, for inbound traffic the
lookup for the interfaces and the policies used the incorrect namespace
(the one the XFRM interface was moved to).

Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Signed-off-by: Tobias Brunner <tobias@strongswan.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_interface.c | 4 ++--
 net/xfrm/xfrm_policy.c    | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_interface.c b/net/xfrm/xfrm_interface.c
index 6f05e831a73e..82723ef44db3 100644
--- a/net/xfrm/xfrm_interface.c
+++ b/net/xfrm/xfrm_interface.c
@@ -76,10 +76,10 @@ static struct xfrm_if *xfrmi_decode_session(struct sk_buff *skb)
 	int ifindex;
 	struct xfrm_if *xi;
 
-	if (!skb->dev)
+	if (!secpath_exists(skb) || !skb->dev)
 		return NULL;
 
-	xfrmn = net_generic(dev_net(skb->dev), xfrmi_net_id);
+	xfrmn = net_generic(xs_net(xfrm_input_state(skb)), xfrmi_net_id);
 	ifindex = skb->dev->ifindex;
 
 	for_each_xfrmi_rcu(xfrmn->xfrmi[0], xi) {
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6ea8036fcdbe..bf5d59270f79 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2340,8 +2340,10 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 
 	if (ifcb) {
 		xi = ifcb->decode_session(skb);
-		if (xi)
+		if (xi) {
 			if_id = xi->p.if_id;
+			net = xi->net;
+		}
 	}
 	rcu_read_unlock();
 
-- 
2.19.1

