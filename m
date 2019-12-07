Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE147C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51BD217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uT5QOxiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLGS2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 13:28:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55994 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLGS2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 13:28:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so11238805wmj.5;
        Sat, 07 Dec 2019 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6CRHheWLEsRhea36/j1vP5N19p+TB3XZ3DGdmSAxY+0=;
        b=uT5QOxiUN7wOISYIchdN3/PmOfAiDusyP/3xELKBch63BgEYJS/uYGIfsWqv87jsmu
         q7Co9vy0nDosT1cUVMsCFyy+su3e3F/BMt8Q8h3UkMBkDbqKTRdbVe15NLv6qXrgeg1f
         yIdiS3C6dGW1FY52iwm4TDxH5seHfqzDLnqdiMKsSQgW0GeVjQVF3OImxY01EGGr2mfw
         Xy5RXz2CZ0dZ0CVatOGacBj4sgb4u45knr4btZt3tAN47b/sioSYxrAdooVibv06e124
         AK0JYoEOM7RmMyw1gJdFSALw8VVKgU+pGPyo98qDtOpSb3FWzsQVT22gX0lq0MNxVsmP
         LxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6CRHheWLEsRhea36/j1vP5N19p+TB3XZ3DGdmSAxY+0=;
        b=dxB5cmLWOCvB6LOBNMGT0E2ke5CS9lcX6ZAUGHW65Ec/J9r8ZE29W8qSfmx/wGYWxE
         b581PblfwchM8oiHW72NGk9B+JfRpZOZC4dGRD+OM26nc4uwMGJ2v++9YSqp1a70aDVi
         RAYvKn4IZ8khEqSIZdiC3MneiwZNupPEB3evMYUbbo655qgyXJR/2Nfxtj5Uev6Gkwdk
         0gRvHG8IOi221RiXrILgWDd24BCNQQq7hTyTYje6ohyAl6tQjaTDeUY291yWBhLla8gl
         6ggo2PrymZFGhOgK4EYNUHNERP+vVN/p8oYTKFnifIx8sXzWw/ZCBi9ekGaaPNTkaOtg
         oZzg==
X-Gm-Message-State: APjAAAW4g9TqnvORPzAHSAP2xzd+jiNGuxEerFDrUFpFe96w6rXW2sjL
        rlGVPn1Ehi79cIXjYviZogY=
X-Google-Smtp-Source: APXvYqyJBoKhsHw8vUh5/YF12V78QSjF7lV2IvsYf8eavpLbi8FeJ4WWVyHTNk+J4Ph9yNS1oRM6Yw==
X-Received: by 2002:a1c:2745:: with SMTP id n66mr16850372wmn.171.1575743288012;
        Sat, 07 Dec 2019 10:28:08 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4f:f100:30e3:988a:bff1:5a99])
        by smtp.gmail.com with ESMTPSA id z3sm20291562wrs.94.2019.12.07.10.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 10:28:07 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Micah Morton <mortonm@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: fix style in SAFESETID SECURITY MODULE
Date:   Sat,  7 Dec 2019 19:27:51 +0100
Message-Id: <20191207182751.14249-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fc5b34a35458 ("Add entry in MAINTAINERS file for SafeSetID LSM")
slips in some formatting with spaces instead of tabs, which
./scripts/checkpatch.pl -f MAINTAINERS complains about:

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #14394: FILE: MAINTAINERS:14394:
  +M:     Micah Morton <mortonm@chromium.org>

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #14395: FILE: MAINTAINERS:14395:
  +S:     Supported

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #14396: FILE: MAINTAINERS:14396:
  +F:     security/safesetid/

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #14397: FILE: MAINTAINERS:14397:
  +F:     Documentation/admin-guide/LSM/SafeSetID.rst

Fixes: fc5b34a35458 ("Add entry in MAINTAINERS file for SafeSetID LSM")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master (eea2d5da29e3) and next-20191207

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 59d4cb7b2981..f282e5cbc40e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14391,10 +14391,10 @@ F:	drivers/media/pci/saa7146/
 F:	include/media/drv-intf/saa7146*
 
 SAFESETID SECURITY MODULE
-M:     Micah Morton <mortonm@chromium.org>
-S:     Supported
-F:     security/safesetid/
-F:     Documentation/admin-guide/LSM/SafeSetID.rst
+M:	Micah Morton <mortonm@chromium.org>
+S:	Supported
+F:	security/safesetid/
+F:	Documentation/admin-guide/LSM/SafeSetID.rst
 
 SAMSUNG AUDIO (ASoC) DRIVERS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
-- 
2.17.1

