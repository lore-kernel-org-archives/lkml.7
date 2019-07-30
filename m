Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839EBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4861F2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MYdDGpp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbfG3VUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:20:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35979 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387476AbfG3VUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:20:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so29403059plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 14:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44ONowdSlztBIQEZ8M7KxSw1b2hoFMAz6PJ/0W+xxXg=;
        b=MYdDGpp4U8oIsvbKVIe106xriDXDt2HsL7ey1BlQ47Ueozytcr9m4K0kD1zTuiDIUr
         s81G9I+zLn6mpHlhRusMyJTXhU0xiQKG6H1w+TjpUsvrxZP2UJ6+xTm3wvFvOwal8vuW
         Kw41DfrD39NC3wbOQq+/iHnnwakNPOXJMDv1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44ONowdSlztBIQEZ8M7KxSw1b2hoFMAz6PJ/0W+xxXg=;
        b=Dc8/7R/HmMo7l6WmHtd0lXaix8xKsj1fNTO6yLrPG9YWNQdVBds2baxEtJfmqj+pH8
         o2ohZKZphto1XMcVjGJCV560FMeDaqTRTigEjSPXZZGx1cA/oN5hCKTTCbJLLNzC5o+4
         8rDtJ8oR+Iq0D62fleS/U/qqqiyox1cumss5zgzDAfF73SRX/mADLJWKTtEvPTshS/dG
         PDZJAZVNZQe+yXngaG0tSHYphHfcqK4Em+C9DAoBJW9rEe0M54PTjgRGXxm8ETtCgKv+
         pvcad4vBxD5tFbvcgpWb1rD6or+lk0dPFzuZmi0cQRcaalMQhNdnuVoU+/G5v4aQ6tZE
         Pt8Q==
X-Gm-Message-State: APjAAAWg70Ar2h/kVkI21AGSu9dMp7PkuH73NHxcqyVlzvgLVn9IN6pX
        nnKTVW5B6LEQWu0a4V4XbWfDoZBrF3GRwA==
X-Google-Smtp-Source: APXvYqwSvLy4JdF9PJDCx8oAd5LCxJAQBDlp7X/T7IjGLK5mMyOmj16cBEiWsPXuNBpZ5ITHvwqSmA==
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr116375727pla.89.1564521650056;
        Tue, 30 Jul 2019 14:20:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n140sm68205686pfd.132.2019.07.30.14.20.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 14:20:49 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Tri Vo <trong@android.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 1/2] idr: Document calling context for IDA APIs mustn't use locks
Date:   Tue, 30 Jul 2019 14:20:47 -0700
Message-Id: <20190730212048.164657-1-swboyd@chromium.org>
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
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/idr.h | 9 ++++++---
 lib/idr.c           | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 4ec8986e5dfb..5bb026007044 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -263,7 +263,8 @@ void ida_destroy(struct ida *ida);
  *
  * Allocate an ID between 0 and %INT_MAX, inclusive.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
  * or %-ENOSPC if there are no free IDs.
  */
@@ -280,7 +281,8 @@ static inline int ida_alloc(struct ida *ida, gfp_t gfp)
  *
  * Allocate an ID between @min and %INT_MAX, inclusive.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
  * or %-ENOSPC if there are no free IDs.
  */
@@ -297,7 +299,8 @@ static inline int ida_alloc_min(struct ida *ida, unsigned int min, gfp_t gfp)
  *
  * Allocate an ID between 0 and @max, inclusive.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
  * or %-ENOSPC if there are no free IDs.
  */
diff --git a/lib/idr.c b/lib/idr.c
index 66a374892482..dbd25696162e 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -381,7 +381,8 @@ EXPORT_SYMBOL(idr_replace);
  * Allocate an ID between @min and @max, inclusive.  The allocated ID will
  * not exceed %INT_MAX, even if @max is larger.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
  * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
  * or %-ENOSPC if there are no free IDs.
  */
@@ -488,7 +489,8 @@ EXPORT_SYMBOL(ida_alloc_range);
  * @ida: IDA handle.
  * @id: Previously allocated ID.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
  */
 void ida_free(struct ida *ida, unsigned int id)
 {
@@ -540,7 +542,8 @@ EXPORT_SYMBOL(ida_free);
  * or freed.  If the IDA is already empty, there is no need to call this
  * function.
  *
- * Context: Any context.
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
  */
 void ida_destroy(struct ida *ida)
 {
-- 
Sent by a computer through tubes

