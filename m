Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C5C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF99220818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356260;
	bh=OW4UbZwh1ZuuO1I8NoHgJPrkGfV1q8SGsN4Z5EdNMXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V5SOW+17122FkMbduc6aTYL1salb385AQ3Sc4euDLH0ABPX5Fj0HnWTablXa/zI2K
	 jdEb6pTMFYxIpCtpFzkvZAuKd5xRsHQ3fJU0fCgOss5ZihAsXF4iVkL3EeHru2DQH3
	 AWwE4HcZgnDg9XM3bNBRQeFz8Pj7G0IyqyQvYGCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfDOTG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729156AbfDOTGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88504218FF;
        Mon, 15 Apr 2019 19:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355180;
        bh=OW4UbZwh1ZuuO1I8NoHgJPrkGfV1q8SGsN4Z5EdNMXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2bzmWJDOGpSYf1REhWZc9IHzQ4r0AN2uK5IPql9WJw8TVEvPeSd9Km3tiqDxAQtU9
         RnYkyziOb8ElX9x5V8KCYniRUrX5/fDHJE7dI6oOXK8IKaXC86x+lt/7e0TgM71WtF
         2Tichbs5MZI6Ynggf2hHDYonT3KqmrvOZyiv7+MM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+2fae8fa157dd92618cae@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Zubin Mithra <zsm@chromium.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 043/101] netfilter: nfnetlink_cttimeout: fetch timeouts for udplite and gre, too
Date:   Mon, 15 Apr 2019 20:58:41 +0200
Message-Id: <20190415183742.752458651@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 89259088c1b7fecb43e8e245dc931909132a4e03 upstream

syzbot was able to trigger the WARN in cttimeout_default_get() by
passing UDPLITE as l4protocol.  Alias UDPLITE to UDP, both use
same timeout values.

Furthermore, also fetch GRE timeouts.  GRE is a bit more complicated,
as it still can be a module and its netns_proto_gre struct layout isn't
visible outside of the gre module. Can't move timeouts around, it
appears conntrack sysctl unregister assumes net_generic() returns
nf_proto_net, so we get crash. Expose layout of netns_proto_gre instead.

A followup nf-next patch could make gre tracker be built-in as well
if needed, its not that large.

Last, make the WARN() mention the missing protocol value in case
anything else is missing.

Reported-by: syzbot+2fae8fa157dd92618cae@syzkaller.appspotmail.com
Fixes: 8866df9264a3 ("netfilter: nfnetlink_cttimeout: pass default timeout policy to obj_to_nlattr")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 include/linux/netfilter/nf_conntrack_proto_gre.h | 13 +++++++++++++
 net/netfilter/nf_conntrack_proto_gre.c           | 14 ++------------
 net/netfilter/nfnetlink_cttimeout.c              | 15 +++++++++++++--
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/include/linux/netfilter/nf_conntrack_proto_gre.h b/include/linux/netfilter/nf_conntrack_proto_gre.h
index b8d95564bd53..14edb795ab43 100644
--- a/include/linux/netfilter/nf_conntrack_proto_gre.h
+++ b/include/linux/netfilter/nf_conntrack_proto_gre.h
@@ -21,6 +21,19 @@ struct nf_ct_gre_keymap {
 	struct nf_conntrack_tuple tuple;
 };
 
+enum grep_conntrack {
+	GRE_CT_UNREPLIED,
+	GRE_CT_REPLIED,
+	GRE_CT_MAX
+};
+
+struct netns_proto_gre {
+	struct nf_proto_net	nf;
+	rwlock_t		keymap_lock;
+	struct list_head	keymap_list;
+	unsigned int		gre_timeouts[GRE_CT_MAX];
+};
+
 /* add new tuple->key_reply pair to keymap */
 int nf_ct_gre_keymap_add(struct nf_conn *ct, enum ip_conntrack_dir dir,
 			 struct nf_conntrack_tuple *t);
diff --git a/net/netfilter/nf_conntrack_proto_gre.c b/net/netfilter/nf_conntrack_proto_gre.c
index 650eb4fba2c5..841c472aae1c 100644
--- a/net/netfilter/nf_conntrack_proto_gre.c
+++ b/net/netfilter/nf_conntrack_proto_gre.c
@@ -43,24 +43,12 @@
 #include <linux/netfilter/nf_conntrack_proto_gre.h>
 #include <linux/netfilter/nf_conntrack_pptp.h>
 
-enum grep_conntrack {
-	GRE_CT_UNREPLIED,
-	GRE_CT_REPLIED,
-	GRE_CT_MAX
-};
-
 static const unsigned int gre_timeouts[GRE_CT_MAX] = {
 	[GRE_CT_UNREPLIED]	= 30*HZ,
 	[GRE_CT_REPLIED]	= 180*HZ,
 };
 
 static unsigned int proto_gre_net_id __read_mostly;
-struct netns_proto_gre {
-	struct nf_proto_net	nf;
-	rwlock_t		keymap_lock;
-	struct list_head	keymap_list;
-	unsigned int		gre_timeouts[GRE_CT_MAX];
-};
 
 static inline struct netns_proto_gre *gre_pernet(struct net *net)
 {
@@ -408,6 +396,8 @@ static int __init nf_ct_proto_gre_init(void)
 {
 	int ret;
 
+	BUILD_BUG_ON(offsetof(struct netns_proto_gre, nf) != 0);
+
 	ret = register_pernet_subsys(&proto_gre_net_ops);
 	if (ret < 0)
 		goto out_pernet;
diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index 1dc4ea327cbe..70a7382b9787 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -469,7 +469,8 @@ static int cttimeout_default_get(struct net *net, struct sock *ctnl,
 	case IPPROTO_TCP:
 		timeouts = net->ct.nf_ct_proto.tcp.timeouts;
 		break;
-	case IPPROTO_UDP:
+	case IPPROTO_UDP: /* fallthrough */
+	case IPPROTO_UDPLITE:
 		timeouts = net->ct.nf_ct_proto.udp.timeouts;
 		break;
 	case IPPROTO_DCCP:
@@ -483,13 +484,23 @@ static int cttimeout_default_get(struct net *net, struct sock *ctnl,
 	case IPPROTO_SCTP:
 #ifdef CONFIG_NF_CT_PROTO_SCTP
 		timeouts = net->ct.nf_ct_proto.sctp.timeouts;
+#endif
+		break;
+	case IPPROTO_GRE:
+#ifdef CONFIG_NF_CT_PROTO_GRE
+		if (l4proto->net_id) {
+			struct netns_proto_gre *net_gre;
+
+			net_gre = net_generic(net, *l4proto->net_id);
+			timeouts = net_gre->gre_timeouts;
+		}
 #endif
 		break;
 	case 255:
 		timeouts = &net->ct.nf_ct_proto.generic.timeout;
 		break;
 	default:
-		WARN_ON_ONCE(1);
+		WARN_ONCE(1, "Missing timeouts for proto %d", l4proto->l4proto);
 		break;
 	}
 
-- 
2.19.1



