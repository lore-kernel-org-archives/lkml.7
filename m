Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B158C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCC82067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="p0ekItKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbfG2VhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:37:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47631 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbfG2VhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:37:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6TLafJo2941815
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Jul 2019 14:36:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6TLafJo2941815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564436202;
        bh=w0bwysiYlTrIWkYtN0bhogg07gctpWnaK7Kk0AEcqlE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=p0ekItKfCL/e90tGmMuxXArf2cPHfk5fJEzRjKcbtIsKP897co8M1pMES2DTmo09L
         Vilv6oNM9an63qLdkYJFhvEjBjjLUq878z6SBVGewRu3HLquTlajeKMCSmDGB2z6VF
         ZNjebJDR0ozit6TGRdGbKAv3q0h9xuxqOl7nyVK4ff0eqXrWEFWwqQ9A/aDdJsGmrF
         PyjBavxsZQWANCD2BevbOSeIa0U2btwTPhMDK3uRqWa7SLAE5C8/J7N73utEluPaQz
         X5vkGAXFIvRhGyDpBzI+bWeyEf4OJYWBEdmdal30/flbSXP8DmQVc/N7MF/9C3RrjA
         wFqfk5twV5rdQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6TLaf3u2941812;
        Mon, 29 Jul 2019 14:36:41 -0700
Date:   Mon, 29 Jul 2019 14:36:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrii Nakryiko <tipbot@zytor.com>
Message-ID: <tip-8aa259b10a6a759c50137bbbf225df0c17ca5d27@git.kernel.org>
Cc:     andriin@fb.com, andrii.nakryiko@gmail.com, ast@fb.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        daniel@iogearbox.net, hpa@zytor.com, mingo@kernel.org
Reply-To: daniel@iogearbox.net, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, acme@redhat.com, ast@fb.com,
          andrii.nakryiko@gmail.com, andriin@fb.com, mingo@kernel.org,
          hpa@zytor.com
In-Reply-To: <20190718173021.2418606-1-andriin@fb.com>
References: <20190718173021.2418606-1-andriin@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] libbpf: fix missing __WORDSIZE definition
Git-Commit-ID: 8aa259b10a6a759c50137bbbf225df0c17ca5d27
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8aa259b10a6a759c50137bbbf225df0c17ca5d27
Gitweb:     https://git.kernel.org/tip/8aa259b10a6a759c50137bbbf225df0c17ca5d27
Author:     Andrii Nakryiko <andriin@fb.com>
AuthorDate: Thu, 18 Jul 2019 10:30:21 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 10:18:08 -0300

libbpf: fix missing __WORDSIZE definition

hashmap.h depends on __WORDSIZE being defined. It is defined by
glibc/musl in different headers. It's an explicit goal for musl to be
"non-detectable" at compilation time, so instead include glibc header if
glibc is explicitly detected and fall back to musl header otherwise.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Fixes: e3b924224028 ("libbpf: add resizable non-thread safe internal hashmap")
Link: https://lkml.kernel.org/r/20190718173021.2418606-1-andriin@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/bpf/hashmap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index 03748a742146..bae8879cdf58 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -10,6 +10,11 @@
 
 #include <stdbool.h>
 #include <stddef.h>
+#ifdef __GLIBC__
+#include <bits/wordsize.h>
+#else
+#include <bits/reg.h>
+#endif
 #include "libbpf_internal.h"
 
 static inline size_t hash_bits(size_t h, int bits)
