Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0153C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832A22087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BK1+NHtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbfG3VHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:07:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35059 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387511AbfG3VHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:07:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so24387741pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQmtlWm+E4Ht8KJWS3CIc6OxhoEnlgrUfo3WZfK6Cgk=;
        b=BK1+NHtgcxXYd9svHIXl4oaEdad9kLD6Mbaabj6IKd0mKnQP6iz6av6uLftJ2EfIp0
         IHgcwqlVAm+LY5PT9XIJCbo8J+roHxXbYtrRLXGVk4QUPtLMvLyx3EfA6kqObonleANQ
         62sPbi3KvkPvCNl2xCTmsiLcUj1NUjRd9goIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQmtlWm+E4Ht8KJWS3CIc6OxhoEnlgrUfo3WZfK6Cgk=;
        b=FKJlsj1JjW8tzDX2nGXfpoyDdK5UASmQ659yH+E7IVPmQNINFi3nI1vCKgCZONQWcZ
         kNrtwi2BUYjHwdSK72TnhYO3KIxPEPLX3IzyWaoJDok6otRN9fqhjeB6qd0k+C8Gtvr4
         UWanyJpzWv8SeVZjausVcLJh+itkn6Mnv5gWLatwLGZWNyCeSWmwZ3pPsiE2fX7ebrdX
         aNs8Ekk+QK1kndXpxoK4or/Oleu6/0SzJzfJqzb8zBp/6TZCl5ROUV+q49b7x53Yhybf
         gErOo6/yxBJkd3D240vaZQ9BdUqoBl2W1QCiZ9OJzYvoDrB6/GJu1h+KGDJXtrBzAhWu
         9uIQ==
X-Gm-Message-State: APjAAAWg98mM4w/U4VL6gZcHCVEd63IR0zRgU2zr/rLY7iOcRfPUJ9IQ
        Lh7nvWQJBJQF6QsJKCW7lEyb5g==
X-Google-Smtp-Source: APXvYqyrYFXubXrdWWyteW8t45F3qq8NknERY3imh1RniTNQgWLo48CyG109AH2gQQ7FnJTccgLJCg==
X-Received: by 2002:a17:90a:8b98:: with SMTP id z24mr120053812pjn.77.1564520873658;
        Tue, 30 Jul 2019 14:07:53 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q1sm77273595pfg.84.2019.07.30.14.07.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 14:07:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Tri Vo <trong@android.com>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] idr: Document calling context for IDA APIs mustn't use locks
Date:   Tue, 30 Jul 2019 14:07:52 -0700
Message-Id: <20190730210752.157700-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for these functions indicates that callers don't need
to hold a lock while calling them, but that documentation is only in one
place under "IDA Usage". Let's state the same information on each IDA
function so that it's clear what the calling context requires.
Furthermore, let's document ida_simple_get() with the same information
so that callers know how this API works.

Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Tri Vo <trong@android.com>
Cc: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

See Greg's comment[1] for the reason why this patch is created.

[1] https://lkml.kernel.org/r/20190730064657.GA1213@kroah.com

 include/linux/idr.h | 23 ++++++++++++++++++++---
 lib/idr.c           |  9 ++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 4ec8986e5dfb..b591ecbba3f4 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -263,7 +263,8 @@ void ida_destroy(struct ida *ida);
  *
  * Allocate an ID between 0 and %INT_MAX, inclusive.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * synchronisation in your code.
  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
  * or %-ENOSPC if there are no free IDs.
  */
@@ -280,7 +281,8 @@ static inline int ida_alloc(struct ida *ida, gfp_t gfp)
  *
  * Allocate an ID between @min and %INT_MAX, inclusive.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * synchronisation in your code.
  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
  * or %-ENOSPC if there are no free IDs.
  */
@@ -297,7 +299,8 @@ static inline int ida_alloc_min(struct ida *ida, unsigned int min, gfp_t gfp)
  *
  * Allocate an ID between 0 and @max, inclusive.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * synchronisation in your code.
  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
  * or %-ENOSPC if there are no free IDs.
  */
@@ -311,6 +314,20 @@ static inline void ida_init(struct ida *ida)
 	xa_init_flags(&ida->xa, IDA_INIT_FLAGS);
 }
 
+/**
+ * ida_simple_get() - Allocate an unused ID between (start, end].
+ * @ida: IDA handle.
+ * @start: ID to start from (inclusive)
+ * @end: ID to stop at (exclusive). Use 0 to indicate %INT_MAX.
+ * @gfp: Memory allocation flags.
+ *
+ * Allocate an ID between (start, end].
+ *
+ * Context: Any context. It is safe to call this function without
+ * synchronisation in your code.
+ * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
+ * or %-ENOSPC if there are no free IDs.
+ */
 #define ida_simple_get(ida, start, end, gfp)	\
 			ida_alloc_range(ida, start, (end) - 1, gfp)
 #define ida_simple_remove(ida, id)	ida_free(ida, id)
diff --git a/lib/idr.c b/lib/idr.c
index 66a374892482..e8a5f47c0c78 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -381,7 +381,8 @@ EXPORT_SYMBOL(idr_replace);
  * Allocate an ID between @min and @max, inclusive.  The allocated ID will
  * not exceed %INT_MAX, even if @max is larger.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * synchronisation in your code.
  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
  * or %-ENOSPC if there are no free IDs.
  */
@@ -488,7 +489,8 @@ EXPORT_SYMBOL(ida_alloc_range);
  * @ida: IDA handle.
  * @id: Previously allocated ID.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * synchronisation in your code.
  */
 void ida_free(struct ida *ida, unsigned int id)
 {
@@ -540,7 +542,8 @@ EXPORT_SYMBOL(ida_free);
  * or freed.  If the IDA is already empty, there is no need to call this
  * function.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * synchronisation in your code.
  */
 void ida_destroy(struct ida *ida)
 {
-- 
Sent by a computer through tubes

