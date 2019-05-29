Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C5DC28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560DB21019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juZrse+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfE2Mji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:39:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36793 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfE2Mjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:39:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so1025725plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/kUApmsHSgHDArihyUOta/cOfsm+uYS/iQzyr+N/nRo=;
        b=juZrse+P5GXwZ9Mr9TkKumoLScyloKiktxo5FhhDWNI7LcrTnkDaRqPI33pWp7lXci
         4Ogtx/AQdl1KsvONOwuev6kNPUPM7CSDW1fzkPN+LGbHwi7km0sPP4OMeR93q1fgBzye
         acY72AJ8WkHQrDvdd8IHCMJnECysgVh5O2ooFvvhKi4JczqhdeEOyMJTbXpGqB8ammkC
         OTDsmGibDQ53bftt6AioXhgzAP2WDApUJVAb6tXG/l01IivWJOuWNv3mwvb48Xi5K71X
         XNHfJPlGTIDtNpYOj+rLNhh01dazq3y2O90/r7WVLu8jPnmVSDPbTRjhO3pUdkogLqLZ
         ISCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/kUApmsHSgHDArihyUOta/cOfsm+uYS/iQzyr+N/nRo=;
        b=o5IE+gtl4YimMPSj4fw5P8fMA8PfRtXIu4CYdNw9V6mAZGGNpVyhd7nGb2oaxPJSE8
         B7lf55j7Fe03Qrpk48D0p3kpReTwSgqAELyHkJ0fn5iNDdnMpfCx5muqNirL9EL0Gc7f
         CAvhiOZBuXtuShEGPaGkUQcQsb6yOxd/6vbTHQOhIChxGLh1WJ6qaMrXg9zPE8s/cUo8
         WsewDlYu6/jfzoeXkcXtMoPWj7eqjCia4pknVRfPza0OcLEezrq9UvRKjTK8NnloL1ZC
         eaMtSJh3jHkoQMGCoJfy3PGq8EYWy7GuCn4hr+OXgX2Kb2LbZ4MaRT9lQgPPLiOVCiDX
         ZFvA==
X-Gm-Message-State: APjAAAWxR+bn+Nxqej3XBM1POpjATmDE1tOzBzJM+GR69vLkISDnmr3Z
        o6VqTjd8trQDOGIlj7nWIzQ=
X-Google-Smtp-Source: APXvYqym4WR0k80SWtZ3I58trWkxoQJvuHmi/gCo6ctyQsvseOeEK4n+4Ibn1SPRYLidkJjLphA2mQ==
X-Received: by 2002:a17:902:bc86:: with SMTP id bb6mr3670959plb.129.1559133576415;
        Wed, 29 May 2019 05:39:36 -0700 (PDT)
Received: from tom-pc.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id 124sm19018905pfe.124.2019.05.29.05.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 May 2019 05:39:35 -0700 (PDT)
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dianzhang Chen <dianzhangchen0@gmail.com>
Subject: [PATCH] mm/slab_common.c: fix possible spectre-v1 in kmalloc_slab()
Date:   Wed, 29 May 2019 20:37:28 +0800
Message-Id: <1559133448-31779-1-git-send-email-dianzhangchen0@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `size` in kmalloc_slab() is indirectly controlled by userspace via syscall: poll(defined in fs/select.c), hence leading to a potential exploitation of the Spectre variant 1 vulnerability.
The `size` can be controlled from: poll -> do_sys_poll -> kmalloc -> __kmalloc -> kmalloc_slab.

Fix this by sanitizing `size` before using it to index size_index.

Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
---
 mm/slab_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 58251ba..41c7e34 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -21,6 +21,7 @@
 #include <asm/tlbflush.h>
 #include <asm/page.h>
 #include <linux/memcontrol.h>
+#include <linux/nospec.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/kmem.h>
@@ -1056,6 +1057,7 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 		if (!size)
 			return ZERO_SIZE_PTR;
 
+		size = array_index_nospec(size, 193);
 		index = size_index[size_index_elem(size)];
 	} else {
 		if (WARN_ON_ONCE(size > KMALLOC_MAX_CACHE_SIZE))
-- 
2.7.4

