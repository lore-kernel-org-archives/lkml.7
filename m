Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C7BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19E023430
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494682;
	bh=1dcMSu4TAYul7LkH8fqne0TvbN4f4LdLMSu1D9WanJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ibYZUiguiO9R2Gb6eTXF2hwEaXOvOJ9hJu9U8O3xgSo/o+/CXz/6hGiZd64qK1TMd
	 ZqIr933P/OQmkQG3Un/k+e02NzXeXnimKTvms6ci2hxDp0inMKVRytolLY34M2hgND
	 07FuP8s1Yfh42H40XOv+4iVfICoBdlPT8ynXz9hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404287AbfHVRYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391343AbfHVRYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:20 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E09523400;
        Thu, 22 Aug 2019 17:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494660;
        bh=1dcMSu4TAYul7LkH8fqne0TvbN4f4LdLMSu1D9WanJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8RMHExOe975msVQlplC5ZbeRMYLEyQf9LK9dHw/Yhoq1VEsc6xjeTzyBoZUy7qxq
         8hsEGGgBUCtvmkivr58GjD91Y2D63ymKI50iQAcBh0tG9yZ0BPE1ujBymqYP2l4YdM
         qlMpJY0d9moFFml5Kw6gCAtyC5BcLCXcV2BaFOEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 102/103] team: Add vlan tx offload to hw_enc_features
Date:   Thu, 22 Aug 2019 10:19:30 -0700
Message-Id: <20190822171733.272845410@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 227f2f030e28d8783c3d10ce70ff4ba79cad653f ]

We should also enable team's vlan tx offload in hw_enc_features,
pass the vlan packets to the slave devices with vlan tci, let the
slave handle vlan tunneling offload implementation.

Fixes: 3268e5cb494d ("team: Advertise tunneling offload features")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1014,7 +1014,9 @@ static void ___team_compute_features(str
 	}
 
 	team->dev->vlan_features = vlan_features;
-	team->dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL;
+	team->dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+				     NETIF_F_HW_VLAN_CTAG_TX |
+				     NETIF_F_HW_VLAN_STAG_TX;
 	team->dev->hard_header_len = max_hard_header_len;
 
 	team->dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;


