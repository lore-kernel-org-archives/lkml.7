Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C159AC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9642B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505556;
	bh=mv8Xmg/kQinWCCXmWb1GB2gyOCpwrhAdqjD2MOgWSas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B/JEZDLRzm1GJ4IUfIWmi2VxcGhMVsb39ULkiQ21wRXwTWmB6T8MrZVCZ/DlGz6Cc
	 f+3YD71hl/gVCXHpzO7RckcaiqZtcqtl46/fcqi2z2AMvIXoY+KEUTLsw6iKns7eU5
	 mErebogmbTyfuPYvEuFmzQpQ+y24jIQg9dkW5T1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfCMTLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727284AbfCMTLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 369502173C;
        Wed, 13 Mar 2019 19:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504264;
        bh=mv8Xmg/kQinWCCXmWb1GB2gyOCpwrhAdqjD2MOgWSas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pb04sNMVA9g4cTE/G+7o7NdZHPT4hq1z8A8U2AOhh5vfTRa8aAdPfBxNgmPdxsrIA
         0HPR0NaaZoG9WkreowPHZeQsTklxhZaFNPOcAsZfCHe2TANWC0eoc03uSM+a8YJ5HK
         UjJFuA3jbiZ1hEYNiYTDSknnfwYTNFWGSA1QkXes=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tobias Brunner <tobias@strongswan.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 20/60] xfrm: Fix inbound traffic via XFRM interfaces across network namespaces
Date:   Wed, 13 Mar 2019 15:09:41 -0400
Message-Id: <20190313191021.158171-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
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
index d679fa0f44b3..fcf3c714f4ff 100644
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

