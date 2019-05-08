Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB8BC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EEF20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LPDtNyGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfEHHv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:51:59 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:56534 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726487AbfEHHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:51:30 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3F18AC00F4;
        Wed,  8 May 2019 07:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557301893; bh=ba+qVB/NWZuxByW3v1MuTmJSb5+zgkCiAXkRuR1pCXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=LPDtNyGvr3bLTHU61G9pW0kuZeHee47+Ma4KgbyzeIxx2kmP2OZBJ7/alBAxA7OHd
         gUNjpmUGKhfojlljUJtllw3SC7VRttKcFax+8FckY2Qr0XiWv8uUoNky0eUqNOgsdz
         2kUQ4BNcdytycbHyLsEnYcEOLpFCv1hnvWSSFFYCj0ic3HHuAvuVQVY77VHyt9Ext1
         +F9f/AMtw1zXTVBRYtfh64I53f42c58iEnFfe4oxjqF93WkubJp4UXEeuYXBEjGUye
         I+3y2sayEeI8w2iZtzXZt6Y7ZkhFSEdMu6fc1kd2jmSw6fTGc5cDJv8XdkW8NEFAKh
         3JoGR29IqZ6fw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7CD9FA02D5;
        Wed,  8 May 2019 07:51:29 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 26FD43D538;
        Wed,  8 May 2019 09:51:28 +0200 (CEST)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next 11/11] net: stmmac: dwmac1000: Fix Hash Filter
Date:   Wed,  8 May 2019 09:51:11 +0200
Message-Id: <f924be1546ec47ddb25b5b31aebd66e78eab4d3a.1557300602.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1557300602.git.joabreu@synopsys.com>
References: <cover.1557300602.git.joabreu@synopsys.com>
In-Reply-To: <cover.1557300602.git.joabreu@synopsys.com>
References: <cover.1557300602.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for hash filter to work we need to set the HPF bit.

Found out while running stmmac selftests.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 8ca73bd15e07..bc91af6c01b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -198,6 +198,7 @@ static void dwmac1000_set_filter(struct mac_device_info *hw,
 		}
 	}
 
+	value |= GMAC_FRAME_FILTER_HPF;
 	dwmac1000_set_mchash(ioaddr, mc_filter, mcbitslog2);
 
 	/* Handle multiple unicast addresses (perfect filtering) */
-- 
2.7.4

