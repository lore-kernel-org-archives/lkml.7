Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D77AC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F053C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfF1MGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:06:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53974 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF1MGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:06:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 93077263955
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v4 0/2] handle vblank when disabling ctc with interrupt disabled 
Date:   Fri, 28 Jun 2019 13:05:30 +0100
Message-Id: <cover.1561722822.git.bob.beckett@collabora.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add warning when about to send stale vblank.
Revert change that stops vblank info being updated if interrupts already
disabled. This fixes a stale vblank timestamp issue seen on drm/imx.


Changes since v2:
Split up the patch in to smaller pieces.
Add warning when about to send bogus vblank event.
Update vblank to best guess info during drm_vblank_disable_and_save.

Changes since v3:
Update cover letter text to describe remaining actions.
Drop drm/imx patches as they have now been merged.
Replace vblank info estimation patch with a revert of the issue that
caused the need for estimation.

Robert Beckett (2):
  drm/vblank: warn on sending stale event
  Revert "drm/vblank: Do not update vblank count if interrupts are
    already disabled."

 drivers/gpu/drm/drm_vblank.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

-- 
2.18.0

