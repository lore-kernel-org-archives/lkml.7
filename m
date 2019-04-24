Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51715C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5E321903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127004;
	bh=EuVWkD67kxegWhxG2DOu8oi0L29ungaCvfFS0ObD8zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0FGMWBKRDbXDWbHhU7f2Cv0MX+IghYYQ/+lKmivCVb1e88gXgTKZQkWkvTXLFyoLv
	 VyxuOxFy2lSQKjRlOXdTF/zTdcY+AhHO9khVysLZSxQDtLZtJaewfOZTkWpQQSFPX2
	 yWde4757DayKg+B5bLQ+cU0zRue580N/Es4qvWXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390910AbfDXRaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:30:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390901AbfDXR35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:57 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B5D21903;
        Wed, 24 Apr 2019 17:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126996;
        bh=EuVWkD67kxegWhxG2DOu8oi0L29ungaCvfFS0ObD8zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q8wY8CY+vRTNYRso4w5leyCigeQ0UALbFNhT8hB7NRxPLmgB5T7BGYHSXhcsEEAey
         h65pu/nziMfQxAfPvsYUJahaDnz6juOcSRv9eAk0FU5zXsULdGeYmi02tewuO1ZvN0
         vHHVK5UE/kNnfZHbbNX35UHxjg0tnd5s8sRPe8LU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Louis Peens <louis.peens@netronome.com>
Subject: [PATCH 4.19 22/96] nfp: flower: replace CFI with vlan present
Date:   Wed, 24 Apr 2019 19:09:27 +0200
Message-Id: <20190424170921.348707009@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>

[ Upstream commit f7ee799a51ddbcc205ef615fe424fb5084e9e0aa ]

Replace vlan CFI bit with a vlan present bit that indicates the
presence of a vlan tag. Previously the driver incorrectly assumed
that an vlan id of 0 is not matchable, therefore we indicate vlan
presence with a vlan present bit.

Fixes: 5571e8c9f241 ("nfp: extend flower matching capabilities")
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
Signed-off-by: Louis Peens <louis.peens@netronome.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h  |    2 +-
 drivers/net/ethernet/netronome/nfp/flower/match.c |   14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/cmsg.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/cmsg.h
@@ -55,7 +55,7 @@
 #define NFP_FLOWER_LAYER2_GENEVE_OP	BIT(6)
 
 #define NFP_FLOWER_MASK_VLAN_PRIO	GENMASK(15, 13)
-#define NFP_FLOWER_MASK_VLAN_CFI	BIT(12)
+#define NFP_FLOWER_MASK_VLAN_PRESENT	BIT(12)
 #define NFP_FLOWER_MASK_VLAN_VID	GENMASK(11, 0)
 
 #define NFP_FLOWER_MASK_MPLS_LB		GENMASK(31, 12)
--- a/drivers/net/ethernet/netronome/nfp/flower/match.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/match.c
@@ -56,14 +56,12 @@ nfp_flower_compile_meta_tci(struct nfp_f
 						      FLOW_DISSECTOR_KEY_VLAN,
 						      target);
 		/* Populate the tci field. */
-		if (flow_vlan->vlan_id || flow_vlan->vlan_priority) {
-			tmp_tci = FIELD_PREP(NFP_FLOWER_MASK_VLAN_PRIO,
-					     flow_vlan->vlan_priority) |
-				  FIELD_PREP(NFP_FLOWER_MASK_VLAN_VID,
-					     flow_vlan->vlan_id) |
-				  NFP_FLOWER_MASK_VLAN_CFI;
-			frame->tci = cpu_to_be16(tmp_tci);
-		}
+		tmp_tci = NFP_FLOWER_MASK_VLAN_PRESENT;
+		tmp_tci |= FIELD_PREP(NFP_FLOWER_MASK_VLAN_PRIO,
+				      flow_vlan->vlan_priority) |
+			   FIELD_PREP(NFP_FLOWER_MASK_VLAN_VID,
+				      flow_vlan->vlan_id);
+		frame->tci = cpu_to_be16(tmp_tci);
 	}
 }
 


