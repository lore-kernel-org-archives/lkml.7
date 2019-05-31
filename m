Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD9FC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD034242AA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GBVdZeNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfEaVDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:03:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33106 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEaVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:03:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id 14so2660191qtf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EVoBy70val96iyRWUzgEGMhxa62G1pkCrgxgHlubNtk=;
        b=GBVdZeNpg4mBcK7MRP/Ey/Rd7KLoJSTk52Ko+aLDV94wYz+jOZUZKPppkU3b/yUX9m
         SohBmPhBlq7AU6D6tt/AQSbODHhrJxBlqhjtjYROqiQ/ZFiYyOr1wpFvy87Ny/uS1x8I
         EFtUGbi8zUSDI9BbyZ2a5lTJbHiRI6FbbH882kG4lsvRh/jUcRG5vSWJRn6rwVYgKzCs
         0/V1DZ3DCJhGUC2v1EraDMexzUlLfrrBk4vUC5o90ykYDw5sgbZZH1NwJAJBOz0vHdaR
         FCDZt+YSOikU5FIjpPT+rlaZq+A4zHc6wAXbPFfZHp/Q7WqRm+6M1v3l6+bEqrse8R8e
         rtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EVoBy70val96iyRWUzgEGMhxa62G1pkCrgxgHlubNtk=;
        b=CaY6CKeIKN1QDW66OoApLfFh/C35HmUH9i7PP8u9a5VoxZ7s0dFBDv/h0/9AQLgtKH
         QHw4B/NiyJxsdxoIIJhjeCSpu4aKJ0ZzuqGCLYbWB6VXEuAYYu9X4iBlwJBRGu72oIDc
         yjtcMmHLqA8GsRqD8PCNEYjmVuCUO//HlDv1/fkYDKsB8f7nmFet/WU3NJLmM3FmG/86
         PIHVSLsnDmBc1Kc1C3N1d+beWJU2zu7RvBXy3RxMsLdv+2i7N6wuQ0ZgigCVQ1m9qOQB
         y+gNA4LmsAQP3eqC3NOThGw5I9XZ8rDX7JBm/8a5m20TwZBEJ1VKCLZiGUSrpV9qhp+c
         k74Q==
X-Gm-Message-State: APjAAAX23GasSmYUOIJSB+tljym+FsItkrR4wQqKaQc892EYdaBKpyKF
        fO1545yXApgFtjApBCWzc4b3BQ==
X-Google-Smtp-Source: APXvYqwehGm14n5LI8yz9G+/yLlBWZ5MFCuhFETeSWsGFtJcEV1cpT/R5ISgD96cYJX85xiqaSm7jA==
X-Received: by 2002:ac8:3861:: with SMTP id r30mr11442271qtb.341.1559336613921;
        Fri, 31 May 2019 14:03:33 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d18sm862293qkj.61.2019.05.31.14.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 14:03:33 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     maarten.lankhorst@linux.intel.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] gpu/drm_memory: fix a few warnings
Date:   Fri, 31 May 2019 17:03:05 -0400
Message-Id: <1559336585-4708-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark "/**" is reserved for kernel-doc comments, so
it will generate a warning with "make W=1".

drivers/gpu/drm/drm_memory.c:2: warning: Cannot understand  * \file
drm_memory.c

Also, silence a checkpatch warning,

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

Signed-off-by: Qian Cai <cai@lca.pw>
---
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

