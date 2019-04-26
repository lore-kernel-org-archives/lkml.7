Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23D9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8557D205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TANMI2VK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfDZPtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:49:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33543 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfDZPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:49:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id d55so1721810ede.0;
        Fri, 26 Apr 2019 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBGtbPc4Hjybxt7HzjkrxpcfTTZAyVllCtxWEE6p+sM=;
        b=TANMI2VKwIWd1nqs0losES/j4XERwdlHVa9rgnbpdDHY4tGiP9RU+v3VK6jHnKTwlX
         klZxgBLoOp+hIPPRg+V7B+NxaxvPPEEcsrEvFBWVtJ2pZ7a1+ezIxs6YrFswFZxtp29P
         iM5FcayCUbX0IWrG/GqiOODZpbgyxfAD/jJO/dk9mUuT6JBRYVabLUX9PtMIe4QmmQNr
         VLoXhWvbPR08D4ZJx71pvGeduWAcSIKHbr/Na+DVVezkUOTBg9Utc2gnEpqmGsKCo2Sn
         O6IzxmU3EoPq3a3P+QYB06iBt2oD07KK+6tFdnAexQ5a+kq5V+5b9O64xUFPeiHHgORG
         wFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=YBGtbPc4Hjybxt7HzjkrxpcfTTZAyVllCtxWEE6p+sM=;
        b=MRiEGWpam/g/5/J4pO78orTpGhKM57JJnS3e2PfcM3uLhExjsmxZLYJOR267VDXLFt
         32mZXnLvhtCKpYY+EB6gUopDueIzjd9ebixADsSKYYsY3XmPA/+yfsHl4mwJeQvpXpKN
         HFbdzl3/aPY1NOThgMtC5irCHzH+QCx8crRGNhFcIgYiIXWE9Nxemh+dflOaL4AtM3Mq
         L+zIKxQG4+Ogo2rZoJDh7gbWLFPXkexZoIptQHkIVnAfWPSomXwSLmVJ3cq0/w+pN1lg
         BccaFedUjzEJuzOI1Oua76OcSUasl7hyHPleJx7DBi/EqVvGnneMqojQrAEAj8ZvcprU
         kcTg==
X-Gm-Message-State: APjAAAUNv9QmZ3gtkVaw237h+dELupuA00x8wYXslh2t32od9Nzv8Gnh
        HORzV8s95yD38BHD8T6jYSg=
X-Google-Smtp-Source: APXvYqwWoZFaQzSSbrhzuGjJKCWN9YO1zAVk7CmAZb/FlIcIezpjHfmqvTRmQAx/UKu+AfUySONUiQ==
X-Received: by 2002:a50:a704:: with SMTP id h4mr12336151edc.7.1556293773101;
        Fri, 26 Apr 2019 08:49:33 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id f15sm4603002eja.39.2019.04.26.08.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:49:31 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v3 1/4] bpf: sock ops: add netns ino and dev in bpf context
Date:   Fri, 26 Apr 2019 17:48:45 +0200
Message-Id: <20190426154848.23490-1-alban@kinvolk.io>
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

Changes since v2:
- replace __u64 by u64 in kernel code (review from Y Song)
- remove unneeded #else branch: program would be rejected in
  is_valid_access (review from Y Song)
- allow partial reads (<u64) (review from Y Song)

  Note: I have not been able to fully test partial reads on netns_dev.
The following patches check partial reads in the verifier but it does
not actually execute the program to check if partial reads generate the
correct value. I tried to write a BPF program in C and declare the
struct bpf_sock_ops as a volatile variable and I could get llvm to
generate the BPF instructions to do partial loads. But then, I get the
verifier error "dereference of modified ctx ptr R2 off=184 disallowed",
explained in https://www.spinics.net/lists/netdev/msg531582.html
What do you think should be done here?
---
 include/uapi/linux/bpf.h |  2 +
 net/core/filter.c        | 94 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

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
index 2f88baf39cc2..9c77464b1501 100644
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
@@ -6810,6 +6812,24 @@ static bool sock_ops_is_valid_access(int off, int size,
 		}
 	} else {
 		switch (off) {
+		case offsetof(struct bpf_sock_ops, netns_dev) ...
+		     offsetof(struct bpf_sock_ops, netns_dev) + sizeof(u64) - 1:
+#ifdef CONFIG_NET_NS
+			if (off - offsetof(struct bpf_sock_ops, netns_dev)
+			    + size > sizeof(u64))
+				return false;
+#else
+			return false;
+#endif
+			break;
+		case offsetof(struct bpf_sock_ops, netns_ino):
+#ifdef CONFIG_NET_NS
+			if (size != sizeof(u64))
+				return false;
+#else
+			return false;
+#endif
+			break;
 		case bpf_ctx_range_till(struct bpf_sock_ops, bytes_received,
 					bytes_acked):
 			if (size != sizeof(__u64))
@@ -7727,6 +7747,11 @@ static u32 sock_addr_convert_ctx_access(enum bpf_access_type type,
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
@@ -7735,6 +7760,10 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 {
 	struct bpf_insn *insn = insn_buf;
 	int off;
+	struct inode *ns_inode;
+	struct path ns_path;
+	u64 netns_dev;
+	void *res;
 
 /* Helper macro for adding read access to tcp_sock or sock fields. */
 #define SOCK_OPS_GET_FIELD(BPF_FIELD, OBJ_FIELD, OBJ)			      \
@@ -7981,6 +8010,71 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 		SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
 					  struct sock, type);
 		break;
+
+	case offsetof(struct bpf_sock_ops, netns_dev) ...
+	     offsetof(struct bpf_sock_ops, netns_dev) + sizeof(u64) - 1:
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
+		off = si->off;
+		off -= offsetof(struct bpf_sock_ops, netns_dev);
+		switch (BPF_LDST_BYTES(si)) {
+		case sizeof(u64):
+			*insn++ = BPF_MOV64_IMM(si->dst_reg, netns_dev);
+			break;
+		case sizeof(u32):
+			netns_dev = *(u32 *)(((char *)&netns_dev) + off);
+			*insn++ = BPF_MOV32_IMM(si->dst_reg, netns_dev);
+			break;
+		case sizeof(u16):
+			netns_dev = *(u16 *)(((char *)&netns_dev) + off);
+			*insn++ = BPF_MOV32_IMM(si->dst_reg, netns_dev);
+			break;
+		case sizeof(u8):
+			netns_dev = *(u8 *)(((char *)&netns_dev) + off);
+			*insn++ = BPF_MOV32_IMM(si->dst_reg, netns_dev);
+			break;
+		}
+#endif
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
+#endif
+		break;
+
 	}
 	return insn - insn_buf;
 }
-- 
2.20.1

