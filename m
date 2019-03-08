Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870EEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555E120657
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCHQRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:17:20 -0500
Received: from anholt.net ([50.246.234.109]:52524 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfCHQRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:17:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1767D10A2E2F;
        Fri,  8 Mar 2019 08:17:19 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 1yUUo0CszL-l; Fri,  8 Mar 2019 08:17:17 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 50E0F10A2E21;
        Fri,  8 Mar 2019 08:17:17 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 217D72FE4653; Fri,  8 Mar 2019 08:17:16 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 0/4] drm/v3d: Add drm core helper, use shmem helpers
Date:   Fri,  8 Mar 2019 08:17:12 -0800
Message-Id: <20190308161716.2466-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was inspired by Rob's respin of the shmem helpers patch for
panfrost (which the final patch depends on).  And, looking at panfrost
and lima, recently I realized that we all had some nasty cargo-cult
code for BO reservations that we can share now that the reservation
object is in the core GEM struct.

Eric Anholt (4):
  drm: Add helpers for locking an array of BO reservations.
  drm/v3d: Use drm_gem_lock_reservations()/drm_gem_unlock_reservations()
  drm/v3d: Remove some dead members of struct v3d_bo.
  drm/v3d: Use the new shmem helpers to reduce driver boilerplate.

 drivers/gpu/drm/drm_gem.c     |  76 +++++++++
 drivers/gpu/drm/v3d/Kconfig   |   1 +
 drivers/gpu/drm/v3d/v3d_bo.c  | 309 ++++++++++------------------------
 drivers/gpu/drm/v3d/v3d_drv.c |  27 +--
 drivers/gpu/drm/v3d/v3d_drv.h |  25 +--
 drivers/gpu/drm/v3d/v3d_gem.c |  67 ++------
 drivers/gpu/drm/v3d/v3d_irq.c |   8 +-
 drivers/gpu/drm/v3d/v3d_mmu.c |  34 +++-
 include/drm/drm_gem.h         |   4 +
 9 files changed, 220 insertions(+), 331 deletions(-)

-- 
2.20.1

