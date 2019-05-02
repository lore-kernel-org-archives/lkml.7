Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA48C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96620204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556812103;
	bh=NB++TD4k0RyFqmsC49wxFNlELGHFOpxdzABIcfI+bM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jBypUt/CxrxtnN/y8JQ6a7Q8oPD+zfg3FMAWJ48AlAfu0DWg0TiXhA8GFQzsuKDxE
	 oydd+iyM7jToaY+LK4+55xBB6CXZzDTwnHXyKzg0FKDzB+s/6NFFyWd1ulN1OaLcUv
	 l2MOrDmw0Lwkt3lqnnT31V9f97Bc4U94kwsNLciw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfEBPsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfEBPXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:23:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2566420449;
        Thu,  2 May 2019 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810603;
        bh=NB++TD4k0RyFqmsC49wxFNlELGHFOpxdzABIcfI+bM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JYphA+VsV6bcsSjCpqd8p4+mYsDYFWyMaw52Yi5kYNaLxnUdIOwBh//AbQbBklpP7
         NWsA+Qclifa5wROVpKfSrZvgEgP+7DHHUV6r/KwbKfdoqKR4/54DGuJzwqWEETbeC+
         R9e4/co4pzsuSzGrmGVJptUIlXzVaeuDwQIUJTh8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        "David S. Miller" <davem@davemloft.net>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.14 10/49] qlcnic: Avoid potential NULL pointer dereference
Date:   Thu,  2 May 2019 17:20:47 +0200
Message-Id: <20190502143325.403863781@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143323.397051088@linuxfoundation.org>
References: <20190502143323.397051088@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5bf7295fe34a5251b1d241b9736af4697b590670 ]

netdev_alloc_skb can fail and return a NULL pointer which is
dereferenced without a check. The patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
index 7f7deeaf1cf0..da042bc520d4 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
@@ -1047,6 +1047,8 @@ int qlcnic_do_lb_test(struct qlcnic_adapter *adapter, u8 mode)
 
 	for (i = 0; i < QLCNIC_NUM_ILB_PKT; i++) {
 		skb = netdev_alloc_skb(adapter->netdev, QLCNIC_ILB_PKT_SIZE);
+		if (!skb)
+			break;
 		qlcnic_create_loopback_buff(skb->data, adapter->mac_addr);
 		skb_put(skb, QLCNIC_ILB_PKT_SIZE);
 		adapter->ahw->diag_cnt = 0;
-- 
2.19.1



