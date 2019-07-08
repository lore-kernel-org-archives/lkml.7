Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33918C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B8320861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq23msEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfGHMdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:33:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41990 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGHMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:33:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so8202056plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cnpaUYY7PfsaPEiNSsa/HFMftAhnh6cWuyIN2oyHtQI=;
        b=oq23msEjxcp/YyvSg1o4afYr5Q8Sb2xtGTbtsbrLoZz1W5PzO5QhZmHvBqXz/kE0hJ
         dk6DJM0VLA3Kdr+aMUDHu3MU3d5cn8/1InYpj6Nseky2nJGFt7LX+ds0YBE+mI27/qiQ
         DT7bde2LtthGa0IgVWpWisyzpcHir8bFypHN+w4GfpfFhssCWKTTytBQubgvCEP0lMyi
         lbU/71Lm3LCCLvllIgEN+ifjZe5cNAjVczwL6Engpe+0K/f3wnuPumPGCKKANQYhI6V6
         MCoWFOSWje6xxISlSgoCAKTQOrsc1kmos6qF7wFtNWBLUQNR5kx3b7XxfmM6FjxstBtc
         FTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cnpaUYY7PfsaPEiNSsa/HFMftAhnh6cWuyIN2oyHtQI=;
        b=U9BeUQXdRE9Gz8cFFl4+PcCcjqTze62DusVqnwG9CaIW64Kyj+BVPGIvelkXZLMT0N
         J1v8ZP2mpAHz9GDp9fmSSXsX+bTR5lO2qtCUfHbOh1CfcxDcM6NLepE2GAiUznebJhjo
         2yy3gwOkD+L9rXy+ydDUBxVw17IbqbpAymxXRP7dwfzoyUW4ZFW1vFo9oy+Ka/LYP8ma
         yAYzjgm+9ziEzJBodc40ZlcCEXIb1mfMx/j+uJbh/048Mn6tQ2x5XqajHmSjW5Pp3Bza
         450LhZ/2zxUIi4MnDZAs+awg38g0JNZMcBdfGdU2MJpPZ9R5VW8bae4wL5aDy57XFuJw
         NupA==
X-Gm-Message-State: APjAAAXnwh4Y7p3bWqYLzV0ghZcD9pIJ63NSiP9jMx/3jiGNoUplkWm4
        t1tca6ampzfGcEgA0IawJeE=
X-Google-Smtp-Source: APXvYqw5PgsxhbaI8eUmPiNT21zGE7yXFZ6cMZ56ySR8GcW2gXlNXBV2MFZVeGhPWAum1yV27k5+pA==
X-Received: by 2002:a17:902:6b02:: with SMTP id o2mr22656033plk.99.1562589202713;
        Mon, 08 Jul 2019 05:33:22 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id j24sm23386297pgg.86.2019.07.08.05.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 05:33:22 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 06/14] drm/i2c: tda9950: Replace devm_add_action() followed by failure action with devm_add_action_or_reset()
Date:   Mon,  8 Jul 2019 20:33:15 +0800
Message-Id: <20190708123315.11897-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_add_action_or_reset() is introduced as a helper function which 
internally calls devm_add_action(). If devm_add_action() fails 
then it will execute the action mentioned and return the error code.
This reduce source code size (avoid writing the action twice) 
and reduce the likelyhood of bugs.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/i2c/tda9950.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/i2c/tda9950.c
index 8039fc0d83db..042f6487e6fb 100644
--- a/drivers/gpu/drm/i2c/tda9950.c
+++ b/drivers/gpu/drm/i2c/tda9950.c
@@ -361,9 +361,7 @@ static int tda9950_devm_glue_init(struct device *dev, struct tda9950_glue *glue)
 			return ret;
 	}
 
-	ret = devm_add_action(dev, tda9950_devm_glue_exit, glue);
-	if (ret)
-		tda9950_devm_glue_exit(glue);
+	ret = devm_add_action_or_reset(dev, tda9950_devm_glue_exit, glue);
 
 	return ret;
 }
-- 
2.11.0

