Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B1FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF19920718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tmQkQ9J5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfKVKv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:51:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbfKVKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+LEvCZkUnHSn1ZAatYIRXWWTq0G8KGnsYQbP9mJBms4=; b=tmQkQ9J52n1dHJKLZorJDboDu
        omRcgyQd4d/LXMNsFUgrHg+rkujOQV01/zVPCgA7k2yQMrq6Ks8LNVkmAEARLARytP4luV6lipzrr
        Zb/rLvt1pYNj6KslApl/Af0WOrBNMwalSKZwzT0hcmJJ9hap1n8CXKTJ1m0qFQnZBAgH934B26xyG
        teXguRPp/Rbnc2Op4xCTePsgmPRwYcORETAyIU5aeo+pHNds3lzbovx3eMigWXwO+q85FnvLXeOPe
        vQUN4JWEn/h1DsNEYFe1zX9T3Rhx5DzxzgIm5CNdndjqie6dGrchca7ZeDjXM2Fp1P5bveKIhI0+M
        5pO0u2a6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iY6XP-0005jK-V3; Fri, 22 Nov 2019 10:51:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1701D3075DD;
        Fri, 22 Nov 2019 11:50:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A3A2202BC5A1; Fri, 22 Nov 2019 11:51:41 +0100 (CET)
Date:   Fri, 22 Nov 2019 11:51:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191122105141.GY4114@hirez.programming.kicks-ass.net>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:34:44AM -0800, Luck, Tony wrote:

> You'll notice that we are at version 10 ... lots of things have been tried
> in previous versions. This new version is to get the core functionality
> in, so we can build fancier features later.

The cover letter actually mentions that as a non-goal. Seems like a
conflicting message here.

> Enabling by default at this point would result in a flurry of complaints
> about applications being killed and kernels panicing. That would be
> followed by:

I thought we already found and fixed all the few kernel users that got
it wrong?

And applications? I've desktop'ed around a little with:

  perf stat -e sq_misc.split_lock -a -I 1000

running and that shows exactly, a grant total of, _ZERO_ split lock
usage. Except when I run my explicit split lock proglet, then it goes
through the roof.

So I really don't buy that argument. Like I've been saying forever, sane
architectures have never allowed unaligned atomics in the first place,
this means that sane software won't have any.

Furthermore, split_lock has been a performance issue on x86 for a long
long time, which is another reason why x86-specific software will not
have them.

And if you really really worry, just do a mode that pr_warn()s about the
userspace instead of SIGBUS.

> #include <linus/all-caps-rant-about-backwards-compatability.h>
>
> and the patches being reverted.

I don't buy that either, it would _maybe_ mean flipping the default. But
that very much depends on how many users and what sort of 'quality'
software they're running.

I suspect we can get away with a no_split_lock_detect boot flag. We've
had various such kernel flags in the past for new/dodgy features and
we've lived through that just fine.

Witness: no5lvl, noapic, noclflush noefi, nofxsr, etc..

> This version can serve a very useful purpose. CI systems with h/w that
> supports split lock can enable it and begin the process of finding
> and fixing the remaining kernel issues. Especially helpful if they run
> randconfig and fuzzers.

A non-lethal default enabled variant would be even better for them :-)

> We'd also find out which libraries and applications currently use
> split locks.

On my debian desktop, absolutely nothing I've used in the past hour or
so. That includes both major browsers and some A/V stuff, as well as
building a kernel and writing emails.

> Any developer with concerns about their BIOS using split locks can also
> enable using this patch and begin testing today.

I don't worry about developers much; they can't fix their BIOS other
than to return the box and try and get their money back :/

