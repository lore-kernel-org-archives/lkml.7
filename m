Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F8AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259B5206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="j0AXpLEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfCFUUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:20:22 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58869 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfCFUUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:20:20 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 69626891A8;
        Thu,  7 Mar 2019 09:20:17 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1551903617;
        bh=ctbZsxNrXNcIhA2R41UoVqOIpvabdfZo88VZTZgZJP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=j0AXpLEXpKqWyI2WqR8TVXlk3j/76v9asNrFu475yEci8T23AR8ZkvtQdcGmbpPWJ
         Hb3q/b3e3N37obOLOyGGB5FCibsgtAEbDGb749kZJ1Jfdio0Dxgm1ovp4iLAGgvRDu
         GObQ6gSzIt+Obwf8tIR+QoVZZyIj1DsSB3qMzFfmtsC5ZoEo/1y/WlXy9uIGTQ6VUD
         X97QsQOnK9pnu6JsNF2mjS8KIGKf1JSovkAC8OcgkDPg9CcZLNN5hj3f7SA7lrZc4J
         St2NFRuGMByLrVUxsus5ffReCelVM69JYNh51rOldfD3zLgctkDYn2gnSmlSUu5zZZ
         EVNLA2S3+n8LQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c802b810002>; Thu, 07 Mar 2019 09:20:17 +1300
Received: from brodieg-dl.ws.atlnz.lc (brodieg-dl.ws.atlnz.lc [10.33.22.16])
        by smtp (Postfix) with ESMTP id 67CDA13EEF9;
        Thu,  7 Mar 2019 09:20:17 +1300 (NZDT)
Received: by brodieg-dl.ws.atlnz.lc (Postfix, from userid 1718)
        id 2896F500390; Thu,  7 Mar 2019 09:20:17 +1300 (NZDT)
From:   Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
To:     davem@davemloft.net, stephen@networkplumber.org,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
        luuk.paulussen@alliedtelesis.co.nz,
        Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
Subject: [PATCH 2/2] ip6mr: Make cache queue length configurable
Date:   Thu,  7 Mar 2019 09:19:56 +1300
Message-Id: <20190306201956.30248-3-brodie.greenfield@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190306201956.30248-1-brodie.greenfield@alliedtelesis.co.nz>
References: <20190306201956.30248-1-brodie.greenfield@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to be able to keep more spaces available in our queue for
processing incoming IPv6 multicast traffic (adding (S,G) entries) - this
lets us learn more groups faster, rather than dropping them at this stage=
.

Signed-off-by: Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
---
 Documentation/networking/ip-sysctl.txt | 8 ++++++++
 include/net/netns/ipv6.h               | 1 +
 net/ipv6/af_inet6.c                    | 1 +
 net/ipv6/ip6mr.c                       | 4 +++-
 net/ipv6/sysctl_net_ipv6.c             | 7 +++++++
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/netwo=
rking/ip-sysctl.txt
index 02f77e932adf..68eada3ca915 100644
--- a/Documentation/networking/ip-sysctl.txt
+++ b/Documentation/networking/ip-sysctl.txt
@@ -1481,6 +1481,14 @@ skip_notify_on_dev_down - BOOLEAN
 	on userspace caches to track link events and evict routes.
 	Default: false (generate message)
=20
+ip_mr_cache_queue_length - INTEGER
+	Limit the number of multicast packets we can have in the queue to be
+	resolved.
+	Bear in mind that when an unresolved multicast packet is received,
+	there is an O(n) traversal of the queue. This should be considered
+	if increasing.
+	Default: 10
+
 IPv6 Fragmentation:
=20
 ip6frag_high_thresh - INTEGER
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index ef1ed529f33c..84b58424c799 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -46,6 +46,7 @@ struct netns_sysctl_ipv6 {
 	int max_hbh_opts_len;
 	int seg6_flowlabel;
 	bool skip_notify_on_dev_down;
+	unsigned int ip6_mr_cache_queue_length;
 };
=20
 struct netns_ipv6 {
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index d99753b5e39b..6551bb63e5a2 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -856,6 +856,7 @@ static int __net_init inet6_net_init(struct net *net)
 	net->ipv6.sysctl.max_hbh_opts_cnt =3D IP6_DEFAULT_MAX_HBH_OPTS_CNT;
 	net->ipv6.sysctl.max_dst_opts_len =3D IP6_DEFAULT_MAX_DST_OPTS_LEN;
 	net->ipv6.sysctl.max_hbh_opts_len =3D IP6_DEFAULT_MAX_HBH_OPTS_LEN;
+	net->ipv6.sysctl.ip6_mr_cache_queue_length =3D 10;
 	atomic_set(&net->ipv6.fib6_sernum, 1);
=20
 	err =3D ipv6_init_mibs(net);
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index cc01aa3f2b5e..bb445871437e 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1135,6 +1135,7 @@ static int ip6mr_cache_report(struct mr_table *mrt,=
 struct sk_buff *pkt,
 static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 				  struct sk_buff *skb, struct net_device *dev)
 {
+	struct net *net =3D dev_net(dev);
 	struct mfc6_cache *c;
 	bool found =3D false;
 	int err;
@@ -1153,7 +1154,8 @@ static int ip6mr_cache_unresolved(struct mr_table *=
mrt, mifi_t mifi,
 		 *	Create a new entry if allowable
 		 */
=20
-		if (atomic_read(&mrt->cache_resolve_queue_len) >=3D 10 ||
+		if (atomic_read(&mrt->cache_resolve_queue_len) >=3D
+		    net->ipv6.sysctl.ip6_mr_cache_queue_length ||
 		    (c =3D ip6mr_cache_alloc_unres()) =3D=3D NULL) {
 			spin_unlock_bh(&mfc_unres_lock);
=20
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index e15cd37024fd..a27299d4cc34 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -159,6 +159,13 @@ static struct ctl_table ipv6_table_template[] =3D {
 		.mode		=3D 0644,
 		.proc_handler	=3D proc_dointvec
 	},
+	{
+		.procname	=3D "ip6_mr_cache_queue_length",
+		.data		=3D &init_net.ipv6.sysctl.ip6_mr_cache_queue_length,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec
+	},
 	{ }
 };
=20
--=20
2.21.0

