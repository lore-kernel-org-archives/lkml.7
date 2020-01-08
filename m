Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCD8C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5089C20678
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgAHQQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:16:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:52040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgAHQQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:16:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A76B4AAC3;
        Wed,  8 Jan 2020 16:16:20 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: cpia2: Fix integer overflow in mmap handling
Date:   Wed,  8 Jan 2020 17:16:19 +0100
Message-Id: <20200108161619.7999-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offset and size checks in cpia2_regmap_buffer() may ignore the
integer overflow and allow local users to obtain the access to the
kernel physical pages.

Fix it by modifying the check more carefully; the size value is
already checked beforehand and guaranteed to be smaller than
cam->frame_size*num_frames, so it's safe to subtract in the right
hand side.

This covers CVE-2019-18675.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

I'm submitting this since there hasn't been any action seen for this
bug over a month.  Let me know if there is already a fix.  Thanks.


 drivers/media/usb/cpia2/cpia2_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/cpia2/cpia2_core.c b/drivers/media/usb/cpia2/cpia2_core.c
index 20c50c2d042e..26ae7a5e3783 100644
--- a/drivers/media/usb/cpia2/cpia2_core.c
+++ b/drivers/media/usb/cpia2/cpia2_core.c
@@ -2401,7 +2401,7 @@ int cpia2_remap_buffer(struct camera_data *cam, struct vm_area_struct *vma)
 
 	if (size > cam->frame_size*cam->num_frames  ||
 	    (start_offset % cam->frame_size) != 0 ||
-	    (start_offset+size > cam->frame_size*cam->num_frames))
+	    (start_offset > cam->frame_size*cam->num_frames - size))
 		return -EINVAL;
 
 	pos = ((unsigned long) (cam->frame_buffer)) + start_offset;
-- 
2.16.4

