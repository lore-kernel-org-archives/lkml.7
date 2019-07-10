Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882C5C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6EB208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHNzvQHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfGJSLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:11:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43192 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfGJSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:11:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so1602088plb.10;
        Wed, 10 Jul 2019 11:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tkiQUH7jKLkTwFwCHjeNvDKd8Do7Dj+FovhMf1Vuvic=;
        b=eHNzvQHZfuEWGmRvlZNBGGtTB7xHUpJw6zdvQOKaJTkoQY/Ik8OyEfgE6TapG82OLm
         CXlSWeNtwDVj7Sty7PQnddjjMsvJN61sj1IcUgQYBTl/ieHiZTORfxjM9CX7lL2dv9mE
         0kXrYzOhVqovdKceYEl2el/h8Ewk3HnuBW6VS6xhJQxy9TErXviuRpRFXKOgzT9sLeTy
         ww3ONk/P1aC69XA5pmvE6JtKQugquHjEA3rwwuqh6JEmRp2ajpvAGJ4SNldP54Xs9chQ
         WeGZh3TnRh3LXF935EacLaoNy1PcnmHntbjCf+VSXBTFPRxpu5gcia+ETnAh+78bTMAe
         9UqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tkiQUH7jKLkTwFwCHjeNvDKd8Do7Dj+FovhMf1Vuvic=;
        b=t5gc0lornCnVgCo+3AvRTrvELpsvA8JkIYd+ySmigjyF8EyF0T6OpiUdPVy2UxLjNp
         5cYx09KjFUIpIc0RL84srYGQRz/UM1SUu1tuV87PP5M8jGncrTvPTdDtkPzvPjujY2aV
         B2iUVcPITCn08dbWfJkgRa6++8PXRbi5tXW/70qkXolH9gqEGDuLUXc/KKprHs32DOnz
         eT0UUohtHPXgnzrlpgIRjk4W6zj4TVtjdj+Awep0z7wWlbUtvgfbAqVZ8ErWdufGBUmy
         Y9a6cUW8V+ezk/b0lg8KPnFQ4LH0ZEaJ6lHSXghtgY3XtmIVBtt0tcm8KlijHhsJG7Gj
         bqaQ==
X-Gm-Message-State: APjAAAWq0kpNgVU7XUgapE5Nfo2KszKeL+J7R7AOiQmbyP2aAS0623F+
        exvCToqCaSKZC9d1NB+AywM=
X-Google-Smtp-Source: APXvYqyIm7dBPHQaeOhsZwKT4qMnmJ4MiYO6k+j5Dggp01zUoz5MZTRxBxhAwOD7Z0Ja+Sa3bMGAqw==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr40075670plp.126.1562782262024;
        Wed, 10 Jul 2019 11:11:02 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([106.51.16.82])
        by smtp.gmail.com with ESMTPSA id s193sm8046179pgc.32.2019.07.10.11.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jul 2019 11:11:01 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     adaplas@gmail.com, b.zolnierkie@samsung.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] video: fbdev: nvidia: Remove dead code
Date:   Wed, 10 Jul 2019 23:46:26 +0530
Message-Id: <1562782586-3994-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is dead code since 3.15. If there is no plan to use it
further, this can be removed forever.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/nvidia/nv_setup.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_setup.c b/drivers/video/fbdev/nvidia/nv_setup.c
index b17acd2..2fa6866 100644
--- a/drivers/video/fbdev/nvidia/nv_setup.c
+++ b/drivers/video/fbdev/nvidia/nv_setup.c
@@ -119,34 +119,10 @@ u8 NVReadMiscOut(struct nvidia_par *par)
 {
 	return (VGA_RD08(par->PVIO, VGA_MIS_R));
 }
-#if 0
-void NVEnablePalette(struct nvidia_par *par)
-{
-	volatile u8 tmp;
-
-	tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
-	VGA_WR08(par->PCIO, VGA_ATT_IW, 0x00);
-	par->paletteEnabled = 1;
-}
-void NVDisablePalette(struct nvidia_par *par)
-{
-	volatile u8 tmp;
-
-	tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
-	VGA_WR08(par->PCIO, VGA_ATT_IW, 0x20);
-	par->paletteEnabled = 0;
-}
-#endif  /*  0  */
 void NVWriteDacMask(struct nvidia_par *par, u8 value)
 {
 	VGA_WR08(par->PDIO, VGA_PEL_MSK, value);
 }
-#if 0
-u8 NVReadDacMask(struct nvidia_par *par)
-{
-	return (VGA_RD08(par->PDIO, VGA_PEL_MSK));
-}
-#endif  /*  0  */
 void NVWriteDacReadAddr(struct nvidia_par *par, u8 value)
 {
 	VGA_WR08(par->PDIO, VGA_PEL_IR, value);
-- 
1.9.1

