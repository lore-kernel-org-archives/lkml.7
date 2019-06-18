Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8723FC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5959220863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfFRUej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:34:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:37354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730621AbfFRUeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:34:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92FAAAE04;
        Tue, 18 Jun 2019 20:34:36 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/3] fonts: Prefer a bigger font for high resolution screens
Date:   Tue, 18 Jun 2019 22:34:25 +0200
Message-Id: <20190618203425.10723-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190618203425.10723-1-tiwai@suse.de>
References: <20190618203425.10723-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although we may have multiple fonts in kernel, the small 8x16 font is
chosen as default usually unless user specify the boot option.  This
is suboptimal for monitors with high resolutions.

This patch tries to assign a bigger font for such a high resolution by
calculating some penalty value.  This won't change anything for a
standard monitor like Full HD (1920x1080), but for a high res monitor
like UHD 4K, a bigger font like TER16x32 will be chosen once when
enabled in Kconfig.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 lib/fonts/fonts.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/fonts/fonts.c b/lib/fonts/fonts.c
index a8e31e9d6fc5..e7258d8c252b 100644
--- a/lib/fonts/fonts.c
+++ b/lib/fonts/fonts.c
@@ -106,7 +106,7 @@ EXPORT_SYMBOL(find_font);
 const struct font_desc *get_default_font(int xres, int yres, u32 font_w,
 					 u32 font_h)
 {
-	int i, c, cc;
+	int i, c, cc, res;
 	const struct font_desc *f, *g;
 
 	g = NULL;
@@ -127,6 +127,11 @@ const struct font_desc *get_default_font(int xres, int yres, u32 font_w,
 		if ((yres < 400) == (f->height <= 8))
 			c += 1000;
 
+		/* prefer a bigger font for high resolution */
+		res = (xres / f->width) * (yres / f->height) / 1000;
+		if (res > 20)
+			c += 20 - res;
+
 		if ((font_w & (1 << (f->width - 1))) &&
 		    (font_h & (1 << (f->height - 1))))
 			c += 1000;
-- 
2.16.4

