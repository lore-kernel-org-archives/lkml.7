Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF37C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FF521916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255234;
	bh=gGo/zg4aOZkFr87BY4HfAJLW7F8rzVIjTDV2A7A061o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYnwULoK5Km8FjdoSApF186nZEb7iN3WtKHdeCAvyJ5BU2KAd7/4V33WxXc8EU0PV
	 H7KJDSK3l1/75LgHuO6Xy8qPIFNa3Yiff5bMb31buQiNY0kS4/DebSKHRAVheea3j3
	 hx4zJmVreBVxtJ6YadjoJLWJ1aHE6tYjHN6ivtjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbfCVLrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfCVLrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:47:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BC5A2075E;
        Fri, 22 Mar 2019 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255229;
        bh=gGo/zg4aOZkFr87BY4HfAJLW7F8rzVIjTDV2A7A061o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mE/i8KpzLzabBGF+r5mbUiRJkLqGOrrKAMiV284kwr07DKpZE0Lu/J+Dw4EuR8dq2
         VUO0uBfbUWb22bbb8goQKrYFo+uq5ki2B9+D0xDmvJlYi1Yv47K2aR5VEh/7wJM//r
         QO73veKS14/83MSUYqaWc5Os4rPl7ZG/zurw47vs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Andrea Claudi <aclaudi@redhat.com>,
        Julian Anastasov <ja@ssi.bg>,
        Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 026/183] ipvs: fix dependency on nf_defrag_ipv6
Date:   Fri, 22 Mar 2019 12:14:14 +0100
Message-Id: <20190322111243.649544181@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

[ Upstream commit 098e13f5b21d3398065fce8780f07a3ef62f4812 ]

ipvs relies on nf_defrag_ipv6 module to manage IPv6 fragmentation,
but lacks proper Kconfig dependencies and does not explicitly
request defrag features.

As a result, if netfilter hooks are not loaded, when IPv6 fragmented
packet are handled by ipvs only the first fragment makes through.

Fix it properly declaring the dependency on Kconfig and registering
netfilter hooks on ip_vs_add_service() and ip_vs_new_dest().

Reported-by: Li Shuang <shuali@redhat.com>
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
Acked-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/Kconfig      |  1 +
 net/netfilter/ipvs/ip_vs_core.c | 10 ++++------
 net/netfilter/ipvs/ip_vs_ctl.c  | 10 ++++++++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index b32fb0dbe237..3f8e490d1133 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -29,6 +29,7 @@ config	IP_VS_IPV6
 	bool "IPv6 support for IPVS"
 	depends on IPV6 = y || IP_VS = IPV6
 	select IP6_NF_IPTABLES
+	select NF_DEFRAG_IPV6
 	---help---
 	  Add IPv6 support to IPVS.
 
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 1bd53b1e7672..4278f5c947ab 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1524,14 +1524,12 @@ ip_vs_try_to_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
 		/* sorry, all this trouble for a no-hit :) */
 		IP_VS_DBG_PKT(12, af, pp, skb, iph->off,
 			      "ip_vs_in: packet continues traversal as normal");
-		if (iph->fragoffs) {
-			/* Fragment that couldn't be mapped to a conn entry
-			 * is missing module nf_defrag_ipv6
-			 */
-			IP_VS_DBG_RL("Unhandled frag, load nf_defrag_ipv6\n");
+
+		/* Fragment couldn't be mapped to a conn entry */
+		if (iph->fragoffs)
 			IP_VS_DBG_PKT(7, af, pp, skb, iph->off,
 				      "unhandled fragment");
-		}
+
 		*verdict = NF_ACCEPT;
 		return 0;
 	}
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index dff4ead3d117..56dd5ce6274f 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -43,6 +43,7 @@
 #ifdef CONFIG_IP_VS_IPV6
 #include <net/ipv6.h>
 #include <net/ip6_route.h>
+#include <net/netfilter/ipv6/nf_defrag_ipv6.h>
 #endif
 #include <net/route.h>
 #include <net/sock.h>
@@ -888,6 +889,7 @@ ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest,
 {
 	struct ip_vs_dest *dest;
 	unsigned int atype, i;
+	int ret = 0;
 
 	EnterFunction(2);
 
@@ -898,6 +900,10 @@ ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest,
 			atype & IPV6_ADDR_LINKLOCAL) &&
 			!__ip_vs_addr_is_local_v6(svc->ipvs->net, &udest->addr.in6))
 			return -EINVAL;
+
+		ret = nf_defrag_ipv6_enable(svc->ipvs->net);
+		if (ret)
+			return ret;
 	} else
 #endif
 	{
@@ -1221,6 +1227,10 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 			ret = -EINVAL;
 			goto out_err;
 		}
+
+		ret = nf_defrag_ipv6_enable(ipvs->net);
+		if (ret)
+			goto out_err;
 	}
 #endif
 
-- 
2.19.1



