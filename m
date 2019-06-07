Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46F9C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD472133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="U0jHKnAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfFGTBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:01:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37439 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfFGTBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:01:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id y57so3525823qtk.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OVNp7A8pa63b39LGeGO0+BUI6zrsYRO5zNAmwKq0LBc=;
        b=U0jHKnAOAdAWxUOGDXNsmx5Jm95O6XYUZ7a94ZUt/5xsz86pDwdhT+eiceiklkvv5P
         yipQfcAbQOcAmLgsS5zLM7Es8pJ6apk9uY3gc04yOg4O60xQrvwYFpUz1VHkLabmN8bM
         6leFR6L964sQCVjVUHq2OmG+J49sbtkgeCtc2ncWJE1L2WzEhorDMfnqvXq1xRomEoX2
         0ZNb0OP5Qm/P8b+Vf3nCFi2K6lA1X9WVeAEoF0Y61tRg1umrXIM5sq7MMGmhwWAk+qt2
         6BLDs97on83MP6j8RYITQRD3/j/VTPOtMgDwc7JC1DdzFDRxPHa1SIPQLRR+vjuBNDxN
         f08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OVNp7A8pa63b39LGeGO0+BUI6zrsYRO5zNAmwKq0LBc=;
        b=fbJa8U9iFw2vDfTM5Qvkj/3/Ydyi0teHD4GmK8gfnAjLE+L5FYCp22f7X6cqzRQG1Q
         /IsEEIkf3C4/Bs7MORo2XL80D/ti5dkjtMEe6nlywnCLNq4C69Own5Vxi+lshyvr7aKW
         biYTiTSxNZK8SIXmsMRTuvBF4rFnPz06wWCr8+eaR8067YijSbQzXeynJGlFWVgarSpE
         GifKZdoFTeOrTkeDYz4PUjjEwZiCrEkvHrZjxTELOPbd5ytUBoXkHzFWhf7Ar0xANU6H
         MZTqvAKHJqborkXSy/Gq4uqegul6ZplHY2T2JVgBemlwZ10fwvymFflClf0Qrp4BSrbJ
         6ZAw==
X-Gm-Message-State: APjAAAVlMU/U3+QJuE9OuT/IYWRqpiY3+BYjsxzXfrQIXEpA+F0qUkoj
        WsdI7X+jQQsZkGRJzZoKCFJXRLidq84=
X-Google-Smtp-Source: APXvYqxlT4Fv6qHKjsJBhlVTYAbYfaaK4ThAgs8mGMGlrUUmnDTMg4dBCsAJuivK4cI9z1dGRTwl/w==
X-Received: by 2002:ad4:43c9:: with SMTP id o9mr38403271qvs.113.1559934059944;
        Fri, 07 Jun 2019 12:00:59 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r39sm1388147qtc.87.2019.06.07.12.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 12:00:59 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH] gpu/drm_memory: fix a few warnings
Date:   Fri,  7 Jun 2019 15:00:35 -0400
Message-Id: <1559934035-3330-1-git-send-email-cai@lca.pw>
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

