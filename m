Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A348BC742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B52021019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934514;
	bh=jAbFcyGbvqDuahV01o/tyOYr3IHhrqzrwQuCsqfTRZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dkSAZ/WDQRzh+Aa04xTOqRY6+if9ir/VIgd+EHwfjSgmcndDaPp14eMoGlhPQ5lTb
	 TwNBg6M8sTlIeR01s0w4CKyhQli16kkMI9vCPEqccPUGJLX+rFdoIkJOeRkNlpLm57
	 DZAWmA8hkHPimuPwb8WEpCUTzvdksId1nTmIk1MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfGLM23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbfGLM21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:28:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2C821019;
        Fri, 12 Jul 2019 12:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934506;
        bh=jAbFcyGbvqDuahV01o/tyOYr3IHhrqzrwQuCsqfTRZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O49M1SmYCwcPwU9N6X6sSRsgPIzf5g6WDs2Q6HITsI/CXEKZdZPOE55VxYlALgAn7
         DosSlPvx7d1QiHc+xKtEbY8GnTuZRmpqB7QtvnexaPw5doTSm4I/UGleIpLqAfw8Zi
         WPvxMXCjr6/8tBl/xvjaKw3Vlzv2d5COjmyQcLek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 033/138] netfilter: ipv6: nf_defrag: accept duplicate fragments again
Date:   Fri, 12 Jul 2019 14:18:17 +0200
Message-Id: <20190712121629.965015417@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8a3dca632538c550930ce8bafa8c906b130d35cf ]

When fixing the skb leak introduced by the conversion to rbtree, I
forgot about the special case of duplicate fragments. The condition
under the 'insert_error' label isn't effective anymore as
nf_ct_frg6_gather() doesn't override the returned value anymore. So
duplicate fragments now get NF_DROP verdict.

To accept duplicate fragments again, handle them specially as soon as
inet_frag_queue_insert() reports them. Return -EINPROGRESS which will
translate to NF_STOLEN verdict, like any accepted fragment. However,
such packets don't carry any new information and aren't queued, so we
just drop them immediately.

Fixes: a0d56cb911ca ("netfilter: ipv6: nf_defrag: fix leakage of unqueued fragments")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/netfilter/nf_conntrack_reasm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 5b3f65e29b6f..8951de8b568f 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -265,8 +265,14 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
 
 	prev = fq->q.fragments_tail;
 	err = inet_frag_queue_insert(&fq->q, skb, offset, end);
-	if (err)
+	if (err) {
+		if (err == IPFRAG_DUP) {
+			/* No error for duplicates, pretend they got queued. */
+			kfree_skb(skb);
+			return -EINPROGRESS;
+		}
 		goto insert_error;
+	}
 
 	if (dev)
 		fq->iif = dev->ifindex;
@@ -304,8 +310,6 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
 	return -EINPROGRESS;
 
 insert_error:
-	if (err == IPFRAG_DUP)
-		goto err;
 	inet_frag_kill(&fq->q);
 err:
 	skb_dst_drop(skb);
-- 
2.20.1



