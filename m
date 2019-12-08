Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F78AC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC79206E0
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLHN6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 08:58:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60056 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726654AbfLHNyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 08:54:41 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1idx1B-0007dJ-79; Sun, 08 Dec 2019 13:54:37 +0000
Received: from ben by deadeye with local (Exim 4.93-RC1)
        (envelope-from <ben@decadent.org.uk>)
        id 1idx1A-0002LB-Kr; Sun, 08 Dec 2019 13:54:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David Airlie" <airlied@linux.ie>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Tomi Valkeinen" <tomi.valkeinen@ti.com>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Douglas Anderson" <dianders@chromium.org>
Date:   Sun, 08 Dec 2019 13:52:54 +0000
Message-ID: <lsq.1575813165.830287385@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 10/72] video: of: display_timing: Add of_node_put()
 in of_get_display_timing()
In-Reply-To: <lsq.1575813164.154362148@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.79-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

commit 4faba50edbcc1df467f8f308893edc3fdd95536e upstream.

=46romcode inspection it can be seen that of_get_display_timing() is
lacking an of_node_put().  Add it.

Fixes: ffa3fd21de8a ("videomode: implement public of_get_display_timing()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190722182439.44844-2-dianders@chromium.org
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/of_display_timing.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -114,6 +114,7 @@ int of_get_display_timing(struct device_
 		struct display_timing *dt)
 {
 	struct device_node *timing_np;
+	int ret;
 
 	if (!np)
 		return -EINVAL;
@@ -125,7 +126,11 @@ int of_get_display_timing(struct device_
 		return -ENOENT;
 	}
 
-	return of_parse_display_timing(timing_np, dt);
+	ret = of_parse_display_timing(timing_np, dt);
+
+	of_node_put(timing_np);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_get_display_timing);
 

