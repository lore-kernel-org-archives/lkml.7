Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C83CC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D849221655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETFtyUbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgABUBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:01:17 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:38274 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgABUBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:01:16 -0500
Received: by mail-vs1-f74.google.com with SMTP id o185so3788911vsc.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 12:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IWftFaF/7pwaE+hKN0rmHHTDccHnFs4MwoJXhQKr9TA=;
        b=ETFtyUbGasImdWusI7+XxX+jtfzy6TbJUp8B/J87NDJKrN0tpvcu+AhRbowiMtcdgg
         bgjYmyFMHeiZP1YyPkOJe2abYtU+18pqk98PIqIpdmXhiL+NCzGaUfwooMn7yIw2l2sK
         XNt0kZnYXtKpSNWS81hh9vYloEblPeBm9UO7rjtiG9Mnbfl6BL6rQonfw28PD19VxaYB
         AtHFPgoQq9kWjklvzY6rcLgQZVIhOxkgZQILADhE/vJ2AnmTJgZg/Nokpsq0P1dpwgGQ
         hJ0Kkj0DAet+gYl0w8PbWpXOWeuJ4xr8D2GffvLt2+nHrPQgHnWpO70Z1VvVu5hp/FdP
         hVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IWftFaF/7pwaE+hKN0rmHHTDccHnFs4MwoJXhQKr9TA=;
        b=AwOfjacVs1QfHbJYL8I5qo0jSIce8AAYkFpZlMA2xLeYofNdo9aKDqLf+RBMrUYhd8
         LxApa9pB7JfIKcV8L4Mf4H8HNf8Mn1NDzNS9ce8SxXMNB7BAYkYWwkGYWFqJ3I3uVk4I
         8UN2p3HFmLlTQ33FOgx/n6DzeKOD+Gku+TK8+YxjeaaApyDjjqFikqMoajbeWu+aiUwj
         V1EZ7Wla+E9OdTQYYK6vyI8weuko0EQzMAbrTcvEwelcx9vZ/08ODixiBCEqAgg+eH7K
         VzJefxSDGCJfNGvHd05YFTDouYj60QFlaQIaeS1uwus9K7hpEQqpjsoNXgYNJKN4FshX
         OINQ==
X-Gm-Message-State: APjAAAUz6dh3fl9BdpZb5r5NohRUVUAxmoeuKvIRSgg4ywVZZ8SbdQyR
        AgVP5H7KhsFqEFNhNYKuPjdgUVl+yJaMMfo=
X-Google-Smtp-Source: APXvYqwtC1Uvje2fbb36HVwCkmW0QcIlFAti3E9fgJHG6wwvnd7vXeyx2pz2lLd6Iz8RTxqnfNJndL5sU4NFASA=
X-Received: by 2002:a1f:d904:: with SMTP id q4mr43772171vkg.13.1577995274922;
 Thu, 02 Jan 2020 12:01:14 -0800 (PST)
Date:   Thu,  2 Jan 2020 12:00:52 -0800
In-Reply-To: <20200102200052.51182-1-semenzato@google.com>
Message-Id: <20200102200052.51182-3-semenzato@google.com>
Mime-Version: 1.0
References: <20200102200052.51182-1-semenzato@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 2/2] pm: add more logging on hibernation failure
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rafael@kernel.org, gpike@google.com,
        Luigi Semenzato <semenzato@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hibernation fails when the kernel cannot allocate enough memory
to copy all pages in use.  This patch ensures that the failure
reason is clearly logged.

Signed-off-by: Luigi Semenzato <semenzato@google.com>
---
 kernel/power/snapshot.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 26b9168321e7..df498717a97e 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1705,16 +1705,20 @@ int hibernate_preallocate_memory(void)
 	ktime_t start, stop;
 	int error;
 
-	pr_info("Preallocating image memory... ");
+	pr_info("Preallocating hibernation image memory\n");
 	start = ktime_get();
 
 	error = memory_bm_create(&orig_bm, GFP_IMAGE, PG_ANY);
-	if (error)
+	if (error) {
+		pr_err("Cannot allocate original bitmap\n");
 		goto err_out;
+	}
 
 	error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
-	if (error)
+	if (error) {
+		pr_err("Cannot allocate copy bitmap\n");
 		goto err_out;
+	}
 
 	alloc_normal = 0;
 	alloc_highmem = 0;
@@ -1804,8 +1808,11 @@ int hibernate_preallocate_memory(void)
 		alloc -= pages;
 		pages += pages_highmem;
 		pages_highmem = preallocate_image_highmem(alloc);
-		if (pages_highmem < alloc)
+		if (pages_highmem < alloc) {
+			pr_err("Image allocation is %lu pages short\n",
+				alloc - pages_highmem);
 			goto err_out;
+		}
 		pages += pages_highmem;
 		/*
 		 * size is the desired number of saveable pages to leave in
@@ -1836,13 +1843,12 @@ int hibernate_preallocate_memory(void)
 
  out:
 	stop = ktime_get();
-	pr_cont("done (allocated %lu pages)\n", pages);
+	pr_info("Allocated %lu pages for hibernation shapshot\n", pages);
 	swsusp_show_speed(start, stop, pages, "Allocated");
 
 	return 0;
 
  err_out:
-	pr_cont("\n");
 	swsusp_free();
 	return -ENOMEM;
 }
-- 
2.24.1.735.g03f4e72817-goog

