Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3106C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A173220578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Oa+YWdq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfD2Ie0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:34:26 -0400
Received: from first.geanix.com ([116.203.34.67]:49808 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbfD2Ie0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:34:26 -0400
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 9DC9F308E7A;
        Mon, 29 Apr 2019 08:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556526781; bh=/Za5EQFdjXhOAX5kl1Ynfftf2bldm3mbCAaudC+/A+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Oa+YWdq83SmrRXD1v9iYYMYNVJwWe0Xo7AFDYIURWZVJ6RkwXiWV8WcABM4jQ5pnN
         KWm3gMFb8iXHyAWPCBC7psoKT2H6U+cBKnDM6IBIFLVLqZnv1noQ0RaZHQReeJbH61
         WS03Cb49TzLuE7EWb4FYTBY47yB6Lm37P1jKyoDSSYOlVd1sUafkj3fL3zi2Rooejo
         DNxnV5HVBOqLp25ppE7IWdFo7Am/wRv4Yef1cXPOIEkkQVX0EXqXkfNPGi1XgIamNH
         IRzz9r9WyyDd/3r/glw/mO43xaI0pGzwg+SPtNUVH2BcbBvV9M9RMMLQX1rGhrCozz
         /splH9Vv5a53A==
From:   Esben Haabendal <esben@geanix.com>
To:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Yang Wei <yang.wei9@zte.com.cn>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] net: ll_temac: x86_64 support
Date:   Mon, 29 Apr 2019 10:34:10 +0200
Message-Id: <20190429083422.4356-1-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426073231.4008-1-esben@geanix.com>
References: <20190426073231.4008-1-esben@geanix.com>
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

Changes since v1:

  - Make indirect_mutex specification mandatory when using platform_data
  - Move header to include/linux/platform_data
  - Enable COMPILE_TEST for XILINX_LL_TEMAC
  - Rebased to v5.1-rc7

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

 drivers/net/ethernet/xilinx/Kconfig           |   5 +-
 drivers/net/ethernet/xilinx/ll_temac.h        |  26 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c   | 515 +++++++++++++++++---------
 drivers/net/ethernet/xilinx/ll_temac_mdio.c   |  53 +--
 include/linux/platform_data/xilinx-ll-temac.h |  32 ++
 5 files changed, 428 insertions(+), 203 deletions(-)
 create mode 100644 include/linux/platform_data/xilinx-ll-temac.h

-- 
2.4.11

