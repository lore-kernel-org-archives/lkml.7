Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C42C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85192085A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfEIONL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:13:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46912 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbfEIONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:13:10 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hOjnI-000124-Gr; Thu, 09 May 2019 15:13:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hOjnI-0006M0-Ae; Thu, 09 May 2019 15:13:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Amit Klein" <aksecurity@gmail.com>
Date:   Thu, 09 May 2019 15:08:17 +0100
Message-ID: <lsq.1557410897.931368180@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 03/10] inet: update the IP ID generation algorithm to
 higher standards.
In-Reply-To: <lsq.1557410896.171359878@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.67-rc1 review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/route.c      | 4 +++-
 net/ipv6/ip6_output.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -487,13 +487,15 @@ EXPORT_SYMBOL(ip_idents_reserve);
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
@@ -541,12 +541,15 @@ static void ip6_copy_metadata(struct sk_
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

