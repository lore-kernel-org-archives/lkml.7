Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD9CC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F22C206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404035AbfIMWF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:05:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404024AbfIMWF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:05:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A715210C0925;
        Fri, 13 Sep 2019 22:05:25 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A46D7600C6;
        Fri, 13 Sep 2019 22:05:24 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/nouveau: dispnv50: Report possible_crtcs incorrectly on mstos, for now
Date:   Fri, 13 Sep 2019 18:03:53 -0400
Message-Id: <20190913220355.6883-4-lyude@redhat.com>
In-Reply-To: <20190913220355.6883-1-lyude@redhat.com>
References: <20190913220355.6883-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Fri, 13 Sep 2019 22:05:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is seperate from the previous one to make it easier to
revert in the future. Basically, while working on making MSTOs per-head
as opposed to per-head-per-connector I discovered these lovely issues:

https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
https://gitlab.gnome.org/GNOME/mutter/issues/759

Note as well that Intel already has a temporary workaround for this in
their kernel driver. So, unfortunately we need to follow suit to avoid
causing a regression in userspace. Once these issues get fixed, this
commit should be reverted.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index d23ac13763b5..f5ad20af0dd5 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2366,6 +2366,18 @@ nv50_display_create(struct drm_device *dev)
 				head->msto = NULL;
 				goto out;
 			}
+
+			/*
+			 * FIXME: This is a hack to workaround the following
+			 * issues:
+			 *
+			 * https://gitlab.gnome.org/GNOME/mutter/issues/759
+			 * https://gitlab.freedesktop.org/xorg/xserver/merge_requests/277
+			 *
+			 * Once these issues are closed, this should be
+			 * removed
+			 */
+			head->msto->encoder.possible_crtcs = crtcs;
 		}
 	}
 
-- 
2.21.0

