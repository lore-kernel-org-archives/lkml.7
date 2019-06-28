Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB26C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5262064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hvQFcpmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfF1H3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:29:31 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:48032 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbfF1H30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:29:26 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6DED1C0BF6;
        Fri, 28 Jun 2019 07:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561706965; bh=TiS0Ekjg7eYc2vrZpldJieBzS4PbzpN/E/eaEOkGBNc=;
        h=From:To:Cc:Subject:Date:From;
        b=hvQFcpmBS+NfBpJ+qKNfxSQD5Lli9HKWhpBAAVnkmKy9F7w5Usq9QI9VxwMJ1cEZ7
         TcRUK+npuLa6rmkJqfjn8MkywfWIjIMrtj264xI9EGAwe/Uiz6rNm6j4uedZlnHBT7
         AEIIeW/mf7mjqS5+Zu9kmkLPbJQJsbEK/dF/fLTQ6sShFZkA7QiEl5L0hAtNQQh0WA
         u60UavqXad9s+a1fLH7yWNpVqtRhsajTzY6JHnRRYQa2N/XDId9eXFzLwwW2IMuAPF
         lT/MWMsUlIdNqGI9QlWJq/Be1V8eDP1ZWtmeLyWO4JePtq05jKFWMWgzx0MrGVNve4
         WuwBxBkiX4pNg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id B8ED3A0064;
        Fri, 28 Jun 2019 07:29:23 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 3EAFC3E942;
        Fri, 28 Jun 2019 09:29:23 +0200 (CEST)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH net-next v2 00/10] net: stmmac: 10GbE using XGMAC
Date:   Fri, 28 Jun 2019 09:29:11 +0200
Message-Id: <cover.1561706800.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for 10Gb Link using XGMAC core plus some performance tweaks.

Tested in a PCI based setup.

iperf3 TCP results:
	TSO ON, MTU=1500, TX Queues = 1, RX Queues = 1, Flow Control ON
	Pinned CPU (-A), Zero-Copy (-Z)

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-600.00 sec   643 GBytes  9.21 Gbits/sec    1             sender
[  5]   0.00-600.00 sec   643 GBytes  9.21 Gbits/sec                  receiver

Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>

Jose Abreu (10):
  net: stmmac: dwxgmac: Enable EDMA by default
  net: stmmac: Do not try to enable PHY EEE if MAC does not support it
  net: stmmac: Decrease default RX Watchdog value
  net: stmmac: dwxgmac: Fix the undefined burst setting
  net: stmmac: Add the missing speeds that XGMAC supports
  net: stmmac: Do not disable interrupts when cleaning TX
  net: stmmac: Enable support for > 32 Bits addressing in XGMAC
  net: stmmac: Update RX Tail Pointer to last free entry
  net: stmmac: Only disable interrupts if NAPI is scheduled
  net: stmmac: Update Kconfig entry

 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   9 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  16 ++-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  14 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |   4 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  27 +++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 160 ++++++++++++++++-----
 7 files changed, 176 insertions(+), 56 deletions(-)

-- 
2.7.4

