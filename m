Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C17FFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397FE21D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YvwaGM8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436589AbfJPSUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:20:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58046 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436567AbfJPST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:19:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GIJuV4028038;
        Wed, 16 Oct 2019 13:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571249996;
        bh=/ChmFDql8zNtnRIKsf8+9j23q+q3h1gjoj0SqTaGnco=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YvwaGM8inYpgKzEc33dax49Mo9ULeCezJiByf2b2FFQr2lqM1GngjAm9cpvCDxgqu
         l7yLZBWisdwSCI1moixqh7kGKSiaSc4OcGogLFyQMrxKMLUjp03mc/q2GPfyB2Sdrt
         p2kNYyUCxYeIjDN+TQQ/iue45YngtlmAk10jz040=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GIJtxq033711
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 13:19:56 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 13:19:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 13:19:55 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GIJtrW074704;
        Wed, 16 Oct 2019 13:19:55 -0500
Received: from localhost ([10.250.79.55])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x9GIJsZ07956;
        Wed, 16 Oct 2019 13:19:54 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Jiri Kosina <trivial@kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 09/10] ixgbe: Remove unneeded conversions to bool
Date:   Wed, 16 Oct 2019 14:19:43 -0400
Message-ID: <20191016181944.25106-6-afd@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016181944.25106-1-afd@ti.com>
References: <20191016181944.25106-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found with scripts/coccinelle/misc/boolconv.cocci.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 0bd1294ba517..2d896d663e3d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -64,8 +64,7 @@ bool ixgbe_device_supports_autoneg_fc(struct ixgbe_hw *hw)
 			hw->mac.ops.check_link(hw, &speed, &link_up, false);
 			/* if link is down, assume supported */
 			if (link_up)
-				supported = speed == IXGBE_LINK_SPEED_1GB_FULL ?
-				true : false;
+				supported = speed == IXGBE_LINK_SPEED_1GB_FULL;
 			else
 				supported = true;
 		}
-- 
2.17.1

