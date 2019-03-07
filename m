Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1AAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFA720684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ledg+69o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfCGBXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:23:16 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:38733 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfCGBXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:23:15 -0500
Received: by mail-pf1-f179.google.com with SMTP id n125so10059095pfn.5;
        Wed, 06 Mar 2019 17:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=D/ikJmjPRlqttyYOieOaynrl7E2wzKJZmRmqccnju3M=;
        b=ledg+69oES59FyPXjLuGUURYI61Ik1N0r9QvckTkJHNnw9JWXbr4U4ch4uYs4B0bhS
         +MHSMIOZscmzJU2sdk/l3XFskolt9P4ZOOvTZFdCnCi2cugF/zGDQ56hI5yu+qEdjXvJ
         KK3qn8Up1P9M+JIeil5Sn7ooKboa1YMr4OuggdSeqZhEqD0wr5ET8luDBnxk9BRh2PUW
         GEjj3YalmFsc1UZLO9EATuXaXo8ScdNiN8ztmFNli/lIIoSUhyDsJRSOzRESAFladmNo
         01ZI7dQ+a3x7SvkpssxmU+E+qM/jch+5hYlvicgqitiPTmhHwJcUnBilp3L1ChYuKwJY
         J6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D/ikJmjPRlqttyYOieOaynrl7E2wzKJZmRmqccnju3M=;
        b=YRALULRovfzyoNDOXjzK0GqLveTA2HBZirxFXXg5YXihzmwZWKwwTsmvzvej3eKvcW
         AQp54YxFIYZR0wGlcYeDfy8JR9Kwx8JTnkzP8+aj+xu7nD7FV9C7+Y3/qMVwIIZow4f8
         5ibqDgxqGdwR5f79va5lRpFGZoOkPSF7tivXJvL4Oo9NMhPxRqWk6Z5Yrx1+r5WP9qDa
         z8/Jm3TOBvsrTgYSqaPyWwLWmK+HVp04gOxlBinbfCFZ5e66dAPbUuL4+7DK+JCjvEjq
         7k2s58srxia04pP78IjU/IYWC/EXcxeMPKcND8faWR2mLe/jsBMggCbNXBmusEBJTPb+
         XsCQ==
X-Gm-Message-State: APjAAAUAVUCEaILdzg0JvCmCFCS0SAff8q/6Iy9RSvdIxdoXqhw5L7tj
        deRrLlZJKCJGe3uxJ5baxzI=
X-Google-Smtp-Source: APXvYqw7D/wOrBMR4fNBkh/UIzHPrRjZuta7SaNwVomE6sS4TunNUnN9ZmCKq5w0tpFhE39a0rWrTw==
X-Received: by 2002:a63:6bc9:: with SMTP id g192mr8985221pgc.198.1551921793732;
        Wed, 06 Mar 2019 17:23:13 -0800 (PST)
Received: from myunghoj-Precision-5530 ([118.220.181.225])
        by smtp.gmail.com with ESMTPSA id f125sm5652772pfc.91.2019.03.06.17.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 17:23:13 -0800 (PST)
Date:   Thu, 7 Mar 2019 10:23:08 +0900
From:   Myungho Jung <mhjungk@gmail.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] xfrm: Reset secpath in xfrm failure
Message-ID: <20190307012305.GA8305@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In esp4_gro_receive() and esp6_gro_receive(), secpath can be allocated
without adding xfrm state to xvec. Then, sp->xvec[sp->len - 1] would
fail and result in dereferencing invalid pointer in esp4_gso_segment()
and esp6_gso_segment(). Reset secpath if xfrm function returns error.

Fixes: 7785bba299a8 ("esp: Add a software GRO codepath")
Reported-by: syzbot+b69368fd933c6c592f4c@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
Changes in v2:
  - Add fixes tag.

Changes in v3:
  - Add out_reset label to remove duplicate secpath_reset() calls.

 net/ipv4/esp4_offload.c | 8 +++++---
 net/ipv6/esp6_offload.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 8756e0e790d2..d3170a8001b2 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -52,13 +52,13 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 			goto out;
 
 		if (sp->len == XFRM_MAX_DEPTH)
-			goto out;
+			goto out_reset;
 
 		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
 				      (xfrm_address_t *)&ip_hdr(skb)->daddr,
 				      spi, IPPROTO_ESP, AF_INET);
 		if (!x)
-			goto out;
+			goto out_reset;
 
 		sp->xvec[sp->len++] = x;
 		sp->olen++;
@@ -66,7 +66,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 		xo = xfrm_offload(skb);
 		if (!xo) {
 			xfrm_state_put(x);
-			goto out;
+			goto out_reset;
 		}
 	}
 
@@ -82,6 +82,8 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 	xfrm_input(skb, IPPROTO_ESP, spi, -2);
 
 	return ERR_PTR(-EINPROGRESS);
+out_reset:
+	secpath_reset(skb);
 out:
 	skb_push(skb, offset);
 	NAPI_GRO_CB(skb)->same_flow = 0;
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index d46b4eb645c2..cb99f6fb79b7 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -74,13 +74,13 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 			goto out;
 
 		if (sp->len == XFRM_MAX_DEPTH)
-			goto out;
+			goto out_reset;
 
 		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
 				      (xfrm_address_t *)&ipv6_hdr(skb)->daddr,
 				      spi, IPPROTO_ESP, AF_INET6);
 		if (!x)
-			goto out;
+			goto out_reset;
 
 		sp->xvec[sp->len++] = x;
 		sp->olen++;
@@ -88,7 +88,7 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 		xo = xfrm_offload(skb);
 		if (!xo) {
 			xfrm_state_put(x);
-			goto out;
+			goto out_reset;
 		}
 	}
 
@@ -109,6 +109,8 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 	xfrm_input(skb, IPPROTO_ESP, spi, -2);
 
 	return ERR_PTR(-EINPROGRESS);
+out_reset:
+	secpath_reset(skb);
 out:
 	skb_push(skb, offset);
 	NAPI_GRO_CB(skb)->same_flow = 0;
-- 
2.17.1

