Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A104C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB492083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YFno93QX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfDLDNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:13:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44947 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfDLDNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 23:13:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id d11so7000310edp.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lSZmLfiTS0tVJgkUC+AaFkmLshmlkzFI4jJrlCOnI6o=;
        b=YFno93QXuTT8g873ob4lzZVYz3tZWm+LfJx0YMpac2uEV9aJ6oZNSx9WOKnOf8lAo1
         +NqfDN8Br13bz4GqPuBdzRpRcU4aHRKhvkkpILIQq8DCmznfx/atr8QKvtlKx36BCQ8b
         DHYXbpmkIT46Gjd93nsMUBag2FEmJGH9PF5Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lSZmLfiTS0tVJgkUC+AaFkmLshmlkzFI4jJrlCOnI6o=;
        b=QqcAR1YX4aInDM5xCyi7Jt6M5IjIuTt7HlnVeT38aZ/Y7gTvu0HAJiJ3F0UBFNEBme
         pXD7bz3Sz44TjSs4gHCUC7ZAMf7jlfU7ceGXn9OCzXpad2Ir+xS4Dz1tVuPAWBV/fVJb
         N6XE3RLO7tGhRi+fTG6aBHC+1Tqyif9HGsIBStlCf0v4quGVK6goJB1ipGqpDiRL175k
         RxQncCh9FMSunrSQcF3y2XN7T0AUQipVCgBe3QReRlMfW4AI9bMOkKAmHctoKtIMcJoO
         f10Gne1mjuEw2G2jOrqxkYtbpVZWZKpLocCJeXHagwZF7Nu7+t4aT4SxHntLcs/gX9b1
         WOhQ==
X-Gm-Message-State: APjAAAVc8JFMeu1p99j/esic9j+b5Z7dxAqrexk/0ILVwXtjX4UryveZ
        7fbE2PrKZM6lZb5ty/W2XH8Qjg==
X-Google-Smtp-Source: APXvYqz8Z8DBYr6JemK9OQFaobK4cwQGMmE9tVq+z/+aM5UzwZDbxfR2W0WlgQFUXvqBP0mVwT6VEg==
X-Received: by 2002:aa7:dc4d:: with SMTP id g13mr5176207edu.106.1555038833471;
        Thu, 11 Apr 2019 20:13:53 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c7sm11533352edt.70.2019.04.11.20.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Apr 2019 20:13:52 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Date:   Fri, 12 Apr 2019 08:43:32 +0530
Message-Id: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few SOCs have limitation that their PCIe host can't allow few inbound
address ranges. Allowed inbound address ranges are listed in dma-ranges
DT property and this address ranges are required to do IOVA mapping.
Remaining address ranges have to be reserved in IOVA mapping.

PCIe Host driver of those SOCs has to list resource entries of allowed
address ranges given in dma-ranges DT property in sorted order. This
sorted list of resources will be processed and reserve IOVA address for
inaccessible address holes while initializing IOMMU domain.

This patch set is based on Linux-5.0-rc2.

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

 drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
 drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
 drivers/pci/probe.c                 |  3 +++
 include/linux/pci.h                 |  1 +
 4 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.7.4

