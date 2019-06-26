Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C716C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9153204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEoviPlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfFZMXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:23:18 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:46685 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:23:18 -0400
Received: by mail-qt1-f201.google.com with SMTP id k31so2616697qte.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XRvnKModUVHTmFHrHwuo1MwyIF32UbSI8S8OvJKLAFg=;
        b=bEoviPlExN6sDh8KZFRQ1yCXcZkyNNLzW3u1pAVA2H1orVPnCYqlhFimU4rLGIWu1f
         CJpOGN2nBuRm6aQ1agx42bRuCEsvMeS+lSGPOVCQj83C+TNfcSHS6b2Q9MsbfNJHxa4b
         gl8xVU7JgPgG0I+Idoe82XDGV7mWty68PWMWXPDSHvW+eZwnURw531ZE7Ph55/H3ZEz8
         LkKIW3ZgaUPS+I6NBRIMeSLBUT/MyQcadnDaa6eKlh1dKhvqdg0M0hkmoiwKNWT8b2oz
         r9Tq8XeSManWCswYnmY3NMckuTA9wL4+t5btPnUG6Uy+XvcGYD+kTQy2Dq6NB5BUq40T
         /i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XRvnKModUVHTmFHrHwuo1MwyIF32UbSI8S8OvJKLAFg=;
        b=UNohb81+71tRAHGzrMytMx1nrul+uW6mZUz/T9LBs4WlKdW9AMx5Qp54S3FtR1cFy7
         GbfaE2iIDHicEYzijXhY2owIH9lxKHjtAYHdHRwjEVx3sNFxsa/rJ17Lq6IlYeHDisfc
         hhXUaJxgqLaVZtSKHVdAjK392iNqlim22F827YTahOR5NuBeaVkJS44eGL9RIzq+vjIK
         Vp7/40MG7AV95JHyJRIPDmCWuZo+kXzOjgRYEXWHZyww0XTPvBQb8twkg7yVjIPo5nM7
         K4kV1jxpB9r2kXNCNoVHGjwobsxLZkVCigR1cr9KxSaUsFuDlfFea42VVUKg27aDxvd+
         NDzA==
X-Gm-Message-State: APjAAAX0pbVWpQy9OsjGzggMKzonEOsRqqUWe4MXYlMQMX8rxUcjtX0B
        GOaR/eWWO/O3mUsZnVMiqwbvU05axA==
X-Google-Smtp-Source: APXvYqyIgp9AlDPLRM1loC21o7i15mfv90NTnLoH2+tcZhHtyFvzp4P95svuux+9O3VuzMVNE7vsIN1kvw==
X-Received: by 2002:a0c:d604:: with SMTP id c4mr3199153qvj.27.1561551796862;
 Wed, 26 Jun 2019 05:23:16 -0700 (PDT)
Date:   Wed, 26 Jun 2019 14:20:17 +0200
In-Reply-To: <20190626122018.171606-1-elver@google.com>
Message-Id: <20190626122018.171606-3-elver@google.com>
Mime-Version: 1.0
References: <20190626122018.171606-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 2/4] lib/test_kasan: Add test for double-kzfree detection
From:   Marco Elver <elver@google.com>
To:     aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a simple test that checks if double-kzfree is being detected
correctly.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 lib/test_kasan.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index e3c593c38eff..dda5da9f5bd4 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -619,6 +619,22 @@ static noinline void __init kasan_strings(void)
 	strnlen(ptr, 1);
 }
 
+static noinline void __init kmalloc_double_kzfree(void)
+{
+	char *ptr;
+	size_t size = 16;
+
+	pr_info("double-free (kzfree)\n");
+	ptr = kmalloc(size, GFP_KERNEL);
+	if (!ptr) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	kzfree(ptr);
+	kzfree(ptr);
+}
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -660,6 +676,7 @@ static int __init kmalloc_tests_init(void)
 	kasan_memchr();
 	kasan_memcmp();
 	kasan_strings();
+	kmalloc_double_kzfree();
 
 	kasan_restore_multi_shot(multishot);
 
-- 
2.22.0.410.gd8fdbe21b5-goog

