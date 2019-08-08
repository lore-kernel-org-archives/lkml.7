Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DBAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2800121882
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291352;
	bh=L1UbzN2FbxpMe/YNMfeHccBGcpbxvsiodflnULxUm50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u9UmK0sur6akC1OduD94kEQqMyKAZFntwXlFQXgtLZ+FEN+/IFgSu/mtCs6QgxJTI
	 9dXZhUv3Y3rsqIGRD+f4dwylrwL0pwJIqdZFtPkfuvWHEcUbylbCl9KE9IAqAFMm7x
	 Rg+IM2q8Dafol1Y0zMPECrv32JLCIf+3mRt5siK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404640AbfHHTJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405045AbfHHTJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:09:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FA5021874;
        Thu,  8 Aug 2019 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291346;
        bh=L1UbzN2FbxpMe/YNMfeHccBGcpbxvsiodflnULxUm50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qiqFXIDkkAnTUbC3AMUEFPBclya98BzADmMTTDWBoTkAAKwSEaPOnJ/1fPxLB4VV8
         fVz0iRcPIBfPId5Sg/1EHc514J3G3T4eyvL/S+6ge+7RDEAAB/sbSt5LuQLHcrednF
         +6rcE2UY6RE85E6fbMhuWijEfAxL5sQxJDkHW6vw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 17/45] ipip: validate header length in ipip_tunnel_xmit
Date:   Thu,  8 Aug 2019 21:05:03 +0200
Message-Id: <20190808190454.703655997@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190453.827571908@linuxfoundation.org>
References: <20190808190453.827571908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit 47d858d0bdcd47cc1c6c9eeca91b091dd9e55637 ]

We need the same checks introduced by commit cb9f1b783850
("ip: validate header length on virtual device xmit") for
ipip tunnel.

Fixes: cb9f1b783850b ("ip: validate header length on virtual device xmit")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ipip.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -281,6 +281,9 @@ static netdev_tx_t ipip_tunnel_xmit(stru
 	const struct iphdr  *tiph = &tunnel->parms.iph;
 	u8 ipproto;
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_error;
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		ipproto = IPPROTO_IPIP;


