Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6552C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF052063F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RV+qphgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfCOTxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:53:13 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:39436 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfCOTwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:52:13 -0400
Received: by mail-it1-f201.google.com with SMTP id h3so8722142itb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qCZblj86ukutCUgaNEezPPnSo6jFx7c0S/27D3+g5SQ=;
        b=RV+qphgRwIM0BlYxCZg0JlfEjDx5G2b5L8ZyFpBg6xhggSYfsl1Fqr2nkYw/1uo2gs
         3X2mnJn0InykZb95Oc3LklEnd5abQO0mxyfCWv4ktefYvvvkA3igSCrt3kfSvFnDcJd2
         yiTPCyZxoNT8Y3VZrTwxne1jWphT3yMFgfIrreIXZfWc85uza+QqmGRI+KRoFp3SruIJ
         AoO+ZWZNEwD/TFL+4c5NovYe7UTZj9KfYqP4IK256g8ihlekEEHLF6pJB9120lvwCNGI
         YKyN4okwCGSEeBvRd5Hm2UUrZHroN4fPZmCKFLzy7try938Sv18vPjuWwinYuq9JIjNh
         YyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qCZblj86ukutCUgaNEezPPnSo6jFx7c0S/27D3+g5SQ=;
        b=qtZ+PKVQHgmneTmGpQu95Z0iNfF5RB1q6yGEEYbsIv8/3B93t6ngAe9ceo/JU0PuBw
         22ixwctmHW8BMKfrBX/Lq6/ldOs6Vhi2qwnHieO3a5gwt0d+pbhDq7FJDY2NinWSLugi
         MzOXVIQ7QYOZGYa1DhE92Xy/EGCAcHsfrigLytPNmAK/GlcENccbKrtxoph9RlCP27nj
         R42+6j22HLrAYZsBvHswQkXCSGSnhrtSFJsQ7C1wP/JD3/gGI/IKXvTrqmeJh5gJoHxh
         x2rOni3XszPhUTVpnOAlHnzgoq8a+sK59dqs9XRx55bbkpyRPhKv2EM06VHrZTcAHaz7
         n9JA==
X-Gm-Message-State: APjAAAWpnVE0xs08okDONgQapS+gq3eO9SGnirT8Bc/No+95VBtuxWgA
        B2w1sRfmsEm6SqT3mI7FQGAqTCxKvvdN10Sy
X-Google-Smtp-Source: APXvYqzF9kP75AZrtaf7n0FWkgnfxl6FIrePx6iNETztWTIe/Q/kL5cqZ/6EOdqOX8uD9nyrlgZxURKjMjdTQ+yZ
X-Received: by 2002:a24:508e:: with SMTP id m136mr2945070itb.34.1552679532548;
 Fri, 15 Mar 2019 12:52:12 -0700 (PDT)
Date:   Fri, 15 Mar 2019 20:51:33 +0100
In-Reply-To: <cover.1552679409.git.andreyknvl@google.com>
Message-Id: <c4d65de9867cb3349af6800242da0de751260c6c.1552679409.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v11 09/14] kernel, arm64: untag user pointers in prctl_set_mm*
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

prctl_set_mm() and prctl_set_mm_map() use provided user pointers for vma
lookups, which can only by done with untagged pointers.

Untag user pointers in these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/sys.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index 12df0e5434b8..8e56d87cc6db 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1993,6 +1993,18 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 	if (copy_from_user(&prctl_map, addr, sizeof(prctl_map)))
 		return -EFAULT;
 
+	prctl_map->start_code	= untagged_addr(prctl_map.start_code);
+	prctl_map->end_code	= untagged_addr(prctl_map.end_code);
+	prctl_map->start_data	= untagged_addr(prctl_map.start_data);
+	prctl_map->end_data	= untagged_addr(prctl_map.end_data);
+	prctl_map->start_brk	= untagged_addr(prctl_map.start_brk);
+	prctl_map->brk		= untagged_addr(prctl_map.brk);
+	prctl_map->start_stack	= untagged_addr(prctl_map.start_stack);
+	prctl_map->arg_start	= untagged_addr(prctl_map.arg_start);
+	prctl_map->arg_end	= untagged_addr(prctl_map.arg_end);
+	prctl_map->env_start	= untagged_addr(prctl_map.env_start);
+	prctl_map->env_end	= untagged_addr(prctl_map.env_end);
+
 	error = validate_prctl_map(&prctl_map);
 	if (error)
 		return error;
@@ -2106,6 +2118,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
 			      opt != PR_SET_MM_MAP_SIZE)))
 		return -EINVAL;
 
+	addr = untagged_addr(addr);
+
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
 		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
-- 
2.21.0.360.g471c308f928-goog

