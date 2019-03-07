Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B9DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D4E2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VybC2Npy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfCGLxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:53:08 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51026 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfCGLw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FTAGVNI6Hb9dNTT478wc/mzluBHW5BLlnleIPj09SRw=; b=VybC2NpyAfOwzUfbyK5HYWqO1q
        b82ydLsdkoLezFBBomu5aLmt0Y/48aF3nIHbpAmz7tZBh3s2joQ8sQNf8R5iPeZipIinE7uDPH/YP
        jZBEloQqek4XvCaCnfnXaQeNTXmclSbO9UKje6CxZwKq9Bz2OMEhkOdAooDGrlrF1OvKU3sDYBpiT
        zftPIEdGJwLcspMj6nsY9SV1CQ5YCaidy9nWB/HwdnZtjigwcd1desw42X7kZ4Fe89hp/b8lGviqT
        LSDtWAQWKoNqNkQkb9LlRE2MR6Qch5PMN4f96znyp5Jzop2HHaX/+Qsbv8lBMyI3+xPW0E10XbJRU
        stV6QbvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZm-0005PV-Mj; Thu, 07 Mar 2019 11:52:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B215A20297BDA; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115159.968646510@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 10/20] x86/uaccess,ubsan: Fix UBSAN vs SMAP
References: <20190307114511.870090179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN can insert extra code in random locations; including AC=1
sections. Typically this code is not safe and needs wrapping.

So far, only __ubsan_handle_type_mismatch* have been observed in AC=1
sections and therefore only those are annotated.

Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/Makefile |    1 +
 lib/ubsan.c  |    4 ++++
 2 files changed, 5 insertions(+)

--- a/lib/Makefile
+++ b/lib/Makefile
@@ -263,6 +263,7 @@ obj-$(CONFIG_UCS2_STRING) += ucs2_string
 obj-$(CONFIG_UBSAN) += ubsan.o
 
 UBSAN_SANITIZE_ubsan.o := n
+CFLAGS_ubsan.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
 obj-$(CONFIG_SBITMAP) += sbitmap.o
 
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <linux/uaccess.h>
 
 #include "ubsan.h"
 
@@ -313,6 +314,7 @@ static void handle_object_size_mismatch(
 static void ubsan_type_mismatch_common(struct type_mismatch_data_common *data,
 				unsigned long ptr)
 {
+	unsigned long flags = user_access_save();
 
 	if (!ptr)
 		handle_null_ptr_deref(data);
@@ -320,6 +322,8 @@ static void ubsan_type_mismatch_common(s
 		handle_misaligned_access(data, ptr);
 	else
 		handle_object_size_mismatch(data, ptr);
+
+	user_access_restore(flags);
 }
 
 void __ubsan_handle_type_mismatch(struct type_mismatch_data *data,


