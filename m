Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9404C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CCB204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfDPW7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:59:02 -0400
Received: from anholt.net ([50.246.234.109]:54058 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727760AbfDPW7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:59:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EE4B610A338A;
        Tue, 16 Apr 2019 15:59:00 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id mDcjud6pLNWA; Tue, 16 Apr 2019 15:58:58 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6916410A3383;
        Tue, 16 Apr 2019 15:58:58 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id BF4A32FE3AA4; Tue, 16 Apr 2019 15:58:56 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 0/5] V3D CSD support, implicit sync fix.
Date:   Tue, 16 Apr 2019 15:58:51 -0700
Message-Id: <20190416225856.20264-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of my April 1st series, rebased on the merge of the
fence array helpers, and with little fixes for bugs reported by static
analysis and one minor race fix I noticed while re-reviewing.

Eric Anholt (5):
  drm/v3d: Switch the type of job-> to reduce casting.
  drm/v3d: Refactor job management.
  drm/v3d: Add support for compute shader dispatch.
  drm/v3d: Drop reservation of a shared slot in the dma-buf
    reservations.
  drm/v3d: Add missing implicit synchronization.

 drivers/gpu/drm/v3d/v3d_debugfs.c |  22 ++
 drivers/gpu/drm/v3d/v3d_drv.c     |  10 +-
 drivers/gpu/drm/v3d/v3d_drv.h     | 104 +++---
 drivers/gpu/drm/v3d/v3d_fence.c   |   2 +
 drivers/gpu/drm/v3d/v3d_gem.c     | 548 +++++++++++++++++++-----------
 drivers/gpu/drm/v3d/v3d_irq.c     |  24 +-
 drivers/gpu/drm/v3d/v3d_regs.h    |  73 ++++
 drivers/gpu/drm/v3d/v3d_sched.c   | 380 ++++++++++++++-------
 drivers/gpu/drm/v3d/v3d_trace.h   |  94 +++++
 include/uapi/drm/v3d_drm.h        |  28 ++
 10 files changed, 908 insertions(+), 377 deletions(-)

-- 
2.20.1

