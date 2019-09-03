Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5556AC3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5F320870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0+3XwuE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfICOGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:06:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52686 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICOGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tW7Nkc6OzeenJ5t90aISNMAX0ToDybVNohTWVX2i9+g=; b=0+3XwuE5ycxa+akInZ8/eLOrW
        C1xKxEw1NhPAOzGzBwInUN6l7UgvqnBv5fQ11FQ66xHp1/ShCQUS6jm7iL2ir1TZVVMQGZJMeoM0B
        Z3M/lAvaNfabp9HqAsTI5GdQAiIQAkbmTHZEGWB5EEPwItFNvP84tVxB8976uo1L9blqWEeJD7qvP
        7DfgpzNvvEs/67tCHjEMGZldDejQvYRrnYEITVWGFxoyiaTz9k0dWUMDtsV7FX0kE2ewC4d0fx3PY
        dkaTVyh8eA4UWVyraDN2K6T8YhBh7zkMDVn5wfbMyNwavxGgtzc9hMeyngJnprXSL6M0hzR9B8ldX
        xNVGxXcKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i59Rp-0007Ht-VC; Tue, 03 Sep 2019 14:06:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 77D933011DF;
        Tue,  3 Sep 2019 16:05:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 606D92097776C; Tue,  3 Sep 2019 16:06:14 +0200 (CEST)
Date:   Tue, 3 Sep 2019 16:06:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     linux-kernel@vger.kernel.org, "He, Min" <min.he@intel.com>,
        "Zhao, Yakui" <yakui.zhao@intel.com>
Subject: Re: About compiler memory barrier for atomic_set/atomic_read on x86
Message-ID: <20190903140614.GR2349@hirez.programming.kicks-ass.net>
References: <256e8ee2-a23c-28e9-3988-8b77307c001a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <256e8ee2-a23c-28e9-3988-8b77307c001a@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:23:41PM +0800, Yin, Fengwei wrote:
> Hi Peter,
> There is one question regarding following commit:
> 
> commit 69d927bba39517d0980462efc051875b7f4db185
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Wed Apr 24 13:38:23 2019 +0200
> 
>     x86/atomic: Fix smp_mb__{before,after}_atomic()
> 
>     Recent probing at the Linux Kernel Memory Model uncovered a
>     'surprise'. Strongly ordered architectures where the atomic RmW
>     primitive implies full memory ordering and
>     smp_mb__{before,after}_atomic() are a simple barrier() (such as x86)
> 
> This change made atomic RmW operations include compiler barrier. And made
> __smp_mb__before_atomic/__smp_mb__after_atomic not include compiler
> barrier any more for x86.
> 
> We face the issue to handle atomic_set/atomic_read which is mapped to
> WRITE_ONCE/READ_ONCE on x86. These two functions don't include compiler
> barrier actually (if operator size is less than 8 bytes).
> 
> Before the commit 69d927bba39517d0980462efc051875b7f4db185, we could use
> __smp_mb__before_atomic/__smp_mb__after_atomic together with these two
> functions to make sure the memory order. It can't work after the commit
> 69d927bba39517d0980462efc051875b7f4db185. I am wandering whether
> we should make atomic_set/atomic_read also include compiler memory
> barrier on x86? Thanks.

No; using smp_mb__{before,after}_atomic() with atomic_{set,read}() is
_wrong_! And it is documented as such; see Documentation/atomic_t.txt.
