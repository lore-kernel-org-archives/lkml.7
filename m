Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42D4C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62FF217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjAZo1be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfD3NZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:25:28 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35312 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfD3NZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:25:25 -0400
Received: by mail-pf1-f201.google.com with SMTP id g1so9099125pfo.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IkuD9zPPDPrNqKOg+1EuZo5HlTMskU88lY/hO73XGBQ=;
        b=cjAZo1bevEgDG9f0Gp0lCqBUDVGf7WH9HfahHvPYK3yXKOMpkTJl6c0Qs/+BaViS4F
         SVbEHv0pbmF0M0fXn45Xz+XZ5NA51A6Q84gce81tqYq+4vQ4fSd4Vfr74XM9VMTqpEUn
         hpbIVHi0Y6E4lGzikQQHuG5LSWrNkshsuGLGjPRywGWJWT4PFmQUF2llhQi6ncC/Vlfh
         XyXZ2xzPVmh+mASSDoCOMBPHpUNh2v+x16jbihEdr4DI6v1V/jUL7ilAE/v54hqYIVN8
         AFB4b6bLnE3ptsM0NTOpxh1giv5Af/8Vei/jZ/b9XgJhABJa8DnBXyZnippbFF98erxD
         64TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IkuD9zPPDPrNqKOg+1EuZo5HlTMskU88lY/hO73XGBQ=;
        b=QBvHLtDaAgp2NjEkJyX499oO2Lm/xXqxjyboYX6cectlb+1w9m/sXlvJtcvimVtC+E
         oxzdrgD1TdkvJcruTEUrjzaEWOByW1OGK1hPCv+1JX6mLwE/8vuo/ozlKr/nLS24jxej
         w9GY7Modgw1rPSdAaJtBshWBhP72zOSjrg1tM74gMyLLYwW1YYh5HmsZ0BiIgl5LYtYu
         Uz/pAN4CU0disFghtkqC1TjWkvtYyWPC3IzSdMHqrQM4IczF+I+MZGNNidt9qODiv5Bq
         YtWbILsHOfR2XpBHA4wFiD7Hh6qLHZRO6Z5eOCBXcZNu/PzxQfFtJB0zXfs5DwwlTOEY
         zjJQ==
X-Gm-Message-State: APjAAAX4YE4A+eU6JeVWu5AzdPoyAIwkLwzgWxOUU+40CIMzV5Pjeyoh
        06HgNudzuWTzRnsb2biy1sIyl5qrCQbKmGoW
X-Google-Smtp-Source: APXvYqxwzeO4aaEq5t7dlXsyLEMZLxNA1xUAM/PWlhFhSshLHzTvKlXrQBr9Il+4R5AJQuOw/QR46XMvR3q8fhhC
X-Received: by 2002:a65:534b:: with SMTP id w11mr7522791pgr.210.1556630723459;
 Tue, 30 Apr 2019 06:25:23 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:24:58 +0200
In-Reply-To: <cover.1556630205.git.andreyknvl@google.com>
Message-Id: <29b7234f48a282037bdfc23e07ff167756fca0df.1556630205.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v14 02/17] arm64: untag user pointers in access_ok and __uaccess_mask_ptr
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
        Yishai Hadas <yishaih@mellanox.com>, Kuehling@google.com,
        Felix <Felix.Kuehling@amd.com>, Deucher@google.com,
        Alexander <Alexander.Deucher@amd.com>, Koenig@google.com,
        Christian <Christian.Koenig@amd.com>,
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
        Chintan Pandya <cpandya@codeaurora.org>,
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

copy_from_user (and a few other similar functions) are used to copy data
from user memory into the kernel memory or vice versa. Since a user can
provided a tagged pointer to one of the syscalls that use copy_from_user,
we need to correctly handle such pointers.

Do this by untagging user pointers in access_ok and in __uaccess_mask_ptr,
before performing access validity checks.

Note, that this patch only temporarily untags the pointers to perform the
checks, but then passes them as is into the kernel internals.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e5d5f31c6d36..9164ecb5feca 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -94,7 +94,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 	return ret;
 }
 
-#define access_ok(addr, size)	__range_ok(addr, size)
+#define access_ok(addr, size)	__range_ok(untagged_addr(addr), size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
@@ -226,7 +226,8 @@ static inline void uaccess_enable_not_uao(void)
 
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
- * current addr_limit.
+ * current addr_limit. In case the pointer is tagged (has the top byte set),
+ * untag the pointer before checking.
  */
 #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
 static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
@@ -234,10 +235,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	void __user *safe_ptr;
 
 	asm volatile(
-	"	bics	xzr, %1, %2\n"
+	"	bics	xzr, %3, %2\n"
 	"	csel	%0, %1, xzr, eq\n"
 	: "=&r" (safe_ptr)
-	: "r" (ptr), "r" (current_thread_info()->addr_limit)
+	: "r" (ptr), "r" (current_thread_info()->addr_limit),
+	  "r" (untagged_addr(ptr))
 	: "cc");
 
 	csdb();
-- 
2.21.0.593.g511ec345e18-goog

