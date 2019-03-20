Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0F1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08AC218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbUaG2SU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfCTOv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:51:56 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33250 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbfCTOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:51:54 -0400
Received: by mail-pg1-f202.google.com with SMTP id y1so2935677pgo.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k1ksHzqcIFCs0rlhYrsau26vl3ocVueBBoKnHNKxr50=;
        b=gbUaG2SUmK0LgYPWKNjtqqNqra0Dj2I7PW9z90Jwp3BbFr6Ygh4VDAsBxA5gDOongd
         +7CxcUNls+IlKo+JGYjfKyQrfYRtO4Z47SxpoLW/8mbPq3NLKcCBVFUfMf1O6lo5lyQS
         Xjgdf+hI7Y/bA1D0SA8rH8Eu8XxBhdBy5VVMEbbfPWY8xA3Sb5oG0H4SEAubrB034XoX
         QEsR92P8+ORdJnszt4DIVx7Fa/WP9kGWpGO4+l3UfQFEGOIoLoqxYh83b5fPG2to4T2Y
         zFPE52PhA9pJC7TqxInYx4207DCj5+fCOTEW3biD/iclPyCXcoUirtevwOL47SHpdgsx
         zTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k1ksHzqcIFCs0rlhYrsau26vl3ocVueBBoKnHNKxr50=;
        b=Crkw32t90ftuCCaqRP1BhWfCoTVPsIT9KZLVIc1Z+7EgGRsUumf2Ih923OLjBCrUAh
         0KcphVr8Bb47tH9Bpy8zlomdXBBEJz9vA1oKPOFy6SVLY7zyuRxqYE/beGx8o9t8e4DH
         ZgnDwbkEwW1NabMTi0Bf8qmuU/nW01Y1ySWSC3mZPiZLm+LuPwLrQtal4C4M7bxvjl5s
         MsO+4O3K/e8b6ACvqrZ9PAnVaJsa8xQpXoY2TtzY1Ynd+dv+5XRtWxhejBnjEr2FmdN/
         lqIk98zw+CKf2dGyWeMc8gyvGFQf4unFhpqUmbtYMJfb6V3/V3YXBnypywi+LmyY4SFM
         7huQ==
X-Gm-Message-State: APjAAAVfER8wCR2X6is5QgrbfoVoMOGCw52bW4oOkakmSIzwGuRVXO1b
        nL7ld42yob9NLm53vqpADwacxYl8rDKyIkHt
X-Google-Smtp-Source: APXvYqyDQEPwUnTSsgi/gUBKfoSs2QhRiDzA2VJUjgLM5tdiS/YJBnhxYd/PCUUZbtlvisMRP7lT9bGN6AETareo
X-Received: by 2002:a63:2ac2:: with SMTP id q185mr3933097pgq.119.1553093512985;
 Wed, 20 Mar 2019 07:51:52 -0700 (PDT)
Date:   Wed, 20 Mar 2019 15:51:17 +0100
In-Reply-To: <cover.1553093420.git.andreyknvl@google.com>
Message-Id: <3faedcd2495a07e13b8611b2c63779d1d6d2b3f0.1553093421.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1553093420.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v13 03/20] lib, arm64: untag user pointers in strn*_user
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
        Alex Deucher <alexander.deucher@amd.com>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
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
2.21.0.225.g810b269d1ac-goog

