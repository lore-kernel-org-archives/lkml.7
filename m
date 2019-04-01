Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E7AC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559BC2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDAW0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:26:44 -0400
Received: from anholt.net ([50.246.234.109]:48332 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfDAW0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:26:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CC64610A28B1;
        Mon,  1 Apr 2019 15:26:42 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id AyzxENQ2BFOi; Mon,  1 Apr 2019 15:26:40 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C9EFF10A2A1B;
        Mon,  1 Apr 2019 15:26:36 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id AC2262FE33BA; Mon,  1 Apr 2019 15:26:35 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Rob Herring <robh@kernel.org>,
        Qiang Yu <yuq825@gmail.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 0/7] DRM fence list helpers, V3D CSD support.
Date:   Mon,  1 Apr 2019 15:26:28 -0700
Message-Id: <20190401222635.25013-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM fence list helpers came from needing to fix implicit
synchronization on V3D (serious flickering in X11 once you had
multiple clients involved), a bug I think I noticed in panfrost, and
having recently reviewed lima and liked their model.  Compared to
lima, I chose to use xarray as the storage, as I think it cleans
things up significantly.  The last_dep thing is a little gross, but
Matthew Wilcox is thinking about giving us an xarray pop function soon
that would let us drop that.

Unfortunately, rebasing the V3D side of things to before the job
refactor was a bit more work than I was ready for, so I'm resending it
and Ccing the Broadcom folks again in the hope that they might be able
to review or ack it.  I would still accept an ack from anyone willing
to do so -- the userspace has been sitting around for a long time at
this point, and I'd love to get it merged.

Eric Anholt (7):
  drm/v3d: Switch the type of job-> to reduce casting.
  drm/v3d: Refactor job management.
  drm/v3d: Add support for compute shader dispatch.
  drm/v3d: Drop reservation of a shared slot in the dma-buf
    reservations.
  drm: Add helpers for setting up an array of dma_fence dependencies.
  drm/v3d: Add missing implicit synchronization.
  drm/lima: Use the drm_gem_fence_array_add helpers for our deps.

 drivers/gpu/drm/drm_gem.c         |  94 ++++++
 drivers/gpu/drm/lima/lima_gem.c   |  37 +-
 drivers/gpu/drm/lima/lima_sched.c |  66 +---
 drivers/gpu/drm/lima/lima_sched.h |   6 +-
 drivers/gpu/drm/v3d/v3d_debugfs.c |  22 ++
 drivers/gpu/drm/v3d/v3d_drv.c     |  10 +-
 drivers/gpu/drm/v3d/v3d_drv.h     | 104 +++---
 drivers/gpu/drm/v3d/v3d_fence.c   |   2 +
 drivers/gpu/drm/v3d/v3d_gem.c     | 545 +++++++++++++++++++-----------
 drivers/gpu/drm/v3d/v3d_irq.c     |  24 +-
 drivers/gpu/drm/v3d/v3d_regs.h    |  73 ++++
 drivers/gpu/drm/v3d/v3d_sched.c   | 380 ++++++++++++++-------
 drivers/gpu/drm/v3d/v3d_trace.h   |  94 ++++++
 include/drm/drm_gem.h             |   5 +
 include/uapi/drm/v3d_drm.h        |  28 ++
 15 files changed, 1019 insertions(+), 471 deletions(-)

-- 
2.20.1

