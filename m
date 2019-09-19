Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D800C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614FB21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931193;
	bh=8OfmWXLfzPUy31L8L3yXbaG3s9YW31QmNCHxQ4GyPOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wG8Br0UT3Wc5rvaVqJmF+k3cZogXmTy2DPW8mfT1Xes4pmqlvLYOiFqzUg6Eu76Vw
	 C99GD1q8ojaTwR+xP6HfRM9F4f6nGy/inz7MC5T6kBHEPHDDwaRUCHBdJ3tsfP0vc1
	 WgIztkWaBqQHvsDO9r9gjKMyrE+rqYPl46LwgN7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393728AbfISWNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393714AbfISWNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:13:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037F621920;
        Thu, 19 Sep 2019 22:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931187;
        bh=8OfmWXLfzPUy31L8L3yXbaG3s9YW31QmNCHxQ4GyPOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baxk1GkUQJBLLzZwPYw8q7QNZbBddHBy88RodCYXfDx2oVJ463EWBDyWxqLAMa7ZG
         PDOslT105LY8BNyr4smK4GUpVxP2KTLdY9uBYysBRKt71nOKiaS5Yi8pkb993Eyv+M
         gz/0REn70bmD+YUPdyg+Cj+70XBBsKNR9uwpV3c4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Seidelmann <tseidelmann@linode.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/79] netfilter: ebtables: Fix argument order to ADD_COUNTER
Date:   Fri, 20 Sep 2019 00:03:18 +0200
Message-Id: <20190919214810.714174443@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Seidelmann <tseidelmann@linode.com>

[ Upstream commit f20faa06d83de440bec8e200870784c3458793c4 ]

The ordering of arguments to the x_tables ADD_COUNTER macro
appears to be wrong in ebtables (cf. ip_tables.c, ip6_tables.c,
and arp_tables.c).

This causes data corruption in the ebtables userspace tools
because they get incorrect packet & byte counts from the kernel.

Fixes: d72133e628803 ("netfilter: ebtables: use ADD_COUNTER macro")
Signed-off-by: Todd Seidelmann <tseidelmann@linode.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/netfilter/ebtables.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 62ffc989a44a2..7d249afa1466c 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -225,7 +225,7 @@ unsigned int ebt_do_table(struct sk_buff *skb,
 			return NF_DROP;
 		}
 
-		ADD_COUNTER(*(counter_base + i), 1, skb->len);
+		ADD_COUNTER(*(counter_base + i), skb->len, 1);
 
 		/* these should only watch: not modify, nor tell us
 		 * what to do with the packet
@@ -963,8 +963,8 @@ static void get_counters(const struct ebt_counter *oldcounters,
 			continue;
 		counter_base = COUNTER_BASE(oldcounters, nentries, cpu);
 		for (i = 0; i < nentries; i++)
-			ADD_COUNTER(counters[i], counter_base[i].pcnt,
-				    counter_base[i].bcnt);
+			ADD_COUNTER(counters[i], counter_base[i].bcnt,
+				    counter_base[i].pcnt);
 	}
 }
 
@@ -1289,7 +1289,7 @@ static int do_update_counters(struct net *net, const char *name,
 
 	/* we add to the counters of the first cpu */
 	for (i = 0; i < num_counters; i++)
-		ADD_COUNTER(t->private->counters[i], tmp[i].pcnt, tmp[i].bcnt);
+		ADD_COUNTER(t->private->counters[i], tmp[i].bcnt, tmp[i].pcnt);
 
 	write_unlock_bh(&t->lock);
 	ret = 0;
-- 
2.20.1



