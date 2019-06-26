Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45B5C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFC420815
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1K6uuNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfFZX6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:58:11 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:32784 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZX6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:58:10 -0400
Received: by mail-vs1-f74.google.com with SMTP id x140so95889vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 16:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/FWnMMr39n+Rg4WltZKLdrffcUYCEq85Tj0c/Xlt4pg=;
        b=h1K6uuNvDhpFiy4IOjc/VvXlbNfLvEjibmUJL+T6vKx8BY5IBz6rs6VwFyuH8i7C4n
         jOTxdwldVQpQfOApPZFurFIXROeHRUMwuJgwLsZW6v+BqA1zoOQA1i268iq7zSqCYpHR
         K4FSZ5SfGsRq4tYLxXwfo0Epe/upYB4h+QrFpi1ffhEGwn27vTI34JrAtRJzoPD1XYTu
         XbCvzhtM0bGcA9+3y702KwvgL9JM/H82SmWjy7bKbaHWOCqUYl/gFSjmExxQWBhLjeSb
         ZZ0wXqCVg3+UUFsCH+OMItnPEiaVcSqoSazsxZrv9PpiHZzMdkx/f/YoDD5ObEdRJtWR
         iI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/FWnMMr39n+Rg4WltZKLdrffcUYCEq85Tj0c/Xlt4pg=;
        b=d+iz5mevktI4c97KDATLhlWwy7AA2xY1Ii1OSA2JkcJaUb/rvvR1Q6sLRBk9nZcXHi
         0ERMKTGtS5TpAgrVfWaJeTY34l6tYCGVXfJOW1y74MYW3CQttqbae3/YoBbk1E3QLUqb
         1EQrVopsu6rHDyxTnW411w/G0C2GSZ36rJO/ZlDL0g0Oya4/I7KK+wusxYugrzzE4O9i
         /7/iY71gucpOzVcnRYMk4uk3rzthIWZqCuOONyih6vO12oBSB3i0OURAczr3wTf4Y9K1
         pEQtT2Cp3bd5wkU/ivXPnDr9XA/8f3/FASzHrRryRC0WFlX1QCrrDFta2OfBcrigNROK
         Vu7g==
X-Gm-Message-State: APjAAAWogVTfPufsjWfJLPZ8Vse8h8zIdBhcylN7WcQ/LUSg5uDcltAC
        pAz4+4wIJNgJcABobzqT8/o0A1H2skqCC9Dm
X-Google-Smtp-Source: APXvYqxuB9gvzyFAJ8uL4vRJPJdl+07EG+iG9nNgRG6SbzlizxVuCbN8yKmMISV5Covbk/2o07tH+xG8BlovyMJL
X-Received: by 2002:a67:bb03:: with SMTP id m3mr681889vsn.84.1561593489019;
 Wed, 26 Jun 2019 16:58:09 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:58:00 -0700
In-Reply-To: <20190626235801.210508-1-allanzhang@google.com>
Message-Id: <20190626235801.210508-2-allanzhang@google.com>
Mime-Version: 1.0
References: <20190626235801.210508-1-allanzhang@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v7 1/2] bpf: Allow bpf_skb_event_output for a few
 prog types
From:   Allan Zhang <allanzhang@google.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, allanzhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: allanzhang <allanzhang@google.com>

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

Signed-off-by: Allan Zhang <allanzhang@google.com>
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

