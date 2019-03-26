Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC52C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB8F2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1gUE6g/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbfCZXBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:01:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39057 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbfCZXBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:01:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so5257355pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q8Pr/WZyoSRwwYcP+AJJmuJCLQP4M/GYCHOXHFc/XBU=;
        b=u1gUE6g/MMeAL3lZXFEu4NW+kyF84y8rdUnQmz+Y2xKYD5xFIWPz1o32knDIgktGVJ
         hpPYLfaXaSoqOUCWilt9IbyDmXLxWniLlJKofk7yvoEAMZh1OQoQs1q6RimBHByeKTrQ
         hEq5gGcVzTfZnk0hOrQN0YHEddN5c6BnnBW9nC37Rfxnlg+7QdpIEiZge4ajjltRV8UR
         qJ2EpXcklesKJT+RIG/Tiec4nR5MqCfAEiZ2wABAwgtShHCbIq1DiX5XD0ni8acrxiYw
         prcQFjKyHjZSgbcUNNUzfWHsldHZskU8Na4WKci0NSvTC3SQUrRp+bFZNn6ooOBSvC2P
         YPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q8Pr/WZyoSRwwYcP+AJJmuJCLQP4M/GYCHOXHFc/XBU=;
        b=k4p8sjUi01SyE2/OH5XaZbQjM1lGJkP1qDek6hflw35GZqN72fdAFg7FpcK5a6cGw9
         gXQ7raGZ3IMKe99oS+VPwRZBvTgORCVqN466LNyCgPIzljzxbQ4PzjbYZ2TTeFCHqnY5
         KV5JCXiQ8bRiDcfkNyLbL3yiKogn0YjuyWqioNWEQgOEg9Y8unJBNmwIaXsvPoHyjB49
         DlZ3foe1XSo5rtpYcdCZdXbrArLswlowYXf6xWyB4IAHPzDV/Dv7MkSiA0XhbLmRF9fQ
         W24VX2pZPQp7zLV8lFQ9nMBTqIaibQw/C1+mmcTedSVUNVgIxT9nAxC9wl3aewZIxvQJ
         qsaA==
X-Gm-Message-State: APjAAAWqIE+UNYdUhABpt4CSp1XqX4FZ8TgMIe1SMp/xEZC3skLKj3En
        8zGD8t1Po9wwWw1vxHCbYdU=
X-Google-Smtp-Source: APXvYqyMCFrLclHWQO0W0LxDCD8UegJz2hV2qvmfChZ9v6Uk7TKPwPf3fPSLo5OEG7+v4pYFJcmL1g==
X-Received: by 2002:a62:1d90:: with SMTP id d138mr31810360pfd.232.1553641297832;
        Tue, 26 Mar 2019 16:01:37 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n24sm43832587pfi.123.2019.03.26.16.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 16:01:37 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: [PATCH v2 RFC/RFT 0/5] Save single pages from CMA area
Date:   Tue, 26 Mar 2019 16:01:26 -0700
Message-Id: <20190326230131.16275-1-nicoleotsuka@gmail.com>
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

Changlog
v1->v2:
 * PATCH-2: Initialized page pointer to NULL

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
 kernel/dma/remap.c          |  4 ++--
 5 files changed, 46 insertions(+), 15 deletions(-)

-- 
2.17.1

