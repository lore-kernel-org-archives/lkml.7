Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3952CC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C01620692
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404174AbfIMWhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:37:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404123AbfIMWhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:37:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84328811A9;
        Fri, 13 Sep 2019 22:37:32 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFB2510018FF;
        Fri, 13 Sep 2019 22:37:28 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/nouveau: dispnv50: Remove nv50_mstc_best_encoder()
Date:   Fri, 13 Sep 2019 18:37:20 -0400
Message-Id: <20190913223721.10185-1-lyude@redhat.com>
In-Reply-To: <20190913220355.6883-2-lyude@redhat.com>
References: <20190913220355.6883-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 13 Sep 2019 22:37:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When drm_connector_helper_funcs->atomic_best_encoder is defined,
->best_encoder is ignored by the atomic modesetting helpers. That being
said, this hook is completely broken anyway - it always returns the
first msto for a given mstc, despite the fact it might already be in
use.

So, just get rid of it. We'll need this in a moment anyway, when we make
mstos per-head as opposed to per-connector.

Changes since v1:
* Fix typo in documentation - imirkin

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index b46be8a091e9..a3f350fdfa8c 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -920,14 +920,6 @@ nv50_mstc_atomic_best_encoder(struct drm_connector *connector,
 	return &mstc->mstm->msto[head->base.index]->encoder;
 }
 
-static struct drm_encoder *
-nv50_mstc_best_encoder(struct drm_connector *connector)
-{
-	struct nv50_mstc *mstc = nv50_mstc(connector);
-
-	return &mstc->mstm->msto[0]->encoder;
-}
-
 static enum drm_mode_status
 nv50_mstc_mode_valid(struct drm_connector *connector,
 		     struct drm_display_mode *mode)
@@ -990,7 +982,6 @@ static const struct drm_connector_helper_funcs
 nv50_mstc_help = {
 	.get_modes = nv50_mstc_get_modes,
 	.mode_valid = nv50_mstc_mode_valid,
-	.best_encoder = nv50_mstc_best_encoder,
 	.atomic_best_encoder = nv50_mstc_atomic_best_encoder,
 	.atomic_check = nv50_mstc_atomic_check,
 };
-- 
2.21.0

