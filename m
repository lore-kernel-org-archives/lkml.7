Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56C1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB85214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbfJVVqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 17:46:24 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33066 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733229AbfJVVqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 17:46:22 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iN1ys-00049M-Rg; Tue, 22 Oct 2019 15:46:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iN1yr-00024v-Vg; Tue, 22 Oct 2019 15:46:18 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 22 Oct 2019 15:46:11 -0600
Message-Id: <20191022214616.7943-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, dan.j.williams@intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 0/5] PLX Switch DMA Engine Driver
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches introduce a driver to use the DMA hardware inside
PLX ExpressLane PEX Switches. The DMA devices appear as one or more
PCI virtual functions per channel and can serve similar use cases as
Intel's IOAT driver.

The first two patches in this series fix some bugs that are required to
support cases where the driver is unbound while the DMA engine is in
use. Without these patches the kernel will panic when that happens.

The final three patches implement the driver itself.

This patchset is based off of v5.4-rc4 and a git branch is available
here:

https://github.com/sbates130272/linux-p2pmem/ plx-dma

Thanks,

Logan

--

Logan Gunthorpe (5):
  dmaengine: Store module owner in dma_device struct
  dmaengine: Call module_put() after device_free_chan_resources()
  dmaengine: plx-dma: Introduce PLX DMA engine PCI driver skeleton
  dmaengine: plx-dma: Implement hardware initialization and cleanup
  dmaengine: plx-dma: Implement descriptor submission

 MAINTAINERS               |   5 +
 drivers/dma/Kconfig       |   9 +
 drivers/dma/Makefile      |   1 +
 drivers/dma/dmaengine.c   |   7 +-
 drivers/dma/plx_dma.c     | 658 ++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |   2 +
 6 files changed, 680 insertions(+), 2 deletions(-)
 create mode 100644 drivers/dma/plx_dma.c

--
2.20.1
