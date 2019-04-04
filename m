Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DF7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003D5206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371866;
	bh=nruYE71tMKdBSwTmSMpR5FkoGU0hAg+y1YyI6b2VNlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sE7bnsEnrJwI25lzmWX3qzOSdfTPSC4DVEUSiHF14JSJGUhdgR/1BP1f66EPXMnrC
	 vePeP09g6kjxvREuiYWtJows1qTwiwZZs1IeHD9xH61ZdwW9L4mkb1cdOpC9zSLsNX
	 XcuGL1AhhirJozh3Bn28VkSairqzIrFILzcDnJcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfDDJ5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728777AbfDDIty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:49:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 649E221734;
        Thu,  4 Apr 2019 08:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367793;
        bh=nruYE71tMKdBSwTmSMpR5FkoGU0hAg+y1YyI6b2VNlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtF8GTrQ0nblvwsCyQNCYOUCyp4pO2knAj563SnbbzQNGHeSwrol/HObJ26gHhW0J
         0pwaWXU/Ee2pVGeNmtKZQg5Wigwa3ICU6Y6MfFX7imbHcXzcnkBzOMc4KM88rNz6Ta
         Ql0NnMBXYcFZeF4B9XHM8WQfyqJdwDtpYjPAF5fI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joe Perches <joe@perches.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshul Garg <aksgarg1989@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Miller <davem@davemloft.net>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Michael Davidson <md@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.9 04/91] lib/int_sqrt: optimize initial value compute
Date:   Thu,  4 Apr 2019 10:46:48 +0200
Message-Id: <20190404084535.672303864@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit f8ae107eef209bff29a5816bc1aad40d5cd69a80 upstream.

The initial value (@m) compute is:

	m = 1UL << (BITS_PER_LONG - 2);
	while (m > x)
		m >>= 2;

Which is a linear search for the highest even bit smaller or equal to @x
We can implement this using a binary search using __fls() (or better when
its hardware implemented).

	m = 1UL << (__fls(x) & ~1UL);

Especially for small values of @x; which are the more common arguments
when doing a CDF on idle times; the linear search is near to worst case,
while the binary search of __fls() is a constant 6 (or 5 on 32bit)
branches.

      cycles:                 branches:              branch-misses:

PRE:

hot:   43.633557 +- 0.034373  45.333132 +- 0.002277  0.023529 +- 0.000681
cold: 207.438411 +- 0.125840  45.333132 +- 0.002277  6.976486 +- 0.004219

SOFTWARE FLS:

hot:   29.576176 +- 0.028850  26.666730 +- 0.004511  0.019463 +- 0.000663
cold: 165.947136 +- 0.188406  26.666746 +- 0.004511  6.133897 +- 0.004386

HARDWARE FLS:

hot:   24.720922 +- 0.025161  20.666784 +- 0.004509  0.020836 +- 0.000677
cold: 132.777197 +- 0.127471  20.666776 +- 0.004509  5.080285 +- 0.003874

Averages computed over all values <128k using a LFSR to generate order.
Cold numbers have a LFSR based branch trace buffer 'confuser' ran between
each int_sqrt() invocation.

Link: http://lkml.kernel.org/r/20171020164644.936577234@infradead.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Suggested-by: Joe Perches <joe@perches.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anshul Garg <aksgarg1989@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: David Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Michael Davidson <md@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/int_sqrt.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -7,6 +7,7 @@
 
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/bitops.h>
 
 /**
  * int_sqrt - rough approximation to sqrt
@@ -21,10 +22,7 @@ unsigned long int_sqrt(unsigned long x)
 	if (x <= 1)
 		return x;
 
-	m = 1UL << (BITS_PER_LONG - 2);
-	while (m > x)
-		m >>= 2;
-
+	m = 1UL << (__fls(x) & ~1UL);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;


