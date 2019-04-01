Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930D0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6088320700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554104860;
	bh=sJ08sokFidKbKjLbAa1jmscWBGUKjw0UwkJOaxJd82I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=e578rZRayGnqv4KTjPNV0CkVulzxYGthhXQ0upmTUimpDVapOR8E0vAqBUeWGCR32
	 a4NxIfVRnhQ+2kADpBO3limEsC3Qwx/yVFXeUOUa046YMWapxgE2DxApz0PbBqeWHI
	 9WkTCC9Ot7H2EGHe4syuUo2UF6mxgDRzT845FouA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfDAHri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:47:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46525 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfDAHri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:47:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so4308054pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 00:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hLFIabtfPdGj+2XLCFlOKbrmi9QIk3TU0jAr0rq6mdA=;
        b=pz1MXr/Ij6KkUcUaoQSaLSsyFNUxj6lsctBEr3A0TIfDZK1xXiSzuPhRcQQ/EThRDJ
         /oi4aqe5op+Xl+d9HHxaMJG054LqVqHoqMepsJsDNn32kGsw7L2U5L9GPaIf+x56Z0Wt
         EfRT8SqaWrbCRrnZULXYWlYlF3zqpP/R/XmtFm9qV3BBgb0l3TG58fBdzbKSkE38d6jH
         mHaTT2sLf5DpEFXM9GTl/I9n3MsafMa5GuIdrSOhzsvBURMLGBdW/JfVq6SHBr7XvLFd
         6pgNDjXgBycN1cr3dS1j2Ud0qeF9nXfbPNumrA5khsAh23uP7pOA/6UCKiAVVuN0BuKQ
         2OZQ==
X-Gm-Message-State: APjAAAW825iPjwZ+6uc92x9CX09ffoGaWTK4UR1in6O/HQd8b9TKKIfG
        VLEcuBQkL55NsAEJQuDPRTG+zMG1rQ==
X-Google-Smtp-Source: APXvYqyjWUMBverUxwJmcUwT0Gjd3rNJDhuncpwezQB9+U/dI8QmFa4yPJMj9q0G7FdQA4pmL+cTXg==
X-Received: by 2002:a62:1c07:: with SMTP id c7mr23011676pfc.159.1554104857107;
        Mon, 01 Apr 2019 00:47:37 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id o5sm33428950pfa.135.2019.04.01.00.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 00:47:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/3] Initial Panfrost driver
Date:   Mon,  1 Apr 2019 02:47:27 -0500
Message-Id: <20190401074730.12241-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's v2 of the panfrost driver. Lots of improvements from the RFC
primarily with support for job hangs resetting the GPU and runtime-pm
thanks to Tomeu.

Several dependencies have been applied already, but the first 2 patches
are the remaining dependencies. We need to take the iommu change via
drm-misc or we need a stable branch.

A git branch is here[1].

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git panfrost-rebase-v2

Rob Herring (3):
  iommu: io-pgtable: Add ARM Mali midgard MMU page table format
  drm: Add a drm_gem_objects_lookup helper
  drm/panfrost: Add initial panfrost driver

 drivers/gpu/drm/Kconfig                      |   2 +
 drivers/gpu/drm/Makefile                     |   1 +
 drivers/gpu/drm/drm_gem.c                    |  46 +-
 drivers/gpu/drm/panfrost/Kconfig             |  14 +
 drivers/gpu/drm/panfrost/Makefile            |  12 +
 drivers/gpu/drm/panfrost/TODO                |  27 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c  | 191 +++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.h  |  14 +
 drivers/gpu/drm/panfrost/panfrost_device.c   | 227 ++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h   | 118 ++++
 drivers/gpu/drm/panfrost/panfrost_drv.c      | 484 ++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_features.h | 309 +++++++++++
 drivers/gpu/drm/panfrost/panfrost_gem.c      |  92 +++
 drivers/gpu/drm/panfrost/panfrost_gem.h      |  29 +
 drivers/gpu/drm/panfrost/panfrost_gpu.c      | 374 +++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h      |  19 +
 drivers/gpu/drm/panfrost/panfrost_issues.h   | 176 ++++++
 drivers/gpu/drm/panfrost/panfrost_job.c      | 556 +++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_job.h      |  51 ++
 drivers/gpu/drm/panfrost/panfrost_mmu.c      | 366 ++++++++++++
 drivers/gpu/drm/panfrost/panfrost_mmu.h      |  17 +
 drivers/gpu/drm/panfrost/panfrost_regs.h     | 298 ++++++++++
 drivers/iommu/io-pgtable-arm.c               |  93 +++-
 drivers/iommu/io-pgtable.c                   |   1 +
 include/drm/drm_gem.h                        |   2 +
 include/linux/io-pgtable.h                   |   7 +
 include/uapi/drm/panfrost_drm.h              | 140 +++++
 27 files changed, 3633 insertions(+), 33 deletions(-)
 create mode 100644 drivers/gpu/drm/panfrost/Kconfig
 create mode 100644 drivers/gpu/drm/panfrost/Makefile
 create mode 100644 drivers/gpu/drm/panfrost/TODO
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_devfreq.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_devfreq.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_device.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_device.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_drv.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_features.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gpu.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gpu.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_issues.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_job.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_job.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_mmu.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_mmu.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_regs.h
 create mode 100644 include/uapi/drm/panfrost_drm.h

--
2.19.1
