Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008FEC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC24221773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127730;
	bh=KAuRgvUmgcqmmJ99Kr1u16yCrcKg9w2QXpKshk1Is2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HeiOV5ZPoFh04fA0wHjgD8FL1PnRAbODX2SoyTPWRN1zeAfmWXe3kg1HugKkjnNDd
	 ftG+/0v+bIokuIu0dSIsDbUTxerV88vQDeGWIDFtAacQC58Reyf+VGojKmCFoWVG9N
	 mXylPoMAQcXWt4hlCVyUAp5XEeqPkUJ2PYkAPhh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392048AbfDXRgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390513AbfDXRgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:08 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6186D2054F;
        Wed, 24 Apr 2019 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127363;
        bh=KAuRgvUmgcqmmJ99Kr1u16yCrcKg9w2QXpKshk1Is2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oz14Ft+AMEi70kox60/LH5uB7etpHz3imQgBW690wSQugKTUjR8c43Rh0uqKZdAnM
         tDbTznH4dGKcwyX/guqZ6juZ3LnpZRT6si7UZUNbzdwUlZwgbGxlwHHPqr9mDCNE0c
         MPMZDnnw+mOo3tYMfeP4KKrICAIfKoFRVQElDrJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 026/115] net: bridge: fix netlink export of vlan_stats_per_port option
Date:   Wed, 24 Apr 2019 19:09:22 +0200
Message-Id: <20190424170926.574090713@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

[ Upstream commit 600bea7dba1a72874ae0cd9bc66bf2abfe43b49d ]

Since the introduction of the vlan_stats_per_port option the netlink
export of it has been broken since I made a typo and used the ifla
attribute instead of the bridge option to retrieve its state.
Sysfs export is fine, only netlink export has been affected.

Fixes: 9163a0fc1f0c0 ("net: bridge: add support for per-port vlan stats")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_netlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1441,7 +1441,7 @@ static int br_fill_info(struct sk_buff *
 	    nla_put_u8(skb, IFLA_BR_VLAN_STATS_ENABLED,
 		       br_opt_get(br, BROPT_VLAN_STATS_ENABLED)) ||
 	    nla_put_u8(skb, IFLA_BR_VLAN_STATS_PER_PORT,
-		       br_opt_get(br, IFLA_BR_VLAN_STATS_PER_PORT)))
+		       br_opt_get(br, BROPT_VLAN_STATS_PER_PORT)))
 		return -EMSGSIZE;
 #endif
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING


