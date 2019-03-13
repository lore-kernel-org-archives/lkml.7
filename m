Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6219C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B819E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505180;
	bh=a3h9aO/GM3yLJHir9bQTJp/R3upESQ8/xRzw8yRUKOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=brGCVMNPmUo/0CsSO1n7XIKvvEbgrMO12wm2UiRMQOwHeG24Wffhp5k5VfXPAcgsY
	 xeWFKbUoV7R9xap+HW7IbPCaqERdWGW8hRvpdpS0mVmDLyYc87qVKYD42D12DxbFOI
	 qT8SNbKzvLoBUvRIXKqEJmoI11nSKVaUQ29shQ3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfCMT0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbfCMTO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:14:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B392184E;
        Wed, 13 Mar 2019 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504495;
        bh=a3h9aO/GM3yLJHir9bQTJp/R3upESQ8/xRzw8yRUKOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BmpOn/uIkcVliKwPmPAIzVPMDk+4z4dAy4kB0cXRW0QdPjbjtL4uxc+uKaW8Kl6Ws
         Brey3A4fxJkVkL1YVj4G4hOQDEIBVgh3uDbYfqUX/h2oVeC2QwH9bV/7k82UuQQ6/d
         AU1WY3TLAqjSPln0vJukDft3USFrNY1T8NwptCds=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 45/48] bnxt_en: Wait longer for the firmware message response to complete.
Date:   Wed, 13 Mar 2019 15:12:47 -0400
Message-Id: <20190313191250.158955-45-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 0000b81a063b5f3ab82fa18041c28327ce72c312 ]

The code waits up to 20 usec for the firmware response to complete
once we've seen the valid response header in the buffer.  It turns
out that in some scenarios, this wait time is not long enough.
Extend it to 150 usec and use usleep_range() instead of udelay().

Fixes: 9751e8e71487 ("bnxt_en: reduce timeout on initial HWRM calls")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 63b97289f4fe..0bd93bb7d1a2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3565,7 +3565,7 @@ static int bnxt_hwrm_do_send_msg(struct bnxt *bp, void *msg, u32 msg_len,
 			dma_rmb();
 			if (*valid)
 				break;
-			udelay(1);
+			usleep_range(1, 5);
 		}
 
 		if (j >= HWRM_VALID_BIT_DELAY_USEC) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index bde384630a75..cf2d4a6583d5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -548,7 +548,7 @@ struct rx_tpa_end_cmp_ext {
 	(HWRM_SHORT_TIMEOUT_COUNTER * HWRM_SHORT_MIN_TIMEOUT +		\
 	 ((n) - HWRM_SHORT_TIMEOUT_COUNTER) * HWRM_MIN_TIMEOUT))
 
-#define HWRM_VALID_BIT_DELAY_USEC	20
+#define HWRM_VALID_BIT_DELAY_USEC	150
 
 #define BNXT_RX_EVENT	1
 #define BNXT_AGG_EVENT	2
-- 
2.19.1

