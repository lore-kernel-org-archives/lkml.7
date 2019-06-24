Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70564C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B9620679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZydj3CH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfFXV6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:58:33 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:43126 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbfFXV6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:58:32 -0400
Received: by mail-vk1-f201.google.com with SMTP id j140so4356994vke.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vljDviNdnBJvl0I2gRgeW5+fqicMSv8iMMvpNNvivIc=;
        b=uZydj3CHzinsBgmHVtzWKn5vODjGhCeYVbsoFmikUSlY/Ax/FB2JsPqEzxPCHX3zDE
         3GwxdzR+5pd9NxCki1F0p53wBWQglzQqO7ztSladwiJ9Dxfj1y6xvqZjjJ2jTXrhpym8
         0e1C2rl+PAo8SeaTOort/RDRYEPvgiGLrEnYqJYC/8i/UzLo6/AbqsdqGK29us5P6zBy
         fPHDiCnccYeGL9EOwv37TsUKXrLWQJoupDpZlMYFxmwfM5WSeyGVlt0/1QcpmUs0IWr5
         PhrpySCgSIqOymUn2P58CRYQn7+rhhdO6GXQtqPfaHooN/YaMiyU2SbTMqPWB+ZM5wMU
         Hjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vljDviNdnBJvl0I2gRgeW5+fqicMSv8iMMvpNNvivIc=;
        b=N4Dl+3igfNdD1ZXcIXxJqxKAIKc+uqEAhC4NDRLM1uWVubbSTCmUXCrFK7vhysJGVa
         qLJ1yAMQ8RphO95f/m5U9UkfaVV8ixMV+D5JSP31sbS4DIvq04FbOzNGa5rcI/TCw/pc
         olteBYg9SQlQoWMBQ7fNyddN+m5WI9u/Pt18wC1d5A3ilEkh6YBJ86Kp2qDyFDe4sm/p
         LbdXhm6iaCEDzaiO182uUvb7UNMMlk4opHI3RtnvR84df964Bnhz4mpqmmySoA5Ihf21
         HMe/vV1Mg2hYDlLmW0ffmDuHQEjagd9Lh5eetVXrr6/jKHJT7T+3yyZ76wFZ3v/c5YMI
         P/2A==
X-Gm-Message-State: APjAAAXlXKkdVomwAXkqjlC6A3gtRywRrlYJd7XTd/XT2wzid77rOtoo
        JGJ6Q31mmiHTkUjEfmzl3376PR4A3eqx+2E/
X-Google-Smtp-Source: APXvYqyGqFI7gewjmf94K55vV9Fppl0A27k3v9JRYJRr5EjU0nwgOXW8C5pNzVEI6Mcwgql0NRnI1GN6z/cpLh5f
X-Received: by 2002:ab0:c16:: with SMTP id a22mr13192833uak.73.1561413510536;
 Mon, 24 Jun 2019 14:58:30 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:58:23 -0700
In-Reply-To: <20190624215824.118783-1-allanzhang@google.com>
Message-Id: <20190624215824.118783-2-allanzhang@google.com>
Mime-Version: 1.0
References: <20190624215824.118783-1-allanzhang@google.com>
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

