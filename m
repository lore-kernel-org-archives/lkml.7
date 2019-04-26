Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B31C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE0E20684
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="APcgq1l3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfDZHkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:40:07 -0400
Received: from first.geanix.com ([116.203.34.67]:59636 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfDZHkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:40:07 -0400
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 05B54308E4B;
        Fri, 26 Apr 2019 07:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556263885; bh=5aSzjjeeGg3gvnZzM0uMyBR5Gv5/enegwSPWZOS50xg=;
        h=From:To:Cc:Subject:Date;
        b=APcgq1l3vbqb+KATFpR51Ygd9HXtUOjlqbXgxC/zeRQBZQdYvwwgisIUZOYOfY16T
         ZH0ypW6bS12XgV0yOJQIvXiMN2Qt3/UPDMIEcUh2DQfEk+nK7KIyshv1PRalAIvDyG
         HnHdisdX7s7RSDeBbxmZlalDTzt3f6PhZI4yfxtWKnDsK5Owaw/RgW7bb407B7xLYf
         +hXYrXSY6PUpNw4cdwRG5lw8f5ZI6gzub74G9fumggL69OhpBQckhKfIUDQqGhBkT7
         v+2FeNGxMTmiESeNeCroQWrmrSo4La7LO9DFHbntscEYFBMIoaCMX71OV0TEmQt3xE
         OOo28ZwnjUI7w==
From:   Esben Haabendal <esben@geanix.com>
To:     netdev@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Yang Wei <yang.wei9@zte.com.cn>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/12] net: ll_temac: x86_64 support
Date:   Fri, 26 Apr 2019 09:32:19 +0200
Message-Id: <20190426073231.4008-1-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for use of ll_temac driver with
platform_data configuration and fixes endianess and 64-bit problems so
that it can be used on x86_64 platform.

A few bugfixes are also included.

Esben Haabendal (12):
  net: ll_temac: Fix and simplify error handling by using devres
    functions
  net: ll_temac: Extend support to non-device-tree platforms
  net: ll_temac: Fix support for 64-bit platforms
  net: ll_temac: Add support for non-native register endianness
  net: ll_temac: Fix support for little-endian platforms
  net: ll_temac: Allow use on x86 platforms
  net: ll_temac: Support indirect_mutex share within TEMAC IP
  net: ll_temac: Fix iommu/swiotlb leak
  net: ll_temac: Fix bug causing buffer descriptor overrun
  net: ll_temac: Replace bad usage of msleep() with usleep_range()
  net: ll_temac: Allow configuration of IRQ coalescing
  net: ll_temac: Enable DMA when ready, not before

 drivers/net/ethernet/xilinx/Kconfig         |   5 +-
 drivers/net/ethernet/xilinx/ll_temac.h      |  26 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c | 514 ++++++++++++++++++----------
 drivers/net/ethernet/xilinx/ll_temac_mdio.c |  53 +--
 include/linux/xilinx_ll_temac.h             |  31 ++
 5 files changed, 426 insertions(+), 203 deletions(-)
 create mode 100644 include/linux/xilinx_ll_temac.h

-- 
2.4.11

