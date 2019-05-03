Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D9FC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725572070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XGauRLD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfECOFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:05:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42498 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfECOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:05:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so6142451eda.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aSsQUXFyMzhd3pF3o0br4GImJGSsL3GlveRwHz9b304=;
        b=XGauRLD7je12LIZeipZdHxet383aKHam8Uhf20D3C35uie66+ON4yoVOBUAHb0kvYg
         ZMfqOIZgd/3FltlG9+MpXPWJMneXgFV0VkLGix9soq6yseinjMnyou90w8geicAnioT3
         G8FzZM5uogBdyWA85z8X1BFuCuwbpHWls5O70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aSsQUXFyMzhd3pF3o0br4GImJGSsL3GlveRwHz9b304=;
        b=LuB/rajlYbWPDkBE3vV6N8mrlqkV3mpDFqAWrd81IliYf0dlZcElaLtjaoeS31pTcL
         5q1sXg6iwIeEyVTi0STG4SC7Guu09/E6xDykiw1cHLmruVANi2INo77GY5/MSB52MkB8
         5dvxDcIh3hv3IdED9uYlwMb3EyKEaBok0YM2+8aS8g01h0qwDmaWeDh+CH8eMk4J+id3
         +CskLpb00qj+MPnPyza+PkV96AVEw5Qf6HlbjyvOATe4jq27m7zO5m0qstrV2uwBNKw8
         YULwV6q4Cb60vovegph4ovHg1cSBKkNTim9+HxNoW5nTjH0ThjjxGYP0TpBPkCmLFdF6
         uC9A==
X-Gm-Message-State: APjAAAX9sUWyhJofscFHJKCvA2bhfsFaMWImhkfmctrL7m6of1c6Usnw
        i7AZDYprgXv7y9qpxCSya4i6Cg==
X-Google-Smtp-Source: APXvYqys1pc2WFq9pcZ+VYTFcRlepbG+istVel36Sx0zs1npV/SpDnsDpQV65SePP6q7OCX1GtSS+g==
X-Received: by 2002:a17:906:1e0f:: with SMTP id g15mr6369446ejj.241.1556892353345;
        Fri, 03 May 2019 07:05:53 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s53sm605472edb.20.2019.05.03.07.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 May 2019 07:05:51 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v6 0/3] PCIe Host request to reserve IOVA
Date:   Fri,  3 May 2019 19:35:31 +0530
Message-Id: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set will reserve IOVA addresses for DMA memory holes.

The IPROC host controller allows only a few ranges of physical address
as inbound PCI addresses which are listed through dma-ranges DT property.
Added dma_ranges list field of PCI host bridge structure to hold these
allowed inbound address ranges in sorted order.

Process this list and reserve IOVA addresses that are not present in its
resource entries (ie DMA memory holes) to prevent allocating IOVA
addresses that cannot be allocated as inbound addresses.

This patch set is based on Linux-5.1-rc3.

Changes from v5:
  - Addressed Robin Murphy, Lorenzo review comments.
    - Error handling in dma ranges list processing.
    - Used commit messages given by Lorenzo to all patches.

Changes from v4:
  - Addressed Bjorn, Robin Murphy and Auger Eric review comments.
    - Commit message modification.
    - Change DMA_BIT_MASK to "~(dma_addr_t)0".

Changes from v3:
  - Addressed Robin Murphy review comments.
    - pcie-iproc: parse dma-ranges and make sorted resource list.
    - dma-iommu: process list and reserve gaps between entries

Changes from v2:
  - Patch set rebased to Linux-5.0-rc2

Changes from v1:
  - Addressed Oza review comments.

Srinath Mannam (3):
  PCI: Add dma_ranges window list
  iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
  PCI: iproc: Add sorted dma ranges resource entries to host bridge

 drivers/iommu/dma-iommu.c           | 35 ++++++++++++++++++++++++++---
 drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 4 files changed, 79 insertions(+), 4 deletions(-)

-- 
2.7.4

