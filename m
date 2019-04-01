Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C2521929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138811;
	bh=ULPrIft/jH73DkDREv25YbkYFGfySPDqvMEPeJKhlSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yW9WHfFxqkoGfAmy20rpvtKeXsakM8i6EbAOaDWOaSgi9uVxs2Vo0BbLhVbCFVUqH
	 3XIipJ42wh9O1QyZ39qkTBWrGpwB0+PU2dMUl7bSTscVeAKo3mCqoX3foSzIuEa/J4
	 D2KxueKrPHhNOVpSngYK6/8vK/QRTp8kNS8eHMvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfDARN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730559AbfDARN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 974A021929;
        Mon,  1 Apr 2019 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138806;
        bh=ULPrIft/jH73DkDREv25YbkYFGfySPDqvMEPeJKhlSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfH+WsBXskVsvqeFVBujQlgsE3okhW8eXDkuPj0U9s3g9TUvNtKFh+Ia43NuPQI87
         vP69LRDq5yIR7t0qaMjiAcxg0d9939coC1a8/ez1vjQPTlpq2HUV9zCD51TyiPPdsd
         NczJUbvCY2bNYVsPK+WV3Q53OsJbgi4syjwPDSAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 026/134] vrf: prevent adding upper devices
Date:   Mon,  1 Apr 2019 19:01:02 +0200
Message-Id: <20190401170046.988482453@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 1017e0987117c32783ba7c10fe2e7ff1456ba1dc ]

VRF devices don't work with upper devices. Currently, it's possible to
add a VRF device to a bridge or team, and to create macvlan, macsec, or
ipvlan devices on top of a VRF (bond and vlan are prevented respectively
by the lack of an ndo_set_mac_address op and the NETIF_F_VLAN_CHALLENGED
feature flag).

Fix this by setting the IFF_NO_RX_HANDLER flag (introduced in commit
f5426250a6ec ("net: introduce IFF_NO_RX_HANDLER")).

Cc: David Ahern <dsahern@gmail.com>
Fixes: 193125dbd8eb ("net: Introduce VRF device driver")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vrf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1262,6 +1262,7 @@ static void vrf_setup(struct net_device
 
 	/* default to no qdisc; user can add if desired */
 	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_NO_RX_HANDLER;
 }
 
 static int vrf_validate(struct nlattr *tb[], struct nlattr *data[],


