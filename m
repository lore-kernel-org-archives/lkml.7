Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E6BC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED47420881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfD1GbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:31:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25383 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726377AbfD1Gah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:30:37 -0400
X-UUID: 6c5966069a4845cab561a516e1268478-20190428
X-UUID: 6c5966069a4845cab561a516e1268478-20190428
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1712772735; Sun, 28 Apr 2019 14:30:28 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 28 Apr 2019 14:30:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 28 Apr 2019 14:30:26 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     Jose Abreu <joabreu@synopsys.com>, <davem@davemloft.net>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yt.shen@mediatek.com>,
        <biao.huang@mediatek.com>, <jianguo.zhang@mediatek.com>
Subject: [PATCH 0/6] fix some bugs and add some features in stmmac
Date:   Sun, 28 Apr 2019 14:30:03 +0800
Message-ID: <1556433009-25759-1-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fix some bugs and add some features in stmmac driver.               
5 patches are for common stmmac or dwmac4:                                      
        1. update rx tail pointer to fix rx dma hang issue.                     
        2. change condition for mdc clock to fix csr_clk can't be zero issue.   
        3. write the modified value back to MTL_OPERATION_MODE.                 
        4. add support for hash table size 128/256                              
        5. add mdio clause 45 access from mac device for dwmac4.                
1 patche is for dwmac-mediatek:                                                 
        1. modify csr_clk value to fix mdio read/write fail issue for dwmac-mediatek.
                                                                                
Biao Huang (6):                                                                 
  net: stmmac: update rx tail pointer register to fix rx dma hang               
    issue.                                                                      
  net: stmmac: fix csr_clk can't be zero issue                                  
  net: stmmac: write the modified value back to MTL_OPERATION_MODE              
  net: stmmac: add support for hash table size 128/256 in dwmac4                
  net: stmmac: add mdio clause 45 access from mac device for dwmac4             
  stmmac: dwmac-mediatek: modify csr_clk value to fix mdio read/write           
    fail                                                                        
                                                                                
 drivers/net/ethernet/stmicro/stmmac/common.h       |   18 ++-                  
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |    4 +-                   
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |    4 +-                   
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   55 ++++---              
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |    1 +                    
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    9 +-                   
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |  167 ++++++++++++++++++-- 
 7 files changed, 213 insertions(+), 45 deletions(-)                            
                                                                                
--                                                                              
1.7.9.5

