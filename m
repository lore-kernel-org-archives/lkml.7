Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42D82075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TPu+6is+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKKIxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:53:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKKIxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N9yhyIJ9ppWghYxR0HXE/KQvRvlgAR3LYacZS7ui4M4=; b=TPu+6is+yp1w9ltws+Vu0qHp9
        Q2LWllgQNZMR5+cShZlGGJmmvZEjVJlBtMwBioKVsK3mutdy16PoHAWakN1ywDHFJxdI9jfKG9+eg
        gqgJB/Iyv+i4YOgXBpkruxLrLp0fAxVgZ1KExRvA13fH1OktOYePL/XLooy7+jGzy/MAbODerfVaS
        8jLIoDDhq4TF28+/tGCrkfANVpXwsOnyW4tls4yXdL6Wv5OgeqNYzp7AD7+i4bPZPoj4l2ftUrcdo
        Al13oOA6MjDBy7UIXN8hApkYWHrQrAxNP7Go4PpHJpdefIjhdKEPMUaOVM3tz1BOCuojB5JViFaxC
        2phBRmeXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iU5RG-00059i-Lt; Mon, 11 Nov 2019 08:52:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 092B73056BE;
        Mon, 11 Nov 2019 09:51:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 369092026E904; Mon, 11 Nov 2019 09:52:44 +0100 (CET)
Date:   Mon, 11 Nov 2019 09:52:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 2/9] x86/process: Unify copy_thread_tls()
Message-ID: <20191111085244.GP4131@hirez.programming.kicks-ass.net>
References: <20191106193459.581614484@linutronix.de>
 <20191106202805.948064985@linutronix.de>
 <53a6f346-fca1-ac04-ee34-6d472a0d4408@kernel.org>
 <alpine.DEB.2.21.1911090040520.2605@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911101332490.12583@nanos.tec.linutronix.de>
 <CALCETrXqP2SfhM83diqS9xr+Zso8rhsfmF8G-DQBBHAY3UU0dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXqP2SfhM83diqS9xr+Zso8rhsfmF8G-DQBBHAY3UU0dw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 08:56:50AM -0800, Andy Lutomirski wrote:
> On Sun, Nov 10, 2019 at 4:36 AM Thomas Gleixner <tglx@linutronix.de> wrote:

> > 64bit does not have flags in the inactive_task_frame ...
> >
> 
> Hmm.  One more thing to unify, I guess.

All that takes is porting objtool to 32bit.

See commit: 64604d54d311 ("sched/x86_64: Don't save flags on context switch")

