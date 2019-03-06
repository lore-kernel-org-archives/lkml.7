Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F35C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FE620661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0eBxBnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfCFHdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:33:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41521 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfCFHdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:33:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id k11so6684380pgb.8;
        Tue, 05 Mar 2019 23:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EKe7pYqO/S8mQt2aBQbI8hgJrHk8UMFItsNlWCpshp8=;
        b=r0eBxBnAmtMaR6ZSRocFqVi8/UsQNjQ61lvDTYFu6ZL7uZJIMO+w+ZNzddHJGW0rFa
         TCiJ3YO407Qs4ziSiISiUIvIEsLxLLOO4PbowYrq12dm1EkUsZRNEx/WzNEdUm1En5dm
         suIF/ogCsaO4wCyeGEyOkZt55bL7l4/L/0Y99aI//IP0JOM3hgwiZP+eTDJZgGLQiGLh
         k5oKKHKtW5GX49Jhj/iVZ2wHXp3DdmXqaQV2jIoNAGrXmUszKYckhAE4dfzDs9bsYLSR
         sgv8+G9Iav74iUCLBmVT6ge/1XksSVpnrvUJwatz4TZ0eJ8TUcd7AW/cDn5bZwhvL+1x
         OzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EKe7pYqO/S8mQt2aBQbI8hgJrHk8UMFItsNlWCpshp8=;
        b=ua5RPus4vDTY9TGUaTMGRs0eJb8BgJCLl+IgIQWv6pxNhiRKCeeemv4dsKrrfPzn5C
         vm9yV8wU8Gz7ENqnAdceos8P+Q06Bnn5U3m80FqpgAwZoUk8LlcSTR2j7cx2iDrFOA7Z
         Ke4htC7JttSWgUVRFV4K+qHhoGXYD1tsglwbjB2jB1Mk8FsA4O7Q/ejQPvSRbdMv+wQ5
         e5o6etlZLVWMv55wmUdKecf/WNPHeRl5dc6z2FQ7h6dry4KPcBKTvAmHsojK1QPttN9f
         WVhXvnU5hZXFBbG9o3ocBxt122SsdoWr4+NNzaUGyPQ3iZPmBxr7k9I0m2bIaalBiRkx
         iDvQ==
X-Gm-Message-State: APjAAAUcD6t+FcqCFZWFkBwhkle9PDqyWcLaMCfpMwirRD/+9hRys6op
        40gd4Kzo7T5JkXxPrOQgBL4MAE588v4=
X-Google-Smtp-Source: APXvYqwsauFknoaispgp9PoM4InjOXvPSgmWK7q82wbWmRYcd2beZ9URiILzyBHSjLIZ7muJfi+N6A==
X-Received: by 2002:a62:a10c:: with SMTP id b12mr5888992pff.234.1551857593169;
        Tue, 05 Mar 2019 23:33:13 -0800 (PST)
Received: from myunghoj-Precision-5530 ([118.220.181.225])
        by smtp.gmail.com with ESMTPSA id l28sm3159823pfi.186.2019.03.05.23.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 23:33:12 -0800 (PST)
Date:   Wed, 6 Mar 2019 16:33:08 +0900
From:   Myungho Jung <mhjungk@gmail.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xfrm: Reset secpath in xfrm failure
Message-ID: <20190306073304.GA22426@myunghoj-Precision-5530>
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

Reported-by: syzbot+b69368fd933c6c592f4c@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
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

