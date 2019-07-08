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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915CBC606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6640720861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4STA3iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfGHMdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:33:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42104 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGHMdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:33:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so7541578pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=twuCq4CMuW36LIT7fXsJGUM7Fs1QiuVh+SZP8dTMu2g=;
        b=g4STA3iwGzf928aVXnjUh7FKMoEON/A89yQ4VfN8v8WA0TkIPrB/mJSsAAOiAU8u1t
         tqaGBFR7dR4ihWaglx5Ywd4HhP8UsifMqbm2F8uSzao9BzHOWY+hk91xpRLWM8Dd3Cdx
         d271Vp/adwXnRtdYqwW6k+b70cG0MQuA1G/yOMnRhRCVkcpZg2/O/Uzo8PlqAbeEuYr+
         UmHE5mZy0Cp9qcj84PbewFV8wYeoAKPIBLlXYsa1fjc4u3+gMjpU6fCgwzsfRciGoG/8
         CIDTglFoC99p447X+CHPDbAjdiHns7MG3z5WsSd8D2Jb/nLs7tmjnu3LWcROvruibWe0
         33Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=twuCq4CMuW36LIT7fXsJGUM7Fs1QiuVh+SZP8dTMu2g=;
        b=GWHgeZWDSJiiTz+jtRPZqiQEHMjm4bqfJP4zSZtyrdfrE9tj3c+VydSJOo6Dmvuctn
         4wXVDFXWIHn8CVF//hgcYCAzOjNZDfCH4wD6jR4h7kFpPSZ4QYQ0Fo0360ZNDJtAOiV+
         k+QlztJ4nCLEtoNBqLeMkhsdAStMnfJV+ADnWczKvBX4hj8m2bRzgRkZOJovt+aCfznl
         vN84XJH/w1Vdb8HsFPZhtz9jT5NKXe0q3PVpE/g3gBFidTyxJdBAyq8UTwCafhXc8ToD
         NSGjbsqP6H3CnyguZuG+z0fIJK8movW0HItCur3FlerMCeAoJ4DAPEAnyxq/0/2BOLQv
         9whA==
X-Gm-Message-State: APjAAAVhgEamFhemYZJNdmLc0ZQpTEO8yahTo/brRbG5YmBJc9P5lihT
        t0w0JmV6QfK0+61ovK/yQlQ=
X-Google-Smtp-Source: APXvYqwOCIYDwfW3ZxqxI8lfOzFQLxdaJusZemcs3HS67k3h0J/DeXoOKpv3z08uR7WcumYix3/XpQ==
X-Received: by 2002:a17:90a:ab01:: with SMTP id m1mr24348826pjq.69.1562589194511;
        Mon, 08 Jul 2019 05:33:14 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id m13sm14784236pgv.89.2019.07.08.05.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 05:33:14 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 05/14] drm/drv: Replace devm_add_action() followed by failure action with devm_add_action_or_reset()
Date:   Mon,  8 Jul 2019 20:33:06 +0800
Message-Id: <20190708123306.11851-1-huangfq.daxian@gmail.com>
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
 drivers/gpu/drm/drm_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 862621494a93..dd004ebbb5fd 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -760,9 +760,7 @@ int devm_drm_dev_init(struct device *parent,
 	if (ret)
 		return ret;
 
-	ret = devm_add_action(parent, devm_drm_dev_init_release, dev);
-	if (ret)
-		devm_drm_dev_init_release(dev);
+	ret = devm_add_action_or_reset(parent, devm_drm_dev_init_release, dev);
 
 	return ret;
 }
-- 
2.11.0

