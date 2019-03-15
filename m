Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7FBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C9021908
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/k7mB6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfCOTwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:52:02 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:34866 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfCOTwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:52:00 -0400
Received: by mail-io1-f73.google.com with SMTP id k2so7892346ioj.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5MhKE+xTLHyfvL7IaHp0v3M/t60vex2+i9OGVnQRymk=;
        b=b/k7mB6t8bkl6WhPUgGfnIbuQpfATsU20Yd9KlI8YbMaGUFttdQxCzkvduKa8IOy8C
         +aL+zDQpxDKN5neB5pmosuIHBI0Zw/VkKPjT+OCI05YKof+0rexjDomInULUZSZZwZe4
         sKO4ip/dnicDW0EiUs3RF19JdO3smNNUCHBqnEYyMQcB4Zi3SAnphW12wObXWLr30yaC
         Cg1FmVpaxC5JzsE7dKMZHXXd8+AOb4omgJILGhPI4h92LrbGtWJe5eIqPcfmyYH0djku
         js0qEZrW0JA+T0+gbA+Ly5yXzixdwcg0y/4Mb6pAB6p7EjV2RE2SUw8xVQAbEf7JiHti
         SGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5MhKE+xTLHyfvL7IaHp0v3M/t60vex2+i9OGVnQRymk=;
        b=W43REZcDHh3vTea6aTiEGyOnPxbSPUb9KZaCGCvHRM49UHvfNTsNy4yRKo3CK8qhBj
         c2FetPWAMc/Hnt8m/flp//HKwugoD40at31CBnIMBRRSMsv2H/0tkHVOeKnw1x0SikaN
         AH4PM0wuprOf6IkJOiOYaYd0oaimZqG5gro/4G9zqp8BzKVkLZCmPOR9PtvRiTOaba+b
         SZa+aXFgWt7nOz8E2/fJ4TNSEGNVctKHyN0YVYSAmjKhpJL2v7SXh3LdPAmVgvwwWJx6
         n4e/pat6zMigFiPLHw1GPlea/RXcLewATgu6cL3LYpPqZZWTPyNWqrZxRsnm4XLLd1Ic
         dgPg==
X-Gm-Message-State: APjAAAW8++Y//L34m8/h7ueJ7etKuauRBkxk6P6uSZFFo5SGuNpHtQi9
        70YPcuQVscFn9QCxGHBFx6qauLIMQ1pxTyHk
X-Google-Smtp-Source: APXvYqzz8vOD7Qv22AiUEzZPFjEW8sEguH+wb4/ai4clU9WhQEQBq5QCuyJA5WS9vCTzYh7rDvAW6xfNjGINS7Ci
X-Received: by 2002:a24:4503:: with SMTP id y3mr2805802ita.32.1552679519819;
 Fri, 15 Mar 2019 12:51:59 -0700 (PDT)
Date:   Fri, 15 Mar 2019 20:51:29 +0100
In-Reply-To: <cover.1552679409.git.andreyknvl@google.com>
Message-Id: <f46caf7bea6bdbb7e50f2abedc83df13d075735c.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v11 05/14] mm, arm64: untag user pointers in mm/gup.c
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

mm/gup.c provides a kernel interface that accepts user addresses and
manipulates user pages directly (for example get_user_pages, that is used
by the futex syscall). Since a user can provided tagged addresses, we need
to handle this case.

Add untagging to gup.c functions that use user addresses for vma lookups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index f84e22685aaa..3192741e0b3a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -686,6 +686,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -848,6 +850,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	vm_fault_t ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.21.0.360.g471c308f928-goog

