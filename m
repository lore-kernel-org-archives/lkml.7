Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D720C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C4C2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T94Bmt0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDLKBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:01:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39257 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfDLKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:01:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id k45so7813535edb.6;
        Fri, 12 Apr 2019 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9tE40D7WU+Y8HzHiDAs7+SuKv5sQXwZHCUNl+8kqKC4=;
        b=T94Bmt0OGRZ9ms627kHsUWhd3fOtd6ZRx3qe+3T6q+pmYVi3D2fCDzW88mraP6IGyX
         kj4wzJMDeSPDf76sTXVYiT8w0JOv+wq3DLTO3lYKczcnV4bzhXNfdnsAQnw53zhtr6mE
         SphZz2wNQ9kXmcY+Qy27AgEddpE9dHGdvMKMv5HOrwBHCXvRkQH1aUZvdzkXcUfOs4i4
         RenxzeSedPivJWkje8S1kc/JwUMMZqjEYhzJ5Qfu30hx55P0nFCUyElCdC1zFo8YkHq4
         IRg6UmMKOwe8+DoEx1foe13+f80XBbL0AMevVA9g58uttMrIiwXmwnUIgaememZYA6AN
         v3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9tE40D7WU+Y8HzHiDAs7+SuKv5sQXwZHCUNl+8kqKC4=;
        b=XJQLoGLR2tpA7fxIQOcFmdeukh8cUwwSr70ASaphsTNTeYxs1ubvPa22HCIBAJdzEA
         Kn23EkTBsB7MQVXTKmx7CBEbrS0/vM2wInysmPjfXd25Lj+/bWTbPy6wVHKSMMA244JI
         ydf/xi2cuSCpBUePYFl1R/7qEtEf587uYULc0n38vEPqywFRvzNkiex2I99ROPgzVqwY
         aQEB/QsIr4ci179w9pd5Pt52UMtpE3pGhnncCrJ7hdH6OraWPim+Ze6bG+xxArvBff/M
         4TK1UKghKWNpnBXE6Ssy3zaPDJqmBVldnYI3xcOVigdarCd42AYx20IH4pZtpN/qrZZf
         ZZvw==
X-Gm-Message-State: APjAAAW8rjCG6ZQy2N2EKsypCSbGYq84Js2KUO9qJ5BqaWsXp4B5Vrob
        iWzDoenNbRpR+kPrKwzyZ4s/Sans4+4=
X-Google-Smtp-Source: APXvYqwkxBg0q2LtRn+SIY2ROfmSKEv3/LvQDGBpftymv/qxGRTln0z+FUBsmjVdAEeKnPhguNuL7A==
X-Received: by 2002:a50:e844:: with SMTP id k4mr34443534edn.249.1555063290215;
        Fri, 12 Apr 2019 03:01:30 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id b10sm1783220edi.28.2019.04.12.03.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 03:01:29 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v1 1/2] bpf: sock ops: add netns in bpf context
Date:   Fri, 12 Apr 2019 12:00:17 +0200
Message-Id: <20190412100018.20852-1-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

sockops programs can now access the network namespace inode via
(struct bpf_sock_ops)->netns. This can be useful to apply different
policies on different network namespaces.

In the unlikely case where network namespaces are not compiled in
(CONFIG_NET_NS=n), the verifier will not allow access to ->netns.

Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 include/uapi/linux/bpf.h |  1 +
 net/core/filter.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 31a27dd337dc..5afaab25f205 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3069,6 +3069,7 @@ struct bpf_sock_ops {
 	__u32 sk_txhash;
 	__u64 bytes_received;
 	__u64 bytes_acked;
+	__u64 netns;
 };
 
 /* Definitions for bpf_sock_ops_cb_flags */
diff --git a/net/core/filter.c b/net/core/filter.c
index 22eb2edf5573..f5e75b6fecb2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6758,6 +6758,14 @@ static bool sock_ops_is_valid_access(int off, int size,
 		}
 	} else {
 		switch (off) {
+		case offsetof(struct bpf_sock_ops, netns):
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
@@ -7908,6 +7916,38 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 		SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
 					  struct sock, type);
 		break;
+
+	case offsetof(struct bpf_sock_ops, netns):
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

