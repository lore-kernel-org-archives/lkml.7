Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFC5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F2A21903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126149;
	bh=WbYeHM9Y/FRcwD5BMmuMbdIj5MOn9UOvVJsEW7UHq/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aba8z3sodv+ElV2tPHqu6zJtvtWnPkZpqg19JWqcE+8fS20WuLyR3DpxRAvrxOgdV
	 rkjU7eop0Pe9OX4DY7qK3j0XSTaufoyRmCqshkt4uStMpxRivrcyqlw3V5ibrXlk37
	 OgoJZHjuAFRD6M5wchrNuOYF2MXKzIBnoU6ximGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbfDXRPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387657AbfDXRPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:15:44 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9722A2054F;
        Wed, 24 Apr 2019 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126144;
        bh=WbYeHM9Y/FRcwD5BMmuMbdIj5MOn9UOvVJsEW7UHq/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0ZBapS8Xa6C/vyd8GLyb5wgAsGOynKbdncs6nF352pdaB07D86JMFYK+8rNvQjda
         cjmpqKm/gY64JRFpCfXFofrDQNJbbKMklmB8UtXlZbKjBZg1xYryfSREXkHRWmYLOl
         4X3zhLyDoHTd3wCKjKMVsfKR2+GjVa6vnacuXUzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amit Klein <aksecurity@gmail.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 3.18 086/104] inet: update the IP ID generation algorithm to higher standards.
Date:   Wed, 24 Apr 2019 19:09:43 +0200
Message-Id: <20190424170908.374955029@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Klein <aksecurity@gmail.com>

Commit 355b98553789 ("netns: provide pure entropy for net_hash_mix()")
makes net_hash_mix() return a true 32 bits of entropy.  When used in the
IP ID generation algorithm, this has the effect of extending the IP ID
generation key from 32 bits to 64 bits.

However, net_hash_mix() is only used for IP ID generation starting with
kernel version 4.1.  Therefore, earlier kernels remain with 32-bit key
no matter what the net_hash_mix() return value is.

This change addresses the issue by explicitly extending the key to 64
bits for kernels older than 4.1.

Signed-off-by: Amit Klein <aksecurity@gmail.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c      |    4 +++-
 net/ipv6/ip6_output.c |    3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -488,13 +488,15 @@ EXPORT_SYMBOL(ip_idents_reserve);
 void __ip_select_ident(struct iphdr *iph, int segs)
 {
 	static u32 ip_idents_hashrnd __read_mostly;
+	static u32 ip_idents_hashrnd_extra __read_mostly;
 	u32 hash, id;
 
 	net_get_random_once(&ip_idents_hashrnd, sizeof(ip_idents_hashrnd));
+	net_get_random_once(&ip_idents_hashrnd_extra, sizeof(ip_idents_hashrnd_extra));
 
 	hash = jhash_3words((__force u32)iph->daddr,
 			    (__force u32)iph->saddr,
-			    iph->protocol,
+			    iph->protocol ^ ip_idents_hashrnd_extra,
 			    ip_idents_hashrnd);
 	id = ip_idents_reserve(hash, segs);
 	iph->id = htons(id);
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -546,12 +546,15 @@ static void ip6_copy_metadata(struct sk_
 static void ipv6_select_ident(struct frag_hdr *fhdr, struct rt6_info *rt)
 {
 	static u32 ip6_idents_hashrnd __read_mostly;
+	static u32 ip6_idents_hashrnd_extra __read_mostly;
 	u32 hash, id;
 
 	net_get_random_once(&ip6_idents_hashrnd, sizeof(ip6_idents_hashrnd));
+	net_get_random_once(&ip6_idents_hashrnd_extra, sizeof(ip6_idents_hashrnd_extra));
 
 	hash = __ipv6_addr_jhash(&rt->rt6i_dst.addr, ip6_idents_hashrnd);
 	hash = __ipv6_addr_jhash(&rt->rt6i_src.addr, hash);
+	hash = jhash_1word(hash, ip6_idents_hashrnd_extra);
 
 	id = ip_idents_reserve(hash, 1);
 	fhdr->identification = htonl(id);


