Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191FB218FD
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cpS86uEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbfHGRQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:16:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41227 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389080AbfHGRQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:16:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so41617183pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xT1EUv7l9ELnBbW3Pj9GyH6zMTpmJcDHOSB5E5y40eQ=;
        b=cpS86uEmYIzhxFzCySaqqOeImVDTWodZUXCQVQcRGqqRAGGDs1sNZw0oH3tmy2iZOE
         XkIu9l2OhfxN0xt6NyH+lVLF+8mXgqz7NSPIIJ+egtHoGZEtUgQY7iySTu1NQl565je/
         qL/IqLU05tBxt6AwDFcVVWZEJCirczwMCOG/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xT1EUv7l9ELnBbW3Pj9GyH6zMTpmJcDHOSB5E5y40eQ=;
        b=JLtu+2O0WoqUaHmKAl7JMMQ+ylRb/f9vCZpzkP0/J/Nvs3PaGMGS/Yg9JserEbZpcf
         zylLLC9tcHXN/fw4gNmp9z1K3BctbMTStNNCQKoQ5msK1FH9OcqPWL3ZcsIlILJ42Ob5
         T8azeP8fYoagT6LroDUbxYApY0YakNNxvRlKlolkYl4WzyQyUi6qlIMXU1dOmWeb6dR9
         XZD9/x8VA0QB4JcenBkC/hnWa5QmoTCFp7Ne+ptG7Y3xMxcSmufN4h6bthUpI7RwHJab
         q9IFYN8LQ5sDv6TOvS4V4NXiNO3nzrDT//lXBRG14xabXAvZHPxv/wg2TNIHQ5NRDo6t
         vovw==
X-Gm-Message-State: APjAAAUqM9PXPhEFNBfsQGh9Jqj3y/WXHQ0E5ZrlgHtohFSLAk4lT8XN
        yDwQuvFsTMJdG/JbP8nAT0ZwZAvFEmA=
X-Google-Smtp-Source: APXvYqwugi3AW6n6dfP+TB/Uc5APuLJqoUYRpEzJ6Mn8Htn03idxWxXllDnzug9Hw6aLl8p384B8Ag==
X-Received: by 2002:a17:90a:1785:: with SMTP id q5mr950338pja.106.1565198183794;
        Wed, 07 Aug 2019 10:16:23 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a1sm62692130pgh.61.2019.08.07.10.16.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 10:16:23 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, joelaf@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: [PATCH v5 5/6] page_idle: Drain all LRU pagevec before idle tracking
Date:   Wed,  7 Aug 2019 13:15:58 -0400
Message-Id: <20190807171559.182301-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190807171559.182301-1-joel@joelfernandes.org>
References: <20190807171559.182301-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During idle page tracking, we see that sometimes faulted anon pages are in
pagevec but are not drained to LRU. Idle page tracking only considers pages
on LRU.

I am able to find multiple issues involving this. One issue looks like
idle tracking is completely broken. It shows up in my testing as if a
page that is marked as idle is always "accessed" -- because it was never
marked as idle (due to not draining of pagevec).

The other issue shows up as a failure during swapping (support for which
this series adds), with the following sequence:
 1. Allocate some pages
 2. Write to them
 3. Mark them as idle                                  <--- fails
 4. Introduce some memory pressure to induce swapping.
 5. Check the swap bit I introduced in this series.    <--- fails to set idle
                                                            bit in swap PTE.

To fix this, this patch drains all CPU's pagevec before starting idle tracking.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/page_idle.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 2766d4ab348c..26440a497609 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -180,6 +180,13 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
 	unsigned long pfn, end_pfn;
 	int bit, ret;
 
+	/*
+	 * Idle page tracking currently works only on LRU pages, so drain
+	 * them. This can cause slowness, but in the future we could
+	 * remove this operation if we are tracking non-LRU pages too.
+	 */
+	lru_add_drain_all();
+
 	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
 	if (ret == -ENXIO)
 		return 0;  /* Reads beyond max_pfn do nothing */
@@ -211,6 +218,13 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 	unsigned long pfn, end_pfn;
 	int bit, ret;
 
+	/*
+	 * Idle page tracking currently works only on LRU pages, so drain
+	 * them. This can cause slowness, but in the future we could
+	 * remove this operation if we are tracking non-LRU pages too.
+	 */
+	lru_add_drain_all();
+
 	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
 	if (ret)
 		return ret;
@@ -428,6 +442,13 @@ ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
 	walk.private = &priv;
 	walk.mm = mm;
 
+	/*
+	 * Idle page tracking currently works only on LRU pages, so drain
+	 * them. This can cause slowness, but in the future we could
+	 * remove this operation if we are tracking non-LRU pages too.
+	 */
+	lru_add_drain_all();
+
 	down_read(&mm->mmap_sem);
 
 	/*
-- 
2.22.0.770.g0f2c4a37fd-goog

