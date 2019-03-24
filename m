Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFCCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A632220989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="p6FDm876"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfCXXQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 19:16:10 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:47722 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbfCXXQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 19:16:09 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 7CA6B75B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 23:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qF8IgVf03wOm for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 18:16:08 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4A97964B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 18:16:08 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id 9so7656566ita.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 16:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UMAQnPK8j5lO5BOxxgj71E79FbIAa75eJ6alCWr8K1k=;
        b=p6FDm876+CtOb/WltSl9lshn+E4ZUw6BKrh0KCI2oxFFnrbPVDnkvvDE3hupwAH9sc
         rN9uUgROqngd3IrnGtE4VC0Q5gVPT8cZBKYCIcD1nTKk/QZvgdokrS2ZfW9e1ZOKXgx4
         d7MaYScWMo4kbmOoS/GoJWaWtTxH/8ilwZmcoS3HG8AZ4HjF1E01AVVsMy+weCoy6Gvp
         MeaNDDz/ZFaXQEdSaxj7wspCXzIMIIP+4ZBLK8ETxyLxYJurkg5M6rxSYvZjvRaUatCS
         xo2Wc1WJqcKYUDPxcrQLHHcCO6tZclOWFrSgkMIu9y4W/AXWKY+D3VViBmvU64HXu8sx
         nXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UMAQnPK8j5lO5BOxxgj71E79FbIAa75eJ6alCWr8K1k=;
        b=Dnk7vC5N48wdgAnmhc/R7FmY+nzFf7tZvev4lkBGKq6QPC4ZjKObiP6PZ1aKTQ38Ha
         lrRiMLR6pdnjFqi8Qm5N7jkSNqS6H/4clihP84TJczQeGgxA4ZkEWFdc7ko/757cOFYW
         kY0f3zyUnrEEhr0pMurWF8lMgIqA7TU1Oywx2kTuObeLeJ4g1bHEpNi8m4WtGip0B58Z
         HuTlb4ZLRfFJ1LJ0MY4T1mN0wCiQ4Eq++TwQ34JbTdk5jxZTwZ98TC3GHAFs5N4I46ii
         Kyq0HG+rzrUlLx4TS1GRle5JBf9jGUfTkrJRVFyGUFg/xBX7aqalxeT9kWBrVq71vvMy
         P3Bg==
X-Gm-Message-State: APjAAAWqzvxmhiZaUR99bILwzgqurs8Tg/Q8UzAjvEh+S8EFSMXtXBtP
        tXX1ui/fb9/QWxKkJknu0PBOKtlM8tM5mvEdJvTXDYpYnjVxH+d9ZZ1xtdME61QFNM4OkpAzmC7
        JaXNsobH4o8UkAUDBus9TrjyVY4NJ
X-Received: by 2002:a24:66c8:: with SMTP id k191mr9041392itc.20.1553469367963;
        Sun, 24 Mar 2019 16:16:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQmdvSQx0UEc7t6VCyV20zttcRLKZUoiSr/ZW9vSuUpYzSY3m3DYXu4MH75EjHhgiz+c0+pw==
X-Received: by 2002:a24:66c8:: with SMTP id k191mr9041383itc.20.1553469367773;
        Sun, 24 Mar 2019 16:16:07 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id g186sm8731444iof.41.2019.03.24.16.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 16:16:06 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: v3d: fix a missing check of pm_runtime_get_sync
Date:   Sun, 24 Mar 2019 18:16:02 -0500
Message-Id: <20190324231602.2436-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync could fail and thus deserves a check.

The patch adds such a check and return its error code upstream
if it indeed failed.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index f0afcec72c34..99daad11fac2 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -101,6 +101,8 @@ static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 			return -EINVAL;
 
 		ret = pm_runtime_get_sync(v3d->dev);
+		if (ret < 0)
+			return ret;
 		if (args->param >= DRM_V3D_PARAM_V3D_CORE0_IDENT0 &&
 		    args->param <= DRM_V3D_PARAM_V3D_CORE0_IDENT2) {
 			args->value = V3D_CORE_READ(0, offset);
-- 
2.17.1

