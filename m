Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4910FC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2162920856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbfDBNtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:49:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59435 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731168AbfDBNtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:49:19 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mgr@pengutronix.de>)
        id 1hBJmn-0007VO-Jv; Tue, 02 Apr 2019 15:49:09 +0200
Received: from mgr by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <mgr@pengutronix.de>)
        id 1hBJmm-0001Cu-Nz; Tue, 02 Apr 2019 15:49:08 +0200
From:   Michael Grzeschik <m.grzeschik@pengutronix.de>
To:     p.zabel@pengutronix.de, airlied@linux.ie,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        dri-devel@lists.freedesktop.org, rafael@kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 0/3] Fix for drm_mode_config_cleanup issue
Date:   Tue,  2 Apr 2019 15:49:01 +0200
Message-Id: <20190402134904.588-1-m.grzeschik@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <0687f68004b28ed3a364b06a9eb64e2e@agner.ch>
References: <0687f68004b28ed3a364b06a9eb64e2e@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the issue: "drm/imx: Crash in drm_mode_config_cleanup".

Which was documented here:

https://www.spinics.net/lists/dri-devel/msg189388.html

And tried to address with this:

https://patchwork.kernel.org/patch/10633297/
https://patchwork.kernel.org/patch/10633299/

This series fixes the possible case of use after free by adding action
functions to the devres cleanup path. So it will ensure the generic
cleanup code will not use the already freed memory.


Michael Grzeschik (3):
  ipuv3-crtc: add remove action for devres data
  ipuv3-ldb: add init list head on bind
  ipuv3-ldb: add remove action for devres data

 drivers/gpu/drm/imx/imx-ldb.c    | 35 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/ipuv3-crtc.c | 12 +++++++++++
 2 files changed, 47 insertions(+)

-- 
2.20.1

