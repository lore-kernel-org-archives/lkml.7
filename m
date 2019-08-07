Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10288C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABF121E73
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qSJJinjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbfHGRQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:16:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45062 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388210AbfHGRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:16:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so41781970plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EpW+/zsfaWUWqnp/CzJ8iSD2ZsdUd34jJeLFlQmjMJk=;
        b=qSJJinjx4WgXKOGFZMmrrGe4d2ALaNficzckUCKQ9VzSczmwMe7F1Cq0uQ7tfoks+e
         rtGpQwgXk30A1hVz+miPyOItSF28qM821PY2ovorbdNSmTsSYUUDhgdU2OE+wjQDzDPX
         CSpRQfnNtyIHoIY+g92oO+tp+BGpBJMqcqBT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EpW+/zsfaWUWqnp/CzJ8iSD2ZsdUd34jJeLFlQmjMJk=;
        b=lkcxcbZGLCRqlr0yjMz4ep6pibxEp3fRNXLYZsx4kaA4mCVfCPxpZxrwcd6MZ7tNo8
         btoFEF5Zmb5R294hYns9WqA4Km6OimV22hUcN4naDtPVf1jNeCsCfuG5kYkoSL8z0MAz
         kmaFtXsriDqucYHRePcstWnAHZ/lSWwS5XGG0MxtYM76nQv8VflD9mFcou/4ybK0b77k
         HHrIZajXLSH7l5ohx/TXj99mXmvJzPYCjDOFKrmpmeCi2RlwZ7C8JRI381uylQNGPGnh
         qkbPxAqCj/JzuWSpnteYP99eaINuOr7Hxql+KyQ/TNvm09pR9e/RCmCFehqEMOVSIuv3
         06yg==
X-Gm-Message-State: APjAAAXRpkGVESbP2BD6eC7eHwihteDkdIKGy8x8c1V9UaFptVsMrKT1
        YV3By0k6UFL7OHtieJaKLdW51GOJu9I=
X-Google-Smtp-Source: APXvYqwFZ4pqna4e9p6C0a1Fkqp6qRc76QmaknFJcHpGMEiflBOSwsFgniRNvWcMNGSw3sFAcWvCGQ==
X-Received: by 2002:a17:90a:7148:: with SMTP id g8mr938080pjs.51.1565198187764;
        Wed, 07 Aug 2019 10:16:27 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a1sm62692130pgh.61.2019.08.07.10.16.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 10:16:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sandeep Patil <sspatil@google.com>,
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
        Michal Hocko <mhocko@suse.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: [PATCH v5 6/6] doc: Update documentation for page_idle virtual address indexing
Date:   Wed,  7 Aug 2019 13:15:59 -0400
Message-Id: <20190807171559.182301-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190807171559.182301-1-joel@joelfernandes.org>
References: <20190807171559.182301-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the documentation with the new page_idle tracking
feature which uses virtual address indexing.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Sandeep Patil <sspatil@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../admin-guide/mm/idle_page_tracking.rst     | 43 ++++++++++++++++---
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/idle_page_tracking.rst b/Documentation/admin-guide/mm/idle_page_tracking.rst
index df9394fb39c2..9eef32000f5e 100644
--- a/Documentation/admin-guide/mm/idle_page_tracking.rst
+++ b/Documentation/admin-guide/mm/idle_page_tracking.rst
@@ -19,10 +19,14 @@ It is enabled by CONFIG_IDLE_PAGE_TRACKING=y.
 
 User API
 ========
+There are 2 ways to access the idle page tracking API. One uses physical
+address indexing, another uses a simpler virtual address indexing scheme.
 
-The idle page tracking API is located at ``/sys/kernel/mm/page_idle``.
-Currently, it consists of the only read-write file,
-``/sys/kernel/mm/page_idle/bitmap``.
+Physical address indexing
+-------------------------
+The idle page tracking API for physical address indexing using page frame
+numbers (PFN) is located at ``/sys/kernel/mm/page_idle``.  Currently, it
+consists of the only read-write file, ``/sys/kernel/mm/page_idle/bitmap``.
 
 The file implements a bitmap where each bit corresponds to a memory page. The
 bitmap is represented by an array of 8-byte integers, and the page at PFN #i is
@@ -74,6 +78,31 @@ See :ref:`Documentation/admin-guide/mm/pagemap.rst <pagemap>` for more
 information about ``/proc/pid/pagemap``, ``/proc/kpageflags``, and
 ``/proc/kpagecgroup``.
 
+Virtual address indexing
+------------------------
+The idle page tracking API for virtual address indexing using virtual frame
+numbers (VFN) for a process ``<pid>`` is located at ``/proc/<pid>/page_idle``.
+It is a bitmap that follows the same semantics as
+``/sys/kernel/mm/page_idle/bitmap`` except that it uses virtual instead of
+physical frame numbers.
+
+This idle page tracking API does not deal with PFN so it does not require prior
+lookups of ``pagemap``. This is an advantage on some systems where looking up
+PFN is considered a security issue.  Also in some cases, this interface could
+be slightly more reliable to use than physical address indexing, since in
+physical address indexing, address space changes can occur between reading the
+``pagemap`` and reading the ``bitmap``, while in virtual address indexing, the
+process's ``mmap_sem`` is held for the duration of the access.
+
+To estimate the amount of pages that are not used by a workload one should:
+
+ 1. Mark all the workload's pages as idle by setting corresponding bits in
+    ``/proc/<pid>/page_idle``.
+
+ 2. Wait until the workload accesses its working set.
+
+ 3. Read ``/proc/<pid>/page_idle`` and count the number of bits set.
+
 .. _impl_details:
 
 Implementation Details
@@ -99,10 +128,10 @@ When a dirty page is written to swap or disk as a result of memory reclaim or
 exceeding the dirty memory limit, it is not marked referenced.
 
 The idle memory tracking feature adds a new page flag, the Idle flag. This flag
-is set manually, by writing to ``/sys/kernel/mm/page_idle/bitmap`` (see the
-:ref:`User API <user_api>`
-section), and cleared automatically whenever a page is referenced as defined
-above.
+is set manually, by writing to ``/sys/kernel/mm/page_idle/bitmap`` for physical
+addressing or by writing to ``/proc/<pid>/page_idle`` for virtual
+addressing (see the :ref:`User API <user_api>` section), and cleared
+automatically whenever a page is referenced as defined above.
 
 When a page is marked idle, the Accessed bit must be cleared in all PTEs it is
 mapped to, otherwise we will not be able to detect accesses to the page coming
-- 
2.22.0.770.g0f2c4a37fd-goog

