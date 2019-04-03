Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E98C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5A7206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDCQDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:03:37 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:50652 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfDCQDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:03:36 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 8E9467A3979475E7A8BC
        for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2019 00:03:33 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x33G3NU2028342
        for <linux-kernel@vger.kernel.org>; Thu, 4 Apr 2019 00:03:23 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019040400034942-7533727 ;
          Thu, 4 Apr 2019 00:03:49 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 0/7] fix possible object reference leaks in drivers/gpu
Date:   Thu, 4 Apr 2019 00:04:08 +0800
Message-Id: <1554307455-40361-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-04 00:03:49,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-04 00:03:15,
        Serialize complete at 2019-04-04 00:03:15
X-MAIL: mse01.zte.com.cn x33G3NU2028342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_cpu_node/of_find_compatible_node/of_parse_phandle...
returns a node pointer with refcount incremented thus it must be
explicitly decremented after the last usage.

This patch series fix those possible object reference leaks in drivers/gpu.

Wen Yang (7):
  drm/mediatek: fix possible object reference leak
  drm/meson: fix possible object reference leak
  drm/msm: a5xx: fix possible object reference leak
  drm/omap: fix possible object reference leak
  drm/pl111: fix possible object reference leak
  drm: rcar-du: fix possible object reference leak
  drm/tegra: fix possible object reference leak

 drivers/gpu/drm/mediatek/mtk_hdmi.c             |  1 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c           |  7 ++-----
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c           | 10 ++++++----
 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c |  5 ++++-
 drivers/gpu/drm/pl111/pl111_versatile.c         |  4 ++++
 drivers/gpu/drm/rcar-du/rcar_du_of.c            |  2 ++
 drivers/gpu/drm/tegra/output.c                  |  2 ++
 drivers/gpu/drm/tegra/rgb.c                     |  8 ++++++--
 8 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.9.5

