Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF075C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8331A21928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568930796;
	bh=0/tNebC7ygoIW5O3RIgQ+uWeQuh9LbW8bEVkAtHUGWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BG+T8+gri5PkRRTTe82HIVUcC19H/sqDkBTUnoygNQcOovloXtB7M1qm9LwYkb9yy
	 6KV4sY8ieCA9kxTPF3FvOQJdl99Vh77wszhng/9avoqjb4QXZNIye7Pcar7x2kTPXo
	 NrZkkE0LiHWbhW+ih68YFk1ogPtGY2RCT/PI+5Do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405238AbfISWGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405208AbfISWG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:06:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88ABA218AF;
        Thu, 19 Sep 2019 22:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930787;
        bh=0/tNebC7ygoIW5O3RIgQ+uWeQuh9LbW8bEVkAtHUGWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzelEI8DPQtn/rrgyauLiKqyBAm4FA6uaOB14kZZOLlQauaoP+bLLkgDawBeJoJwy
         pbsHN3iTG1iwQzwTZu2p8m1TpaoLMW69A3+3OkjN5wLUvJMJni41hXXUKDrhcSEE/5
         XRWz3yLR+ODZhY/RhSd6PeNn76VqRKHIRFFOBGac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 014/124] net: aquantia: fix limit of vlan filters
Date:   Fri, 20 Sep 2019 00:01:42 +0200
Message-Id: <20190919214819.655833034@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>

commit 392349f60110dc2c3daf86464fd926afc53d6143 upstream.

Fix a limit condition of vlans on the interface before setting vlan
promiscuous mode

Fixes: 48dd73d08d4dd ("net: aquantia: fix vlans not working over bridged network")
Signed-off-by: Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/aquantia/atlantic/aq_filters.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
@@ -843,7 +843,7 @@ int aq_filters_vlans_update(struct aq_ni
 		return err;
 
 	if (aq_nic->ndev->features & NETIF_F_HW_VLAN_CTAG_FILTER) {
-		if (hweight < AQ_VLAN_MAX_FILTERS && hweight > 0) {
+		if (hweight <= AQ_VLAN_MAX_FILTERS && hweight > 0) {
 			err = aq_hw_ops->hw_filter_vlan_ctrl(aq_hw,
 				!(aq_nic->packet_filter & IFF_PROMISC));
 			aq_nic->aq_nic_cfg.is_vlan_force_promisc = false;


