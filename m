Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDC5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95E3212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VaMMF9tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfDZRMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:12:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37382 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfDZRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:12:51 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3QHCjR6105144;
        Fri, 26 Apr 2019 12:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556298765;
        bh=Bz4Ll7VXb7oya22ulDFsqlTo5sCT9i/aXgS9BcVlP0Q=;
        h=From:To:CC:Subject:Date;
        b=VaMMF9tjBdC5TZp5kcv53+GMs3IL9pKxWx6ICJcuwWNpSwQlIrOx/yWGGB9c5S4JU
         2AW8KmO/1doSO+rXfCw6jBsco8eBPH0+vSGD6HBZs/xLX4K1Y5p33IOosquTTf4isZ
         xfxJLsw0LzxITndf+yEzOHZbUdalddTAtLwq/xEY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3QHCjJe029555
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Apr 2019 12:12:45 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 26
 Apr 2019 12:12:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 26 Apr 2019 12:12:45 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3QHCilT090997;
        Fri, 26 Apr 2019 12:12:44 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next v2 00/20] net: ethernet: ti: clean up and optimizations
Date:   Fri, 26 Apr 2019 20:12:22 +0300
Message-ID: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is a preparation series for introducing new switchbase TI CPSW driver which
was originally introduced [1][2] by Ilias Apalodimas <ilias.apalodimas@linaro.org> 
and also discussed in private mails and at Netdev x13 confernce.

Following discussions and suggestions (mostly by Andrew and Ivan) we going
to introduce the new driver which is operating in dual-emac mode
by default, thus working as 2 individual network interfaces.
When both interfaces joined the bridge - CPSW driver will enter a switch
mode and discard dual_mac configuration. The CPSW will be switched back
to dual_mac mode if any port leaves the bridge. All configuration is going to be
implemented via switchdev API.

Hence overall change is already very big I'm sending prerequisite patches which
are mostly minor fixes/clean ups and code refactoring to separate common parts
to be reused by both drivers.
Probably the most serious change from functional point of view is Patch 11.

These patches were NFS boot tetested on TI AM335x/AM437x/AM5xx boards.

These patches can be found at:
 git@git.ti.com:~gragst/ti-linux-kernel/gragsts-ti-linux-kernel.git
 branch: lkml-5.1-cpsw-clean-up-v2

changes in v2:
- added new patch 16 to get rid of force type conversation
- other chages metioned in patches

Grygorii Strashko (20):
  net: ethernet: ti: convert to SPDX license identifiers
  net: ethernet: ti: cpsw: drop TI_DAVINCI_CPDMA config option
  net: ethernet: ti: cpsw: drop CONFIG_TI_CPSW_ALE config option
  net: ethernet: ti: cpsw: update cpsw_split_res() to accept cpsw_common
  net: ethernet: ti: cpsw: use local var dev in probe
  net: ethernet: ti: cpsw: drop pinctrl_pm_select_default_state call
  net: ethernet: ti: cpsw: use devm_alloc_etherdev_mqs()
  net: ethernet: ti: cpsw: drop cpsw_tx_packet_submit()
  net: ethernet: ti: ale: fix mcast super setting
  net: ethernet: ti: ale: use define for host port in
    cpsw_ale_set_allmulti()
  net: ethernet: ti: cpsw: fix allmulti cfg in dual_mac mode
  net: ethernet: ti: ale: do not auto delete mcast super entries
  net: ethernet: ti: davinci_mdio: use devm_ioremap()
  net: ethernet: ti: cpsw: refactor probe to group common hw
    initialization
  net: ethernet: ti: cpsw: move cpsw definitions in priv header
  net: ethernet: ti: davinci_cpdma: use dma_addr_t for desc_mem_phys and
    desc_hw_addr
  net: ethernet: ti: cpsw: move common hw init code in separate func
  net: ethernet: ti: cpsw: introduce mac sl module api
  net: ethernet: ti: cpsw: switch to use mac sl api
  net: ethernet: ti: cpsw: move ethtool func in separate file

 drivers/net/ethernet/ti/Kconfig          |   19 -
 drivers/net/ethernet/ti/Makefile         |    9 +-
 drivers/net/ethernet/ti/cpmac.c          |   14 +-
 drivers/net/ethernet/ti/cpsw-common.c    |   12 +-
 drivers/net/ethernet/ti/cpsw-phy-sel.c   |    9 +-
 drivers/net/ethernet/ti/cpsw.c           | 1530 +++-------------------
 drivers/net/ethernet/ti/cpsw.h           |    9 +-
 drivers/net/ethernet/ti/cpsw_ale.c       |   55 +-
 drivers/net/ethernet/ti/cpsw_ale.h       |   12 +-
 drivers/net/ethernet/ti/cpsw_ethtool.c   |  719 ++++++++++
 drivers/net/ethernet/ti/cpsw_priv.c      |  132 ++
 drivers/net/ethernet/ti/cpsw_priv.h      |  429 ++++++
 drivers/net/ethernet/ti/cpsw_sl.c        |  328 +++++
 drivers/net/ethernet/ti/cpsw_sl.h        |   73 ++
 drivers/net/ethernet/ti/cpts.c           |   14 +-
 drivers/net/ethernet/ti/cpts.h           |   14 +-
 drivers/net/ethernet/ti/davinci_cpdma.c  |   37 +-
 drivers/net/ethernet/ti/davinci_cpdma.h  |   13 +-
 drivers/net/ethernet/ti/davinci_emac.c   |   16 +-
 drivers/net/ethernet/ti/davinci_mdio.c   |   19 +-
 drivers/net/ethernet/ti/netcp.h          |   10 +-
 drivers/net/ethernet/ti/netcp_core.c     |   10 +-
 drivers/net/ethernet/ti/netcp_ethss.c    |   10 +-
 drivers/net/ethernet/ti/netcp_sgmii.c    |    9 +-
 drivers/net/ethernet/ti/netcp_xgbepcsr.c |    9 +-
 25 files changed, 1870 insertions(+), 1641 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/cpsw_ethtool.c
 create mode 100644 drivers/net/ethernet/ti/cpsw_priv.c
 create mode 100644 drivers/net/ethernet/ti/cpsw_priv.h
 create mode 100644 drivers/net/ethernet/ti/cpsw_sl.c
 create mode 100644 drivers/net/ethernet/ti/cpsw_sl.h

-- 
2.17.1

