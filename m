Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AE6C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540D02077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMkbyHim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLMWiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:38:17 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36267 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMWiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:38:16 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so767541iln.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 14:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=05pwc1cDq1D/DICCYWl1LBEP7b2TGkJ4T9jlAojcSw4=;
        b=AMkbyHim27QPrfH+SFbUq5K6UtLpL5hRLHJ2gT/tiB/okhD6H760a3eNBadZXZ3USZ
         9IqwEe874ONRzJUPePaY7+ZFBY/7Jw4a8qNUz2Lwb2Cwe0AYa3Dr2ScyeuHIoT9QOopz
         4WEjiIH+qRYgL3U4gHwl41xMXGF3CsjNG0ICD0D4HRgm3c9LHj2d9e0a9Oh5NzglgwDA
         mKC2Zxb13JloprCzr+lr9Lgtg7CSK+ywVxFJ0L0bjf9FrOr3cu6Z1k7Eg1QTc17SVaM6
         CoQrQ7YCAZAomYu7mxI0jRh+fZOtxyUbc5NVxGYImZTDO09mOhcam4wxIml9YPeUX8eI
         ouZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=05pwc1cDq1D/DICCYWl1LBEP7b2TGkJ4T9jlAojcSw4=;
        b=YeKDOGiNyJtvNyrfRK7wSFQKqJS4QzhcT1UuQ8yw9SE9/yNBluQKQde/LbKD6kZ4EG
         ixJbQLXfMDKvK03jvx4UCyShXm60qZQsWZmMoGOEAOXrwTjaw/cPwBn7uUuNWJ+g1Knz
         4AVSg/BDeqh9D3RcMXfwFIOt4/CpRrPpgBqgVblTMRrUC41yIKXmhbbadThtS+qC1a8V
         2AB+89KJZHqSgoqj+7h5O5nxqw0y54uYixQSukRamMtHepHkqr9VswRYoxCoPON1/4XA
         SJpHH+AFli3bBc3C9KEe7YmAyXQzqMyl9TTn8/zsmZH0idjePilEJaDkXAyq9TNergEB
         xRGA==
X-Gm-Message-State: APjAAAVg0BpBOnywB+a/xwgi5RbAPPi7o6yTwoXHc6ExEW05yTcz3ntg
        z0kDuZ+zAseApPDb/X17PTY=
X-Google-Smtp-Source: APXvYqx0uEsIvwLyNJN7RXSIIglVZGUqy7rs3mqi+4ZkWl+6KLFw6vmUQBxc/SD9Aaiscam/6CaC1g==
X-Received: by 2002:a92:9107:: with SMTP id t7mr1701040ild.51.1576276695976;
        Fri, 13 Dec 2019 14:38:15 -0800 (PST)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id f7sm2396743ioo.27.2019.12.13.14.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 14:38:15 -0800 (PST)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, jhubbard@nvidia.com,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH v2] mm/gup: Fix memory leak in __gup_benchmark_ioctl
Date:   Fri, 13 Dec 2019 16:37:41 -0600
Message-Id: <20191213223751.4089-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <9a692d27-4654-f1fc-d4c5-c6efba02c8a9@nvidia.com>
References: <9a692d27-4654-f1fc-d4c5-c6efba02c8a9@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of __gup_benchmark_ioctl() the allocated pages
should be released before returning in case of an invalid cmd. Release
pages via kvfree() by goto done.

Fixes: 714a3a1ebafe ("mm/gup_benchmark.c: add additional pinning methods")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
Changes in v2:
	-- added goto and ret value instead of return -1.
---
 mm/gup_benchmark.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index b160638f647e..b773b2568544 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -24,7 +24,7 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 {
 	ktime_t start_time, end_time;
 	unsigned long i, nr_pages, addr, next;
-	int nr;
+	int nr, ret = 0;
 	struct page **pages;
 
 	if (gup->size > ULONG_MAX)
@@ -63,8 +63,8 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 					    NULL);
 			break;
 		default:
-			kvfree(pages);
-			return -1;
+			ret = -EINVAL;
+			goto done;
 		}
 
 		if (nr <= 0)
@@ -85,8 +85,9 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 	end_time = ktime_get();
 	gup->put_delta_usec = ktime_us_delta(end_time, start_time);
 
+done:
 	kvfree(pages);
-	return 0;
+	return ret;
 }
 
 static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
-- 
2.17.1

