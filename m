Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A542C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631782147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqwSqFIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfD3CDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 22:03:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41483 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbfD3CDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:03:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so6067771pgs.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 19:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B3NugZ9TINdI1OI3FrmhQJTknBH3QXdWgtcaMz1fRrE=;
        b=XqwSqFIMy+BpZ4efc1taHt162C2WW2p4uw8J3gjvFeVMRGG0jSzSMC5xmLrNbcacwb
         kSZK6xHoUI8DOw1Rn0IJi7pOnOguOGYDs8nJd3/pYhhpJJwIX6AAhvP7U4ZCk5HucW0r
         wEtLypFJNVjRAy0V9h8rcEzU+AlOskOxc5qdwH4IyW+8UGKIB9ngyPx+R4jnN5B8bab9
         XlN+auwr8kV1zdzjaoNJyFMm3Xx9Q+BC1M2cEeEGlsJvt8oBRNxj3ngpNGKtqvXP2k/E
         geSlyyKH2M3Bblfe4P/DuWJYKIY4xHFOGq6pauv+9acGM3EgEuE6IMCqxFKdOvSxs2pL
         Y4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B3NugZ9TINdI1OI3FrmhQJTknBH3QXdWgtcaMz1fRrE=;
        b=mJFzf1cl8JRZGyYe8UAskm76+3CAN9sPW0NM8R2BX8mZ6i8T0nU6uPji2i8Uo3dD7o
         /A4BGpXIg86PLO192iQDg484p5xwnEPqr2y7vrGAhV7GfGcpEUPv/tE7ehJfodijFKTj
         qfbaczGARweOjNRQk4qXk2a5KQqb+w2UxN148suPVmuG3M8hAQcdghrEXxodghvSfdG5
         n8gYIgwZaJ+X6CY116MYkAYOKuLhF5bGAGstiPDhpKTNHvo5Au7jhTeFD6fnAtnm0Jkd
         cL5HcoWSNM059/10/YQBPp2DYZXIeZGXgjkbdFNoXmvVA2jYPucWJMBMpGVviM40/JQh
         Yj3A==
X-Gm-Message-State: APjAAAWg348CGjjrqZOv4T2Xp6Z7jOFTDH/hmh7C0aXtpeLgFek4fhGh
        Z2drw5c344VmPUy9arMQabs=
X-Google-Smtp-Source: APXvYqyq/ePAJdQfrFoIyaNhBIEKmUwzsYwFbKt20m93i9o3xKFFhfZk/XcMS+4PRI8PvCEezew/dA==
X-Received: by 2002:a65:4247:: with SMTP id d7mr18565472pgq.114.1556589421204;
        Mon, 29 Apr 2019 18:57:01 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id a12sm36918995pgq.21.2019.04.29.18.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 18:57:00 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Subject: [RFC/RFT PATCH 0/2] Optimize dma_*_from_contiguous calls
Date:   Mon, 29 Apr 2019 18:55:19 -0700
Message-Id: <20190430015521.27734-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches try to optimize dma_*_from_contiguous calls:
PATCH-1 does some abstraction and cleanup.
PATCH-2 saves single pages and reduce fragmentations from CMA area.

Both two patches may impact the source of pages (CMA or normal)
depending on the use cases, so are being tagged with "RFC/RFT".

Please check their commit messages for detail.

Nicolin Chen (2):
  dma-contiguous: Simplify dma_*_from_contiguous() function calls
  dma-contiguous: Use fallback alloc_pages for single pages

 arch/arm/mm/dma-mapping.c      | 14 +++-----
 arch/arm64/mm/dma-mapping.c    | 11 +++---
 arch/xtensa/kernel/pci-dma.c   | 19 +++-------
 drivers/iommu/amd_iommu.c      | 20 +++--------
 drivers/iommu/intel-iommu.c    | 20 ++---------
 include/linux/dma-contiguous.h | 15 +++-----
 kernel/dma/contiguous.c        | 64 ++++++++++++++++++++++------------
 kernel/dma/direct.c            | 24 +++----------
 kernel/dma/remap.c             | 11 ++----
 9 files changed, 73 insertions(+), 125 deletions(-)

-- 
2.17.1

