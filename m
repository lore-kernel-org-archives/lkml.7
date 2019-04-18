Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F0FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13D120821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QipZTpMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389609AbfDRP5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:57:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36581 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:57:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id u57so2234272edm.3;
        Thu, 18 Apr 2019 08:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mRIa7YtbcBQn0bTD/QeYRSxAmMEbW6gakCQU+eJmUrM=;
        b=QipZTpMbL3qfg5Cvba0enefPaLwhFSwiZLz9v42+AD9CDIZl9C/78gdXAVlrqxyAfF
         HW1MrLIVK6sGaqb1TjmElO4hijQlOBtuVePA2WuP4RYinOE3E1p7HrVMYPoj9viQkrnt
         a4HWNsfWNzpiGF3qXx6KDeo9BMObMCaEVN+wT9QLm2kzvXp9qIcmao5GwHxbsj3QD4pk
         w2DNkxwud99SEzF9or8FUdMn0uiWkf1HSUKY1yO9GmvihkFyhke9wTQ3R5Vmxyh8GoZe
         RTna5jKuMkTgnGNGUO987xIUF8U32NXCheBHymyeaFIjY8KrFBypdGVcXfam2iMqyWqn
         60tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mRIa7YtbcBQn0bTD/QeYRSxAmMEbW6gakCQU+eJmUrM=;
        b=jbjLQdIGzmowxNjNJl9D7GuEhQ6l5nNhoAr9QcrqtRyXiuc3GY4Os/7tctvgmReEHY
         ot76EXm6XtdgOVVmwWW597DJiqRvTo0Nee8eRH4wmW2wMEgeQUSqcaTJb6D0ReK7TVrD
         CtuL9qFYM/6GbPH0s/954cwytFXF0dh4xaXCZtaWuklTAx7+ujOTUC155vb6Ixn5mSa4
         boYfgXeUu56HHwQA0StdYfif7KBJYOcY6JKX7NnNMviSBcPAw+DGAcx7212HH/3GIGz1
         eAG682rNbcVtmWf89roSAvbIFaQt8jTVfP10RHxcv+SyDLWq9jbCXw+ZuA50p99cbYYH
         dH+Q==
X-Gm-Message-State: APjAAAXg+9nkYjt3k6tngfWtuDxL/GLajo3/j/PKi4XgxlKenYcwsT8j
        T7Ch1s5vr/zEvPDa5XA159c=
X-Google-Smtp-Source: APXvYqz07Be+E6TFm1SXIu3H1LWJLYQXDCwLaRvS1Q5PbQL1B58Y/8ze1eksh7yhe41YLViHkuQyAw==
X-Received: by 2002:a50:e61a:: with SMTP id y26mr46513128edm.157.1555603033989;
        Thu, 18 Apr 2019 08:57:13 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id 31sm591274edf.18.2019.04.18.08.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 08:57:13 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v2 1/3] bpf: sock ops: add netns ino and dev in bpf context
Date:   Thu, 18 Apr 2019 17:56:50 +0200
Message-Id: <20190418155652.22181-1-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

sockops programs can now access the network namespace inode and device
via (struct bpf_sock_ops)->netns_ino and ->netns_dev. This can be useful
to apply different policies on different network namespaces.

In the unlikely case where network namespaces are not compiled in
(CONFIG_NET_NS=n), the verifier will not allow access to ->netns_*.

The generated BPF bytecode for netns_ino is loading the correct inode
number at the time of execution.

However, the generated BPF bytecode for netns_dev is loading an
immediate value determined at BPF-load-time by looking at the initial
network namespace. In practice, this works because all netns currently
use the same virtual device. If this was to change, this code would need
to be updated too.

Signed-off-by: Alban Crequy <alban@kinvolk.io>

---

Changes since v1:
- add netns_dev (review from Alexei)
---
 include/uapi/linux/bpf.h |  2 ++
 net/core/filter.c        | 70 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index eaf2d3284248..f4f841dde42c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3213,6 +3213,8 @@ struct bpf_sock_ops {
 	__u32 sk_txhash;
 	__u64 bytes_received;
 	__u64 bytes_acked;
+	__u64 netns_dev;
+	__u64 netns_ino;
 };
 
 /* Definitions for bpf_sock_ops_cb_flags */
diff --git a/net/core/filter.c b/net/core/filter.c
index 1833926a63fc..93e3429603d7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -75,6 +75,8 @@
 #include <net/seg6_local.h>
 #include <net/lwtunnel.h>
 #include <net/ipv6_stubs.h>
+#include <linux/kdev_t.h>
+#include <linux/proc_ns.h>
 
 /**
  *	sk_filter_trim_cap - run a packet through a socket filter
@@ -6774,6 +6776,15 @@ static bool sock_ops_is_valid_access(int off, int size,
 		}
 	} else {
 		switch (off) {
+		case offsetof(struct bpf_sock_ops, netns_dev):
+		case offsetof(struct bpf_sock_ops, netns_ino):
+#ifdef CONFIG_NET_NS
+			if (size != sizeof(__u64))
+				return false;
+#else
+			return false;
+#endif
+			break;
 		case bpf_ctx_range_till(struct bpf_sock_ops, bytes_received,
 					bytes_acked):
 			if (size != sizeof(__u64))
@@ -7660,6 +7671,11 @@ static u32 sock_addr_convert_ctx_access(enum bpf_access_type type,
 	return insn - insn_buf;
 }
 
+static struct ns_common *sockops_netns_cb(void *private_data)
+{
+	return &init_net.ns;
+}
+
 static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				       const struct bpf_insn *si,
 				       struct bpf_insn *insn_buf,
@@ -7668,6 +7684,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 {
 	struct bpf_insn *insn = insn_buf;
 	int off;
+	struct inode *ns_inode;
+	struct path ns_path;
+	__u64 netns_dev;
+	void *res;
 
 /* Helper macro for adding read access to tcp_sock or sock fields. */
 #define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)			      \
@@ -7914,6 +7934,56 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 		SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
 					  struct sock, type);
 		break;
+
+	case offsetof(struct bpf_sock_ops, netns_dev):
+#ifdef CONFIG_NET_NS
+		/* We get the netns_dev at BPF-load-time and not at
+		 * BPF-exec-time. We assume that netns_dev is a constant.
+		 */
+		res = ns_get_path_cb(&ns_path, sockops_netns_cb, NULL);
+		if (IS_ERR(res)) {
+			netns_dev = 0;
+		} else {
+			ns_inode = ns_path.dentry->d_inode;
+			netns_dev = new_encode_dev(ns_inode->i_sb->s_dev);
+		}
+#else
+		netns_dev = 0;
+#endif
+		*insn++ = BPF_MOV64_IMM(si->dst_reg, netns_dev);
+		break;
+
+	case offsetof(struct bpf_sock_ops, netns_ino):
+#ifdef CONFIG_NET_NS
+		/* Loading: sk_ops->sk->__sk_common.skc_net.net->ns.inum
+		 * Type: (struct bpf_sock_ops_kern *)
+		 *       ->(struct sock *)
+		 *       ->(struct sock_common)
+		 *       .possible_net_t
+		 *       .(struct net *)
+		 *       ->(struct ns_common)
+		 *       .(unsigned int)
+		 */
+		BUILD_BUG_ON(offsetof(struct sock, __sk_common) != 0);
+		BUILD_BUG_ON(offsetof(possible_net_t, net) != 0);
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
+						struct bpf_sock_ops_kern, sk),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sock_ops_kern, sk));
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
+						possible_net_t, net),
+				      si->dst_reg, si->dst_reg,
+				      offsetof(struct sock_common, skc_net));
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
+						struct ns_common, inum),
+				      si->dst_reg, si->dst_reg,
+				      offsetof(struct net, ns) +
+				      offsetof(struct ns_common, inum));
+#else
+		*insn++ = BPF_MOV64_IMM(si->dst_reg, 0);
+#endif
+		break;
+
 	}
 	return insn - insn_buf;
 }
-- 
2.20.1

