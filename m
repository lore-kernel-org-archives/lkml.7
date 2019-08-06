Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D755BC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFEA20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UF/s6Itm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbfHFNm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:42:57 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:59074 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfHFNm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:42:56 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 31394C21AE;
        Tue,  6 Aug 2019 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1565098976; bh=g3fYN+8z/UxI7FeCuuLDjSYU9su9owSrWnBkpruQfVk=;
        h=From:To:Cc:Subject:Date:From;
        b=UF/s6Itmeojm8oETQnPHErGmMkvlb08dC+w1dnzGHFrL/riVd8JM6sKyJ3g8DGsVz
         CJkwybaxciRPAd1jUVTY4bt/wdNX8b6J2SzPfTh0Oo0EsxOhaqMs6ufEQFg6a1j4xl
         ZwWfbSebC8r1RcS6z906yKPdQehIG6j+3AVfi//hEbTUiNY6kOhSldocrHUCHU/+sJ
         HXApwwNQCP+Y2RQE0Sfbt08ciP1s/x+QCv2AvFyODtsmYC4/WbmoRLHWXLrXZAFQHs
         BVNyqzZ6kjSPtvJp/zX7bsVIpjPWhxCf/QxP0ItHfE+8XuO2PvQQ+aZC2kOyzrCeYP
         TxJIOoHwCn6Qg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id ADC9EA0057;
        Tue,  6 Aug 2019 13:42:53 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 00/10] net: stmmac: Improvements for -next
Date:   Tue,  6 Aug 2019 15:42:41 +0200
Message-Id: <cover.1565098881.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of improvements for -next tree. More info in commit logs.

---
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Jose Abreu (10):
  net: stmmac: xgmac: Implement MMC counters
  net: stmmac: xgmac: Implement set_mtl_tx_queue_weight()
  net: stmmac: xgmac: Implement tx_queue_prio()
  net: stmmac: Implement RSS and enable it in XGMAC core
  net: stmmac: selftests: Add RSS test
  net: stmmac: Implement VLAN Hash Filtering in XGMAC
  net: stmmac: selftests: Add test for VLAN and Double VLAN Filtering
  net: stmmac: Implement Safety Features in XGMAC core
  net: stmmac: Add Flexible RX Parser support in XGMAC
  net: stmmac: selftests: Add a selftest for Flexible RX Parser

 drivers/net/ethernet/stmicro/stmmac/common.h       |   6 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  76 ++-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 605 ++++++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |  29 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  10 +
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  17 +
 drivers/net/ethernet/stmicro/stmmac/mmc.h          |   9 +
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     | 192 +++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  11 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  81 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 120 +++-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c | 322 ++++++++++-
 include/linux/stmmac.h                             |   1 +
 14 files changed, 1474 insertions(+), 9 deletions(-)

-- 
2.7.4

