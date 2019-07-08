Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C43C606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5592166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562598998;
	bh=udHj6L7oj91gY5v1/CPLP4scAiCxc6ToXIGOAqToVz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fWflUiFKNlLvn995xZ1AXfrISNrxT1tU+/hr2z1QQi5IY1vmZzWzi/JGBYKk0AiCb
	 RDCZSP+UySOY1HfWJc3Feu0Kd0B7D38IjM7W/tu2YDYYKoWbrehwPBtYkixM/OJGqU
	 SBJKA9+FIc8Sn6sVLsYBIVXv1dDHURWiL0r/07xM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfGHPQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732599AbfGHPQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:16:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41092214C6;
        Mon,  8 Jul 2019 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562598993;
        bh=udHj6L7oj91gY5v1/CPLP4scAiCxc6ToXIGOAqToVz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e4tOKoecyrydO5meVe/lLg6o3JXF0JwsRPRyAAdS4BY20cTJcHWWOkXz2Y1koGNKl
         Nm52KUI1ou8XfEbX0NVV9JNfHsOnlCU34OGgtUUorVaSKUFKZMSGPZmOP2PuJzdQqT
         HOOaFWms1hh2+SWVsKV/Q1AQmeJESuZcSi8IjGjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 43/73] team: Always enable vlan tx offload
Date:   Mon,  8 Jul 2019 17:12:53 +0200
Message-Id: <20190708150523.644728335@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit ee4297420d56a0033a8593e80b33fcc93fda8509 ]

We should rather have vlan_tci filled all the way down
to the transmitting netdevice and let it do the hw/sw
vlan implementation.

Suggested-by: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2091,12 +2091,12 @@ static void team_setup(struct net_device
 	dev->features |= NETIF_F_NETNS_LOCAL;
 
 	dev->hw_features = TEAM_VLAN_FEATURES |
-			   NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	dev->hw_features &= ~(NETIF_F_ALL_CSUM & ~NETIF_F_HW_CSUM);
 	dev->features |= dev->hw_features;
+	dev->features |= NETIF_F_HW_VLAN_CTAG_TX;
 }
 
 static int team_newlink(struct net *src_net, struct net_device *dev,


