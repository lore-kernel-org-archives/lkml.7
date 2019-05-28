Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248C4C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE942075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KW37xWZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfE1JDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38121 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfE1JDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id g13so836423edu.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vM1aYE2ulFqwNKAI91FehOuN3FngVvZTQQrOwUdJ200=;
        b=KW37xWZVcPypjbSNTGtze1qbJdJ+h3eyy81RbWAyp7nDLbzjHN5Wkb5DfFZKHDsp2A
         v6vepSIbHMJFlOq2tkBtTV/XzHFr6pwUkmz2w01+sxCfI4CkmEqKeMStEPkcI1eaw2zU
         cTRX3cMyqjfte5kX7q5zfCLS6/JyWCmbOWE5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vM1aYE2ulFqwNKAI91FehOuN3FngVvZTQQrOwUdJ200=;
        b=O+6FV31heGqfeshqGR8o/MEenFEU0vQ4oHUQH+KKXirr4fGoTCyOAqTX1Pt3ykng/P
         n8CHDlSINFxrpGS+cSEg1fme04VxdwR7zTBBUSxue8pFKSHcKJPMfw9is5FckM9/OclJ
         9il5BiqpwUL4CvVkJk8InEJSx0J5BwHsALgfIZFxKY74fpUWgfrJjgQycOBO165lm738
         aIIla57tn6q+/c3vhRI0jYXCFrzE3Kzi7BN8L0h3Yg8/96npnh9O+aujsPPNROkNE11N
         bJcTq7dwRVabA0XF1aFLtsFLLNtSGCpi1gyV/FfDr4JybXBMrz4g7EqYUiRXB81mUgn5
         6LWw==
X-Gm-Message-State: APjAAAVqPnLTVjiNvPat949mAzXUOaNhToOOuzNWSfkjz3natTBEMSf5
        EizqceYw9PW5c67YpvCeDWl7Ah6gQX0=
X-Google-Smtp-Source: APXvYqwU3phWu021ZksHkbFLtcLsKLyfWY2d+xsu54QDYCzOWlQy1gkDllSESV1InsXH4hWCGMcBow==
X-Received: by 2002:a50:b3a6:: with SMTP id s35mr129115181edd.220.1559034210796;
        Tue, 28 May 2019 02:03:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:29 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 13/33] fbdev: sysfs files can't disappear before the device is gone
Date:   Tue, 28 May 2019 11:02:44 +0200
Message-Id: <20190528090304.9388-14-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Which means lock_fb_info can never fail. Remove the error handling.

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 44cca39f2b51..5f329278e55f 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -179,10 +179,7 @@ static ssize_t store_modes(struct device *device,
 		return -EINVAL;
 
 	console_lock();
-	if (!lock_fb_info(fb_info)) {
-		console_unlock();
-		return -ENODEV;
-	}
+	lock_fb_info(fb_info);
 
 	list_splice(&fb_info->modelist, &old_list);
 	fb_videomode_to_modelist((const struct fb_videomode *)buf, i,
@@ -409,10 +406,7 @@ static ssize_t store_fbstate(struct device *device,
 	state = simple_strtoul(buf, &last, 0);
 
 	console_lock();
-	if (!lock_fb_info(fb_info)) {
-		console_unlock();
-		return -ENODEV;
-	}
+	lock_fb_info(fb_info);
 
 	fb_set_suspend(fb_info, (int)state);
 
-- 
2.20.1

