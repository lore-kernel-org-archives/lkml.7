Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D1FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710D220673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfJHLgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:36:02 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52415 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbfJHLgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:36:02 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iHnma-0007Yt-I5; Tue, 08 Oct 2019 12:36:00 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iHnma-0007hg-6Z; Tue, 08 Oct 2019 12:36:00 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/5] drm/nouveau/gr/gf100-: make undeclared symbols static
Date:   Tue,  8 Oct 2019 12:35:55 +0100
Message-Id: <20191008113559.29569-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following functions are not declared outside of the
file they are in, so make them static to avoid these
warnings:

drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:745:1: warning: symbol 'gf100_gr_fecs_start_ctxsw' was not declared. Should it be static?
drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:760:1: warning: symbol 'gf100_gr_fecs_stop_ctxsw' was not declared. Should it be static?
drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:2071:1: warning: symbol 'gf100_gr_ctor_fw_legacy' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
index c578deb5867a..f1d1174ce67a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -741,7 +741,7 @@ gf100_gr_fecs_ctrl_ctxsw(struct gf100_gr *gr, u32 mthd)
 	return -ETIMEDOUT;
 }
 
-int
+static int
 gf100_gr_fecs_start_ctxsw(struct nvkm_gr *base)
 {
 	struct gf100_gr *gr = gf100_gr(base);
@@ -756,7 +756,7 @@ gf100_gr_fecs_start_ctxsw(struct nvkm_gr *base)
 	return ret;
 }
 
-int
+static int
 gf100_gr_fecs_stop_ctxsw(struct nvkm_gr *base)
 {
 	struct gf100_gr *gr = gf100_gr(base);
@@ -2067,7 +2067,7 @@ gf100_gr_ = {
 	.ctxsw.inst = gf100_gr_ctxsw_inst,
 };
 
-int
+static int
 gf100_gr_ctor_fw_legacy(struct gf100_gr *gr, const char *fwname,
 			struct gf100_gr_fuc *fuc, int ret)
 {
-- 
2.23.0

