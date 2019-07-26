Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDD8C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19B321901
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en3ja7Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfGZIDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:03:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42073 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZIDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:03:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so24380270pgb.9;
        Fri, 26 Jul 2019 01:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ezk7udNGHpj8DbEIJ/QK4G3fHV7bgQKFf1n90gssYQo=;
        b=en3ja7HyoKgOPY37rbkkkpAKcd3jXXyZKTnEL91Dcq/q0Tlt+t8iJtE2ZT6824Hcn1
         V7TeS/+Hw0FAF4yiWCDOkUhboPVglR8hJ7cIAls7dgJlR0OQKP89SEcWtOfeuptZP3b8
         zE2ufeY0BLqnrzxryvVDcfW2YIyFBSED/jRbfck+d0iAwzZGGqRFf4bmh/3w5W9x4dUL
         q1ASzn5Z9qF32UXqwAM/newgkWDnex6px7geRSJmEc/Bqe/jAaLJJs5mm5gcw7LvUKie
         t3w0xqBC1udxSllaPpeobGT2dAezNKcI5q9+CbwLlKO+0HXO9dXO3mIYHc82ejxCwHm2
         3b7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ezk7udNGHpj8DbEIJ/QK4G3fHV7bgQKFf1n90gssYQo=;
        b=Awg5sIWsbUYxYNg7Ds29nf+xOF1qsEQDfSko+IZ+5C5wVv1gSGMgWAnGlc2E6Tf6OK
         bwKL04NztfTJwVOt0jh0V069BK2WlimUvmYHW/hTIef40n19xtpBaRpIhGZK1gvcCaNd
         s1t7U6+sv4kSG36/bZeN+8ENlpCIydJABZN+/h8zuWIp6t9rV6+J9pl9t5/k0lyrjVsN
         Bw572kwQYSadgdWLhFEU99RuyNien7iS49obuXlx4/0KhWIbxH7CMa2GBuLtjkuKd9Mm
         3rQMIkICQ6mDPNKhxwtyWCzfu7hWgr09bxVGaq6CCczY7o6Zlnk0zZ+6EyPvsQN4k3gF
         Yy0Q==
X-Gm-Message-State: APjAAAWkwRMgvahlzSiSSLZxoq9XfzGMvtFE5SPRGdRvoxFDO8n343Ed
        9vJQKBhyuZUhDiZoCv3TV48=
X-Google-Smtp-Source: APXvYqwZHG3CeVEGEoQyGF0hdHVJkM/QYHRbr5DITZn/g0vK6/+1dNQHLnzULw5PNNjdf4tMGzhzsw==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr95739307pjz.140.1564128198517;
        Fri, 26 Jul 2019 01:03:18 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id v22sm49742272pgk.69.2019.07.26.01.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 01:03:18 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] net: ipv6: Fix a possible null-pointer dereference in ip6_xmit()
Date:   Fri, 26 Jul 2019 16:03:07 +0800
Message-Id: <20190726080307.4414-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ip6_xmit(), there is an if statement on line 245 to check whether 
np is NULL:
    if (np)

When np is NULL, it is used on line 251:
    ip6_autoflowlabel(net, np)
        if (!np->autoflowlabel_set)

Thus, a possible null-pointer dereference may occur.

To fix this bug, np is checked before calling 
ip6_autoflowlabel(net,np).

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 net/ipv6/ip6_output.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8e49fd62eea9..07db5ab6e970 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -247,8 +247,10 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	if (hlimit < 0)
 		hlimit = ip6_dst_hoplimit(dst);
 
-	ip6_flow_hdr(hdr, tclass, ip6_make_flowlabel(net, skb, fl6->flowlabel,
-				ip6_autoflowlabel(net, np), fl6));
+	if (np) {
+		ip6_flow_hdr(hdr, tclass, ip6_make_flowlabel(net, skb, fl6->flowlabel,
+					ip6_autoflowlabel(net, np), fl6));
+	}
 
 	hdr->payload_len = htons(seg_len);
 	hdr->nexthdr = proto;
-- 
2.17.0

