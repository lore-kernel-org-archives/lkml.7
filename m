Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CDDC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30324217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554843272;
	bh=mOK6R69ZG3tAJy5GL4xUM1gG9kLGJdll0Ph3+wN9q68=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QaF0WFkiIiD0UkDs33Po8UCdqkyjp0K+9K+aaYjr4iAJGkHQKQAxzhK2mi9gi0Y5D
	 hmktVOQ6DVWunYP+Gxk5V/lxBdnO7x/feVWZgMkl6Ki8tPEHnhE/MEmwRXq8yR+a1u
	 JFlomFjxOi2lE6bQpg+NMZ5chZu1mLdscZtq8KGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDIUya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:54:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40559 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfDIUya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:54:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id 3so14817408oir.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQOCMV3xKrmHqHY1PVCBaCxVJYAiJpfExHpXaR163xc=;
        b=bXTb4YUA++DKI/zuZEYuy85WYD8n2sUs7nM1XOIUSJ7NbjwZtT00qlrjTrPkMkQhPh
         JNeOzXE6zQDfARkei+51R/gjlY4F96WOwHUSL180xCUGoan/U8pvTfgZottj4Ysq3kTr
         lLDcjb8qKZjtvOkyIpsq4AaOF+QGpo4uqFZ4fzXpGlcUzlDm+3CFYHYFA+LVFwOmjtQM
         ebD5saXOJ1C8VBOisAKQkENlaUth6l8sJIVnigAvkWWwazJ0h57kXZbbvjY91wsLdh1l
         BGBBSj58v1UfPKS7RFYI1EiPIWL3a6gS51OxxJY/oZAj7vEcG2X8iGoWyErbaUElAR3R
         IdcA==
X-Gm-Message-State: APjAAAU2UFafXFzexyxSIXBD7p1xXzbQJ5cX1MlCULKsrNIHHwEkhCFl
        Vw04sODvh8l0yEYBeZAS/w==
X-Google-Smtp-Source: APXvYqzEDQZ7uqfTLestu2+gWF7kbkRYF6dpRyRzZVYhYW3aFz+roUub5HfG+RvptTkyfEeN5bo6lw==
X-Received: by 2002:aca:b886:: with SMTP id i128mr207754oif.169.1554843268821;
        Tue, 09 Apr 2019 13:54:28 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o66sm6472175oig.11.2019.04.09.13.54.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Apr 2019 13:54:28 -0700 (PDT)
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
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v3 0/3] Initial Panfrost driver
Date:   Tue,  9 Apr 2019 15:54:24 -0500
Message-Id: <20190409205427.6943-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's v3 of the panfrost driver. Lot's of changes from review comments
and further testing. Details are in each patch. Of note, a problem with
MMU page faults has been addressed improving the stability. In the
process, the TLB invalidate has been optimized which Tomeu says has
improved the performance some.

Several dependencies have been applied already, but the first 2 patches
are the remaining dependencies. We need to take the iommu change via
drm-misc or we need a stable branch.

I'm hoping this is the last version. I'm hoping to apply this to drm-misc
this week before -rc5 cutoff.

A git branch is here[1].

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git panfrost-rebase-v3


Rob Herring (3):
  iommu: io-pgtable: Add ARM Mali midgard MMU page table format
  drm: Add a drm_gem_objects_lookup helper
  drm/panfrost: Add initial panfrost driver

 MAINTAINERS                                  |   9 +
 drivers/gpu/drm/Kconfig                      |   2 +
 drivers/gpu/drm/Makefile                     |   1 +
 drivers/gpu/drm/drm_gem.c                    |  93 ++-
 drivers/gpu/drm/panfrost/Kconfig             |  14 +
 drivers/gpu/drm/panfrost/Makefile            |  12 +
 drivers/gpu/drm/panfrost/TODO                |  27 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c  | 218 ++++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.h  |  14 +
 drivers/gpu/drm/panfrost/panfrost_device.c   | 252 +++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h   | 124 ++++
 drivers/gpu/drm/panfrost/panfrost_drv.c      | 460 +++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_features.h | 309 ++++++++++
 drivers/gpu/drm/panfrost/panfrost_gem.c      |  95 ++++
 drivers/gpu/drm/panfrost/panfrost_gem.h      |  29 +
 drivers/gpu/drm/panfrost/panfrost_gpu.c      | 362 ++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h      |  19 +
 drivers/gpu/drm/panfrost/panfrost_issues.h   | 176 ++++++
 drivers/gpu/drm/panfrost/panfrost_job.c      | 560 +++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_job.h      |  51 ++
 drivers/gpu/drm/panfrost/panfrost_mmu.c      | 369 ++++++++++++
 drivers/gpu/drm/panfrost/panfrost_mmu.h      |  17 +
 drivers/gpu/drm/panfrost/panfrost_regs.h     | 298 ++++++++++
 drivers/iommu/io-pgtable-arm.c               |  91 ++-
 drivers/iommu/io-pgtable.c                   |   1 +
 include/drm/drm_gem.h                        |   2 +
 include/linux/io-pgtable.h                   |   7 +
 include/uapi/drm/panfrost_drm.h              | 142 +++++
 28 files changed, 3722 insertions(+), 32 deletions(-)
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
