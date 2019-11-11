Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03446C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EE3214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498109;
	bh=k87w9jQo4jl4H1STReJGVJk1oCFwtUoA02ot0Lfe2jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F7wedtzExg1lPI3OPD07hVN/lheKr0B8l8QAQ7bOUN32UhOOhBwkmXVWQ0RJmJBgr
	 HcJs7HiQy9dzO1KNkKSC494Py7pdwr0rZj3lCnst9/+YdaiDGl1DRRun4OI12Qrt4e
	 rXFuitH/qXsXBNWHu2YOLuaC2aF6pfMu8+Pdhtlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfKKSs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:48:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbfKKSsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:48:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA2920674;
        Mon, 11 Nov 2019 18:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498104;
        bh=k87w9jQo4jl4H1STReJGVJk1oCFwtUoA02ot0Lfe2jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vjgheSmcWEVlSRYzpN5vOacAXtcKW6IbgeUCz6sRU2IirKp43SDhPx6ez/ZTqkc3S
         N8/OHPhhuQhoLf8JVDxwTVSfPYBSKCIY8RtSzcsN7JAq6unWWJGYpoL56oJrSIb4DF
         Y6DVd/P+oGsjl33E7SgbnVcDzgXXHq35rzoZZrEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 004/193] net: ethernet: octeon_mgmt: Account for second possible VLAN header
Date:   Mon, 11 Nov 2019 19:26:26 +0100
Message-Id: <20191111181500.174903055@linuxfoundation.org>
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

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

[ Upstream commit e4dd5608033efe7b6030cde359bfdbaeb73bc22d ]

Octeon's input ring-buffer entry has 14 bits-wide size field, so to account
for second possible VLAN header max_mtu must be further reduced.

Fixes: 109cc16526c6d ("ethernet/cavium: use core min/max MTU checking")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -1499,7 +1499,7 @@ static int octeon_mgmt_probe(struct plat
 	netdev->ethtool_ops = &octeon_mgmt_ethtool_ops;
 
 	netdev->min_mtu = 64 - OCTEON_MGMT_RX_HEADROOM;
-	netdev->max_mtu = 16383 - OCTEON_MGMT_RX_HEADROOM;
+	netdev->max_mtu = 16383 - OCTEON_MGMT_RX_HEADROOM - VLAN_HLEN;
 
 	mac = of_get_mac_address(pdev->dev.of_node);
 


