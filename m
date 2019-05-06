Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC3EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8619C206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEFKpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:45:11 -0400
Received: from relay.sw.ru ([185.231.240.75]:53852 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfEFKpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:45:10 -0400
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hNb7K-0002zI-3h; Mon, 06 May 2019 13:45:06 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 2/2] ubsan: Remove vla bound checks.
Date:   Mon,  6 May 2019 13:45:27 +0300
Message-Id: <20190506104527.10724-2-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506104527.10724-1-aryabinin@virtuozzo.com>
References: <CAHk-=winPBAQwSr9onDoa_ejnV6uWhFiAuQSwd1X-B16vknyXw@mail.gmail.com>
 <20190506104527.10724-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel the kernel is built with -Wvla for some time, so is not supposed
to have any variable length arrays. Remove vla bounds checking from ubsan
since it's useless now.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 lib/ubsan.c            | 18 ------------------
 lib/ubsan.h            |  5 -----
 scripts/Makefile.ubsan |  1 -
 3 files changed, 24 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 1e9e2ab25539..c4859c2d2f1b 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -349,24 +349,6 @@ void __ubsan_handle_type_mismatch_v1(struct type_mismatch_data_v1 *data,
 }
 EXPORT_SYMBOL(__ubsan_handle_type_mismatch_v1);
 
-void __ubsan_handle_vla_bound_not_positive(struct vla_bound_data *data,
-					void *bound)
-{
-	unsigned long flags;
-	char bound_str[VALUE_LENGTH];
-
-	if (suppress_report(&data->location))
-		return;
-
-	ubsan_prologue(&data->location, &flags);
-
-	val_to_string(bound_str, sizeof(bound_str), data->type, bound);
-	pr_err("variable length array bound value %s <= 0\n", bound_str);
-
-	ubsan_epilogue(&flags);
-}
-EXPORT_SYMBOL(__ubsan_handle_vla_bound_not_positive);
-
 void __ubsan_handle_out_of_bounds(struct out_of_bounds_data *data, void *index)
 {
 	unsigned long flags;
diff --git a/lib/ubsan.h b/lib/ubsan.h
index f4d8d0bd4016..b8fa83864467 100644
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -57,11 +57,6 @@ struct nonnull_arg_data {
 	int arg_index;
 };
 
-struct vla_bound_data {
-	struct source_location location;
-	struct type_descriptor *type;
-};
-
 struct out_of_bounds_data {
 	struct source_location location;
 	struct type_descriptor *array_type;
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 38b2b4818e8e..019771b845c5 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -3,7 +3,6 @@ ifdef CONFIG_UBSAN
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=shift)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=integer-divide-by-zero)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=unreachable)
-      CFLAGS_UBSAN += $(call cc-option, -fsanitize=vla-bound)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=signed-integer-overflow)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
       CFLAGS_UBSAN += $(call cc-option, -fsanitize=object-size)
-- 
2.21.0

