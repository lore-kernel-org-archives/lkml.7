Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ADFC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBCE20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407344AbfHIPWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:22:38 -0400
Received: from 8bytes.org ([81.169.241.247]:48508 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfHIPWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:22:37 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E360D3D0; Fri,  9 Aug 2019 17:22:35 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Thomas.Lendacky@amd.com, Suravee.Suthikulpanit@amd.com,
        bp@alien8.de
Subject: [PATCH 0/3] Disable IOMMU Passthrough when SME is active
Date:   Fri,  9 Aug 2019 17:22:30 +0200
Message-Id: <20190809152233.2829-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is a small patch-set to disable IOMMU Passthrough mode when SME is
active even when CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y is set.

The reason for that change is that SME with passthrough mode turned out
to be fragile with devices requiring SWIOTLB, mainly because SWIOTLB has
a maximum allocation size of 256kb and a limit overall size of the
bounce buffer.

Therefore having IOMMU in translation mode by default is better when SME
is active on a system.

Please review.

Thanks,

	Joerg

Joerg Roedel (3):
  iommu: Print default domain type on boot
  iommu: Set default domain type at runtime
  iommu: Disable passthrough mode when SME is active

 drivers/iommu/iommu.c | 48 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

-- 
2.17.1

