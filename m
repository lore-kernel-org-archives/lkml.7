Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77906CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C9120874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNZPLsM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfJ2XWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 19:22:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41823 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfJ2XW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:22:28 -0400
Received: by mail-qt1-f193.google.com with SMTP id o3so620891qtj.8;
        Tue, 29 Oct 2019 16:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NL5NHkQo49SzWvXcG4GM9cxAAP6UXPgbkUHRM9GwPRM=;
        b=BNZPLsM/pFTx/j8tsrlHokltVoy7lphtIngmNZpMI7tw7cLyH+x1Og5Vgy0PKhIRck
         +REO+9To7CtKlPkEIDVjccdwXUWJTlJNGr/cGUPguD838pybkp3K5eu0Tgt+CGGBSI7g
         94gPtvnJJszTMW58jNGi8VxZEG6Ikrv65kQzvWnyoJTi4enJoykJL5zCXe4KzHlhVUXt
         RC8d8W32ZWzNmI1UCnDKCQN/m1JONdnt8sIFpK4JfvrA47FuKMr+zgvg2ux5ym41wzUd
         aYBIhelWxNe+xOlF7jwb+bmMepE/jN2ZxbiTEwAZImGODD6m/MXYViD8tEBpxvbamKHD
         9TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NL5NHkQo49SzWvXcG4GM9cxAAP6UXPgbkUHRM9GwPRM=;
        b=UVeO5Os15oQ9VAzIDvZyOVTizRZ5cqjwuK/IFNsRfVfPyOKGfHjDu9fRJNKeK3Yj/o
         uphskCIAiWPdXMXuRvoQkgNySD++cLRknbtmktHExl0Mj2pUd602fhau1fdaw6/HydzA
         UjYSfehHqsqTzxe39SO9IYhfcFnPbY+QEsnFywi3EUkaHRhFUIx59zsEK3/OcetQ8xFR
         6Uh+lg8RDeykwtavhHg4VJyDMaAx1Itkox2cxOzxKpZVjsGmQOygzQ0XrJZmT1EqJ1qm
         ZVnwcd8L9fQ7eHOvOn1TkJpOd1CmZKM/iADdBWCCQ8acR7upjNJJc1/5dlxUWfNR/TMl
         V2sg==
X-Gm-Message-State: APjAAAXYRmz2nWjlyH5LsLaSBF4gO1Rf4OlCoy3N5XnOc09jfxiFWnfR
        wtQzF8gFJm2gwCvelLuOWG4=
X-Google-Smtp-Source: APXvYqzQxW5G8EXq8zMyuMWTrYVdA+nHFpY0Mk0GHbknCXVXGWlpjdvhbi2ZPPAhch3mQfE6x+0ZAA==
X-Received: by 2002:ac8:117:: with SMTP id e23mr2054008qtg.82.1572391347698;
        Tue, 29 Oct 2019 16:22:27 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-85-136.wifi.ic.unicamp.br. [177.220.85.136])
        by smtp.gmail.com with ESMTPSA id a18sm633940qkc.2.2019.10.29.16.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 16:22:27 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 2/2] staging: sm750fb: Replace multiple spaces with tabs when it suits
Date:   Tue, 29 Oct 2019 20:22:07 -0300
Message-Id: <20191029232207.4113-3-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029232207.4113-1-gabrielabittencourt00@gmail.com>
References: <20191029232207.4113-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace multiple spaces before some comments with one tab. Aligning the
comment with the function below it.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 5925d7c7d464..8faa601c700b 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -243,21 +243,21 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 */
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase); /* dpr44 */
 
-    /*
-     * Program pitch (distance between the 1st points of two adjacent lines).
-     * Note that input pitch is BYTE value, but the 2D Pitch register uses
-     * pixel values. Need Byte to pixel conversion.
-     */
+	/*
+	 * Program pitch (distance between the 1st points of two adjacent lines).
+	 * Note that input pitch is BYTE value, but the 2D Pitch register uses
+	 * pixel values. Need Byte to pixel conversion.
+	 */
 	write_dpr(accel, DE_PITCH,
 		  ((dPitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
 		  (sPitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
-    /*
-     * Screen Window width in Pixels.
-     * 2D engine uses this value to calculate the linear address in frame buffer
-     * for a given point.
-     */
+	/*
+	 * Screen Window width in Pixels.
+	 * 2D engine uses this value to calculate the linear address in frame buffer
+	 * for a given point.
+	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
 		  ((dPitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-- 
2.20.1

