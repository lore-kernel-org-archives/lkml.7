Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF5EC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB56214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498350;
	bh=jpbIPP49zvHFC2TMrGanJSqYYGPqKzLDrVU9Or1jmEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RQ7erOEw7jpvbxUu8dlKBNZUDH2tdiDW1iX3dHKKBxCA8HyYF80y0TQXNNeQgTOvO
	 i/d4Qf3BYzCzOFUIkm7kva+Abf2xP3fvRV75VtLybSI+vHwxEt96e1BIaakK5UiRL6
	 HSDQeVHKcYqi8O2D+W2CrcUfQ3ZmZtaKDtqFXXtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfKKSw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:52:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729608AbfKKSw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:52:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C97E214E0;
        Mon, 11 Nov 2019 18:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498346;
        bh=jpbIPP49zvHFC2TMrGanJSqYYGPqKzLDrVU9Or1jmEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ioFb8Cl9c4GfSESA0vP+eVSdva2JNMRZpTxDYi/bPnZmQBuzns8to8YO96pxYplgO
         7dJofPN+LnsEw8OnKxceHhqWBOOfncvSrV4rO060gCMZTySjVSvKD6biXNIAgRWrk7
         365L7GLPSGwA5QOHuJUDf3e9ZXp4A1FkSd/DNZ7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 093/193] bpf: lwtunnel: Fix reroute supplying invalid dst
Date:   Mon, 11 Nov 2019 19:27:55 +0100
Message-Id: <20191111181508.002089805@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Benc <jbenc@redhat.com>

[ Upstream commit 9e8acd9c44a0dd52b2922eeb82398c04e356c058 ]

The dst in bpf_input() has lwtstate field set. As it is of the
LWTUNNEL_ENCAP_BPF type, lwtstate->data is struct bpf_lwt. When the bpf
program returns BPF_LWT_REROUTE, ip_route_input_noref is directly called on
this skb. This causes invalid memory access, as ip_route_input_slow calls
skb_tunnel_info(skb) that expects the dst->lwstate->data to be
struct ip_tunnel_info. This results to struct bpf_lwt being accessed as
struct ip_tunnel_info.

Drop the dst before calling the IP route input functions (both for IPv4 and
IPv6).

Reported by KASAN.

Fixes: 3bd0b15281af ("bpf: add handling of BPF_LWT_REROUTE to lwt_bpf.c")
Signed-off-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Peter Oskolkov <posk@google.com>
Link: https://lore.kernel.org/bpf/111664d58fe4e9dd9c8014bb3d0b2dab93086a9e.1570609794.git.jbenc@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/lwt_bpf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index f93785e5833c1..74cfb8b5ab330 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -88,11 +88,16 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 	int err = -EINVAL;
 
 	if (skb->protocol == htons(ETH_P_IP)) {
+		struct net_device *dev = skb_dst(skb)->dev;
 		struct iphdr *iph = ip_hdr(skb);
 
+		dev_hold(dev);
+		skb_dst_drop(skb);
 		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					   iph->tos, skb_dst(skb)->dev);
+					   iph->tos, dev);
+		dev_put(dev);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		skb_dst_drop(skb);
 		err = ipv6_stub->ipv6_route_input(skb);
 	} else {
 		err = -EAFNOSUPPORT;
-- 
2.20.1



