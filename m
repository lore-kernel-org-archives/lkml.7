Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324E6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0330C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127293;
	bh=na+Q/5toPnZHHchn+9geosB5UDql8b/5wGrhfPhGrZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bpsEJG7xMBhqBtE9UXHNL2Fs/zXp5jPC31QuPgScCib03tx0w7KmqXL+3BH/lg5Va
	 kXtt+XOvF1YzUowvU2+BVzq+zY/grigrhQzObBjB547BML3o7GW5FF5gyR81F7u4h4
	 SI2EeyRAAMnAeUUTDiqFElok3r9g1EwIyEDSd2IQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391795AbfDXRev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391390AbfDXRer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:34:47 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 902EF2054F;
        Wed, 24 Apr 2019 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127287;
        bh=na+Q/5toPnZHHchn+9geosB5UDql8b/5wGrhfPhGrZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gnok9bb7t3qgxFTrCHdAhcwxgnaOoxOYcwQuOsYTap2QM81wY9hBjrrK8/i00SbPf
         hOuUrqkUQsYx7EP2p1iJCZ5mxsgVkrNPqDHX5pTE/yK1lG4sVH23kOz8EAMUhQbwRT
         yzLopEu+t5hqT7AT2BsKHf7QO26C3xiBSRD9YHjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Louis Peens <louis.peens@netronome.com>
Subject: [PATCH 5.0 037/115] nfp: flower: replace CFI with vlan present
Date:   Wed, 24 Apr 2019 19:09:33 +0200
Message-Id: <20190424170927.229794578@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
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
@@ -26,7 +26,7 @@
 #define NFP_FLOWER_LAYER2_GENEVE_OP	BIT(6)
 
 #define NFP_FLOWER_MASK_VLAN_PRIO	GENMASK(15, 13)
-#define NFP_FLOWER_MASK_VLAN_CFI	BIT(12)
+#define NFP_FLOWER_MASK_VLAN_PRESENT	BIT(12)
 #define NFP_FLOWER_MASK_VLAN_VID	GENMASK(11, 0)
 
 #define NFP_FLOWER_MASK_MPLS_LB		GENMASK(31, 12)
--- a/drivers/net/ethernet/netronome/nfp/flower/match.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/match.c
@@ -26,14 +26,12 @@ nfp_flower_compile_meta_tci(struct nfp_f
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
 


