Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4494CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7D520840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="I8JOvcz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfCFUU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:20:26 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58871 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfCFUUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:20:20 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6B431891A9;
        Thu,  7 Mar 2019 09:20:17 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1551903617;
        bh=/ncGicRhpT0Jrx1YkKh+dSzX+9GKtXbzCjm1aNfcRSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=I8JOvcz4g74AjLVr+NH6gUR+2XrXeYY7vaAt+8zQ6gW0lJKO9pQqGBLY9BaipZNqT
         S7KqBVO6HEAAeTmEANc2sf0FP4yn3P634TAV+tgV7kLY72orJpZ6Pfs16La2a5y4Ig
         Jje+Pd12bDDgticSLsVtUGChvs8Hv6mbVlLw6NNuE+onfRnuJOFFZfpnFZ7efcXTYk
         ICL8fR/JmDNJAJErzRhc6l7CpeXsU5EiDFIW5+kWrdHPICd1EnmpKIchVdZdvB4/N2
         BoxjkbF1rM4T7MLNqoOypkY7f6/w0/0usjydKiTLRtEv0tw7RwkKSOHhmR+Jzrb8E8
         OLDsPGTNHx7uw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c802b810001>; Thu, 07 Mar 2019 09:20:17 +1300
Received: from brodieg-dl.ws.atlnz.lc (brodieg-dl.ws.atlnz.lc [10.33.22.16])
        by smtp (Postfix) with ESMTP id 6639C13EED5;
        Thu,  7 Mar 2019 09:20:17 +1300 (NZDT)
Received: by brodieg-dl.ws.atlnz.lc (Postfix, from userid 1718)
        id 2960E5004E3; Thu,  7 Mar 2019 09:20:17 +1300 (NZDT)
From:   Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
To:     davem@davemloft.net, stephen@networkplumber.org,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
        luuk.paulussen@alliedtelesis.co.nz,
        Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
Subject: [PATCH 1/2] ipmr: Make cache queue length configurable
Date:   Thu,  7 Mar 2019 09:19:55 +1300
Message-Id: <20190306201956.30248-2-brodie.greenfield@alliedtelesis.co.nz>
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
processing incoming multicast traffic (adding (S,G) entries) - this lets
us learn more groups faster, rather than dropping them at this stage.

Signed-off-by: Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
---
 Documentation/networking/ip-sysctl.txt | 8 ++++++++
 include/net/netns/ipv4.h               | 1 +
 net/ipv4/af_inet.c                     | 1 +
 net/ipv4/ipmr.c                        | 4 +++-
 net/ipv4/sysctl_net_ipv4.c             | 7 +++++++
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.txt b/Documentation/netwo=
rking/ip-sysctl.txt
index acdfb5d2bcaa..02f77e932adf 100644
--- a/Documentation/networking/ip-sysctl.txt
+++ b/Documentation/networking/ip-sysctl.txt
@@ -887,6 +887,14 @@ ip_local_reserved_ports - list of comma separated ra=
nges
=20
 	Default: Empty
=20
+ip_mr_cache_queue_length - INTEGER
+	Limit the number of multicast packets we can have in the queue to be
+	resolved.
+	Bear in mind that when an unresolved multicast packet is received,
+	there is an O(n) traversal of the queue. This should be considered
+	if increasing.
+	Default: 10
+
 ip_unprivileged_port_start - INTEGER
 	This is a per-namespace sysctl.  It defines the first
 	unprivileged port in the network namespace.  Privileged ports
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 104a6669e344..3411d3f18d51 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -187,6 +187,7 @@ struct netns_ipv4 {
 	int sysctl_igmp_max_msf;
 	int sysctl_igmp_llm_reports;
 	int sysctl_igmp_qrv;
+	unsigned int sysctl_ip_mr_cache_queue_length;
=20
 	struct ping_group_range ping_group_range;
=20
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 0dfb72c46671..8e25538bdb1e 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1827,6 +1827,7 @@ static __net_init int inet_init_net(struct net *net=
)
 	net->ipv4.sysctl_igmp_llm_reports =3D 1;
 	net->ipv4.sysctl_igmp_qrv =3D 2;
=20
+	net->ipv4.sysctl_ip_mr_cache_queue_length =3D 10;
 	return 0;
 }
=20
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index ddbf8c9a1abb..c6a6c3e453a9 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1127,6 +1127,7 @@ static int ipmr_cache_unresolved(struct mr_table *m=
rt, vifi_t vifi,
 				 struct sk_buff *skb, struct net_device *dev)
 {
 	const struct iphdr *iph =3D ip_hdr(skb);
+	struct net *net =3D dev_net(dev);
 	struct mfc_cache *c;
 	bool found =3D false;
 	int err;
@@ -1142,7 +1143,8 @@ static int ipmr_cache_unresolved(struct mr_table *m=
rt, vifi_t vifi,
=20
 	if (!found) {
 		/* Create a new entry if allowable */
-		if (atomic_read(&mrt->cache_resolve_queue_len) >=3D 10 ||
+		if (atomic_read(&mrt->cache_resolve_queue_len) >=3D
+		    net->ipv4.sysctl_ip_mr_cache_queue_length ||
 		    (c =3D ipmr_cache_alloc_unres()) =3D=3D NULL) {
 			spin_unlock_bh(&mfc_unres_lock);
=20
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index ba0fc4b18465..78ae86e8c6cb 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -784,6 +784,13 @@ static struct ctl_table ipv4_net_table[] =3D {
 		.proc_handler	=3D proc_dointvec
 	},
 #ifdef CONFIG_IP_MULTICAST
+	{
+		.procname	=3D "ip_mr_cache_queue_length",
+		.data		=3D &init_net.ipv4.sysctl_ip_mr_cache_queue_length,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec
+	},
 	{
 		.procname	=3D "igmp_qrv",
 		.data		=3D &init_net.ipv4.sysctl_igmp_qrv,
--=20
2.21.0

