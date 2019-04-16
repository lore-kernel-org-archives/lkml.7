Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06406C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71C1206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k01rTGBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfDPQHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:07:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47736 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfDPQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=38wQZpp5j2p6NeqrhoHkJr20siK/EXZ0n+4wf1Pq+0g=; b=k01rTGBsT5y4BZtcj92Fdy/gS
        eG2WwVGp/ubkPjhEGtYB+8I14fnNsQ1mtAR6vfLw1A3KUNFad6z/YCP7TcuJtFHt4I+qWG1Vd2PjY
        OkDIOg8+p7fhyYMld0w+RQ1lnwCw15dmEsR6g0gV7oCe9bftxRNJDEVngsd0Ht2ZlIdBjuGoQDM4+
        TdnVjtWNTI7NLoW4qfSqIGRswPcDIgVNTDqwo8TpXd4Tvkpok6muLpCBDuCoVDnbnH35j6HbmJoQ/
        d4vCLvDiNjSy6G2BIYAOJls/Gurt3iDvbvhI/ekAQxZ7e1Symb57NliJxOJJ/YuQqYQW9qKBqzikt
        SywTZod5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGQcA-000413-QE; Tue, 16 Apr 2019 16:07:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86FC929AC1638; Tue, 16 Apr 2019 18:07:17 +0200 (CEST)
Date:   Tue, 16 Apr 2019 18:07:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.COM>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <20190416160717.GP4038@hirez.programming.kicks-ass.net>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
 <20190416073444.GC127769@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net>
 <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416154348.GB3004@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:43:49AM -0400, Theodore Ts'o wrote:
> If it's x86 specific, maybe the simplest thing to do is to use RDRAND
> if it exists, and fall back to something involving a TSC and maybe
> prandom_u32 (assuming on how bad you think the stack leak is going to
> be) if RDRAND isn't available?

From https://lkml.kernel.org/r/20190320072715.3857-1-elena.reshetova@intel.com

Performance:

1) lmbench: ./lat_syscall -N 1000000 null
   base:                     Simple syscall: 0.1774 microseconds
   random_offset (rdtsc):     Simple syscall: 0.1803 microseconds
   random_offset (rdrand): Simple syscall: 0.3702 microseconds

2) Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
   base:                     10000000 loops in 1.62224s = 162.22 nsec / loop
   random_offset (rdtsc):     10000000 loops in 1.64660s = 164.66 nsec / loop
   random_offset (rdrand): 10000000 loops in 3.51315s = 351.32 nsec / loop


Basically, RDRAND is frigging slow...
