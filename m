Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C40C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11C120675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fT4VkUb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfDQHnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:43:52 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:46336 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728108AbfDQHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:43:50 -0400
Received: from mailhost1.synopsys.com (us02-dmz-cl-eth-s1p4c0.internal.synopsys.com [10.12.241.126])
        by smtprelay-out1.synopsys.com (Postfix) with ESMTP id 3C9F6C0B16;
        Wed, 17 Apr 2019 07:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555486396; bh=YwRTRliRe35QaXc9TWma0CdZJr5VED6GbuAobjabqLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=fT4VkUb9IchzQnevK8aHRDlNo5kYBRgzoN21KGwO04IJ6A9QAMnL3amlPST2SIxGu
         wECROyJdQp457D762suH75dEvXfjWyFm3eA2yBEAr/Q1T+JNZUbUZguSZyykh8lQzi
         sq4lhx/MA1iJrgjbBp4uWIuCbHRCCPhBp+Pw1D7jDYcbr/CxtXJ3/0b5gIt4HcNebR
         OX+qMpHKWX9FEnAAm940qV7e4OCl7YhWFf/hm53wQaeN8AVrbQLQJaF72p8jNFLMVn
         FmkjkVGUfDJno9M5z/zuxDtV+2cL5nLX8cL+rVrJa1KQenZr9KupFrjnf8qFSyfOyp
         AguxcW9ra4AUA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id E4A9D501F;
        Wed, 17 Apr 2019 00:33:14 -0700 (PDT)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next 2/2] net: stmmac: Set Flow Control to automatic mode in the driver
Date:   Wed, 17 Apr 2019 09:33:05 +0200
Message-Id: <62d330a2767a87367a9082116999158b442f65f0.1555486210.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1555486210.git.joabreu@synopsys.com>
References: <cover.1555486210.git.joabreu@synopsys.com>
In-Reply-To: <cover.1555486210.git.joabreu@synopsys.com>
References: <cover.1555486210.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default Flow Control feature is not being enabled in stmmac.

This is a useful feature that can prevent loss of packets and now that
XGMAC already supports it (along with GMAC and QoS) it makes sense to
activate it.

Switch the module parameter to FLOW_AUTO so that Flow Control is
activated.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a26e36dbb5df..7a895a2889e3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -74,7 +74,7 @@ MODULE_PARM_DESC(phyaddr, "Physical device address");
 #define STMMAC_TX_THRESH	(DMA_TX_SIZE / 4)
 #define STMMAC_RX_THRESH	(DMA_RX_SIZE / 4)
 
-static int flow_ctrl = FLOW_OFF;
+static int flow_ctrl = FLOW_AUTO;
 module_param(flow_ctrl, int, 0644);
 MODULE_PARM_DESC(flow_ctrl, "Flow control ability [on/off]");
 
-- 
2.7.4

