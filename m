Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A13C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918962054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126812;
	bh=XwvjRGdv5jLgOatDCEKJUNJ+CJZ1fcoggod5B6x0hYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tiUOj2Cny+lo0INS2WNFHiWJxypX3i+W4C8+W+5IP+wZaRP+ufqCMy1/Hi3w9P+n5
	 Hcoj7bvOj7m7/6sxn9ligT0vLDqlZVgwf0hFLZRkiwbheQomPE3O8x7FkGjhNi7ee9
	 MoCMv45lCJF1/LX2mG50PVtwSwKBFeTRLrvl0SdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390312AbfDXR0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390259AbfDXR0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:26:48 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7939B2054F;
        Wed, 24 Apr 2019 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126808;
        bh=XwvjRGdv5jLgOatDCEKJUNJ+CJZ1fcoggod5B6x0hYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oong8BLdJaQj5kMc1JLCcMThPJ8Z8jxlNlRPmpbUFqL9XHUdU+AD8v+lpE+UhAeGx
         Oeamyn/rSol9L04ona+qEzYRgu8MLjtqFuQedC+yekmW3GpxB8kQIbUds985Zz+j3E
         GoNwilEywsNmfOqgreLXpq4L/Yw6FwpMlrH/vJw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 04/70] net: bridge: multicast: use rcu to access port list from br_multicast_start_querier
Date:   Wed, 24 Apr 2019 19:09:24 +0200
Message-Id: <20190424170907.791097008@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

[ Upstream commit c5b493ce192bd7a4e7bd073b5685aad121eeef82 ]

br_multicast_start_querier() walks over the port list but it can be
called from a timer with only multicast_lock held which doesn't protect
the port list, so use RCU to walk over it.

Fixes: c83b8fab06fc ("bridge: Restart queries when last querier expires")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_multicast.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2119,7 +2119,8 @@ static void br_multicast_start_querier(s
 
 	__br_multicast_open(br, query);
 
-	list_for_each_entry(port, &br->port_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &br->port_list, list) {
 		if (port->state == BR_STATE_DISABLED ||
 		    port->state == BR_STATE_BLOCKING)
 			continue;
@@ -2131,6 +2132,7 @@ static void br_multicast_start_querier(s
 			br_multicast_enable(&port->ip6_own_query);
 #endif
 	}
+	rcu_read_unlock();
 }
 
 int br_multicast_toggle(struct net_bridge *br, unsigned long val)


