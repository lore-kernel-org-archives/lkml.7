Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D9C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2FD218A0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VarsZURq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbfGHSGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:06:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36305 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731096AbfGHSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:06:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so14030409qkl.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 11:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=I8jJ+UMX+62Iqns8V74zJotY7EecOGGtFx+XKKcbDpY=;
        b=VarsZURq90ygwxHNrjFAh6rbNnMR0TBSzeXPcIx1G6WMYl/iCVbjuCpFXSQMmalgxG
         ABuhiSwWf9p4tw6VEjz6ID7WK7tqr/ZHdYuOYifeXdBfvzpewaJgL7z7FmiGbjce6fQu
         oYb9e+HkhfkkrJFxPCiS179lh3lqa0ILLD1epaKvM7vjs9HFuFlQVpYF/bqP/LsIe2xw
         Ax4KGV/mFAyn3JLLWmqIiftYUsNmS8d8cr5LQAG6HIbeu7nCFCVIOORVOgo4ygL44y6j
         q3dnHlHfI86v/O+bZEZFuAbchGVk8nF/r5wCummh8518kvC35p0dCiebjC1Jp8cBkWvx
         e4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I8jJ+UMX+62Iqns8V74zJotY7EecOGGtFx+XKKcbDpY=;
        b=ccB3nSPFQDib+s4HVz0FHhXpKsiJK1YtyAOU0ojZ9CUc2PjDuRnfbbXN9XpKCBfGDw
         zaGthS8oywzeTSvgVdG/RTdhOtcUDUq2OCp26YtS4mAKFo3qKj3MQ22u9BlnO1kqvuJ1
         2T5BO9ZB31F8EAEKN9wARU2no+ApgzL8m/nybFZPyvbvy/GoZ4zh6Uq14Zz+xsarO7AT
         3B/MWZq9GNqKiw2AdytAPhiQbknHYQYHZglrjl9mLTJrlxKmQcybSSbwrtqmMpH/oAt2
         nRg3IPJ8LkYZ71RzNwURA1IY5Iodgzeujc2w5Y+HCpjohXvtcR+81XNtJGQSGDmrvPyI
         WoBA==
X-Gm-Message-State: APjAAAW3EAWJkvK/YA9C0mZHclYJmIintYtEx8INMKRgDMPqzAUIsoW8
        SeJRRXJBA5AO0rkgZhs2wbPbJA==
X-Google-Smtp-Source: APXvYqzUFZwYeyS0AHx6zXu47cd2czYyvLkLjn0iE0AaOF33sGPp7sm4eBjIM8hwSt7k6Cj+LM6jqw==
X-Received: by 2002:a37:743:: with SMTP id 64mr13812170qkh.175.1562609168824;
        Mon, 08 Jul 2019 11:06:08 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o5sm7812422qkf.10.2019.07.08.11.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 11:06:08 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        joe@perches.com, linux-spdx@archiver.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] gpu/drm_memory: fix a few warnings
Date:   Mon,  8 Jul 2019 14:05:51 -0400
Message-Id: <1562609151-7283-1-git-send-email-cai@lca.pw>
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

It becomes redundant to add both an SPDX identifier and have a
description of the license in the comment block at the top, so remove
the later.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: remove the redundant description of the license.

 drivers/gpu/drm/drm_memory.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
index 132fef8ff1b6..86a11fc8e954 100644
--- a/drivers/gpu/drm/drm_memory.c
+++ b/drivers/gpu/drm/drm_memory.c
@@ -1,4 +1,5 @@
-/**
+// SPDX-License-Identifier: MIT
+/*
  * \file drm_memory.c
  * Memory management wrappers for DRM
  *
@@ -12,25 +13,6 @@
  * Copyright 1999 Precision Insight, Inc., Cedar Park, Texas.
  * Copyright 2000 VA Linux Systems, Inc., Sunnyvale, California.
  * All Rights Reserved.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
  */
 
 #include <linux/highmem.h>
-- 
1.8.3.1

