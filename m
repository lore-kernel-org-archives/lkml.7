Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C865EC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF1620838
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkZdvYRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfLZWC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:02:28 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:38199 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZWC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:02:28 -0500
Received: by mail-pf1-f201.google.com with SMTP id l17so7078911pff.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 14:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IWftFaF/7pwaE+hKN0rmHHTDccHnFs4MwoJXhQKr9TA=;
        b=gkZdvYRIM6t/k5mvuiOx0NjfLs8crDbn+2OtfVQzXTnkf6e+nNttco+jq6a/qP5oON
         /y0+M3BAAzcRXG2LZrJNaLyKa4mG/9AELtjd4dIFKjBPJHtyGADgLZ1sr00z1SdXGSgG
         JbGc/Jq+Ka2wgAakUhGMqkpJWt0kpwqLiKmdvBoRlS8FKqN9nifvr/tgH4f91BcZX7iE
         ay1h92vcYGzo1FrWidKKBNdVSe3XO7qxM+pk28acwFCaeTARXxPMCCTl3TReEXPo0nrc
         W5ejQ61bxVlRc2bgokOjh4XqGPjlZan7anjbQY7eGeOMyaZdwEN9z3IzUbOF+9yn36Ns
         8pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IWftFaF/7pwaE+hKN0rmHHTDccHnFs4MwoJXhQKr9TA=;
        b=IQtGiaFa0byDjZzcOjjC8M6IqESTTSPPmm8m7qekCjC8+qpD5unrCKkK1qDv3NjxRb
         wiHZRfZx9BuVj+sBV8b5R3BOpCs0vRKMCkMsTVtPtNM2lRpcrqNTf6JbOvg/sTT3qtj0
         aNgl+utSGZ3/Xf7pt05WDymFQvrXkg1NrGyH4iA0cIjjBGM4fe90RxoS/CylYeRpCJk/
         kokfDzjhIs5i1IlKP/HyaoHiBPwFCo1U5SYGsDYdODDyL6q2Wznit96JYuW4Z+gq0QOv
         0gJNvWMySgJ0AyFjVi/qdk9gvCNNDhEDMtXXdB06P1xF/X0HkrhVgk5+OoOVsLcU3lnN
         w36g==
X-Gm-Message-State: APjAAAUPNp4C5ugOrvdfaYITh8DG7b7BXdgbf7KbGjXNQ28rPJ24lQDI
        8qCwYAtWd2Z1TI7uZjTJ0SVab9OdKkr+UGw=
X-Google-Smtp-Source: APXvYqygoqLJ8SQsBJagXnXMwLThPZ1Q7K65Ic9rVUp5GhbxT0kZYEMJZGBoPByE7ohpqmcY8EDJJ7fSSmg5L4g=
X-Received: by 2002:a63:1c5e:: with SMTP id c30mr51963594pgm.30.1577397747273;
 Thu, 26 Dec 2019 14:02:27 -0800 (PST)
Date:   Thu, 26 Dec 2019 14:02:05 -0800
In-Reply-To: <20191226220205.128664-1-semenzato@google.com>
Message-Id: <20191226220205.128664-3-semenzato@google.com>
Mime-Version: 1.0
References: <20191226220205.128664-1-semenzato@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH 2/2] pm: add more logging on hibernation failure
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, akpm@linux-foundation.org, gpike@google.com,
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

