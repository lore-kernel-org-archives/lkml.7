Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D23C4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB58205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NrZSDJTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfFYANf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:13:35 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38002 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbfFYANd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:13:33 -0400
Received: by mail-pf1-f202.google.com with SMTP id e25so9459874pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 17:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vljDviNdnBJvl0I2gRgeW5+fqicMSv8iMMvpNNvivIc=;
        b=NrZSDJTh2FXpckKHa1h0Vqi/bJQqnapLp0xhDRHwzxqZtLCJTKKcgAvWXz/QuTMr89
         qrnZIGSX7+dh7Cf0m9OaVKWvUMDASf/4qbk9twE8pMngTy/eBshvsqYsDGW8TdoZ6N6U
         rD7MMZJDTJtSdTevvTRBZ5+pT4oXQ9PvPra/CBM6wydugJWtU9/YT0HqUqd2pPrMsQc6
         fMK/y1g2a+9gaY0x5CkLI1yY1VDrND1uhvgKWJLQglZlX2HvFrXnGJH1Q5CkOAlIq3cA
         D3lwgo2Ph94FPf6D6ZCvo9tPnd+12nFW6DlrfFcSJBnPMTSu9E+QWlYTijDG/mtGcz84
         C7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vljDviNdnBJvl0I2gRgeW5+fqicMSv8iMMvpNNvivIc=;
        b=NKkuugNb0Imd/6iEkA7yB4N/m+6pxFhyL9+NwZrBTBubhl024zcJjCPwvafj8Dp0yq
         f3gnz51hnu06p2rRCN3RA/uVVwzMVisg6tYjQFsYyTwMPG8vfjn0pFuLtT1OymF/4OR5
         gsppH7pXE1EKck/0OSKGT75XPQFLTDkSpe2sabZVYozGPthz6Rs3SDDjqPUwZjTPxbdy
         rnQkOH0NPPk8Xqfo97nhsqvZ5RwOVqZRIqe7gENGtqMgG6qw8a9xThencc9C1ovRD3xl
         jNtYmKafl0YfwWcgbI5nFqnxRY9f0rTaTFufA9J1Gb0zHi0ed1IwkocKkZd0xTLcdk89
         TBFw==
X-Gm-Message-State: APjAAAVQWfMmsfOgoXPToJ9qyJMpTv9ymBjNHcHbI6Ufxx0FsOO32hNP
        hK6QILwzzlhgfvIhgKZVYGnCP0AtOWf7IyAT
X-Google-Smtp-Source: APXvYqwFAbGso4c66okMxnyz0loyzCLHwBq4peR9dUOP0qU3kDdjv232XyHaizp0eZ2sYJCn5B/udSKKWL0D7+Fz
X-Received: by 2002:a63:9143:: with SMTP id l64mr24766192pge.65.1561421612604;
 Mon, 24 Jun 2019 17:13:32 -0700 (PDT)
Date:   Mon, 24 Jun 2019 17:13:25 -0700
In-Reply-To: <20190625001326.172280-1-allanzhang@google.com>
Message-Id: <20190625001326.172280-2-allanzhang@google.com>
Mime-Version: 1.0
References: <20190625001326.172280-1-allanzhang@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] bpf: Allow bpf_skb_event_output for a few prog types
From:   allanzhang <allanzhang@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     allanzhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software event output is only enabled by a few prog types right now (TC,
LWT out, XDP, sockops). Many other skb based prog types need
bpf_skb_event_output to produce software event.

Added socket_filter, cg_skb, sk_skb prog types to generate sw event.

Test bpf code is generated from code snippet:

struct TMP {
    uint64_t tmp;
} tt;
tt.tmp = 5;
bpf_perf_event_output(skb, &connection_tracking_event_map, 0,
                      &tt, sizeof(tt));
return 1;

the bpf assembly from llvm is:
       0:       b7 02 00 00 05 00 00 00         r2 = 5
       1:       7b 2a f8 ff 00 00 00 00         *(u64 *)(r10 - 8) = r2
       2:       bf a4 00 00 00 00 00 00         r4 = r10
       3:       07 04 00 00 f8 ff ff ff         r4 += -8
       4:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00    r2 = 0ll
       6:       b7 03 00 00 00 00 00 00         r3 = 0
       7:       b7 05 00 00 08 00 00 00         r5 = 8
       8:       85 00 00 00 19 00 00 00         call 25
       9:       b7 00 00 00 01 00 00 00         r0 = 1
      10:       95 00 00 00 00 00 00 00         exit

Patch 1 is enabling code.
Patch 2 is fullly covered selftest code.

Signed-off-by: allanzhang <allanzhang@google.com>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2014d76e0d2a..b75fcf412628 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5958,6 +5958,8 @@ sk_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_socket_cookie_proto;
 	case BPF_FUNC_get_socket_uid:
 		return &bpf_get_socket_uid_proto;
+	case BPF_FUNC_perf_event_output:
+		return &bpf_skb_event_output_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -5978,6 +5980,8 @@ cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
+	case BPF_FUNC_perf_event_output:
+		return &bpf_skb_event_output_proto;
 #ifdef CONFIG_SOCK_CGROUP_DATA
 	case BPF_FUNC_skb_cgroup_id:
 		return &bpf_skb_cgroup_id_proto;
@@ -6226,6 +6230,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_redirect_map_proto;
 	case BPF_FUNC_sk_redirect_hash:
 		return &bpf_sk_redirect_hash_proto;
+	case BPF_FUNC_perf_event_output:
+		return &bpf_skb_event_output_proto;
 #ifdef CONFIG_INET
 	case BPF_FUNC_sk_lookup_tcp:
 		return &bpf_sk_lookup_tcp_proto;
-- 
2.22.0.410.gd8fdbe21b5-goog

