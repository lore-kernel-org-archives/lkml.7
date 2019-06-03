Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DA5C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2AE27F38
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553354;
	bh=v1u4WaibhGkT0QwhXbC4ebfZ3xPIoHuMkzdWT2zUeiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vkg6NKn0AdOJ9JQCWXzdMcu0+PKnsYbAm1bBoqSwZrPIsbXa7e/My1pD7Qzggx22d
	 80ZJlM+GUGxjV1l982un+vnMkeLcnrVbmrMmxin3Q1CngVFFhWovRZHOsgC6uoqNDg
	 d0CvG7ItkV1G7YQGfP2cerkZYiBdFaSVIcd1BSCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfFCJPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbfFCJNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:13:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3843B25B49;
        Mon,  3 Jun 2019 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553196;
        bh=v1u4WaibhGkT0QwhXbC4ebfZ3xPIoHuMkzdWT2zUeiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c3Vc2wRLaLzpPiunaTb/ouX6Ljzf44blbqxuDVtP0GfJJHcs78fWEXfMO5OVcb/K5
         N1uRwMZfVonPqB7h0odTAFgWA5ycUWg5ow0yjX9VcMnE1AcNDV2cqneShi9HZQ1hnP
         67cN2/TLg//SKXRcbdwG0Wdw0FdCMTjlTe/fz0cY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 02/40] cxgb4: offload VLAN flows regardless of VLAN ethtype
Date:   Mon,  3 Jun 2019 11:08:55 +0200
Message-Id: <20190603090522.767228340@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090522.617635820@linuxfoundation.org>
References: <20190603090522.617635820@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raju Rangoju <rajur@chelsio.com>

[ Upstream commit b5730061d1056abf317caea823b94d6e12b5b4f6 ]

VLAN flows never get offloaded unless ivlan_vld is set in filter spec.
It's not compulsory for vlan_ethtype to be set.

So, always enable ivlan_vld bit for offloading VLAN flows regardless of
vlan_ethtype is set or not.

Fixes: ad9af3e09c (cxgb4: add tc flower match support for vlan)
Signed-off-by: Raju Rangoju <rajur@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
@@ -197,6 +197,9 @@ static void cxgb4_process_flow_match(str
 		fs->val.ivlan = vlan_tci;
 		fs->mask.ivlan = vlan_tci_mask;
 
+		fs->val.ivlan_vld = 1;
+		fs->mask.ivlan_vld = 1;
+
 		/* Chelsio adapters use ivlan_vld bit to match vlan packets
 		 * as 802.1Q. Also, when vlan tag is present in packets,
 		 * ethtype match is used then to match on ethtype of inner
@@ -207,8 +210,6 @@ static void cxgb4_process_flow_match(str
 		 * ethtype value with ethtype of inner header.
 		 */
 		if (fs->val.ethtype == ETH_P_8021Q) {
-			fs->val.ivlan_vld = 1;
-			fs->mask.ivlan_vld = 1;
 			fs->val.ethtype = 0;
 			fs->mask.ethtype = 0;
 		}


