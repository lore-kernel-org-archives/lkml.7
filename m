Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DD1C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E9F2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFuxSSu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfFYWXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:23:51 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39970 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfFYWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:23:37 -0400
Received: by mail-pf1-f202.google.com with SMTP id z1so213855pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lTASmr8508yaqk28Yw8XQISa65o9AY9rEgUPJ2XrbLE=;
        b=iFuxSSu4w+qeEDrnY8eCvHpyEmzF/JGzC5jealGOACnmQUOxHsvXUrxbx5B6NbMf9r
         m0Ish2G+BzlT5I4xeMQ+olR/2b7upyAKmJvFDbKeXv9/C6crCP7GQX8iqRQieVK5hv/k
         PF+Em80VwxveytMkLWejhiJATX/wxPCQgP6uhd8sTiThHx+VCJbL5PqkG1TTg5/Uohp0
         EchVDYcu13G8obyU86sTZANEFEbTuqhOFg2Yt3HKAnFia4/dqzfG5m9HR35NUyK6iBFz
         ZGp+p0l2JHbEetVVoSj2YO+upcrYy6CVYDt7Wg3xjK6WZ3DXIBEYE8sxTCYM9jgWTIU6
         bMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lTASmr8508yaqk28Yw8XQISa65o9AY9rEgUPJ2XrbLE=;
        b=JyJ4ViZdu6Oim95q/4rhO9I5//KivYPgVl9GRhAl92dU4393pWFNbjqHcw/tFIWHwv
         MuZ6HJm4lq8kS41yNbmLR5CtRUmMEwlX6A9nYsaDHieEo7jlyXqacUgGrbnnH8VzNzwB
         EMp8wLHaDcXyJ9bW2G3wB7ZKbCvvon4UbgvrYbA6SWTp+mbh364qMsEWvcI5R35QCb0L
         dmcbm85WoGBEF7W1lO6WeLtvP/WSGWnPbWJyysAj1lh/ASCX7iwP3VcnGhJ+KILA5ppJ
         IKnDtrlFmcL4R/ctb/E//aign8j0cpV1CKNk5C8LNQOvJX4oJUuAre7Ow6eu0QOql0IK
         G11g==
X-Gm-Message-State: APjAAAUyeRNu/WbMcpLEHLv0WZko3GWd80hJhe9yL1jmKOnAK3BDEZmK
        c8PTteIQSFyNtVvPn3LdwDrR3SxSJZJsA1H9
X-Google-Smtp-Source: APXvYqzWflQoTTCY4koVcOoYwwtcf1JO0bMRrK4mtCaxSI3WP6xeQVhy1ZTe3jrivMVF+vUDuw642TCLpR9CHoyY
X-Received: by 2002:a63:490a:: with SMTP id w10mr40549380pga.6.1561501416111;
 Tue, 25 Jun 2019 15:23:36 -0700 (PDT)
Date:   Tue, 25 Jun 2019 15:23:28 -0700
In-Reply-To: <20190625222329.209732-1-allanzhang@google.com>
Message-Id: <20190625222329.209732-2-allanzhang@google.com>
Mime-Version: 1.0
References: <20190625222329.209732-1-allanzhang@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v5 1/2] bpf: Allow bpf_skb_event_output for a few
 prog types
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

