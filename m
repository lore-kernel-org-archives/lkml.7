Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C7BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B131221901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HbRHDvfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfGVSZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:25:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33211 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbfGVSZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:25:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so8825848pgj.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6lPTFkPAyVmuitAa4mWi4F3NQrNbt8SbSytM3vpn0a4=;
        b=HbRHDvfM0apfHIujyRj3077zDqjerxdCRfAZo6YgD6vz6Zsc15GjN+7nPgKerlEBLN
         4yAfZGf9Wq/qgGh8pvCNUq3+QtBcnC3ykrSvr7kATX6tqP81wL1yoSc8P/qF2fL4tWaR
         hi05VT7unfKPLXhDchw25LWu4Cufs7dF1a/eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6lPTFkPAyVmuitAa4mWi4F3NQrNbt8SbSytM3vpn0a4=;
        b=TCStL0spPferWKm4T0TAnIcdem6IzUGPhAudeOsy1tBh/tXzlYehmYcz0Lpk3SqJu2
         tsW6G+uX4tlseh/s/I2VbumxX/Bsngqy0CWbdKrcUsBMmTE2fekullP7R1X9C3BgVsHk
         KEj6sqFH2J/Y/hvIsQ+fcdvWxNabgKnMVZ/uVMcH85s+W8/U+S2UwI90PsEyZoNfjmZ0
         nIai1M0w4CwBi1Zg/bo2yfTqP36oqo6oVD6e46JfSykqNVcDEHm1nMJml9vg1ezPBDVD
         8kgQlzSGM55aHneAg7IqwQxDEKK0wIBZvsTpxd9mfRPsFjscVIDtB+VJ7kRuckVowQBU
         U8hw==
X-Gm-Message-State: APjAAAVL/8BCpWZblOoOvC5OpR0rWcI2wUhoHwUgwbHP9sl2AFgRQ6Zu
        nDQ2al5cOdWvlxW76tLI/FZ9IQ==
X-Google-Smtp-Source: APXvYqwI+vy0ViASrIf3xCLwt0/dbuCnHEOUXK68q+q6D/Uk77Ehyv/s9HJa76vJ9R6YVsvovtfFjg==
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr13577531pgm.143.1563819907864;
        Mon, 22 Jul 2019 11:25:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id a3sm36117683pfl.145.2019.07.22.11.25.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:25:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] video: amba-clcd: Spout an error if of_get_display_timing() gives an error
Date:   Mon, 22 Jul 2019 11:24:39 -0700
Message-Id: <20190722182439.44844-5-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722182439.44844-1-dianders@chromium.org>
References: <20190722182439.44844-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the patch ("video: of: display_timing: Don't yell if no timing node
is present") we'll stop spouting an error directly in
of_get_display_timing() if no node is present.  Presumably amba-clcd
should take charge of spouting its own error now.

NOTE: we'll print two errors if the node was present but there were
problems parsing the timing node (one in of_parse_display_timing() and
this new one).  Since this is a fatal error for the driver's probe
(and presumably someone will be debugging), this should be OK.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/video/fbdev/amba-clcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 89324e42a033..7de43be6ef2c 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -561,8 +561,10 @@ static int clcdfb_of_get_dpi_panel_mode(struct device_node *node,
 	struct videomode video;
 
 	err = of_get_display_timing(node, "panel-timing", &timing);
-	if (err)
+	if (err) {
+		pr_err("%pOF: problems parsing panel-timing (%d)\n", node, err);
 		return err;
+	}
 
 	videomode_from_timing(&timing, &video);
 
-- 
2.22.0.657.g960e92d24f-goog

