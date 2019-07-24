Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F53C76194
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F2721738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbfGXPUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:20:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33574 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:20:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id AF18728B4E7
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        stable@vger.kernel.org
Subject: [PATCH] media: vivid: fix device init when no_error_inj=1 and fb disabled
Date:   Wed, 24 Jul 2019 16:19:22 +0100
Message-Id: <20190724151922.11124-1-guillaume.tucker@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an extra condition to add the video output control class when the
device has some hdmi outputs defined.  This is required to then always
be able to add the display present control, which is enabled when
there are some hdmi outputs.

This fixes the corner case where no_error_inj is enabled and the
device has no frame buffer but some hdmi outputs, as otherwise the
video output control class would be added anyway.  Without this fix,
the sanity checks fail in v4l2_ctrl_new() as name is NULL.

Fixes: c533435ffb91 ("media: vivid: add display present control")
Cc: stable@vger.kernel.org
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 drivers/media/platform/vivid/vivid-ctrls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vivid/vivid-ctrls.c b/drivers/media/platform/vivid/vivid-ctrls.c
index 3e916c8befb7..7a52f585cab7 100644
--- a/drivers/media/platform/vivid/vivid-ctrls.c
+++ b/drivers/media/platform/vivid/vivid-ctrls.c
@@ -1473,7 +1473,7 @@ int vivid_create_controls(struct vivid_dev *dev, bool show_ccs_cap,
 	v4l2_ctrl_handler_init(hdl_vid_cap, 55);
 	v4l2_ctrl_new_custom(hdl_vid_cap, &vivid_ctrl_class, NULL);
 	v4l2_ctrl_handler_init(hdl_vid_out, 26);
-	if (!no_error_inj || dev->has_fb)
+	if (!no_error_inj || dev->has_fb || dev->num_hdmi_outputs)
 		v4l2_ctrl_new_custom(hdl_vid_out, &vivid_ctrl_class, NULL);
 	v4l2_ctrl_handler_init(hdl_vbi_cap, 21);
 	v4l2_ctrl_new_custom(hdl_vbi_cap, &vivid_ctrl_class, NULL);
-- 
2.20.1

