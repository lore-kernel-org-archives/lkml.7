Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8B7C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5852080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QOy5xYDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfD3Jj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:39:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34616 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfD3Jj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R59xQNltNlo+UQspZjbwof7CktqW9+HwkEeV2CRgeuU=; b=QOy5xYDiWYSE3dg+lHcIEahnZ
        yso18XfZ2dJ+dYjUgeLSEj/9WsOa+WoKe+RQdMwsrNPXH3R6Xhq0TaOucgTPKijsid30226nZatGl
        pM3K0mFG5EGNvuvf/5r6+NLizmdw3kivj/5U+4ZRLWYOJgEP3ALrMYw5K99gEmJ7gNJo9VuqYPW7K
        +nik/sRvL/cofQIX6Qa6NnSG3Yk5PliBKEizrH5pibNe0KF0fxrUm9ipNL4VRP2k5HxSPYfaopNvG
        tZukHvNBTQgyf0/bTcSppTp6YdqDpsTc1X0cEt2RvMSGu1O4Q31Pj4PEoJRHsclvVgq/wI5oYG1A3
        N5wdO5xFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLPE4-0007rz-Ir; Tue, 30 Apr 2019 09:39:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7510F29ACFA27; Tue, 30 Apr 2019 11:38:57 +0200 (CEST)
Date:   Tue, 30 Apr 2019 11:38:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call
 isolation
Message-ID: <20190430093857.GO2623@hirez.programming.kicks-ass.net>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
 <20190426083144.GA126896@gmail.com>
 <20190426095802.GA35515@gmail.com>
 <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
 <20190427084752.GA99668@gmail.com>
 <20190427104615.GA55518@gmail.com>
 <CALCETrUn_86VAd8FGacJ169xcWE6XQngAMMhvgd1Aa6ZxhGhtA@mail.gmail.com>
 <20190430050336.GA92357@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430050336.GA92357@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 07:03:37AM +0200, Ingo Molnar wrote:
> So the question IMHO isn't whether it's "valid C", because we already 
> have the Linux kernel's own C syntax variant and are enforcing it with 
> varying degrees of success.

I'm not getting into the whole 'safe' fight here; but you're under
selling things. We don't have a C syntax, we have a full blown C
lanugeage variant.

The 'Kernel C' that we write is very much not 'ANSI/ISO C' anymore in a
fair number of places. And if I can get my way, we'll only diverge
further from the standard.

And this is quite separate from us using every GCC extention under the
sun; which of course also doesn't help. It mostly has to do with us
treating C as a portable assembler and the C people not wanting to
commit to sensible things because they think C is a high-level language.
