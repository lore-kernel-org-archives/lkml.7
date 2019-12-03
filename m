Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58457C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2075820674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413728;
	bh=XWGD5FnpioMR5ta8+wtIT9CfYIjrrA31YwBBRXFFIKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VJOvmofsNg1nq07T9MmvmgkEgqtmI2+OKsxebAQ4Myg7YOVj3BjZ5oVWAG5I10pd6
	 fduQxXuOk97k2RD/wKDSpq1/h/O28BlaeDXlux+Wg+z2rZnlVoCYV8uKsApjObOAHM
	 G250PT3uU2YkjdOGiJ3kbtlBwwqherSavvQYpU3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfLCWz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:55:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730342AbfLCWzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:55:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DC1D2158C;
        Tue,  3 Dec 2019 22:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413723;
        bh=XWGD5FnpioMR5ta8+wtIT9CfYIjrrA31YwBBRXFFIKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqsPbS8/5Nlm/qdJQ2+A+IfUVN7PHlxB38DH83J1xXb10OQ57p6x4yfHQqLnH6QuS
         g/GLbW0YgH2irTM0wKwa+hRlFJ4yPvfnKsfCXzM4Qf5CiFLLoW3iWIj7ZZV0u+hdbI
         JPGTJ3JEiF92C5RSjfjTVqr1YVbLp1NQbTr/6Tfs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 237/321] net: ip6_gre: do not report erspan_ver for ip6gre or ip6gretap
Date:   Tue,  3 Dec 2019 23:35:03 +0100
Message-Id: <20191203223439.461049783@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 103d0244d29fcaf38f1339d4538919bbbc051490 ]

Report erspan version field to userspace in ip6gre_fill_info just for
erspan_v6 tunnels. Moreover report IFLA_GRE_ERSPAN_INDEX only for
erspan version 1.
The issue can be triggered with the following reproducer:

$ip link add name gre6 type ip6gre local 2001::1 remote 2002::2
$ip link set gre6 up
$ip -d link sh gre6
14: grep6@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1448 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/gre6 2001::1 peer 2002::2 promiscuity 0 minmtu 0 maxmtu 0
    ip6gre remote 2002::2 local 2001::1 hoplimit 64 encaplimit 4 tclass 0x00 flowlabel 0x00000 erspan_index 0 erspan_ver 0 addrgenmode eui64

Fixes: 94d7d8f29287 ("ip6_gre: add erspan v2 support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_gre.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index dee4113f21a9a..8fd28edd6ac57 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2135,9 +2135,23 @@ static int ip6gre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	struct __ip6_tnl_parm *p = &t->parms;
 	__be16 o_flags = p->o_flags;
 
-	if ((p->erspan_ver == 1 || p->erspan_ver == 2) &&
-	    !p->collect_md)
-		o_flags |= TUNNEL_KEY;
+	if (p->erspan_ver == 1 || p->erspan_ver == 2) {
+		if (!p->collect_md)
+			o_flags |= TUNNEL_KEY;
+
+		if (nla_put_u8(skb, IFLA_GRE_ERSPAN_VER, p->erspan_ver))
+			goto nla_put_failure;
+
+		if (p->erspan_ver == 1) {
+			if (nla_put_u32(skb, IFLA_GRE_ERSPAN_INDEX, p->index))
+				goto nla_put_failure;
+		} else {
+			if (nla_put_u8(skb, IFLA_GRE_ERSPAN_DIR, p->dir))
+				goto nla_put_failure;
+			if (nla_put_u16(skb, IFLA_GRE_ERSPAN_HWID, p->hwid))
+				goto nla_put_failure;
+		}
+	}
 
 	if (nla_put_u32(skb, IFLA_GRE_LINK, p->link) ||
 	    nla_put_be16(skb, IFLA_GRE_IFLAGS,
@@ -2152,8 +2166,7 @@ static int ip6gre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_u8(skb, IFLA_GRE_ENCAP_LIMIT, p->encap_limit) ||
 	    nla_put_be32(skb, IFLA_GRE_FLOWINFO, p->flowinfo) ||
 	    nla_put_u32(skb, IFLA_GRE_FLAGS, p->flags) ||
-	    nla_put_u32(skb, IFLA_GRE_FWMARK, p->fwmark) ||
-	    nla_put_u32(skb, IFLA_GRE_ERSPAN_INDEX, p->index))
+	    nla_put_u32(skb, IFLA_GRE_FWMARK, p->fwmark))
 		goto nla_put_failure;
 
 	if (nla_put_u16(skb, IFLA_GRE_ENCAP_TYPE,
@@ -2171,19 +2184,6 @@ static int ip6gre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 			goto nla_put_failure;
 	}
 
-	if (nla_put_u8(skb, IFLA_GRE_ERSPAN_VER, p->erspan_ver))
-		goto nla_put_failure;
-
-	if (p->erspan_ver == 1) {
-		if (nla_put_u32(skb, IFLA_GRE_ERSPAN_INDEX, p->index))
-			goto nla_put_failure;
-	} else if (p->erspan_ver == 2) {
-		if (nla_put_u8(skb, IFLA_GRE_ERSPAN_DIR, p->dir))
-			goto nla_put_failure;
-		if (nla_put_u16(skb, IFLA_GRE_ERSPAN_HWID, p->hwid))
-			goto nla_put_failure;
-	}
-
 	return 0;
 
 nla_put_failure:
-- 
2.20.1



