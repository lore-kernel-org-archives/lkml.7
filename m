Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECA2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204B820863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eTZPglq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfCRRTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:19:41 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:35379 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfCRRR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:17:56 -0400
Received: by mail-vs1-f74.google.com with SMTP id e63so3944536vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UykDW4hFaDHfzyUH5xSGMBQs4gGYEgUL/nC+SEDYWFU=;
        b=eTZPglq7PxVqxdqVAjoMC4HmmCrWD8Td2oOWhHZFu/cW19YPVAKsaJLDurjgd2ljVf
         XFoitnM7dNKXaO1X3w5n48lJ0Y+z6lMVYoHTi6MyqIKBKDduB9n8l/eQ3eoQ6ApOGJcf
         g0Ut1Mty7B6R+MM5DXRurd3w783o+tqjI10hk93IissEzK7cyNctMDjvmU3Tdk6WDEwH
         ffIMuMSLEoDbieTKF2ybjM0vJlmx+cWPNY/uy7bo6luMmancF6Vim1Jp4tv/8hL6d3pb
         M2HFyE+DxIM6V89Ha75sQlU/Ar8a05rWTSWi6zpfjkxsTGWw3NraARaPUHt9My5Uw9OY
         7lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UykDW4hFaDHfzyUH5xSGMBQs4gGYEgUL/nC+SEDYWFU=;
        b=s9jSIDJpk4ME5RcicrAI+zK8npDzAHsrIeeMMQsBNZ3Gxs9UwVFSdbRZJQSBg3La2I
         dzp0BxAVoUQDSnKtE4wpHQnMQ5Zh6gAJK9mzwu6kcotU3AeRmENHO19KAxYNJqBQn7Nm
         AEjaHsCC9Qldb8KVcG5eb7kQR03yrRkIWcgA47Oiicbs34wuTukKSek2Ywx3vjFz5ns2
         uyFJ6AI8E7dDZOyGU5LLh1RDmnx0i2NyvO0wUeo/MDQDKAUUq4gvQGpoegnhWqJF+n8G
         ChDgrIKWwSnsfVP/U8togjWdbf27xGmY4NPNOXKyIgnac8sjqP2rTdj7/ybPV+afW+2l
         euCg==
X-Gm-Message-State: APjAAAX0+1i5TDWTncGKm7b/Of402ZTRAE2XUu3KF7QVBB4yX5YPPapi
        BmoP8WBEf551TXyQiNBm/D/zuKeJrebQfK94
X-Google-Smtp-Source: APXvYqw1yRv1Lvlj4b/qzRYNiehInvLnccniboB47LbD/6n+0FpFdxyh/c9QXVRmnP7ZYupHxKhIzMKUChtQA6Na
X-Received: by 2002:a1f:1e4a:: with SMTP id e71mr11807432vke.2.1552929475245;
 Mon, 18 Mar 2019 10:17:55 -0700 (PDT)
Date:   Mon, 18 Mar 2019 18:17:34 +0100
In-Reply-To: <cover.1552929301.git.andreyknvl@google.com>
Message-Id: <f7b263a20223da2b8b26f6a5b0d84a575af28010.1552929301.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552929301.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v12 02/13] arm64: untag user pointers in access_ok and __uaccess_mask_ptr
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
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
2.21.0.225.g810b269d1ac-goog

