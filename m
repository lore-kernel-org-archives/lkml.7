Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C837CC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F19B21479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg66WX9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfDTMBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:01:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40651 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfDTMBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 08:01:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so3643791pfc.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 05:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TYcqLUKwgRRyQzi5mdeTkKEfri0f6DVFA/6M4shfqls=;
        b=mg66WX9agvFJy/CrgjwOOHSCCOBN54K1XX6aHCU/0GFSW2ImILcPcw2R6Z+mOVevpz
         nSLUYLdd6VzXm0aNlSXu5YXnlljDSwAhwdgbnM/C0XgeNpIcvvy1QKEuRg6ddEMP36yi
         bLAwfMYOjIJu+1k+kqrWjyXLeyTCskFmc+mAD+GIgtha5/MzPnp/YijMwmholv7ZTi7b
         V52Eh7v8o9SwhVF+8dnBIq64Ykmx1j4muQc9wNe1AG76MgDz50mipFo72KnGE+WTQxgw
         OARFqg7aJ5MbekqAFCHlTbzHjvsBXNjT2VdcFmdE41PAE6/DaeAYSGEHWzrZyEZO1RyE
         ZYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TYcqLUKwgRRyQzi5mdeTkKEfri0f6DVFA/6M4shfqls=;
        b=pbIrJVBraK2Fs196Fnv4jiVrwcx8aN8ALl0Hw/nfrrmVQK6nJJTgBCunuUtzUyXp9v
         GeSdeGj03fOxRvZVAlv0zvRGZ/TOA6cANmaQ5WG8q7lei/mxSXs96mSeRwkCqIvv7WPp
         owRtl5U7w799TRj9qkXcT67U+gN71DVGtuS3i9WIf9hrG3RnyZak4oCKRTDjfLNrR65N
         Z+xm9SS+CmKmugWKZpJPUjQ+yNl0AxO1ixMcxevI57kPNJofyAEultxC8DEQ65lkFvVJ
         LFrnp2mT5fE2EHDcMy7kOhlM++2YBFpOVPZ5cymecDFOIrngItzsQjlH5FfYyZrfqrMm
         Flag==
X-Gm-Message-State: APjAAAWDoLSVmFXQqHAhoIPaorpNlRRKnstkekYr3Jun+r96NxUNFgPT
        vDE5Z6+lZz7qGKYU15g3K7OYpB3G2yI=
X-Google-Smtp-Source: APXvYqzDQ9cYpbqAXkdiyfbFuYzb76SIVmkTkgzr5yAL9cTcMtI4tIkb/ihzu2K9AIVCB/knM8IZ+w==
X-Received: by 2002:a63:da14:: with SMTP id c20mr4750286pgh.444.1555761684148;
        Sat, 20 Apr 2019 05:01:24 -0700 (PDT)
Received: from localhost.localdomain ([117.204.45.231])
        by smtp.gmail.com with ESMTPSA id f20sm17269742pff.176.2019.04.20.05.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 05:01:23 -0700 (PDT)
From:   MosesChristopher <moseschristopherb@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH] staging: vt665*: use help instead of ---help--- in Kconfig
Date:   Sat, 20 Apr 2019 12:01:08 +0000
Message-Id: <20190420120108.31718-1-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moses Christopher <moseschristopherb@gmail.com>

  - Resolve the following warning from the Kconfig,
    "WARNING: prefer 'help' over '---help---' for new help texts"
  - Use 8space tab instead of 3space in  vt6655/Kconfig

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/vt6655/Kconfig | 9 ++++-----
 drivers/staging/vt6656/Kconfig | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/Kconfig b/drivers/staging/vt6655/Kconfig
index 77cfc708c516..ed0cfc765677 100644
--- a/drivers/staging/vt6655/Kconfig
+++ b/drivers/staging/vt6655/Kconfig
@@ -1,6 +1,5 @@
 config VT6655
-   tristate "VIA Technologies VT6655 support"
-   depends on PCI && MAC80211 && m
-   ---help---
-   This is a vendor-written driver for VIA VT6655.
-
+	tristate "VIA Technologies VT6655 support"
+	depends on PCI && MAC80211 && m
+	help
+	  This is a vendor-written driver for VIA VT6655.
diff --git a/drivers/staging/vt6656/Kconfig b/drivers/staging/vt6656/Kconfig
index b602ef175d55..16b124ed23bc 100644
--- a/drivers/staging/vt6656/Kconfig
+++ b/drivers/staging/vt6656/Kconfig
@@ -2,6 +2,6 @@ config VT6656
 	tristate "VIA Technologies VT6656 support"
 	depends on MAC80211 && USB && WLAN && m
 	select FW_LOADER
-	---help---
-	This is a vendor-written driver for VIA VT6656.
+	help
+	  This is a vendor-written driver for VIA VT6656.
 
-- 
2.11.0

