Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA13C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E5F20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tpYMZ/N5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732826AbfDJOdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:33:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54778 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbfDJOdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dZbaO/fpxzqz5UFKVt9LJSeKtINVKHGV1teOqRpxTBs=; b=tpYMZ/N5r3lKcu+fMIhR0hNb+
        BmFED9xei1YHXXne14nwZbo5PtuJNvzwafO/uM6xyvQh2Jqezor3u+5/7KX7FDAjb/LPU2oTb5ZUq
        oTn0NdZepBveIRGx1ui3GGh1H0cWX2aLHehIdK3cm5UYvGvx4XeiK90T4jQjwkwnnmfvHXwvSKUfp
        bLRyKWU85vxF2hXTbIDuCv6D8vsTaEbsaBZSK8wUWHBfIX9VkbVfRM8pBpOzheUUGR+1BeiJQOyph
        S3qvVJG5BqMdQDDzgcTKnWNq+kwMac1g9aSHGDfm8mJyCXjVcLoihZuf7N+a0EbPB7kPtAqnoyc39
        iD+WVKNtg==;
Received: from [89.200.33.100] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEEIC-0000aC-L1; Wed, 10 Apr 2019 14:33:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51709984F05; Wed, 10 Apr 2019 16:33:48 +0200 (CEST)
Date:   Wed, 10 Apr 2019 16:33:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>, acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>, jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
Message-ID: <20190410143348.GG2490@worktop.programming.kicks-ass.net>
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
 <20190403104103.GE4038@hirez.programming.kicks-ass.net>
 <eb3cbf9b-6851-72c6-2648-3e6eaa78fb7d@linux.ibm.com>
 <20190404110909.GY4038@hirez.programming.kicks-ass.net>
 <20190404130300.GF14281@hirez.programming.kicks-ass.net>
 <adcbac67-82b5-98a4-efb4-61c9ed870c15@linux.ibm.com>
 <20190408082229.GI4038@hirez.programming.kicks-ass.net>
 <20190408095031.GG14281@hirez.programming.kicks-ass.net>
 <20190409085327.GA21979@lakrids.cambridge.arm.com>
 <a24a2dca-72f3-ff56-5004-97c6ce86f6af@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24a2dca-72f3-ff56-5004-97c6ce86f6af@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 03:51:24PM +0200, Thomas-Mich Richter wrote:
> Thanks for the fix with commit id 86071b11317550d994b55ce5e31aa06bcad783b5.
> 
> However doing an fgrep on the pending_disable member of struct perf_event
> reveals two more hits in file kernel/events/ringbuffer.c when events
> have auxiliary data.
> 
> Not sure if this needs to be addresses too, just wanted to let you know.

*groan* indeed, and yes that would need fixing too. I completely missed
the AUX stuff using that too.

I think we can simply do the below on top, Alexander?

---
 kernel/events/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 678ccec60d8f..ab2b7b38adc5 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -392,7 +392,7 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 		 * store that will be enabled on successful return
 		 */
 		if (!handle->size) { /* A, matches D */
-			event->pending_disable = 1;
+			event->pending_disable = smp_processor_id();
 			perf_output_wakeup(handle);
 			local_set(&rb->aux_nest, 0);
 			goto err_put;
@@ -480,7 +480,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)

 	if (wakeup) {
 		if (handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)
-			handle->event->pending_disable = 1;
+			handle->event->pending_disable = smp_processor_id();
 		perf_output_wakeup(handle);
 	}


