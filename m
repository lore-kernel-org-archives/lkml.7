Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72B0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAC3206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfJVWB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:01:26 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33318 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731191AbfJVWBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:01:25 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iN2DU-0004Kp-By; Tue, 22 Oct 2019 16:01:25 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iN2DT-0000Ip-4j; Tue, 22 Oct 2019 16:01:23 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>
Cc:     Kit Chow <kchow@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 22 Oct 2019 16:01:19 -0600
Message-Id: <20191022220121.1120-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, kchow@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 0/2]  AMD IOMMU Changes for NTB
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please find the following patches which help support
Non-Transparent-Bridge (NTB) devices on AMD platforms with the IOMMU
enabled.

These patches add support for multiple PCI aliases. NTB
hardware will normally send TLPs from a range of requestor IDs to
facilitate routing the responses back to the correct requestor on the
other side of the bridge. To support this, NTB hardware registers a
number of PCI aliases. Currently the AMD IOMMU only allows for one
PCI alias so TLPs from the other aliases get rejected.

See commit ad281ecf1c7d ("PCI: Add DMA alias quirk for Microsemi
Switchtec NTB") for more information on this.

Similar patches were upstreamed for Intel hardware earlier this year:

commit 3f0c625c6ae7 ("iommu/vt-d: Allow interrupts from the entire bus
    for aliased devices")

Thanks,

Logan

--

Changes since v1:
  * Dropped the first patch as similar functionality has already
    been added with the generic iommu interface
  * Rebased onto joro/iommu.git next branch
  * Reworked the set_remap_table_entry_alias() function to also do
    the flushing by getting the iommu from amd_iommu_rlookup_table
    (per suggestion from Joerg)

Logan Gunthorpe (2):
  iommu/amd: Support multiple PCI DMA aliases in device table
  iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping

 drivers/iommu/amd_iommu.c       | 170 +++++++++++++++++---------------
 drivers/iommu/amd_iommu_types.h |   2 +-
 2 files changed, 92 insertions(+), 80 deletions(-)

--
2.20.1
