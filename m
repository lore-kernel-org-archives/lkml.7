Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5885C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7E6206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a/E0I485"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKURfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:35:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57568 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKURfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kT85EYnF8HVqmBD+sD5mv1wk+c/n8OFhrGY8G/TqmhQ=; b=a/E0I485O72yRrViXyHzOa+hv
        cxyZeqYZeEtuT7frD0Pg5pbmQFf3f3CIuEIastTdK8rsT0R9c4KqotVfWEEXktP77e6rzAuHooZFp
        NawuZyC2S+FONuBVSJeFI/68eo06B+qvo1nOImUSQIIcNvGUYwO9KdapqwCa47LtoXMN0KG8yxBhN
        0hRNoiPAeYLXFMIYoKoqeiw7RZJMvgRAKNveTaKNef3+yHmDxgnvpUymmXjNkg90YI0nSit929jYP
        YJQGn56Rx1jIwLVa+IlZQFxigKyXQ2nAeq691rML8mB+W6YkOjNjWK4eMwJdU7sROLL/hfHbWGnEq
        Ly2liGlcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXqMC-0006KW-AC; Thu, 21 Nov 2019 17:35:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 786B13056C8;
        Thu, 21 Nov 2019 18:33:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 414EC2021C978; Thu, 21 Nov 2019 18:35:01 +0100 (CET)
Date:   Thu, 21 Nov 2019 18:35:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121173501.GT4097@hirez.programming.kicks-ass.net>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121161410.GA199273@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121161410.GA199273@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 08:14:10AM -0800, Fenghua Yu wrote:

> The usage scope of this patch set is largely reduced to only real time.
> The long split lock processing time (>1000 cycles) cannot be tolerated
> by real time.

I'm thinking you're clueless on realtime. There's plenty of things that
can cause many cycles to go out the window. And just a single
instruction soaking up cycles like that really isn't the problem.

The problem is that split lock defeats isolation. An otherwise contained
task can have pretty horrific side effects on other tasks.

> Real time customers do want to use this feature to detect the fatal
> split lock error. They don't want any split lock issue from BIOS/EFI/
> firmware/kerne/drivers/user apps.

Cloud vendors also don't want them. Nobody wants them, they stink. They
have a system wide impact.

I don't want them on my system.

> > Imagine the BIOS/EFI/firmware containing an #AC exception. At that point
> > the feature becomes useless, because you cannot enable it without your
> > machine dying.
> 
> I believe Intel real time team guarantees to deliever a split lock FREE
> BIOS/EFI/firmware to their real time users.

Not good enough. Any system shipping with this capability needs to have
a split lock free firmware blob. And the only way to make that happen is
to force enable it by default.

> From kernel point of view, we are working on a split lock free kernel.
> Some blocking split lock issues have been fixed in TIP tree.

Haven't we fixed them all by now?

> Only limited user apps can run on real time and should be split lock
> free before they are allowed to run on the real time system.

I'm thinking most of the normal Linux userspace will run just fine.
Seeing how other architectures have rejected such nonsense forever.

> In summary, the patch set only wants to enable the feature for real time
> and disable it by default.

We told you that wasn't good enough many times. Lot's of people run the
preemp-rt kernel on lots of different hardware. And like I said, even
cloudy folks would want this.

Features that require special firmware that nobody has are useless.

For giggles, run the below. You can notice your desktop getting slower.

---
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

void main(void)
{
	void *addr = mmap(NULL, 4096*2, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	unsigned int *var;
	if (addr == (void*)-1) {
		printf("fail\n");
		return;
	}

	var = addr + 4096 - 2;

	for (;;)
		asm volatile ("lock incl %0" : : "m" (*var));
}
