Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B1C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6181E20862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbfFJSvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:51:53 -0400
Received: from foss.arm.com ([217.140.110.172]:47542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388544AbfFJSvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:51:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C646C15;
        Mon, 10 Jun 2019 11:51:52 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A12A93F246;
        Mon, 10 Jun 2019 11:51:50 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     will.deacon@arm.com
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, jacob.jun.pan@linux.intel.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eric.auger@redhat.com
Subject: [PATCH 2/8] dt-bindings: document PASID property for IOMMU masters
Date:   Mon, 10 Jun 2019 19:47:08 +0100
Message-Id: <20190610184714.6786-3-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Arm systems, some platform devices behind an SMMU may support the PASID
feature, which offers multiple address space. Let the firmware tell us
when a device supports PASID.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
Previous discussion on this patch last year:
https://patchwork.ozlabs.org/patch/872275/
I split PASID and stall definitions, keeping only PASID here.
---
 Documentation/devicetree/bindings/iommu/iommu.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b4624defc..3c36334e4f94 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -86,6 +86,12 @@ have a means to turn off translation. But it is invalid in such cases to
 disable the IOMMU's device tree node in the first place because it would
 prevent any driver from properly setting up the translations.
 
+Optional properties:
+--------------------
+- pasid-num-bits: Some masters support multiple address spaces for DMA, by
+  tagging DMA transactions with an address space identifier. By default,
+  this is 0, which means that the device only has one address space.
+
 
 Notes:
 ======
-- 
2.21.0

