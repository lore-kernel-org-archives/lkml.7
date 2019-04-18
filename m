Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF108C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AE421871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610518;
	bh=GbKyeYqQa3/GMO5nR3hTQHdxXOSkHWfd5ZRAzqUDK8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VZF6jtJhPtPbzjeoj08jtGqlF3mro2MwX6c46TrSc9N7FCaIA5wazfnF0Okyuc+qu
	 /muSa8GJsebtN++F7APaV4hFtUG1UXWOs4ojF9jxwXKN5yPjIUhcp32nAP0avF7E5+
	 85S1ajkxk8A39pQiFSqiOvavl/7NuSkBcGA0Tl0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390656AbfDRSB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390638AbfDRSBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:01:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8FC6206B6;
        Thu, 18 Apr 2019 18:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610511;
        bh=GbKyeYqQa3/GMO5nR3hTQHdxXOSkHWfd5ZRAzqUDK8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9hUjwadhnKpNjsACbNBX8OC0SN6keJ3xfe/t19WnTaeDrw4W6d0clDSpHPF0ioEc
         FrGUWC5VAgGZSYpHZESpTZh2NEn+5fQbLljU9Xu5asR/nqk5JixvKMXdHH7kudaPPK
         j1UCdJmWGN/wQZYzySC5Z4G7Gr0krCJzDBiZTql0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 061/110] netfilter: xt_cgroup: shrink size of v2 path
Date:   Thu, 18 Apr 2019 19:56:50 +0200
Message-Id: <20190418160444.248469124@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0d704967f4a49cc2212350b3e4a8231f8b4283ed ]

cgroup v2 path field is PATH_MAX which is too large, this is placing too
much pressure on memory allocation for people with many rules doing
cgroup v1 classid matching, side effects of this are bug reports like:

https://bugzilla.kernel.org/show_bug.cgi?id=200639

This patch registers a new revision that shrinks the cgroup path to 512
bytes, which is the same approach we follow in similar extensions that
have a path field.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter/xt_cgroup.h | 16 ++++++
 net/netfilter/xt_cgroup.c                | 72 ++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/include/uapi/linux/netfilter/xt_cgroup.h b/include/uapi/linux/netfilter/xt_cgroup.h
index e96dfa1b34f7..b74e370d6133 100644
--- a/include/uapi/linux/netfilter/xt_cgroup.h
+++ b/include/uapi/linux/netfilter/xt_cgroup.h
@@ -22,4 +22,20 @@ struct xt_cgroup_info_v1 {
 	void		*priv __attribute__((aligned(8)));
 };
 
+#define XT_CGROUP_PATH_MAX	512
+
+struct xt_cgroup_info_v2 {
+	__u8		has_path;
+	__u8		has_classid;
+	__u8		invert_path;
+	__u8		invert_classid;
+	union {
+		char	path[XT_CGROUP_PATH_MAX];
+		__u32	classid;
+	};
+
+	/* kernel internal data */
+	void		*priv __attribute__((aligned(8)));
+};
+
 #endif /* _UAPI_XT_CGROUP_H */
diff --git a/net/netfilter/xt_cgroup.c b/net/netfilter/xt_cgroup.c
index 5d92e1781980..5cb1ecb29ea4 100644
--- a/net/netfilter/xt_cgroup.c
+++ b/net/netfilter/xt_cgroup.c
@@ -68,6 +68,38 @@ static int cgroup_mt_check_v1(const struct xt_mtchk_param *par)
 	return 0;
 }
 
+static int cgroup_mt_check_v2(const struct xt_mtchk_param *par)
+{
+	struct xt_cgroup_info_v2 *info = par->matchinfo;
+	struct cgroup *cgrp;
+
+	if ((info->invert_path & ~1) || (info->invert_classid & ~1))
+		return -EINVAL;
+
+	if (!info->has_path && !info->has_classid) {
+		pr_info("xt_cgroup: no path or classid specified\n");
+		return -EINVAL;
+	}
+
+	if (info->has_path && info->has_classid) {
+		pr_info_ratelimited("path and classid specified\n");
+		return -EINVAL;
+	}
+
+	info->priv = NULL;
+	if (info->has_path) {
+		cgrp = cgroup_get_from_path(info->path);
+		if (IS_ERR(cgrp)) {
+			pr_info_ratelimited("invalid path, errno=%ld\n",
+					    PTR_ERR(cgrp));
+			return -EINVAL;
+		}
+		info->priv = cgrp;
+	}
+
+	return 0;
+}
+
 static bool
 cgroup_mt_v0(const struct sk_buff *skb, struct xt_action_param *par)
 {
@@ -99,6 +131,24 @@ static bool cgroup_mt_v1(const struct sk_buff *skb, struct xt_action_param *par)
 			info->invert_classid;
 }
 
+static bool cgroup_mt_v2(const struct sk_buff *skb, struct xt_action_param *par)
+{
+	const struct xt_cgroup_info_v2 *info = par->matchinfo;
+	struct sock_cgroup_data *skcd = &skb->sk->sk_cgrp_data;
+	struct cgroup *ancestor = info->priv;
+	struct sock *sk = skb->sk;
+
+	if (!sk || !sk_fullsock(sk) || !net_eq(xt_net(par), sock_net(sk)))
+		return false;
+
+	if (ancestor)
+		return cgroup_is_descendant(sock_cgroup_ptr(skcd), ancestor) ^
+			info->invert_path;
+	else
+		return (info->classid == sock_cgroup_classid(skcd)) ^
+			info->invert_classid;
+}
+
 static void cgroup_mt_destroy_v1(const struct xt_mtdtor_param *par)
 {
 	struct xt_cgroup_info_v1 *info = par->matchinfo;
@@ -107,6 +157,14 @@ static void cgroup_mt_destroy_v1(const struct xt_mtdtor_param *par)
 		cgroup_put(info->priv);
 }
 
+static void cgroup_mt_destroy_v2(const struct xt_mtdtor_param *par)
+{
+	struct xt_cgroup_info_v2 *info = par->matchinfo;
+
+	if (info->priv)
+		cgroup_put(info->priv);
+}
+
 static struct xt_match cgroup_mt_reg[] __read_mostly = {
 	{
 		.name		= "cgroup",
@@ -134,6 +192,20 @@ static struct xt_match cgroup_mt_reg[] __read_mostly = {
 				  (1 << NF_INET_POST_ROUTING) |
 				  (1 << NF_INET_LOCAL_IN),
 	},
+	{
+		.name		= "cgroup",
+		.revision	= 2,
+		.family		= NFPROTO_UNSPEC,
+		.checkentry	= cgroup_mt_check_v2,
+		.match		= cgroup_mt_v2,
+		.matchsize	= sizeof(struct xt_cgroup_info_v2),
+		.usersize	= offsetof(struct xt_cgroup_info_v2, priv),
+		.destroy	= cgroup_mt_destroy_v2,
+		.me		= THIS_MODULE,
+		.hooks		= (1 << NF_INET_LOCAL_OUT) |
+				  (1 << NF_INET_POST_ROUTING) |
+				  (1 << NF_INET_LOCAL_IN),
+	},
 };
 
 static int __init cgroup_mt_init(void)
-- 
2.19.1



