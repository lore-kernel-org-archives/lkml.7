Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEA5C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FA920C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RN61SRAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436582AbfHISgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:36:31 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:38458 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407406AbfHISgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:36:31 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9CBA0C0B9F;
        Fri,  9 Aug 2019 18:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1565375791; bh=nCNzho8v5alI/6i+1aHygJFRglDtTEl398Nq+I6/yIg=;
        h=From:To:Cc:Subject:Date:From;
        b=RN61SRAeyCRovJOdAw3w51pIzr4qX27Evn2Gxk1CVaM57hiZFcd9XGZUG/vwmBudU
         EC7v0tXdh6Y3nAn826Tmywch55W4daNIOp7Is1PWy9ANjOhLxHBfxLxAle+HWj8FAM
         BvucbXYt9OA4DKv/jvd9Qfc5lXmAdhNADV84ow6C0i1yaZP+Qw3ZreOSqLswCX42sS
         5tOwiEt7847Q+lkFRf+Kq0whtADYQ4VqBAAqncXm8CfQtUazD38g6WyqnCqlOByswC
         qwmdu4MAxM594bAQXHiuTb3dcSH2J61qbwq4h8bJxa4Q/qiKyhdBIAyXyf/36/MqcX
         b/DVojavfeMHg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4E0CAA0057;
        Fri,  9 Aug 2019 18:36:27 +0000 (UTC)
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
Subject: [PATCH net-next 00/12] net: stmmac: Improvements for -next
Date:   Fri,  9 Aug 2019 20:36:08 +0200
Message-Id: <cover.1565375521.git.joabreu@synopsys.com>
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

Jose Abreu (12):
  net: stmmac: Get correct timestamp values from XGMAC
  net: stmmac: Prepare to add Split Header support
  net: stmmac: xgmac: Correctly return that RX descriptor is not last
    one
  net: stmmac: Add Split Header support and enable it in XGMAC cores
  net: stmmac: Add a counter for Split Header packets
  net: stmmac: dwxgmac: Add Flexible PPS support
  net: stmmac: Add ethtool register dump for XGMAC cores
  net: stmmac: Add support for SA Insertion/Replacement in XGMAC cores
  net: stmmac: selftests: Add tests for SA Insertion/Replacement
  net: stmmac: xgmac: Add EEE support
  net: stmmac: Add support for VLAN Insertion Offload
  net: stmmac: selftests: Add selftest for VLAN TX Offload

 drivers/net/ethernet/stmicro/stmmac/common.h       |  10 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  56 ++++
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 189 +++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |  88 ++++++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  31 ++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  30 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  10 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  25 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 282 ++++++++++++++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c | 194 +++++++++++++-
 10 files changed, 824 insertions(+), 91 deletions(-)

-- 
2.7.4

