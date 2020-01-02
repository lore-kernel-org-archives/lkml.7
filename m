Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D705C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA44A20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005387;
	bh=x2lcTiBhOXdAVjBY0Kp+9U/6tGlDXi5779Q2NKQrz2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sP6Fry7nU4YAtb1MIatRjHRRZdaSF1KB88pJUDc481pbVqXqd27QQkRlXsaI7no2q
	 JKjQUWeGP+rxo7nCsI6qYQ+gQzfK2zZeuNUUGbf9TRSnKxq1P5Q68SL2+P+9/H+KUB
	 WqxzNyjkrm8DsziFF0lsfCtsNA0/E0txY+dpx3xE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgABWtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:49:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729638AbgABW00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:26:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 529F921835;
        Thu,  2 Jan 2020 22:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003985;
        bh=x2lcTiBhOXdAVjBY0Kp+9U/6tGlDXi5779Q2NKQrz2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQG/7kESuXlDG8nY3nMkfu/iApOebxuqwbPp4TAQy0T6lATN7wXZMk72tOmE85OYP
         qdeVizQ0RfxvjoOk8/S/YsKcmnM/ini6oA+Whzzc15H3XFtsr6EfaZ+ywcqwxezmG4
         wWefUhhHZSqXr96m3q7RDYopbBDAwDa0VCh4g9uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 81/91] gtp: do not confirm neighbor when do pmtu update
Date:   Thu,  2 Jan 2020 23:08:03 +0100
Message-Id: <20200102220450.102582634@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 6e9105c73f8d2163d12d5dfd762fd75483ed30f5 ]

When do IPv6 tunnel PMTU update and calls __ip6_rt_update_pmtu() in the end,
we should not call dst_confirm_neigh() as there is no two-way communication.

Although GTP only support ipv4 right now, and __ip_rt_update_pmtu() does not
call dst_confirm_neigh(), we still set it to false to keep consistency with
IPv6 code.

v5: No change.
v4: No change.
v3: Do not remove dst_confirm_neigh, but add a new bool parameter in
    dst_ops.update_pmtu to control whether we should do neighbor confirm.
    Also split the big patch to small ones for each area.
v2: Remove dst_confirm_neigh in __ip6_rt_update_pmtu.

Reviewed-by: Guillaume Nault <gnault@redhat.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/gtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 9e3963f46458..d957ffdfec0f 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -545,7 +545,7 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 		mtu = dst_mtu(&rt->dst);
 	}
 
-	rt->dst.ops->update_pmtu(&rt->dst, NULL, skb, mtu, true);
+	rt->dst.ops->update_pmtu(&rt->dst, NULL, skb, mtu, false);
 
 	if (!skb_is_gso(skb) && (iph->frag_off & htons(IP_DF)) &&
 	    mtu < ntohs(iph->tot_len)) {
-- 
2.20.1



