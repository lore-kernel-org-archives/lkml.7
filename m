Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4DDC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A960920675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbfETK2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:28:06 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:56274 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbfETK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:28:05 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hSfWU-0008HV-Ud; Mon, 20 May 2019 12:28:03 +0200
Date:   Mon, 20 May 2019 12:28:02 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Marc Haber <mh+netdev@zugschlus.de>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Kernel 5.1 breaks UDP checksums for SIP packets
Message-ID: <20190520102802.vv3xyd2p7ei4j65r@breakpoint.cc>
References: <20190520094955.GA6502@torres.zugschlus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520094955.GA6502@torres.zugschlus.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Haber <mh+netdev@zugschlus.de> wrote:
> when I update my Firewall from Kernel 5.0 to Kernel 5.1, SIP clients
> that connect from the internal network to an external, commercial SIP
> service do not work any more. When I trace beyond the NAT, I see that
> the outgoing SIP packets have incorrect UDP checksums:

I'm a moron.  Can you please try this patch?

diff --git a/net/netfilter/nf_nat_helper.c b/net/netfilter/nf_nat_helper.c
--- a/net/netfilter/nf_nat_helper.c
+++ b/net/netfilter/nf_nat_helper.c
@@ -170,7 +170,7 @@ nf_nat_mangle_udp_packet(struct sk_buff *skb,
 	if (!udph->check && skb->ip_summed != CHECKSUM_PARTIAL)
 		return true;
 
-	nf_nat_csum_recalc(skb, nf_ct_l3num(ct), IPPROTO_TCP,
+	nf_nat_csum_recalc(skb, nf_ct_l3num(ct), IPPROTO_UDP,
 			   udph, &udph->check, datalen, oldlen);
 
 	return true;
