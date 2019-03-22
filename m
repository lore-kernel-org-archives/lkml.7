Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DC62192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256076;
	bh=MbB8UnBqJaX6DO88O8/ZyK8v2Lef1hTTVD7LBu4PgdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SVfrWSphN+Lzt/mK6Tf+71cOvTqyyb0D3BTDyBEjurEYFUY35kkeClE3Ga7B4kCX4
	 /oQPTVdaMkUasUp3wbmA7x+YSkblYqAI7nC5eEDtiNaQHjEYeqnAtLz39MVVyvUbNq
	 ThAb48lC1oEqZzgXIcB/IaBzbZ1bpT18hcf+J+Dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbfCVMBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388179AbfCVMBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:01:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E247204FD;
        Fri, 22 Mar 2019 12:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256071;
        bh=MbB8UnBqJaX6DO88O8/ZyK8v2Lef1hTTVD7LBu4PgdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSc9R5s6CFc+7MrQN2QLoD5EtFaMqZpkyX6hmLoZVCfs9sU3N9QxKS2Vv9zkxK/b9
         vWwLsRO5yv5xnb6E2vy7ecrDi7Eol/E9qKGoWC9gXsDvJsLleyYpZSw59fL5ktyL32
         ubiGUEVqH1gxMK1OBjzykTlaGupmfmZKdOO7M6gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Brunner <tobias@strongswan.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 084/280] xfrm: Fix inbound traffic via XFRM interfaces across network namespaces
Date:   Fri, 22 Mar 2019 12:13:57 +0100
Message-Id: <20190322111311.110135874@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



