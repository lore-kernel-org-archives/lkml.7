Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17B6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772C72339D
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vjbu0oxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395020AbfHWM4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:56:18 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59260 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732824AbfHWM4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:56:10 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7NCu3ku076487;
        Fri, 23 Aug 2019 07:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566564964;
        bh=90F2Ku1Xn8M7W9QVFhYhs3tdIyL07/aRX/oyDTbPkQM=;
        h=From:To:CC:Subject:Date;
        b=vjbu0oxDaj/Z/q8NQPAemQSd1aSsfSI2xT2o831AZa+07dKUXjZFWW/vKhp7Gsf2A
         8y9RuVmeskLNZ60kCzGY6UDJQ++Kw8IUgrsFye+VFKF6h6Fs7/gi88FtyEhyk+WzVt
         S+VTFIsDkI5uG5LpKX/832LrD010lPyKiyP4ZmsM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7NCu3uB015093
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Aug 2019 07:56:03 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 23
 Aug 2019 07:56:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 23 Aug 2019 07:56:01 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7NCtwke092319;
        Fri, 23 Aug 2019 07:55:59 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH 0/5] dmaengine: ti: edma: Multicore usage related fixes
Date:   Fri, 23 Aug 2019 15:56:13 +0300
Message-ID: <20190823125618.8133-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When other cores want to use EDMA for their use cases Linux was not playing
nicely.
By design EDMA is supporting shared use with shadow regions. Linux is using
region0, others can be used by other cores.

In order to not break multicore shared usage of EDMA:
- do not reset paRAM slots which is not allocated for Linux (reserved paRAM
  slots)
- Only reset region0 access registers, do not touch other regions
- Add option for reserved channels which should not be used by Linux in a similar
  fashion as we already have for reserved paRAM slots.

Regards,
Peter
---
Peter Ujfalusi (5):
  dmaengine: ti: edma: Do not reset reserved paRAM slots
  dmaengine: ti: edma: Only reset region0 access registers
  dmaengine: ti: edma: Use bitmap_set() instead of open coded
    edma_set_bits()
  dt-bindings: dma: ti-edma: Add option for reserved channel ranges
  dmaengine: ti: edma: Add support for handling reserved channels

 .../devicetree/bindings/dma/ti-edma.txt       |   5 +
 drivers/dma/ti/edma.c                         | 190 +++++++++++-------
 2 files changed, 123 insertions(+), 72 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

