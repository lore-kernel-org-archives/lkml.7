Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CAEC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA485222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AOu3uI7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKMIar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:30:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35226 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfKMIaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jAnuk676gtjIK8QQZry4+QwGiJ4gyCmXYvvmSBfsBUg=; b=AOu3uI7mr7oWt2X6LQdwJAWAd
        3B11NBeqiTta0u5mzmx0CPGDcl2OHNR6SgfeIhqA/7akajgckj2zdDi8byXUU0ms3OrgdSLnpYdWr
        BJku1PkidV8Hk1EW2DM9K7djF/69BXvAr+5jQja7NbeuV5sPGKqxfTVAbZ6C0LdsI2e4Jh6ITf0Sg
        1I2i8WL/ouK0UZuyI21evZQNTxgawrYK0xE/Dm4MhxCm1qKEPqAaMoEddVGTgo7JUZDu6OKLoM6oR
        UDGt0OVE/VbJg2fxxFFR3m4Ppc+RBGN44HkBTEKyN0s1daEprcDXwIwHWL6PvrES5xpHFc2oa3f2L
        ATBijVw3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUo2b-0006X4-Me; Wed, 13 Nov 2019 08:30:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 679BD301120;
        Wed, 13 Nov 2019 09:29:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 812F72026185A; Wed, 13 Nov 2019 09:30:14 +0100 (CET)
Date:   Wed, 13 Nov 2019 09:30:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 09/16] x86/ioperm: Move TSS bitmap update to exit to
 user work
Message-ID: <20191113083014.GD4131@hirez.programming.kicks-ass.net>
References: <20191111220314.519933535@linutronix.de>
 <20191111223052.400498664@linutronix.de>
 <CALCETrU1i4_N8M0o=8hxxPFYisLsxpmDqM-GTsymORp9UeZYSg@mail.gmail.com>
 <alpine.DEB.2.21.1911121811150.1833@nanos.tec.linutronix.de>
 <CALCETrWX7POruLpr27mVoZ-CtVjz35tJBaZz0FNy9_eXfZo_fg@mail.gmail.com>
 <CAHk-=wiPX0xdMGjmZw2yM=aeYArq4V=x=kD7Yr1guMHbaL+Ubg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPX0xdMGjmZw2yM=aeYArq4V=x=kD7Yr1guMHbaL+Ubg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 09:46:30AM -0800, Linus Torvalds wrote:

> I think it's just that the pattern to find "start of new function" is
> confused by the "__visible" or something.
> 
> Don't rely too much on the function names in the diff headers. They
> can be confused by labels, or just by other things. I think it ends up
> being "does the line start with alphabetic character" that is the
> heuristic for "this is a function header".

Right, so I have this in my .gitconfig:

[diff "default"]
	xfuncname = "^[[:alpha:]$_].*[^:]$"

Which works nice for C in that it will no longer accept labels as
funcname, but it stinks for ASM :-)
