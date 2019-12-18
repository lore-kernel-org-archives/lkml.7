Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5143AC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FE22082E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lHIItX6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLRRQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:16:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45776 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfLRRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:16:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so1587973pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rsgLsLg/wxtAj9kO60kIoIvi8Gvu9M5kT2kkH8nAkwg=;
        b=lHIItX6fuQmi0XhrOTbnRwTehxKFE1FN1sEZ7rdOae4VBHmNGUVQOn2gyjtOyFklAr
         gqKuvEZeJzngwhbMGoFTfkbZb6WE0VfIzvVfkWthnU7FX2JVq0XmJZzl1zVaP9gIIriL
         Gyp2tfl1CeCw2U/LzXGQqnTHGL1VlOaK8W7bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rsgLsLg/wxtAj9kO60kIoIvi8Gvu9M5kT2kkH8nAkwg=;
        b=YsZK56ocoSfy90AHGOARtZVrP9aIBIl2dizI5IH3W1lNhPKZTyTogmdApMYwebeKg0
         DMxPIPKahsjbky4N8wUMaVBg8KrjA1JI3gA/RSGmYxVt3nGnk88v9rnXPmQhEKToieEO
         mzQVItWZ/BnjstR7HDnHfHlehPq8ZdFr7e50Qp8o3eSvD2MNM1OygzfYu1x7jW5/5sI4
         NRfsIwaGrzEfFIp1jwEgkFGiATo/nlasUAkUxqPFg2mCVEmeWDfaoGkMqJ1G1npmFEaI
         DGqN4Of4W7bKe669NhX3OdiDxi/Dc5W5qPKYjJzgHPu7AvAj386eNIWdSerUWW0yrbu1
         XIxQ==
X-Gm-Message-State: APjAAAUs0xODRApKpPhfna9/rD+IkS5/7dnB6MQLLY8eEEvKxK/NH1SL
        V6dqC/WNbriFuVDmSqpL0Fv+pA==
X-Google-Smtp-Source: APXvYqxDCuD9IVb9t3S3rGH4Y9Oz7ptzoyvBZqNsgpOzpElb+EU0ZowiBrYWJ5I1PdvNnIBlRp+7nw==
X-Received: by 2002:aa7:93c1:: with SMTP id y1mr2894684pff.200.1576689374963;
        Wed, 18 Dec 2019 09:16:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t30sm3894117pgl.75.2019.12.18.09.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:16:13 -0800 (PST)
Date:   Wed, 18 Dec 2019 09:16:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Paul Burton <paulburton@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH] MIPS: BPF: Use sizeof_field() instead of FIELD_SIZEOF()
Message-ID: <201912180915.9878694B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIELD_SIZEOF() macro was redundant, and is being removed from the
kernel. Since commit c593642c8be0 ("treewide: Use sizeof_field() macro")
this is one of the last users of the old macro, so replace it.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/mips/net/bpf_jit.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 3a0e34f4e615..0af88622c619 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -689,7 +689,7 @@ static int build_body(struct jit_ctx *ctx)
 			emit_load_imm(r_A, k, ctx);
 			break;
 		case BPF_LD | BPF_W | BPF_LEN:
-			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, len) != 4);
+			BUILD_BUG_ON(sizeof_field(struct sk_buff, len) != 4);
 			/* A <- len ==> lw r_A, offset(skb) */
 			ctx->flags |= SEEN_SKB | SEEN_A;
 			off = offsetof(struct sk_buff, len);
@@ -1093,7 +1093,7 @@ static int build_body(struct jit_ctx *ctx)
 		case BPF_ANC | SKF_AD_PROTOCOL:
 			/* A = ntohs(skb->protocol */
 			ctx->flags |= SEEN_SKB | SEEN_OFF | SEEN_A;
-			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
+			BUILD_BUG_ON(sizeof_field(struct sk_buff,
 						  protocol) != 2);
 			off = offsetof(struct sk_buff, protocol);
 			emit_half_load(r_A, r_skb, off, ctx);
@@ -1118,7 +1118,7 @@ static int build_body(struct jit_ctx *ctx)
 		case BPF_ANC | SKF_AD_CPU:
 			ctx->flags |= SEEN_A | SEEN_OFF;
 			/* A = current_thread_info()->cpu */
-			BUILD_BUG_ON(FIELD_SIZEOF(struct thread_info,
+			BUILD_BUG_ON(sizeof_field(struct thread_info,
 						  cpu) != 4);
 			off = offsetof(struct thread_info, cpu);
 			/* $28/gp points to the thread_info struct */
@@ -1137,30 +1137,30 @@ static int build_body(struct jit_ctx *ctx)
 				   b_imm(prog->len, ctx), ctx);
 			emit_reg_move(r_ret, r_zero, ctx);
 			if (code == (BPF_ANC | SKF_AD_IFINDEX)) {
-				BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, ifindex) != 4);
+				BUILD_BUG_ON(sizeof_field(struct net_device, ifindex) != 4);
 				off = offsetof(struct net_device, ifindex);
 				emit_load(r_A, r_s0, off, ctx);
 			} else { /* (code == (BPF_ANC | SKF_AD_HATYPE) */
-				BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, type) != 2);
+				BUILD_BUG_ON(sizeof_field(struct net_device, type) != 2);
 				off = offsetof(struct net_device, type);
 				emit_half_load_unsigned(r_A, r_s0, off, ctx);
 			}
 			break;
 		case BPF_ANC | SKF_AD_MARK:
 			ctx->flags |= SEEN_SKB | SEEN_A;
-			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, mark) != 4);
+			BUILD_BUG_ON(sizeof_field(struct sk_buff, mark) != 4);
 			off = offsetof(struct sk_buff, mark);
 			emit_load(r_A, r_skb, off, ctx);
 			break;
 		case BPF_ANC | SKF_AD_RXHASH:
 			ctx->flags |= SEEN_SKB | SEEN_A;
-			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, hash) != 4);
+			BUILD_BUG_ON(sizeof_field(struct sk_buff, hash) != 4);
 			off = offsetof(struct sk_buff, hash);
 			emit_load(r_A, r_skb, off, ctx);
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG:
 			ctx->flags |= SEEN_SKB | SEEN_A;
-			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
+			BUILD_BUG_ON(sizeof_field(struct sk_buff,
 						  vlan_tci) != 2);
 			off = offsetof(struct sk_buff, vlan_tci);
 			emit_half_load_unsigned(r_A, r_skb, off, ctx);
@@ -1186,7 +1186,7 @@ static int build_body(struct jit_ctx *ctx)
 			break;
 		case BPF_ANC | SKF_AD_QUEUE:
 			ctx->flags |= SEEN_SKB | SEEN_A;
-			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
+			BUILD_BUG_ON(sizeof_field(struct sk_buff,
 						  queue_mapping) != 2);
 			BUILD_BUG_ON(offsetof(struct sk_buff,
 					      queue_mapping) > 0xff);
-- 
2.17.1


-- 
Kees Cook
