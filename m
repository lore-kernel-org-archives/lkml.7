Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33347C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03E8217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555543304;
	bh=y1M+A6AnsX9pqLEpFZXtB6UcyPLK0zEX4KF/7oDdBIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qh+aBo5n16gyeb9Xta+16tP6zqd4T1Oev2LvHOy9D3xNZe8jDsKFcrRUJbsNmKiuo
	 Y8a+IH1aPTSLWdQgWmAy0oAkkKc6TRSbD3D0qLljcBCmQuWLXis9qv+F+O/8fNHjmY
	 sRzsikaEUxP2rY3BW//XNxACZJWMX1FL1qn7WrSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbfDQXVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:21:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34752 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387611AbfDQXVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:21:42 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01E45C37;
        Wed, 17 Apr 2019 23:21:40 +0000 (UTC)
Date:   Wed, 17 Apr 2019 16:21:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tri Vo <trong@android.com>
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, oberpar@linux.ibm.com,
        Trilok Soni <tsoni@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Daniel Mentz <danielmentz@google.com>,
        Petri Gynther <pgynther@google.com>
Subject: Re: [PATCH v5] gcov: Clang support
Message-Id: <20190417162139.2ca3ba78eab414b2fa854a07@linux-foundation.org>
In-Reply-To: <20190417225328.208129-1-trong@android.com>
References: <20190417225328.208129-1-trong@android.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 15:53:28 -0700 Tri Vo <trong@android.com> wrote:

> LLVM uses profiling data that's deliberately similar to GCC, but has a very
> different way of exporting that data.  LLVM calls llvm_gcov_init() once per
> module, and provides a couple of callbacks that we can use to ask for more
> data.
> 
> We care about the "writeout" callback, which in turn calls back into
> compiler-rt/this module to dump all the gathered coverage data to disk:
> 
>    llvm_gcda_start_file()
>      llvm_gcda_emit_function()
>      llvm_gcda_emit_arcs()
>      llvm_gcda_emit_function()
>      llvm_gcda_emit_arcs()
>      [... repeats for each function ...]
>    llvm_gcda_summary_info()
>    llvm_gcda_end_file()
> 
> This design is much more stateless and unstructured than gcc's, and is
> intended to run at process exit.  This forces us to keep some local state
> about which module we're dealing with at the moment.  On the other hand, it
> also means we don't depend as much on how LLVM represents profiling data
> internally.
> 
> See LLVM's lib/Transforms/Instrumentation/GCOVProfiling.cpp for more
> details on how this works, particularly GCOVProfiler::emitProfileArcs(),
> GCOVProfiler::insertCounterWriteout(), and GCOVProfiler::insertFlush().

checkpatch speaketh truth.

Also, I'll change those Co-authored-by's to the documented Co-developed-by.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: gcov-clang-support-checkpatch-fixes

WARNING: Non-standard signature: Co-authored-by:
#31: 
Co-authored-by: Nick Desaulniers <ndesaulniers@google.com>

WARNING: Non-standard signature: Co-authored-by:
#32: 
Co-authored-by: Tri Vo <trong@android.com>

WARNING: Possible unnecessary 'out of memory' message
#158: FILE: kernel/gcov/clang.c:90:
+	if (!info) {
+		pr_warn_ratelimited("failed to allocate gcov info\n");

WARNING: Possible unnecessary 'out of memory' message
#193: FILE: kernel/gcov/clang.c:125:
+	if (!info) {
+		pr_warn_ratelimited("failed to allocate gcov function info for %s\n",

WARNING: line over 80 characters
#546: FILE: kernel/gcov/clang.c:478:
+			pos += store_gcov_u32(buffer, pos, fi_ptr->cfg_checksum);

total: 0 errors, 5 warnings, 663 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

./patches/gcov-clang-support.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Please run checkpatch prior to sending patches

Cc: Daniel Mentz <danielmentz@google.com>
Cc: Greg Hackmann <ghackmann@android.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Petri Gynther <pgynther@google.com>
Cc: Prasad Sodagudi <psodagud@quicinc.com>
Cc: Trilok Soni <tsoni@quicinc.com>
Cc: Tri Vo <trong@android.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/gcov/clang.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/kernel/gcov/clang.c~gcov-clang-support-checkpatch-fixes
+++ a/kernel/gcov/clang.c
@@ -86,10 +86,8 @@ void llvm_gcov_init(llvm_gcov_callback w
 {
 	struct gcov_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
 
-	if (!info) {
-		pr_warn_ratelimited("failed to allocate gcov info\n");
+	if (!info)
 		return;
-	}
 
 	INIT_LIST_HEAD(&info->head);
 	INIT_LIST_HEAD(&info->functions);
@@ -121,11 +119,8 @@ void llvm_gcda_emit_function(u32 ident,
 {
 	struct gcov_fn_info *info = kzalloc(sizeof(*info), GFP_KERNEL);
 
-	if (!info) {
-		pr_warn_ratelimited("failed to allocate gcov function info for %s\n",
-				function_name ?: "UNKNOWN");
+	if (!info)
 		return;
-	}
 
 	INIT_LIST_HEAD(&info->head);
 	info->ident = ident;
_

