Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E52C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1472C20651
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 23:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAME1B1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfGLX0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 19:26:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32988 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfGLX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 19:26:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so4968580pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9K2PnM68Sr4HXzBx9riApkCnBAv8CDZaCLWyJR0LblM=;
        b=hAME1B1wqG+JPV935fJ3Sza5FibSiYSE57wkmttsMh5iv7JuHYpHviZRhIEd3n4Kja
         zWwZnYauDGonPpni6Y/fft/+OWAwp05H4Sd0gNt66jCC0Ykw04SForIMyl4J3zv4i/Nt
         0ovUOzbw6fkx7Og8jL/h19UsGhS5nZF2+Y9Nt1weh4hZbEmioVhUeCU0Y+gaIrh6oR+i
         DdcL0NeKZ80UrdvU0eXFVP05A7ZT0daFQ3Hy5ws7G+aeuArqjTu1tjhSCL4AqbXQxcji
         0JsJkYI6H4xCPw3s5mh+GyCPBCixCKPy/355KLfTEcxPcqdZW2v1Ll2Bd1hhF0e6O6wu
         MfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9K2PnM68Sr4HXzBx9riApkCnBAv8CDZaCLWyJR0LblM=;
        b=Gnz/yjams1+2fCf/DUOSPI3RATjpqO5M96wCuH+MkxgelcCn6dp1ps5C+pk9znJgRW
         Rwi2SlVd9pzfLqQgIc0fmVKWkVEXL21vsxMDkkLsX/OJ8TJZrrcDSnWzMXC+/J1DAbUZ
         gtZD1kqoWMrtBE9OYcVkG3p7UyGbNpyyVEBH1i9waIlUVe7tdv+/LUcwefE2+p1V7AH3
         7XwXLeZHVy9/OHN/tUL/VSZ9pZ0DSRifSNs1nlEJK3/3oe44Q+KzuZGbw16bjwWYfkQy
         Y4yhakXCPu/Ti3Fh8bJ6zIS+SVzVqlYwQFSTvFvfQ9nhSW+OjWNw6ID/yytjnPUg7Lmt
         FSdw==
X-Gm-Message-State: APjAAAWePY8toVcNuvcUcCrLTCqQNjlCuF6YJncibZcfMqQNc44Ai45g
        9sxhiWNxjE6ul6CoWrmEI6I=
X-Google-Smtp-Source: APXvYqzkTrHpK0hEBJbpW9NCr+rMOzw107si4tU6jH0VOrjMYMAZ2jSCvko/B00ps6fGveiakVHgFQ==
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr15251729pjb.20.1562974000429;
        Fri, 12 Jul 2019 16:26:40 -0700 (PDT)
Received: from sultan-box.hsd1.ca.comcast.net ([2601:200:c001:5f40:3dac:1a9b:f47c:b78e])
        by smtp.gmail.com with ESMTPSA id f12sm9020575pgo.85.2019.07.12.16.26.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 16:26:39 -0700 (PDT)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Allison Randal <allison@lohutok.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scatterlist: Don't allocate sg lists using __get_free_page
Date:   Fri, 12 Jul 2019 16:26:31 -0700
Message-Id: <20190712232632.6306-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

Allocating pages with __get_free_page is slower than going through the
slab allocator to grab free pages out from a pool.

These are the results from running the code at the bottom of this
message:
[    1.278602] speedtest: __get_free_page: 9 us
[    1.278606] speedtest: kmalloc: 4 us
[    1.278609] speedtest: kmem_cache_alloc: 4 us
[    1.278611] speedtest: vmalloc: 13 us

kmalloc and kmem_cache_alloc (which is what kmalloc uses for common
sizes behind the scenes) are the fastest choices. Use kmalloc to speed
up sg list allocation.

This is the code used to produce the above measurements:
#include <linux/kthread.h>
#include <linux/slab.h>
#include <linux/vmalloc.h>

static int speedtest(void *data)
{
	static const struct sched_param sched_max_rt_prio = {
		.sched_priority = MAX_RT_PRIO - 1
	};
	volatile s64 ctotal = 0, gtotal = 0, ktotal = 0, vtotal = 0;
	struct kmem_cache *page_pool;
	int i, j, trials = 1000;
	volatile ktime_t start;
	void *ptr[100];

	sched_setscheduler_nocheck(current, SCHED_FIFO, &sched_max_rt_prio);

	page_pool = kmem_cache_create("pages", PAGE_SIZE, PAGE_SIZE, SLAB_PANIC,
				      NULL);
	for (i = 0; i < trials; i++) {
		start = ktime_get();
		for (j = 0; j < ARRAY_SIZE(ptr); j++)
			while (!(ptr[j] = kmem_cache_alloc(page_pool, GFP_KERNEL)));
		ctotal += ktime_us_delta(ktime_get(), start);
		for (j = 0; j < ARRAY_SIZE(ptr); j++)
			kmem_cache_free(page_pool, ptr[j]);

		start = ktime_get();
		for (j = 0; j < ARRAY_SIZE(ptr); j++)
			while (!(ptr[j] = (void *)__get_free_page(GFP_KERNEL)));
		gtotal += ktime_us_delta(ktime_get(), start);
		for (j = 0; j < ARRAY_SIZE(ptr); j++)
			free_page((unsigned long)ptr[j]);

		start = ktime_get();
		for (j = 0; j < ARRAY_SIZE(ptr); j++)
			while (!(ptr[j] = kmalloc(PAGE_SIZE, GFP_KERNEL)));
		ktotal += ktime_us_delta(ktime_get(), start);
		for (j = 0; j < ARRAY_SIZE(ptr); j++)
			kfree(ptr[j]);

		start = ktime_get();
		*ptr = vmalloc(ARRAY_SIZE(ptr) * PAGE_SIZE);
		vtotal += ktime_us_delta(ktime_get(), start);
		vfree(*ptr);
	}
	kmem_cache_destroy(page_pool);

	printk("%s: __get_free_page: %lld us\n", __func__, gtotal / trials);
	printk("%s: kmalloc: %lld us\n", __func__, ktotal / trials);
	printk("%s: kmem_cache_alloc: %lld us\n", __func__, ctotal / trials);
	printk("%s: vmalloc: %lld us\n", __func__, vtotal / trials);
	complete(data);
	return 0;
}

static int __init start_test(void)
{
	DECLARE_COMPLETION_ONSTACK(done);

	BUG_ON(IS_ERR(kthread_run(speedtest, &done, "malloc_test")));
	wait_for_completion(&done);
	return 0;
}
late_initcall(start_test);

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 lib/scatterlist.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index c2cf2c311b7d..d3093e8f8978 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -148,31 +148,12 @@ EXPORT_SYMBOL(sg_init_one);
  */
 static struct scatterlist *sg_kmalloc(unsigned int nents, gfp_t gfp_mask)
 {
-	if (nents == SG_MAX_SINGLE_ALLOC) {
-		/*
-		 * Kmemleak doesn't track page allocations as they are not
-		 * commonly used (in a raw form) for kernel data structures.
-		 * As we chain together a list of pages and then a normal
-		 * kmalloc (tracked by kmemleak), in order to for that last
-		 * allocation not to become decoupled (and thus a
-		 * false-positive) we need to inform kmemleak of all the
-		 * intermediate allocations.
-		 */
-		void *ptr = (void *) __get_free_page(gfp_mask);
-		kmemleak_alloc(ptr, PAGE_SIZE, 1, gfp_mask);
-		return ptr;
-	} else
-		return kmalloc_array(nents, sizeof(struct scatterlist),
-				     gfp_mask);
+	return kmalloc_array(nents, sizeof(struct scatterlist), gfp_mask);
 }
 
 static void sg_kfree(struct scatterlist *sg, unsigned int nents)
 {
-	if (nents == SG_MAX_SINGLE_ALLOC) {
-		kmemleak_free(sg);
-		free_page((unsigned long) sg);
-	} else
-		kfree(sg);
+	kfree(sg);
 }
 
 /**
-- 
2.22.0

