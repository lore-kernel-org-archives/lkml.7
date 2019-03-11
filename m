Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D37C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79972148D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="hS7wkKnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfCKXUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:20:10 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:48058 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfCKXUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:20:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id C1186938
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 23:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lRnLSKJqxj_u for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 18:20:07 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 896446E8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 18:20:07 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id 190so599841itv.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 16:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=q3CdnuMQy0ShWWsmGLLstnXz29N0wkvNqXI8ARE0Z/Y=;
        b=hS7wkKnD2MVBlF/utd7/cPL5quV4KbNUt0laVpApIyn6IodQ7WzkIq9FC9cO+bGaic
         JoovTGFo++RPoGMxuA23fOu6EW1BBDaxD04WJLMQNRaNg5bC8RnIzgcoDsjYSNNYXv60
         gNfDBhtNQJs/Wp7UClj91eYN6OzJ2tPQYZz3lKuQDJQZMUwnnGUJCTwPD+SuFwNf7bhH
         78bSU2IUIjHnFgae10FlrM3Mx482PgcgteAibDfJvioWPlR2VOTrxOcMAuQyZ54pmLXd
         4wbefSnmSM4TSjfF877RnxdTrO4BunMUD74UDCOAwtU5gKiwt3sny5nLVJWUF71A+9L+
         oYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q3CdnuMQy0ShWWsmGLLstnXz29N0wkvNqXI8ARE0Z/Y=;
        b=e7jD820SPTz9UQe38MZkHozCPUfAyTCuH44iTBhdx9ZWLrqlOsZb/bLOOqdB3rrP5n
         B7XhUm1veE0GnDYNTOmtn6zFh1undcFwxAelJTYwZIFtoGduC5Rn342DIlM4wGvbXhox
         PtkCogSWkXJhFzI0NmTarjorwIgIK6XHiKjpXYlUrYi+BNsRrYp3N7v+OTfC5N5Ku4cf
         DTJ8hx3N4njqYXGfhwi+++ailkIXfFJevYIO05O49w+FL9MXsa/2/IAOmPF4gLR1Anb4
         ByezYkWTDL+QhUwTJVP+hHaR02QUBUO3HZsr2CjLBCPUVNBYI9PHxT+oBUdxpM4/4UND
         BAiw==
X-Gm-Message-State: APjAAAWAK225utliDU65b99olCbWFlJnybWyGynhpWJy82qWvUnudaX5
        KbL0//oAoO88QXNpQQZ9hrVfqathIK0LzGq8893Egu5NNuOOBabf6je9lAA6rebFkJ82YLujl+V
        kZmFBydGmdfdUfl9KGG0bhd3ZyO9a
X-Received: by 2002:a6b:7718:: with SMTP id n24mr18015369iom.299.1552346406933;
        Mon, 11 Mar 2019 16:20:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/631QgHOU6QwPo2m2Zr15jCD7IUbj0ajS6h6Z4VC5owymdYUM2Yfrae6IV3QkDQHjkcMomg==
X-Received: by 2002:a6b:7718:: with SMTP id n24mr18015357iom.299.1552346406709;
        Mon, 11 Mar 2019 16:20:06 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id f17sm382100itb.36.2019.03.11.16.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 16:20:06 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: ip6t_srh: Fix potential NULL pointer dereference
Date:   Mon, 11 Mar 2019 18:19:20 -0500
Message-Id: <20190311231920.26514-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb_header_pointer in srh_mt6 may return a NULL pointer that is
dereferenced in ipv6_masked_addr_cmp. This patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/ipv6/netfilter/ip6t_srh.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/netfilter/ip6t_srh.c b/net/ipv6/netfilter/ip6t_srh.c
index 1059894a6f4c..5a1c0437f74b 100644
--- a/net/ipv6/netfilter/ip6t_srh.c
+++ b/net/ipv6/netfilter/ip6t_srh.c
@@ -210,9 +210,10 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 		psidoff = srhoff + sizeof(struct ipv6_sr_hdr) +
 			  ((srh->segments_left + 1) * sizeof(struct in6_addr));
 		psid = skb_header_pointer(skb, psidoff, sizeof(_psid), &_psid);
-		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_PSID,
+		if (psid &&
+		    NF_SRH_INVF(srhinfo, IP6T_SRH_INV_PSID,
 				ipv6_masked_addr_cmp(psid, &srhinfo->psid_msk,
-						     &srhinfo->psid_addr)))
+							&srhinfo->psid_addr)))
 			return false;
 	}
 
@@ -223,7 +224,8 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 		nsidoff = srhoff + sizeof(struct ipv6_sr_hdr) +
 			  ((srh->segments_left - 1) * sizeof(struct in6_addr));
 		nsid = skb_header_pointer(skb, nsidoff, sizeof(_nsid), &_nsid);
-		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_NSID,
+		if (nsid &&
+		    NF_SRH_INVF(srhinfo, IP6T_SRH_INV_NSID,
 				ipv6_masked_addr_cmp(nsid, &srhinfo->nsid_msk,
 						     &srhinfo->nsid_addr)))
 			return false;
@@ -233,7 +235,8 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	if (srhinfo->mt_flags & IP6T_SRH_LSID) {
 		lsidoff = srhoff + sizeof(struct ipv6_sr_hdr);
 		lsid = skb_header_pointer(skb, lsidoff, sizeof(_lsid), &_lsid);
-		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_LSID,
+		if (lsid &&
+		    NF_SRH_INVF(srhinfo, IP6T_SRH_INV_LSID,
 				ipv6_masked_addr_cmp(lsid, &srhinfo->lsid_msk,
 						     &srhinfo->lsid_addr)))
 			return false;
-- 
2.17.1

