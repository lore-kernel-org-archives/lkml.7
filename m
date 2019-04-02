Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E581C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9E020856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbfDBNn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:43:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43640 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731515AbfDBNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:11 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe0-0002ol-J5; Tue, 02 Apr 2019 14:40:04 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004w0-8h; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Peter Rosin" <peda@axentia.se>,
        "Tomi Valkeinen" <tomi.valkeinen@ti.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Geoff Levand" <geoff@infradead.org>,
        "James Simmons" <jsimmons@users.sf.net>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "Fabian Frederick" <ffrederick@users.sourceforge.net>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.78862759@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 69/99] fbdev: fbmem: behave better with small rotated
 displays and many CPUs
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Rosin <peda@axentia.se>

commit f75df8d4b4fabfad7e3cba2debfad12741c6fde7 upstream.

Blitting an image with "negative" offsets is not working since there
is no clipping. It hopefully just crashes. For the bootup logo, there
is protection so that blitting does not happen as the image is drawn
further and further to the right (ROTATE_UR) or further and further
down (ROTATE_CW). There is however no protection when drawing in the
opposite directions (ROTATE_UD and ROTATE_CCW).

Add back this protection.

The regression is 20-odd years old but the mindless warning-killing
mentality displayed in commit 34bdb666f4b2 ("fbdev: fbmem: remove
positive test on unsigned values") is also to blame, methinks.

Fixes: 448d479747b8 ("fbdev: fb_do_show_logo() updates")
Signed-off-by: Peter Rosin <peda@axentia.se>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Fabian Frederick <ffrederick@users.sourceforge.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
cc: Geoff Levand <geoff@infradead.org>
Cc: James Simmons <jsimmons@users.sf.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/core/fbmem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -433,7 +433,9 @@ static void fb_do_show_logo(struct fb_in
 			image->dx += image->width + 8;
 		}
 	} else if (rotate == FB_ROTATE_UD) {
-		for (x = 0; x < num; x++) {
+		u32 dx = image->dx;
+
+		for (x = 0; x < num && image->dx <= dx; x++) {
 			info->fbops->fb_imageblit(info, image);
 			image->dx -= image->width + 8;
 		}
@@ -445,7 +447,9 @@ static void fb_do_show_logo(struct fb_in
 			image->dy += image->height + 8;
 		}
 	} else if (rotate == FB_ROTATE_CCW) {
-		for (x = 0; x < num; x++) {
+		u32 dy = image->dy;
+
+		for (x = 0; x < num && image->dy <= dy; x++) {
 			info->fbops->fb_imageblit(info, image);
 			image->dy -= image->height + 8;
 		}

