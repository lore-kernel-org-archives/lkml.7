Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F3FC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B862166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfKFLQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:16:22 -0500
Received: from cnc.isely.net ([75.149.91.89]:43795 "EHLO cnc.isely.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfKFLQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:16:22 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Nov 2019 06:16:21 EST
Received: from ts3-dock2.isely.net (ts3-dock2.isely.net [::ffff:192.168.23.14])
  (AUTH: PLAIN isely, TLS: TLSv1/SSLv3,256bits,DHE-RSA-AES256-GCM-SHA384)
  by cnc.isely.net with ESMTPSA; Wed, 06 Nov 2019 05:11:15 -0600
  id 00000000001420F5.000000005DC2AA53.00004E44
Date:   Wed, 6 Nov 2019 05:11:14 -0600 (CST)
From:   Mike Isely <isely@pobox.com>
X-X-Sender: isely@sheridan.isely.net
Reply-To: Mike Isely at pobox <isely@pobox.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc:     Mike Isely at pobox <isely@pobox.com>
Subject: [PATCH] pvrusb2: Fix oops on tear-down when radio support is not
 present
Message-ID: <alpine.DEB.2.21.1911060510410.31133@sheridan.isely.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some device configurations there's no radio or radio support in the
driver.  That's OK, as the driver sets itself up accordingly.  However
on tear-down in these caes it's still trying to tear down radio
related context when there isn't anything there, leading to
dereferences through a null pointer and chaos follows.

How this bug survived unfixed for 11 years in the pvrusb2 driver is a
mystery to me.

Signed-off-by: Mike Isely <isely@pobox.com>
---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index aa4fbc3e88cc..339119f6cc23 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -909,8 +909,12 @@ static void pvr2_v4l2_internal_check(struct pvr2_channel *chp)
 	pvr2_v4l2_dev_disassociate_parent(vp->dev_video);
 	pvr2_v4l2_dev_disassociate_parent(vp->dev_radio);
 	if (!list_empty(&vp->dev_video->devbase.fh_list) ||
-	    !list_empty(&vp->dev_radio->devbase.fh_list))
+	    ((vp->dev_radio != NULL) &&
+	     !list_empty(&vp->dev_radio->devbase.fh_list))) {
+		pvr2_trace(PVR2_TRACE_STRUCT,
+			   "pvr2_v4l2 internal_check exit-empty id=%p", vp);
 		return;
+	}
 	pvr2_v4l2_destroy_no_lock(vp);
 }
 
@@ -946,7 +950,8 @@ static int pvr2_v4l2_release(struct file *file)
 	kfree(fhp);
 	if (vp->channel.mc_head->disconnect_flag &&
 	    list_empty(&vp->dev_video->devbase.fh_list) &&
-	    list_empty(&vp->dev_radio->devbase.fh_list)) {
+	    ((vp->dev_radio == NULL) ||
+	     list_empty(&vp->dev_radio->devbase.fh_list))) {
 		pvr2_v4l2_destroy_no_lock(vp);
 	}
 	return 0;
-- 
2.20.1
