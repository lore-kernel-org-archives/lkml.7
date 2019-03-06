Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3C3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38B620663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic1ityeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfCFV4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:56:06 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:43111 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCFV4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:56:06 -0500
Received: by mail-pf1-f181.google.com with SMTP id q17so9678377pfh.10;
        Wed, 06 Mar 2019 13:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=doWDRphVEnglfL89Tp64Jf1WtVGQTVDfI9OaD8Of7NU=;
        b=Ic1ityeu8FGyas3S1s7YKTfa8d2Uajg74ls5CfH7I9pZCjKz6m4Sjjiawhj294msfY
         5anLh5n+hRe47dm435+IoXcJNAm90rsNUHKcrWaQYoegGwVqG2DyiM3xiqNhm3iWuQqV
         T2A2Fyt9K6VlcHAeb1aGg/iIGB9hDVB9kFWNKRR0FQckNJJm7yuZPyDwr1C33UHpcYs0
         GyzqIZ87JniF3KOvP4QgWWdKNgJJVEyeZ/ouP5trpIQVS3RkDmmWtEjKCgVXrbNAHEyn
         dDnnvI0xeYLmDNz8CIXjP3U1OdKV2yqYt5q9FofsQcrdSYJl03Lu5dLe/zUvhDVVsB6N
         dPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=doWDRphVEnglfL89Tp64Jf1WtVGQTVDfI9OaD8Of7NU=;
        b=Lz8UqYLV+Kh8QV3DRsAHcsjfQzjRCYKGEiONU7pKWPEt8DFe8o7hU5SuQlME0uoVFg
         JQ/zLxN61TBfzenYh9qdyVRriQid3tJSW/FdUISoarZxbvLOHmTbRf675lh1A1407Lcv
         Zr26tILAYhF9Q66+lVsGGa2KX64xM6aCNUqPHERmhMQHCqEBaChUjv1q+hADG6RnmF6R
         TMnILIe2XhIbNh7ldKcNaM3VnQ6vHaKTDtBsndjpLvcPR6wo5pRP5MtpTz5/2l460Qqi
         LwP3juXfZp+z22gI2x5jFS5hShyG1tzFtP4/7/HzCskyokab5nXLAmPQ9kUBKGlwMG3k
         NUFw==
X-Gm-Message-State: APjAAAV+nhsil35oSOvqq2i0+DxmQLpUG12E6QWQJ6tNC2kQ7lSYN8sM
        /FmnZVvafqexb1afJ0R5nqBhWmsb84g=
X-Google-Smtp-Source: APXvYqxBSQe2b6ZOkvfHbE2rIZxu4DveqM0oeJzu7nv9vsPHAWYyv75wwg2as2CcVaznu/6UdLtvyQ==
X-Received: by 2002:a62:4793:: with SMTP id p19mr9621486pfi.76.1551909364694;
        Wed, 06 Mar 2019 13:56:04 -0800 (PST)
Received: from myunghoj-Precision-5530 ([118.220.181.225])
        by smtp.gmail.com with ESMTPSA id n18sm8575334pfh.93.2019.03.06.13.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 13:56:04 -0800 (PST)
Date:   Thu, 7 Mar 2019 06:55:59 +0900
From:   Myungho Jung <mhjungk@gmail.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] xfrm: Reset secpath in xfrm failure
Message-ID: <20190306215556.GA6104@myunghoj-Precision-5530>
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

 net/ipv4/esp4_offload.c | 9 +++++++--
 net/ipv6/esp6_offload.c | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 8756e0e790d2..7329e40c73f6 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -51,14 +51,18 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 		if (!sp)
 			goto out;
 
-		if (sp->len == XFRM_MAX_DEPTH)
+		if (sp->len == XFRM_MAX_DEPTH) {
+			secpath_reset(skb);
 			goto out;
+		}
 
 		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
 				      (xfrm_address_t *)&ip_hdr(skb)->daddr,
 				      spi, IPPROTO_ESP, AF_INET);
-		if (!x)
+		if (!x) {
+			secpath_reset(skb);
 			goto out;
+		}
 
 		sp->xvec[sp->len++] = x;
 		sp->olen++;
@@ -66,6 +70,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 		xo = xfrm_offload(skb);
 		if (!xo) {
 			xfrm_state_put(x);
+			secpath_reset(skb);
 			goto out;
 		}
 	}
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index d46b4eb645c2..399c688d192e 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -73,14 +73,18 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 		if (!sp)
 			goto out;
 
-		if (sp->len == XFRM_MAX_DEPTH)
+		if (sp->len == XFRM_MAX_DEPTH) {
+			secpath_reset(skb);
 			goto out;
+		}
 
 		x = xfrm_state_lookup(dev_net(skb->dev), skb->mark,
 				      (xfrm_address_t *)&ipv6_hdr(skb)->daddr,
 				      spi, IPPROTO_ESP, AF_INET6);
-		if (!x)
+		if (!x) {
+			secpath_reset(skb);
 			goto out;
+		}
 
 		sp->xvec[sp->len++] = x;
 		sp->olen++;
@@ -88,6 +92,7 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 		xo = xfrm_offload(skb);
 		if (!xo) {
 			xfrm_state_put(x);
+			secpath_reset(skb);
 			goto out;
 		}
 	}
-- 
2.17.1

