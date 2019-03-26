Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3B0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265822173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2wbbN0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfCZWuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:50:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33783 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbfCZWuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:50:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id bg8so2314401plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 15:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e5DY//bd4ABajPh9E86maxYkAmj3lPA2dscnZKXW2Qk=;
        b=n2wbbN0OsXuVk+0FAj6hZ8X/6dH6uDYiZnI8cfOX7sOOjdIS3Y4LiWU0vynQNlWYBb
         sW3zBvEUNTwT+0JyqYUWU89azy79knAiMV6lU4I0rboLLmEQGwIRoLxnnLmpGzwK1O9/
         JKuZ0mjPhZKmHNStJC9o6VK2hLXPPlLKdyY0cjYyKMCb/RORxwzWI9y9OWu+y0XiMA1C
         OjZjcpcpRrmZ8np+NVdbpjUOHgPx2IYChG1yOgWerx2nuy7Y7ISN+QiqZXiJiAbttVtO
         vp7+gAT9pUa0GOUOkCJHEcssuDdRiu2l3pO55bnSTvBeDk/nZdXSNLHlO1AQrY326ebf
         bw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e5DY//bd4ABajPh9E86maxYkAmj3lPA2dscnZKXW2Qk=;
        b=X4JzabEJmLC8Q51BqFQPgGBxrxqZZcAWdGwDyrkn57gBLVhoroUDgKiN+YJhvr82iR
         qXgxDW8PbizN+DW6WLr8PcyYBhch6Ld2yIqFuNkqSRjFmU4+4t7IsqyXoFJEFvbb8DTk
         2w7r4tHplpmJSmNl5rToer7V2PcWsGPyc7ZtvPclwC8xRDDiT95nDcZeJfcFSh96wTsg
         FvMlPxJOMob/5/3vDWMhbBpOqpQ5gUGGUCv7ACfrtQfAjcpIO3QN0kSoSFW9Dds5f911
         XVBBQc/q5eLzj2BiMLQSdezxOKoOnsqLf6OZXOSb/GUip5+/1pkphJwHbeDzEQdCi5k/
         Bgcg==
X-Gm-Message-State: APjAAAXtwpHamez/056yfLFD86mhsBd8SPyoVW0z9ZThR5+OLpVJkUD1
        /JohVIcdAW2pvAe4ROOQFBM=
X-Google-Smtp-Source: APXvYqzENC9UGVQ3jRiFlKy6HAKbq8RA5f10B6IfDv3ZnpV7i7ECCReq6XySdE8T7KZaU5V1waKJdw==
X-Received: by 2002:a17:902:6907:: with SMTP id j7mr32053108plk.32.1553640606166;
        Tue, 26 Mar 2019 15:50:06 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 8sm56937368pfs.50.2019.03.26.15.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 15:50:05 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: [PATCH RFC/RFT 0/5] Save single pages from CMA area
Date:   Tue, 26 Mar 2019 15:49:54 -0700
Message-Id: <20190326224959.9656-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches try to save single pages from CMA area bypassing
all CMA single page alloctions and allocating normal pages instead, as
all addresses within one single page are contiguous.

We had once applied the PATCH-5 but reverted it as actually not all the
callers handled the fallback allocations. Per Robin's suggestion, let's
stuff alloc_pages()/free_page() fallbacks to those callers before having
PATCH-5.

Nicolin Chen (5):
  ARM: dma-mapping: Add fallback normal page allocations
  dma-remap: Run alloc_pages() on failure
  iommu: amd_iommu: Add fallback normal page allocations
  arm64: dma-mapping: Add fallback normal page allocations
  dma-contiguous: Do not allocate a single page from CMA area

 arch/arm/mm/dma-mapping.c   | 13 ++++++++++---
 arch/arm64/mm/dma-mapping.c | 19 ++++++++++++-------
 drivers/iommu/amd_iommu.c   |  3 +++
 kernel/dma/contiguous.c     | 22 +++++++++++++++++++---
 kernel/dma/remap.c          |  2 +-
 5 files changed, 45 insertions(+), 14 deletions(-)

-- 
2.17.1

