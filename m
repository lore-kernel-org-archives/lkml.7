Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143AAC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B92205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e90YIYJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfEFQda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:33:30 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:32872 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfEFQbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:31:17 -0400
Received: by mail-yw1-f73.google.com with SMTP id c4so26406133ywd.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x8HMVSO2lCP9thpVq0jteC8wa+ruR/qG5sfvMEzcSf4=;
        b=e90YIYJEqCjuv0dQNXe7JfByZ3LYw/uoix1gLG6qHxakrZEGoit4yh6fTDsfYia+jH
         wb7igUzrFQvpjJl955zqS3eb64AMNM806CURkcixGS6z1rzCJzMGBiAz82rRhlhjgKjR
         9cdDyeo/3JMugM0eGAxc56H2X/rF/Gu5NZJ6OlTvycYfBxRjWeovYDz5GGyc2/popU6X
         Q4rJTvbhNlqr5zqGtmKCjWUttV6dsKWcbk2qBw0aV1In8VLH8mRF5MiPk8iCO4KWMnPF
         BSI3N1BBXtSHWlnz3+Iji+1TK5JldUspg0pnnlvUCK4PaDa6c2GsK9cElOVCY5yx3kNx
         bcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x8HMVSO2lCP9thpVq0jteC8wa+ruR/qG5sfvMEzcSf4=;
        b=b6PHwXvVmLNg6m4yrGzNzPtce8LLQuOl8+4tsOGE+4B2LW1tVfLKgkfhll3H+skADf
         oM7bra6XsUIhla/oWUZid9buGss9ibcE+t9NQSsYvFgiZq+c9FpMIMZ4KFV+P3G645eG
         NyZ78rugmsHd9zVACcAOxJ3usf5ryOTBB0i6w3P8Fm4N/U+Rh2+uSmkGflXNylb/mlnV
         UCkYfip8EYeE5o7BzletGiSFSGZgdx2bBVKzduu7/7olczGG4MJVs3tgpkSM83Z/Dbdw
         X21ZOuY9l4xzIMZ09q2tJnqbhabupPm0zS96MX8NC48ih1M8kFnCzciQbKpum8tU4cCe
         77zQ==
X-Gm-Message-State: APjAAAWy12oFjoBEHAy2/u/L0VucIwBrDh0sUCoUa04ORQn8RqHWRn8A
        aoTv2jNmuXZd6uxf4C3+yfQKe7bsV0VAJkDA
X-Google-Smtp-Source: APXvYqyZq8rlWFW4uBLN8C8I3oEaQAU5CNW3HReq+6c5opQ9wp/VGDDqgMMeEo6tOAWNlA3+Gfl3rFVlDcMv6bDq
X-Received: by 2002:a5b:8c2:: with SMTP id w2mr16278460ybq.201.1557160276487;
 Mon, 06 May 2019 09:31:16 -0700 (PDT)
Date:   Mon,  6 May 2019 18:30:49 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <861418ff7ed7253356cb8267de5ee2d4bd84196d.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 03/17] lib, arm64: untag user pointers in strn*_user
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to handle the case of tagged user addresses separately.

Untag user pointers passed to these functions.

Note, that this patch only temporarily untags the pointers to perform
validity checks, but then uses them as is to perform user memory accesses.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 3 ++-
 lib/strnlen_user.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 58eacd41526c..6209bb9507c7 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -6,6 +6,7 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/mm.h>
 
 #include <asm/byteorder.h>
 #include <asm/word-at-a-time.h>
@@ -107,7 +108,7 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 		return 0;
 
 	max_addr = user_addr_max();
-	src_addr = (unsigned long)src;
+	src_addr = (unsigned long)untagged_addr(src);
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
 		long retval;
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 1c1a1b0e38a5..8ca3d2ac32ec 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/uaccess.h>
+#include <linux/mm.h>
 
 #include <asm/word-at-a-time.h>
 
@@ -109,7 +110,7 @@ long strnlen_user(const char __user *str, long count)
 		return 0;
 
 	max_addr = user_addr_max();
-	src_addr = (unsigned long)str;
+	src_addr = (unsigned long)untagged_addr(str);
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
 		long retval;
-- 
2.21.0.1020.gf2820cf01a-goog

