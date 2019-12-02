Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D701AC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8032084F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4WsHbuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLBNg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:36:56 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46120 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBNgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:36:55 -0500
Received: by mail-oi1-f196.google.com with SMTP id a124so8735804oii.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 05:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=FnsSvzvpi8rvXngynEnIF5568olLzHSROrVg8551Pdg=;
        b=s4WsHbuEIV/IT4VcFl3ordMxhLT1jgk5Hd8GZEhmqL9YAU57tg6T+afCLLolAuMvp2
         ga29NPZZNHQfPv0IOXQQkkStrvBUEaPZOjbnpfvh9d/krzIwQfrS14wQk7HQLEJX7PbL
         N/t98w7lMGw+rrqJhXKF4SCeVQwOYK5pZZvD1Z5hmIa11RjIfw4DqYfaymVpUeRqnxm7
         ddiSgW6zEuy2zQpUGAAHdcPlYkv18rttoH3UHB0+Gud1/JfUzgQKjguh6r8L87rZhWv5
         Qj80069/uUJD6pf9N8Cuf4t5u9sIik36fVctICHLCgH1JinJd4zKySjH9NaGFVUBRM19
         hdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=FnsSvzvpi8rvXngynEnIF5568olLzHSROrVg8551Pdg=;
        b=XP4suIiIKWyZNMj9+XsTWNrikqr3iAiDpGfvEBg/oHwUkA0WBrvA3ZePw+448fhjmE
         FhpTdtyjfoJ2ouHOrebp7QcPepPdoO0tXPx8hkBLjV5k82ZYN5xZA805Z2NlJ5M/n7wO
         dnQXf6gtq5L9NtL6GuO3gUtKYdWEwsJvadnbGbd2AgBZqTJ5Qai8mpBSImVb8BI2Yoj+
         UUwKBrKaBR8UZMVZ2ClxoNe2yqUOE+5wC7BZGIdlqkouNDb4kArXpEjKexhAidnyaaJk
         EudcfR5FVauOYry886IIG4ksuXMXKulV1DvxBQaDknGCC6x9B5K+ztE0UacwZ1bgkRjK
         l4ew==
X-Gm-Message-State: APjAAAW8HiYjB/X57Bn1pQLVI365/hxfO6AxVO8jwjE42AmbmsLk5/4s
        OVDOQjOOgKSB0M5gAGpMFAw=
X-Google-Smtp-Source: APXvYqx/AuYwJFFyGAocMdeJL8EwVFo4CUFiifY6rbcl8jS1D87O2ftjdbHeXTr71+6vZ58rn6UC9Q==
X-Received: by 2002:aca:d6c4:: with SMTP id n187mr10999803oig.29.1575293814707;
        Mon, 02 Dec 2019 05:36:54 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w2sm7666720otp.55.2019.12.02.05.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 05:36:53 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Lyude Paul <lyude@redhat.com>
Subject: [PATCH] drm/dp_mst: Fix build on systems with STACKTRACE_SUPPORT=n
Date:   Mon,  2 Dec 2019 05:36:50 -0800
Message-Id: <20191202133650.11964-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with STACKTRACE_SUPPORT=n, we get:

WARNING: unmet direct dependencies detected for STACKTRACE
  Depends on [n]: STACKTRACE_SUPPORT
  Selected by [y]:
  - STACKDEPOT [=y]

and build errors such as:

m68k-linux-ld: kernel/stacktrace.o: in function `stack_trace_save':
(.text+0x11c): undefined reference to `save_stack_trace'

Add the missing deendency on STACKTRACE_SUPPORT.

Fixes: 12a280c72868 ("drm/dp_mst: Add topology ref history tracking for debugging")
Cc: Lyude Paul <lyude@redhat.com>
Cc: Sean Paul <sean@poorly.run>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 1168351267fd..bfdadc3667e0 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -95,6 +95,7 @@ config DRM_KMS_FB_HELPER
 
 config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
         bool "Enable refcount backtrace history in the DP MST helpers"
+	depends on STACKTRACE_SUPPORT
         select STACKDEPOT
         depends on DRM_KMS_HELPER
         depends on DEBUG_KERNEL
-- 
2.17.1

