Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB01C47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A1821D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aH+q1oJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfJYXsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 19:48:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36458 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfJYXsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 19:48:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so1536131plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 16:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kpP5L5ZL9jr9Wuirrq/wpxNCtz1x33e9wP9JwvG83tE=;
        b=aH+q1oJwle0nqOjUevAI2mb8wKUrtDhyNCymP6wx1Ejk2vXIr1dGQFtWul5+98jwl5
         NO9Iy0gKcfG72k6QZO9qhdGo7LSYi0XtxBHzmFcp9Isx9v1/v6olIDuSiz8ZyEYNQEib
         ibY4cf3DmZZuXO/k7TCOxJOoVEUq1q9IGNs9O36Zv62yADhnhDv/ea+isimPR9ixiX0J
         S7AVKbruLRl+6+C5qP1BB4gA+aaGLy3wtcy1dJhqRG5Y7KeXR9sDkspCuLQZPbL0Am4L
         KYy8KYY6fS36vL5cyXVmwC9VUEPcZHQJ6gcR7JBqhiYKRIA0N07LPYw1nkLntijgcZZg
         s5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kpP5L5ZL9jr9Wuirrq/wpxNCtz1x33e9wP9JwvG83tE=;
        b=qTXhFNilk1NDiuw8pBTB2vJPIkxrlg1/qvzu3mAcp8pNlrQNTWux2EOxLOGlASB6HE
         I0WRC67Hbtzvs9FKgiokBFj6nwYn72cXMYDmndglzuVNBeIduO0j84DRm3Glhegla/B6
         8MQupbnKQ9aXrhSBCTjpABL+8KQmgiwK76Ak9byS5vDBjyuq8A6RRfZOhGBpEMeThQEE
         781suiJ1d+46jIzvCCX97iMampFxxFAZkK5h/ogHa5tkrGnUCsK3CqI4twpvsarBMEsy
         CE2gUlMKgq9tWL5fwLCZ7z8/KuMxE/PHCBiYG3g+SnovcOEeobgs3IHzcv/uckhMK3qi
         tE1w==
X-Gm-Message-State: APjAAAVmY5UpCEZPUv+7Fgn6/IbTzFckT1bqY1bfNjtLZkaxLC3G5g16
        14ru84pbDR2El0LXBocOm7tTJmLu/24=
X-Google-Smtp-Source: APXvYqychMWInYueDZ6EKJar8eyzhLNrYGYyX2Zp5f95/WM8Z4uN16jYK60waVFhNpHWeyYvjB4gmg==
X-Received: by 2002:a17:902:aa07:: with SMTP id be7mr6818499plb.242.1572047319332;
        Fri, 25 Oct 2019 16:48:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id cx22sm2817179pjb.19.2019.10.25.16.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 16:48:38 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Sandeep Patil <sspatil@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel@lists.freedesktop.org,
        John Stultz <john.stultz@linaro.org>
Subject: [RFC][PATCH 1/2] mm: cma: Export cma symbols for cma heap as a module
Date:   Fri, 25 Oct 2019 23:48:33 +0000
Message-Id: <20191025234834.28214-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025234834.28214-1-john.stultz@linaro.org>
References: <20191025234834.28214-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Patil <sspatil@google.com>

Export cma_get_name, cma_alloc, cma_release, cma_for_each_area
and dma_contiguous_default_area so that we can use these from
the dmabuf cma heap when it is built as module.

Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yue Hu <huyue2@yulong.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Sandeep Patil <sspatil@google.com>
[jstultz: Rewrote commit message, added
 dma_contiguous_default_area to the set of exported symbols]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 kernel/dma/contiguous.c | 1 +
 mm/cma.c                | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 69cfb4345388..ff6cba63ea6f 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -31,6 +31,7 @@
 #endif
 
 struct cma *dma_contiguous_default_area;
+EXPORT_SYMBOL(dma_contiguous_default_area);
 
 /*
  * Default global CMA area size can be defined in kernel's .config.
diff --git a/mm/cma.c b/mm/cma.c
index 7fe0b8356775..db4642e58058 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -24,6 +24,7 @@
 #include <linux/memblock.h>
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -54,6 +55,7 @@ const char *cma_get_name(const struct cma *cma)
 {
 	return cma->name ? cma->name : "(undefined)";
 }
+EXPORT_SYMBOL_GPL(cma_get_name);
 
 static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
 					     unsigned int align_order)
@@ -500,6 +502,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	pr_debug("%s(): returned %p\n", __func__, page);
 	return page;
 }
+EXPORT_SYMBOL_GPL(cma_alloc);
 
 /**
  * cma_release() - release allocated pages
@@ -533,6 +536,7 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(cma_release);
 
 int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 {
@@ -547,3 +551,4 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cma_for_each_area);
-- 
2.17.1

