Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D702C73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A2D2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Kk5VH4hW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfGIPNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:13:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37660 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGIPNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:13:44 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so16286478qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WHvzwCCcvuwidmEeTSDSKbjZ51f0w3J+bTcRkdflHTQ=;
        b=Kk5VH4hWg+nQngt8M3wARa7Aa4RZtgZyR+LKlATJywlzSNp0c3+TqdFsgFRG4GpGwp
         BAZE3L+hS/o687mtHqDpLu46LTqSKryJinawDjomq+2NuZR9VV0t17540i5vjqszvpW0
         wm/l5BJxrDw63hYBEWqlKdCxPEy4SVGTbF3vG+g7PFfgzomOuQoVlV7o/y3VaxMSFu8f
         FV+1fBdha9fUV8C3u/0g7YxKoW9YwAlAwYG33KW6GHzfBzhxqmcIIinacC9qVQUf9lZi
         hmBlm0oRftFePYw3SXxhJ4pVdXO4AOuOisfhQ4PNd2dJqK/WD2pzLCMYGMWmgzM+9SXM
         koOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WHvzwCCcvuwidmEeTSDSKbjZ51f0w3J+bTcRkdflHTQ=;
        b=bxW4JAKYkZcAQh3DnGvmV3Q8/UdF9QdF+NvbymiIPIdYWgB4yR4eswc95OrbDR/xyX
         eB4PMa+ef2u7+YCR308iuIU6Nnim7JNxyVXQUUoou4YWyGkF4MppnsTPSHeLDKBBKqZe
         EE7t9GH/bufPBrf74YUdkWVPypy2TE5U3nYRzF0sRTHz2wEo9iArfdcyGWUUJBpkVFFH
         CWH7FXhdxL5Q0dj+6+7HlTpbBlSoj4W6H+sY5Q4xpRUhMYu4IRrS8mvDpTG8pO4kFqCZ
         4CcGwWjg36qjT6DJq3LKCd65xoZuD3E70eTQ1dC2ThcOECCovsMa1ovf0SMLiLaOIXg2
         Wgeg==
X-Gm-Message-State: APjAAAUp+wudNL+Mk4sBRdDrVyiWAa8oadjt50diD1kMpW6dkCZ+bbmr
        IQQKotK9mx9ERR2UQluHxJFpaJF+K6IrQQ==
X-Google-Smtp-Source: APXvYqyxXEO5ObwdhLEx98Jnglsk7WZ63no55kPV1Lr36Qo6VDYUS0XbtMZ1K1zgeQx7228hhG8x5w==
X-Received: by 2002:ae9:de81:: with SMTP id s123mr19043791qkf.339.1562685223713;
        Tue, 09 Jul 2019 08:13:43 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a135sm6606670qkg.72.2019.07.09.08.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 08:13:42 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     imirkin@alum.mit.edu, airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        joe@perches.com, rfontana@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-spdx@archiver.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3] gpu/drm_memory: fix a few warnings
Date:   Tue,  9 Jul 2019 11:13:10 -0400
Message-Id: <1562685190-1353-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark "/**" is reserved for kernel-doc comments, so
it will generate a warning with "make W=1".

drivers/gpu/drm/drm_memory.c:2: warning: Cannot understand  * \file
drm_memory.c

Also, silence a checkpatch warning by adding a license identfiter where
it indicates the MIT license further down in the source file.

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

Fix it by adding the MIT SPDX identifier without touching the boilerplate
language.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: Keep the boilerplate language.
v2: Remove the redundant description of the license.

 drivers/gpu/drm/drm_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
index 132fef8ff1b6..683042c8ee2c 100644
--- a/drivers/gpu/drm/drm_memory.c
+++ b/drivers/gpu/drm/drm_memory.c
@@ -1,4 +1,5 @@
-/**
+// SPDX-License-Identifier: MIT
+/*
  * \file drm_memory.c
  * Memory management wrappers for DRM
  *
-- 
1.8.3.1

