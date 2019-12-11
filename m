Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83088C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5428120652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079554;
	bh=wPH1ASaSFlhbjvw8DtlszMkLA3HruIqPfzIMd5a2MLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nTziLw4XNNx4oLDG75o3uc086WuhMH0f4QvMrHzZmcWq8gWIFroWD7jbf6eNSKg5a
	 EeYoqxbe5JNL/+2uhluavPYR/gm9uxCVQNU2B0tZNp+mHp6nWmDDu5Ki8h6hlrhlRq
	 37VRzX+e+7g/SXzaqg9cZBNvE+8FDrf5mYElVUYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbfLKPwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:52:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731986AbfLKPUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:20:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0F6122527;
        Wed, 11 Dec 2019 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077642;
        bh=wPH1ASaSFlhbjvw8DtlszMkLA3HruIqPfzIMd5a2MLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtUYzfjTW7Mwq2LBWkDA86sMP5rpmgQs8+2d79uzvq6PDBQplEhpMbH6shCeCIg+v
         bwrCWdm8My5pgl/Q6CfkhocukLqg1FZ8R+Np/kcCB3mEATY04CR3kJ72lOxhrasGCZ
         APkbahywqTUuJaRPqImfMvvWkCI/78cEhN7q4g3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiumei Mu <xmu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 067/243] sctp: count sk_wmem_alloc by skb truesize in sctp_packet_transmit
Date:   Wed, 11 Dec 2019 16:03:49 +0100
Message-Id: <20191211150343.622625855@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 02968ccf0125d39b08ecef5946300a8a873c0942 ]

Now sctp increases sk_wmem_alloc by 1 when doing set_owner_w for the
skb allocked in sctp_packet_transmit and decreases by 1 when freeing
this skb.

But when this skb goes through networking stack, some subcomponents
might change skb->truesize and add the same amount on sk_wmem_alloc.
However sctp doesn't know the amount to decrease by, it would cause
a leak on sk->sk_wmem_alloc and the sock can never be freed.

Xiumei found this issue when it hit esp_output_head() by using sctp
over ipsec, where skb->truesize is added and so is sk->sk_wmem_alloc.

Since sctp has used sk_wmem_queued to count for writable space since
Commit cd305c74b0f8 ("sctp: use sk_wmem_queued to check for writable
space"), it's ok to fix it by counting sk_wmem_alloc by skb truesize
in sctp_packet_transmit.

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/output.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/net/sctp/output.c b/net/sctp/output.c
index 08601223b0bfa..b0e74a3e77ec5 100644
--- a/net/sctp/output.c
+++ b/net/sctp/output.c
@@ -399,25 +399,6 @@ finish:
 	return retval;
 }
 
-static void sctp_packet_release_owner(struct sk_buff *skb)
-{
-	sk_free(skb->sk);
-}
-
-static void sctp_packet_set_owner_w(struct sk_buff *skb, struct sock *sk)
-{
-	skb_orphan(skb);
-	skb->sk = sk;
-	skb->destructor = sctp_packet_release_owner;
-
-	/*
-	 * The data chunks have already been accounted for in sctp_sendmsg(),
-	 * therefore only reserve a single byte to keep socket around until
-	 * the packet has been transmitted.
-	 */
-	refcount_inc(&sk->sk_wmem_alloc);
-}
-
 static void sctp_packet_gso_append(struct sk_buff *head, struct sk_buff *skb)
 {
 	if (SCTP_OUTPUT_CB(head)->last == head)
@@ -604,7 +585,7 @@ int sctp_packet_transmit(struct sctp_packet *packet, gfp_t gfp)
 	if (!head)
 		goto out;
 	skb_reserve(head, packet->overhead + MAX_HEADER);
-	sctp_packet_set_owner_w(head, sk);
+	skb_set_owner_w(head, sk);
 
 	/* set sctp header */
 	sh = skb_push(head, sizeof(struct sctphdr));
-- 
2.20.1



