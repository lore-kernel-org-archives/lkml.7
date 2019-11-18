Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1C5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040902068E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmaHxIU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfKRIJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:09:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45342 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfKRIJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:09:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so9980764pfn.12;
        Mon, 18 Nov 2019 00:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRkaKiZ0jcK6pZOODPSHPs05af1EHFvRH6r+NHDvbGM=;
        b=pmaHxIU+GCD6VEupE1hCmo/hCdEJPDzkAJsMNygngaLbm8RyaEKPo+YTSBEyzbu1St
         Lk2mlA6PYXWbfpGDclJv5JAXeYpd/R9xVBBm5QF1mLaapYKL+2VD0l06tEcqwG+hC+rv
         iZB7f6tuFby6M0JjyMAYEgJSr2V4UYoBjlKRFbWOouMn3X5Fhbkjs25K8vHvJF8327pk
         sejuBgyTiqOMzEflAc1CCskqRuGZexEIO+B86jmueVbjbAFhhWNjrhB8rWYbrBn7Hc1H
         ci7s1jDzU9rvq0Cfz/PpS2VzpdX1YHTUAHyccMaKngTLMtKrI5W95E/+wX6RryrlXVPv
         IfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vRkaKiZ0jcK6pZOODPSHPs05af1EHFvRH6r+NHDvbGM=;
        b=Cal9+Q97DkBPwGTWSZo8wMmtwnVY7PGO5/1crooJwEQjtrFIEVFlG8rpxAfW+TWzEe
         eo0bBExaquomOLejOtUDfYkOSfxrKH7TI+dqlQ3IAK6qhC830w/kzLzNYzdNebGt+mNR
         BpnyGImQU+dMjtC/u+MP8Yxg4uL4FemcqpuRZ696lVD1/6sK4Rt78CAKdcUmZe5YDdYF
         wRC6GcQlkFbvNojp8Q2i2c+MN6O34Fs/nKj02/D+NdetIysK5+n0rJUJIPcrhRiFxZ1C
         UtMN92EDWBWBGPyPBq/QUgvXHhYju9cFvDNPcoVODfdX+NSp7jOweF1nsJmv4iv+Kx2N
         lXRw==
X-Gm-Message-State: APjAAAVLjASoJDZoX7KOKgNc/qYTKOE7fYekt/oWd54lmKJFYih00XHd
        +4bqd5rrMlq6vbh2G6+QQhs=
X-Google-Smtp-Source: APXvYqyqXM4dF/Bi8sS6a38D6GEbquJXQ6xwUz/LmqrrZeJ/7Sma+NSuyAYem4JwyHzl9f78o5JtYw==
X-Received: by 2002:a62:e119:: with SMTP id q25mr33042968pfh.161.1574064551736;
        Mon, 18 Nov 2019 00:09:11 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id y24sm21273800pfr.116.2019.11.18.00.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 00:09:11 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] fbdev: s1d13xxxfb: add missed unregister_framebuffer in remove
Date:   Mon, 18 Nov 2019 16:09:00 +0800
Message-Id: <20191118080900.30634-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver calls register_framebuffer in probe but does not call
unregister_framebuffer in remove.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/s1d13xxxfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index e04efb567b5c..162003ea6b79 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -729,6 +729,7 @@ s1d13xxxfb_remove(struct platform_device *pdev)
 	struct s1d13xxxfb_par *par = NULL;
 
 	if (info) {
+		unregister_framebuffer(info);
 		par = info->par;
 		if (par && par->regs) {
 			/* disable output & enable powersave */
-- 
2.24.0

