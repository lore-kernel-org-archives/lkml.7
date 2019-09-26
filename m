Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E1BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E15F222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MNJe0ACf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfIZLTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:19:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51616 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfIZLTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:19:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBJDnb013031;
        Thu, 26 Sep 2019 06:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569496753;
        bh=x5UNff13Ux7e75VM9yw2ZEuh6YPd/12K8z+lzDEZtnA=;
        h=From:To:CC:Subject:Date;
        b=MNJe0ACf2KI4Nv0TdzevMrfzask0HtZvWupd4cta+vmiHp9S5QFEgAs86Lj9ToXL7
         TPnMfGhKJ4TTH2LoiBM+AfrWrlIfIWht/eN9+GmngRw7CVqFE7PPRj13CMTfO717Eg
         guhzi3Mujh0orYf+iZpzDHNlOnBCK1ge7zPt1mrs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBJDma038340
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:19:13 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:19:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:19:05 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBJAdr013885;
        Thu, 26 Sep 2019 06:19:11 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/3] dmaengine: bindings/edma: dma-channel-mask to array
Date:   Thu, 26 Sep 2019 14:19:51 +0300
Message-ID: <20190926111954.9184-1-peter.ujfalusi@ti.com>
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

Changes since v2:
- Fix dma-common.yaml documentation patch and extend the description of the
  dma-channel-mask array
- The edma documentation now includes information on the dma-channel-mask array
  size for EDMAs with 32 or 64 channels

Changes since v1:
- Extend the common dma-channel-mask to uint32-array to be usable for
  controllers with more than 32 channels
- Use the dma-channel-mask instead custom property for available channels for
  EDMA.

The original patch was part of the EDMA multicore usage series.

Rob: I'm not sure if I got the dma-common.yaml update correctly...

EDMAs can have 32 or 64 channels depending on the SoC, the dma-channel-mask
needs to be an array to be usable for the driver.

Regards,
Peter
---
Peter Ujfalusi (3):
  dt-bindings: dmaengine: dma-common: Change dma-channel-mask to
    uint32-array
  dt-bindings: dma: ti-edma: Document dma-channel-mask for EDMA
  dmaengine: ti: edma: Add support for handling reserved channels

 .../devicetree/bindings/dma/dma-common.yaml   |  9 ++-
 .../devicetree/bindings/dma/ti-edma.txt       |  8 +++
 drivers/dma/ti/edma.c                         | 59 +++++++++++++++++--
 3 files changed, 69 insertions(+), 7 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

