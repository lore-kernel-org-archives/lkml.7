Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23879C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5D921019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Yp8lYPOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfCNH61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:58:27 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:59874 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCNH61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:58:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id D8261A2F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:58:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U0CdIwF1iXwG for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 02:58:25 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id A1F2D7D1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:58:25 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id l10so3644333iob.22
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BbqmGjLcyKyOuWw9asJAe7bSmTd5l7ynZnmbov0Wmhg=;
        b=Yp8lYPOnNd28KD6jqchkkdgKvUfWU1AsHXHZWrmuomjTC+9E/0sYw4d5ddtQ7HNd9c
         NpqkwjYyYwgoJ/EEBMwuK7rm6CapaeP0xAzgfhrVXLa1LvhDNhTsfn8CeRYYqXB0aeTI
         OxWIJJlPaPuTg/mOo3qgART5mTnFtD3vNeksk205Rh0yAn9RLKGactmulY63p5YnDmfo
         502Dsqz54cn3l3ntKDASv25YL9NeOad+GSWYd89iqGTbXWuFEn5fuc4XuUrMZsq5LWH0
         Nj0K9yclks3jM8dMoD0v5tTLyjYJ/V8nkH8up6CsA4plN6amimKgiKlJEnPZfPjL1lGb
         uXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BbqmGjLcyKyOuWw9asJAe7bSmTd5l7ynZnmbov0Wmhg=;
        b=d8kI4Low84jC3aXwrngPZ5dlyotHgdA6W7YhDU92pCe728Skb03+rSsj4javwQO9z0
         GPvq6WorBDSpAhpwCSld6IYqQVys7NU0M6NTZAu3XInyl77Ns2R22CvVNq99YBKU5J5A
         +KA5r4JfRSlrQGm+lCp1Eb8Nl6DceNRGzSaAM7uKx1+eQQYSFhQJNdQochbxOQGL1AIH
         G4kL6cOdLi6lW/UVeyAI/dM1bMnIf0L5EVTAdtd7JeLCXYVOo9BpKAd+ylM8EohmvCYK
         prS2ESwFHvbsj50uIuKTKNRY3ewKIlx7VeOJxyW2frBOpyopam2qOD4oGdON/JBntWwq
         kGcw==
X-Gm-Message-State: APjAAAXj5t20XZQTDD9r8rKwtu/AX5QRFY7e4Yt3KwsJIcB8bxJHhvIw
        VkWgR3uFWM1jznflBrMXGYMUFh6vGgMQil/PggPsDYmIvLpgRbtpUqHywJcEV+VU1+XledJholW
        yTZb59BbNf2bYbpT2nRBFKzWj+JCx
X-Received: by 2002:a02:5cdd:: with SMTP id w90mr27367124jad.90.1552550305275;
        Thu, 14 Mar 2019 00:58:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtfMDaKG4fvcj2S91FxJFVr0D4tev6/8EWOXYaVlu4u3dHgBC2i3k7uiHsHfXicWqAjDYorw==
X-Received: by 2002:a02:5cdd:: with SMTP id w90mr27367117jad.90.1552550305022;
        Thu, 14 Mar 2019 00:58:25 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id i14sm892269itc.34.2019.03.14.00.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 00:58:24 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: ip6t_srh: fix NULL pointer dereferences
Date:   Thu, 14 Mar 2019 02:58:18 -0500
Message-Id: <20190314075818.29951-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb_header_pointer may return NULL. The current code dereference
its return values without a NULL check.

The fix inserts the checks to avoid NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/ipv6/netfilter/ip6t_srh.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/netfilter/ip6t_srh.c b/net/ipv6/netfilter/ip6t_srh.c
index 1059894a6f4c..4cb83fb69844 100644
--- a/net/ipv6/netfilter/ip6t_srh.c
+++ b/net/ipv6/netfilter/ip6t_srh.c
@@ -210,6 +210,8 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 		psidoff = srhoff + sizeof(struct ipv6_sr_hdr) +
 			  ((srh->segments_left + 1) * sizeof(struct in6_addr));
 		psid = skb_header_pointer(skb, psidoff, sizeof(_psid), &_psid);
+		if (!psid)
+			return false;
 		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_PSID,
 				ipv6_masked_addr_cmp(psid, &srhinfo->psid_msk,
 						     &srhinfo->psid_addr)))
@@ -223,6 +225,8 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 		nsidoff = srhoff + sizeof(struct ipv6_sr_hdr) +
 			  ((srh->segments_left - 1) * sizeof(struct in6_addr));
 		nsid = skb_header_pointer(skb, nsidoff, sizeof(_nsid), &_nsid);
+		if (!nsid)
+			return false;
 		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_NSID,
 				ipv6_masked_addr_cmp(nsid, &srhinfo->nsid_msk,
 						     &srhinfo->nsid_addr)))
@@ -233,6 +237,8 @@ static bool srh1_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 	if (srhinfo->mt_flags & IP6T_SRH_LSID) {
 		lsidoff = srhoff + sizeof(struct ipv6_sr_hdr);
 		lsid = skb_header_pointer(skb, lsidoff, sizeof(_lsid), &_lsid);
+		if (!lsid)
+			return false;
 		if (NF_SRH_INVF(srhinfo, IP6T_SRH_INV_LSID,
 				ipv6_masked_addr_cmp(lsid, &srhinfo->lsid_msk,
 						     &srhinfo->lsid_addr)))
-- 
2.17.1

