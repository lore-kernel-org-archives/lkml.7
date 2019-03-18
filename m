Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8902AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF9E20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+OUUKNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfCRRSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:18:51 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39036 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfCRRSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:18:20 -0400
Received: by mail-qk1-f201.google.com with SMTP id w134so15210921qka.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K4asd4oI0/VXu7bks/7ZozR0oEqYxUgnLBJb7yiErTQ=;
        b=Z+OUUKNgtK/1jfa4BvhYHhx7IjjNLQEUJY1NJ7A3vWEIk1RX9PbVSKhiX+wNpR0VVK
         rm+RSajsjJHCrhE1N6/tIuVP+q9XdaMCbwZRMPCgTCjx/L9P2gvJmmbwqvWCKBP9MeF4
         Qw6j2LzWa+BeBhtFcRkoFqLNaB2ov3Vsincet7Xt01JgrRy0n0Px8l+DavyyXnsSQINI
         wfOpZ4cpDL384ukM2hnrV7HWIk5LriqFPiuoGB3tjO+kwnvk5ccqGZfvf45ZsEC8+Jc9
         GnSLuoWMdhDxaKuqFTy4AAf17P9nihFjMbB/8eHPp3LiMDt9udnfahJfYpgVE4FXcX3j
         TbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K4asd4oI0/VXu7bks/7ZozR0oEqYxUgnLBJb7yiErTQ=;
        b=G3AkDoDnYzD8EK/OCHOe3MGG4XIv2rTQeuumbDUDsyHiLktU2898ijHapO666RC3UK
         76bsWl9ml2ZqK38xQWzk5pUsqgyr+1Rf89LICwwJ/z71d7aqogJiL367udNVwbIqn0FX
         jme4h7/m0lhLmvVRrEbkGD2vbBKIWwPJaBl5WKTL/wowlaiz2NrwVd/angaFUMKYFQD/
         x6wacxskmbcbyVR8G14oAQNKdU+C9WDbFt+QqNLJ581k2GwPrkZFT433BRMw/l+Xt/jt
         e7VHWEwPBo+YpZX3+yAeWWJPCUII+JMVivoXFQ8uVojJkU2SjScuCwP/SSl3goL9zz0U
         Z5mg==
X-Gm-Message-State: APjAAAV6fesfThdm513kqb80porY4b9B/cOzUOhfsVwcEkMebMlpKFL3
        7BVt6oPMAp7ceLjgxfBi8fHXsQFYja6NODAE
X-Google-Smtp-Source: APXvYqyJhTgZar+ik6UuyzlVr6SmEq6/15j430olxCWRyB477jKqfxZfFi3KkJC1jdRI+TAOqV2mqA21WihG+rqN
X-Received: by 2002:ac8:21f2:: with SMTP id 47mr10994391qtz.9.1552929499883;
 Mon, 18 Mar 2019 10:18:19 -0700 (PDT)
Date:   Mon, 18 Mar 2019 18:17:42 +0100
In-Reply-To: <cover.1552929301.git.andreyknvl@google.com>
Message-Id: <9733fd0b723aab6bcf4369fe366104ba795eb5a9.1552929301.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552929301.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v12 10/13] tracing, arm64: untag user pointers in seq_print_user_ip
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

seq_print_user_ip() uses provided user pointers for vma lookups, which
can only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/trace/trace_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 54373d93e251..6376bee93c84 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -370,6 +370,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
 {
 	struct file *file = NULL;
 	unsigned long vmstart = 0;
+	unsigned long untagged_ip = untagged_addr(ip);
 	int ret = 1;
 
 	if (s->full)
@@ -379,7 +380,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
 		const struct vm_area_struct *vma;
 
 		down_read(&mm->mmap_sem);
-		vma = find_vma(mm, ip);
+		vma = find_vma(mm, untagged_ip);
 		if (vma) {
 			file = vma->vm_file;
 			vmstart = vma->vm_start;
@@ -388,7 +389,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
 			ret = trace_seq_path(s, &file->f_path);
 			if (ret)
 				trace_seq_printf(s, "[+0x%lx]",
-						 ip - vmstart);
+						 untagged_ip - vmstart);
 		}
 		up_read(&mm->mmap_sem);
 	}
-- 
2.21.0.225.g810b269d1ac-goog

