Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094A4C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00A920863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OVRG0jDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfCRRSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:18:31 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:40712 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfCRRS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:18:27 -0400
Received: by mail-yw1-f73.google.com with SMTP id x2so3173757ywc.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hfuKek+o8vy+53O51p2MPtj2JUyumu3LZdujtPFxXko=;
        b=OVRG0jDx+a4bA2Xe0x2W0QLSaeWfLl/IABe0xhS3IFP8diCvylSVwKQWoIigEjNHVc
         yxjFs3rDXFN+YQZXXdBXqzoVuEhq+g8HP9vfnj/K/jnMV093FMqmv6YIj0itG5FlZbO1
         ke03j95r0/PkzmDHuCN3H9fGFOQlTbWpbvmuT2QemWXQk/lZDOT0fPG1qeBd7bYvwCAL
         AE3Z9++g1iD+M29C/0LdG7U5gglyxyekWqwWKO87UeLRgDFAy26KL+NKf1x9Z+3nMGJh
         HWwxBBm2ki5StK4NVq41umliE7Ge0hSfeTd7JwuOJHWr+3LKBGyWEd26Ba9MwuaG3MTr
         +/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hfuKek+o8vy+53O51p2MPtj2JUyumu3LZdujtPFxXko=;
        b=e1KZNpt9//t/EARekqt+SYrAtWZET71/83sS1Qmb6MzwXqWbNN2ATzSSTTHeuSr6qJ
         LhoUd7lIdPCSwRoqyMg9dy6pq3yA4QfLmVbmT0+g+WC6EtLmXcvD0854pwATASySruub
         xGVa1QlBGRb1Bi6e/JbwJWE4UsCyWDDaEJX+YvLe44y9cSHHRO3XygDr2hNTWrL0l8Ck
         98gc/3OpoNOG2iIUgcMHFhsE6w9YxrhIayO4mH+eP6F1eFjCYq2FGA39KavWRhG8jiiA
         +heiVZ+I4I/B6GCFnBrKJl6NOGHmvS0wBWtVkMwy/KQCBgdYZwo5F5ZTfVHJ7LqB2xv8
         GvTg==
X-Gm-Message-State: APjAAAWedK5+3dMdJkbUun1xcs/HnzOGGWjnqlGo86eKcgDj2XjoYycO
        /vSUN5FZqAGl1ufaR3+9C7c+Kbur7hnS0qKT
X-Google-Smtp-Source: APXvYqyE9Hf1UP7XaN3S1ukCc+WMyyJkC7y8Hk/2DK6LClASlL+h1czCzSFlt0sWM+JMT6cpK2e3Il7FKfoAeEtz
X-Received: by 2002:a25:e648:: with SMTP id d69mr9320791ybh.95.1552929506037;
 Mon, 18 Mar 2019 10:18:26 -0700 (PDT)
Date:   Mon, 18 Mar 2019 18:17:44 +0100
In-Reply-To: <cover.1552929301.git.andreyknvl@google.com>
Message-Id: <7883ff7cbe2e8075c3a0f450eade08587f49f3bc.1552929301.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552929301.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v12 12/13] bpf, arm64: untag user pointers in stack_map_get_build_id_offset
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

stack_map_get_build_id_offset() uses provided user pointers for vma
lookups, which can only by done with untagged pointers.

Untag the user pointer in this function for doing the lookup and
calculating the offset, but save as is into the bpf_stack_build_id
struct.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/bpf/stackmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 950ab2f28922..bb89341d3faf 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -320,7 +320,9 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	}
 
 	for (i = 0; i < trace_nr; i++) {
-		vma = find_vma(current->mm, ips[i]);
+		u64 untagged_ip = untagged_addr(ips[i]);
+
+		vma = find_vma(current->mm, untagged_ip);
 		if (!vma || stack_map_get_build_id(vma, id_offs[i].build_id)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
@@ -328,7 +330,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			memset(id_offs[i].build_id, 0, BPF_BUILD_ID_SIZE);
 			continue;
 		}
-		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
+		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + untagged_ip
 			- vma->vm_start;
 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
 	}
-- 
2.21.0.225.g810b269d1ac-goog

