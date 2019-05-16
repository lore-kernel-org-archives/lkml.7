Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C35CC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C792082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfEPOO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:14:59 -0400
Received: from foss.arm.com ([217.140.101.70]:47142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfEPOO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:14:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D5D51715;
        Thu, 16 May 2019 07:14:58 -0700 (PDT)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86ED53F71E;
        Thu, 16 May 2019 07:14:55 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/panfrost: drm_gem_map_offset() helper
Date:   Thu, 16 May 2019 15:14:44 +0100
Message-Id: <20190516141447.46839-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panfrost has a re-implementation of drm_gem_dumb_map_offset() with an
extra bug regarding the handling of imported buffers. However we don't
really want Panfrost calling _dumb functions because it's not a KMS
driver.

This series renames drm_gem_dumb_map_offset() to drop the '_dumb' and
introduces a shmem helper to wrap it. This means that the shmem
implementation can be kept in sync with the semantics the
drm_gem_shmem_mmap() callback provides.

v1: https://lore.kernel.org/lkml/20190513143244.16478-1-steven.price@arm.com/
Changes since v1:
 * Rename drm_gem_dumb_map_offset to drop _dumb
 * Add a shmem helper

Steven Price (3):
  drm/gem: Rename drm_gem_dumb_map_offset() to drm_gem_map_offset()
  drm: shmem: Add drm_gem_shmem_map_offset() wrapper
  drm/panfrost: Use drm_gem_shmem_map_offset()

 drivers/gpu/drm/drm_dumb_buffers.c      |  4 ++--
 drivers/gpu/drm/drm_gem.c               |  6 +++---
 drivers/gpu/drm/drm_gem_shmem_helper.c  | 20 ++++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_gem.c |  3 +--
 drivers/gpu/drm/panfrost/panfrost_drv.c | 16 ++--------------
 include/drm/drm_gem.h                   |  4 ++--
 include/drm/drm_gem_shmem_helper.h      |  2 ++
 7 files changed, 32 insertions(+), 23 deletions(-)

-- 
2.20.1

