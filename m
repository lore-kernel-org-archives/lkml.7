Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0884C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B014E21738
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599265;
	bh=MHxrmQoo3AqSTpxnNMb+1VFS5VfTgF9vE/6eG3e2a64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qtuk8kJxexBzSsP5hjIfLKmTrPzHnnpEQoaDPu0CqHhCEi9xSsuqbHXX1KYdBWt9h
	 KVjxNaF8Y27Cpsa2LemSpF66fnaLABegPmHYyK8X9oFcD58pZ28WXgnVB9PbW+RfFx
	 1fUg2i1U5+MjCyTGt4ADyzRbMOmxZxI9NcmTJaD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfGHPVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387709AbfGHPVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:21:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB8B216FD;
        Mon,  8 Jul 2019 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599262;
        bh=MHxrmQoo3AqSTpxnNMb+1VFS5VfTgF9vE/6eG3e2a64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcruMpq1j6MkS6Io+acvFaU1GEVka7SbwZBPY2Wwc6Vos+cz/RC45eqe9ZmgDwvx5
         bHsTo/rCgIbhZNfk6tfSfEpLmx28DpgL+KujH7+hQoxBhRyuoMWnKBorjkPXHag8Z2
         V5den9ySCcLvz3tIAXBxCP5iG24GYrb7VsIvc1qo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 058/102] team: Always enable vlan tx offload
Date:   Mon,  8 Jul 2019 17:12:51 +0200
Message-Id: <20190708150529.455098887@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
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
@@ -2136,12 +2136,12 @@ static void team_setup(struct net_device
 	dev->features |= NETIF_F_NETNS_LOCAL;
 
 	dev->hw_features = TEAM_VLAN_FEATURES |
-			   NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_CTAG_RX |
 			   NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
 	dev->features |= dev->hw_features;
+	dev->features |= NETIF_F_HW_VLAN_CTAG_TX;
 }
 
 static int team_newlink(struct net *src_net, struct net_device *dev,


