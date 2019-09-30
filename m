Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC27C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0B121855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SXGwPHNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfI3Qc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:32:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55464 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfI3Qc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8Ng1o01VoSIGifSBStGW3u8rPP0a8SwwC6yHPSZlmuQ=; b=SXGwPHNrrgfhWNeRE+H80Dh5n
        1ceMe1DoGzwAfcAGEucvLON9TDi75x2VKmikjAtdgMd83yazG6MRLsrO6aBXv11u3OiHp5KiigRlm
        02e195xOrWEUWCpdA586D+K8jnoNfZwyQcs10MMg2zry1KQsM1/rNlKXDWWBSr3kvkZNbl2DS3NNG
        Yi3Vjfpuqg3WPKsFtuDWhQa4ne/y237OU4qzTt/jMabryc9hBuoOHkkkJkuKArfuNFbKMHqhxFl8V
        qDbZlRMmsNA30CEvMf35YhlNfHjA7TIp+QEJQX0zoGXOoEhE7pxe/3mJoG6u3QVsvPkRnsyAibpg1
        8XgbBkhXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEyav-0006JZ-6j; Mon, 30 Sep 2019 16:32:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51F18305ED5;
        Mon, 30 Sep 2019 18:31:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B461265261B4; Mon, 30 Sep 2019 18:32:15 +0200 (CEST)
Date:   Mon, 30 Sep 2019 18:32:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <20190930163215.GH4519@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
 <20190930033706.GD4994@mit.edu>
 <20190930131639.GF4994@mit.edu>
 <CAHk-=wg7YAx_+CDe6fUqApPD_ghP18H9sPnJWWUg32pQ4pU82g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg7YAx_+CDe6fUqApPD_ghP18H9sPnJWWUg32pQ4pU82g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 09:15:55AM -0700, Linus Torvalds wrote:
> On Mon, Sep 30, 2019 at 6:16 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:

> But it _also_ means that if you have a small and excessively stupid
> in-order CPU, I can almost guarantee that you will at least have cache
> misses likely all the way out to memory. So a CPU-only loop like the
> LFSR thing that Thomas reports generates entropy even on its own would
> likely generate nothing at all on a simple in-order core - but I do

In my experience LFSRs are good at defeating branch predictors, which
would make even in-order cores suffer lots of branch misses. And that
might be enough, maybe.

