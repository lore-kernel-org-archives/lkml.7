Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22397C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E232F222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565208246;
	bh=bAnZKDOHa6S/AueqvOn27z8E6ylUixYsDkIKVgnZVKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HCTYREOX3yiIhASIYOEgkuw0TEGsbCZORZM1txIAOXLlHtDccHImdWEgr+TL7Sj/F
	 d/Pg+Dj3zMS6UULLlcgE2qXU0pAQFO7yqI54X8bVC9XoI8LIlYX07MezviaVo5mOee
	 6c/9iJ2fricdXKFAcX4VJEnZRbN2nLDhsSzrCAjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389034AbfHGUEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 16:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfHGUEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:04:04 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A4402229C;
        Wed,  7 Aug 2019 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565208243;
        bh=bAnZKDOHa6S/AueqvOn27z8E6ylUixYsDkIKVgnZVKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YVf9MEhf32W89lIFkjGgA88GCVZUVwxfcFmTKmPUg1Q1y6FDrsnr0QeqCQi2SxSAj
         boCVYX0PmLYKtZPc0GeShN1mYQGBwDMs4u3zZmSSnElYlW9VIKtGrr+WQfA7EMdUZ7
         l8JiW40t7+5cKUXM2gftIZQ0r8IJhj4wMos6tTo0=
Date:   Wed, 7 Aug 2019 13:04:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, joelaf@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking
 using virtual index
Message-Id: <20190807130402.49c9ea8bf144d2f83bfeb353@linux-foundation.org>
In-Reply-To: <20190807171559.182301-1-joel@joelfernandes.org>
References: <20190807171559.182301-1-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Aug 2019 13:15:54 -0400 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> In Android, we are using this for the heap profiler (heapprofd) which
> profiles and pin points code paths which allocates and leaves memory
> idle for long periods of time. This method solves the security issue
> with userspace learning the PFN, and while at it is also shown to yield
> better results than the pagemap lookup, the theory being that the window
> where the address space can change is reduced by eliminating the
> intermediate pagemap look up stage. In virtual address indexing, the
> process's mmap_sem is held for the duration of the access.

So is heapprofd a developer-only thing?  Is heapprofd included in
end-user android loads?  If not then, again, wouldn't it be better to
make the feature Kconfigurable so that Android developers can enable it
during development then disable it for production kernels?

