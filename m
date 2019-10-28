Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BA6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD4921783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMh/MkDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbfJ1JUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:20:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54053 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfJ1JUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:20:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id n7so8565719wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wIuGwn2jgbDtMcHHOszupBu+fQifNyNj/PTHe+Q5iEw=;
        b=CMh/MkDfospgY1lS3Xa8YLvgA9gN95y9aLEw+FmGBfX8eZl2bSwff0ji6BoiaaTSLy
         MOJK+6FLYglo4N6XVNJmnHdND7sNqftfNoXJocRfHqY8UgcbKumVjpa7W7zjCIHbjphq
         Bpsq49P0mzhpqPzd1E2iLq2T1Yka06IFlCMvpJAl5jyGgJp0O0Pwz43p6dJmNQ4csW9l
         T5RLdsVBLcBayfL+eTTaDCLM7Pq+42LucGCwv9KfRrGvRvVt4stEiYwVyGh0LkMF4pBb
         LkrHy+VKanwipDT7oyQZU28VX1uF6YWijZbK+woXWBY/8RAsAdecnMhEVnz4uW68Issh
         qwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wIuGwn2jgbDtMcHHOszupBu+fQifNyNj/PTHe+Q5iEw=;
        b=dQdeG9GOJw0/8t2IeT/plhYicjUZ9vjv9nIeb2SsfIT0P5+1/266JEgLHv1SzVaVxK
         ym5162PSvhlSZnyYw/rlFZ/DUi/eEGB1IZu2476sSwnWisWg9zhigsuvseRB4JZnV20i
         Zm6k23ZM7YQNsU6JXDh3O9m0J3bWoM9cYUl12TJ2kuHSNBjcKYu3tDXXuDYL5/kUoOJg
         YBAxO+XH+dsjtOVFG3sojtY2vyx6OQb00zvPHbn9GWjTtlkmaK2da/k9rj0EyeZUuSx2
         guLP6osYmarAlzibV8IbEYEe25Ecoh3rDhxDz9PbTvu3xUTX9jALsTKXZ7gi/xL+IOZh
         /ZfA==
X-Gm-Message-State: APjAAAVvZGyE6IKDDplzGHYJ3ic0tBYGZumCQ9IirxzMy29q7nmb+AMM
        a61B2hA5v85srMDbC4UU1ATkssOWf8Dnww==
X-Google-Smtp-Source: APXvYqxBcssIkhamPko/fax5AmALlb8thgEIQaTOHQbgFgVvAlPSNmDGOtswJVwTfhME3llhdxSSmw==
X-Received: by 2002:a1c:1d10:: with SMTP id d16mr15486351wmd.14.1572254417401;
        Mon, 28 Oct 2019 02:20:17 -0700 (PDT)
Received: from localhost.localdomain ([197.254.95.38])
        by smtp.googlemail.com with ESMTPSA id z9sm11427513wrv.1.2019.10.28.02.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 02:20:16 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        outreachy-kernel@googlegroups.com
Subject: [Outreachy][PATCH 1/2] drm/amd: declare amdgpu_exp_hw_support in amdgpu.h
Date:   Mon, 28 Oct 2019 12:20:04 +0300
Message-Id: <20191028092005.31121-2-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028092005.31121-1-wambui.karugax@gmail.com>
References: <20191028092005.31121-1-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare `amdgpu_exp_hw_support` as extern in amdgpu.h to address the
following sparse warning:
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:118:5: warning: symbol 'amdgpu_exp_hw_support' was not declared. Should it be static?

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
Suggested-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f4d9041ef430..3610defdfae1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -140,6 +140,7 @@ extern int amdgpu_vm_fragment_size;
 extern int amdgpu_vm_fault_stop;
 extern int amdgpu_vm_debug;
 extern int amdgpu_vm_update_mode;
+extern int amdgpu_exp_hw_support;
 extern int amdgpu_dc;
 extern int amdgpu_sched_jobs;
 extern int amdgpu_sched_hw_submission;
-- 
2.17.1

