Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F79CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA4C20673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbfJHLgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:36:04 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52426 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbfJHLgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:36:02 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iHnma-0007Yw-SX; Tue, 08 Oct 2019 12:36:00 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iHnma-0007hp-As; Tue, 08 Oct 2019 12:36:00 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 4/5] drm/nouveau/disp/gv100: make undeclared symbols static
Date:   Tue,  8 Oct 2019 12:35:58 +0100
Message-Id: <20191008113559.29569-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008113559.29569-1-ben.dooks@codethink.co.uk>
References: <20191008113559.29569-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two objects gv100_disp_wndw and gv100_disp_wndw_mthd are
not declared or used outside the file, so make them static to
avoid the following warnings:

drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c:120:1: warning: symbol 'gv100_disp_wndw_mthd' was not declared. Should it be static?
drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c:140:1: warning: symbol 'gv100_disp_wndw' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c
index 5d3b641dbb14..e635247d794f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/wndwgv100.c
@@ -116,7 +116,7 @@ gv100_disp_wndw_mthd_base = {
 	}
 };
 
-const struct nv50_disp_chan_mthd
+static const struct nv50_disp_chan_mthd
 gv100_disp_wndw_mthd = {
 	.name = "Window",
 	.addr = 0x001000,
@@ -136,7 +136,7 @@ gv100_disp_wndw_intr(struct nv50_disp_chan *chan, bool en)
 	nvkm_mask(device, 0x611da4, mask, data);
 }
 
-const struct nv50_disp_chan_func
+static const struct nv50_disp_chan_func
 gv100_disp_wndw = {
 	.init = gv100_disp_dmac_init,
 	.fini = gv100_disp_dmac_fini,
-- 
2.23.0

