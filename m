Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D4EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96C020836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T2kyS6Rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLKWj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:39:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKWj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hhGHBxcN43IzIZcb+CPl3PQzuvRfyJsA7P+/PVFssoI=; b=T2kyS6Rn6kLsU2TrpCokseTQT
        qNw1N9Df7ZCeCaJ6++9JjmWisu2H2gagowjD2t9gowhyNhYvq6h5/0zF7zlhB60hQE+z4LF4cmVnQ
        kqPKWlJ9YI3gFh6XTVvfsQpHuvQ1Wvgjz/BGp1+3Ei0BAmieucZdcogG+KeH9Y4+YiOpXDLReU9cx
        FTAJq0ohkXE8JM4QjCudjdnZb3I0F1MrKUiGSMvOZun7q9mKTZ4YDoI8MXPLtp1B9mNpi3CrN9s7V
        J3y0MHo5mFkwrko+a0uTLx1DaFc2MMJTOKzHgrk7Rt8vb09+EeLmb+X7fsemPOqB0FWClxiMlxknn
        JDV2BO1Cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifAdb-0004dT-Rl; Wed, 11 Dec 2019 22:39:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 944743058B4;
        Wed, 11 Dec 2019 23:37:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AAA6720120E46; Wed, 11 Dec 2019 23:39:17 +0100 (CET)
Date:   Wed, 11 Dec 2019 23:39:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191211223917.GU2844@hirez.programming.kicks-ass.net>
References: <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com>
 <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
 <20191122203105.GE2844@hirez.programming.kicks-ass.net>
 <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
 <20191211175202.GQ2827@hirez.programming.kicks-ass.net>
 <20191211184416.GA6344@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211184416.GA6344@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:44:16AM -0800, Luck, Tony wrote:
> On Wed, Dec 11, 2019 at 06:52:02PM +0100, Peter Zijlstra wrote:
> > Sure, but we're talking two cpus here.
> > 
> > 	u32 var = 0;
> > 	u8 *ptr = &var;
> > 
> > 	CPU0			CPU1
> > 
> > 				xchg(ptr, 1)
> > 
> > 	xchg((ptr+1, 1);
> > 	r = READ_ONCE(var);
> 
> It looks like our current implementation of set_bit() would already run
> into this if some call sites for a particular bitmap `pass in constant
> bit positions (which get optimized to byte wide "orb") while others pass
> in a variable bit (which execute as 64-bit "bts").

Yes, but luckily most nobody cares.

I only know of two places in the entire kernel where we considered this,
one is clear_bit_unlock_is_negative_byte() and there we punted and
stuffed everything in a single byte, and the other is that x86
queued_fetch_set_pending_acquire() thing I pointed out earlier.

> I'm not a h/w architect ... but I've assumed that a LOCK operation
> on something contained entirely within a cache line gets its atomicity
> by keeping exclusive ownership of the cache line.

Right, but like I just wrote to Andy, consider SMT where each thread has
its own store-buffer. Then the line is local to the core, but there
still is a remote sb to hide stores in.

I don't know if anything x86 does that, or even allows that, but I'm not
aware of specs that are clear enough to say either way.
