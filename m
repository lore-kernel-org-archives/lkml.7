Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2633CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC6F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA1GFgr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbfJ1GE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 02:04:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35998 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730394AbfJ1GEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 02:04:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id j22so142422pgh.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 23:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lW+AMEtlabITQrPIpkqEPcUL1c8hvMDtNJcO22Y71bs=;
        b=fA1GFgr0M7qMTfbFv+f/Ka2HxjRPYS4lE5hTtV7aQ/+wsXdC92oDJdyfBV8WlQXp+9
         EgaWvx17CWE7JOG/QdpW7S8nJtT4Yf6W4E0NZgO9bzQQIuwl3D39yXc7bnnl3KJcIPaN
         EVBLmGLrza4ev6kL97i+ybUziWXmpK7hdBVIbwKr0XEibvi7rkLUUZzD80/ov+7myDXg
         mMoHsByScueJM0AcBxi6wW05VZplyaKf6EUG7aFJdA8ufZZOndv4vBD5WYqTHsLCSeBD
         lk/GQJgJgH758N9hVMj3fW1uIgW9evdI80GELTyi3O+MKyh4oW9OHHr8gRqWhWVCRXnI
         NdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lW+AMEtlabITQrPIpkqEPcUL1c8hvMDtNJcO22Y71bs=;
        b=X4pJfvtA5bCQfBA9wEg3skWyTEVIIcPO3djG2QiuQCKfchHpCLEq/1FmEdXs9PwwOu
         T9+igNC9shm4s/jV29jICPoHQbsB9N/2Yljcj/VaVmVH1DUEaPhcY7mt9J26RjcMi8g2
         06iT65iQdrBw+j/QLIAqgMO7U3HqNs7FCTAZJwZv8rVIox0tF+OvF8Nd+fOioNCr+a1K
         T9m5uHxaDpipYk1yF5ASJcCl2BL1wHj8tw2U+lugixJyzAG78rUJu/KdFtVqcvxKpSAk
         lb4lS4SdaJqjdxH7np1rlXjFwN8Zj5ZgEYeZBcV5ULhB8j/3tNSnJhP2TxVdeOC8tuPF
         zLlg==
X-Gm-Message-State: APjAAAWrd+TBP2J/FlimFN0zXQJsQ5SzFccIKefyaCoKt6mbQJ9hKTI8
        NIUMKRT0uPf8rNoWcykijb4wfYNy
X-Google-Smtp-Source: APXvYqypO2kpkDNISVJ7fsyBWXgUnI5+CNeeFIO21EiBsPoZf30U5WuHHFkB6bbCN9JfOQOvi3YBew==
X-Received: by 2002:a62:1454:: with SMTP id 81mr18453438pfu.43.1572242693463;
        Sun, 27 Oct 2019 23:04:53 -0700 (PDT)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:539:cf3b:393e:2dcf:24de:b4fb])
        by smtp.gmail.com with ESMTPSA id d25sm1008366pfq.70.2019.10.27.23.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 23:04:52 -0700 (PDT)
From:   madhuparnabhowmik04@gmail.com
To:     harry.wentland@amd.com, alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] Drivers: gpu: drm: amd: display: amdgpu_dm: amdgpu_dm.h: Fixed a documentation warning
Date:   Mon, 28 Oct 2019 11:34:43 +0530
Message-Id: <20191028060443.14997-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch fixes the following  warning: Incorrect use of
 kernel-doc format:          * @atomic_obj
by adding a colon after @atomic_obj.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c8c525a2b505..80d53d095773 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -128,7 +128,7 @@ struct amdgpu_display_manager {
 	u16 display_indexes_num;
 
 	/**
-	 * @atomic_obj
+	 * @atomic_obj:
 	 *
 	 * In combination with &dm_atomic_state it helps manage
 	 * global atomic state that doesn't map cleanly into existing
-- 
2.17.1

