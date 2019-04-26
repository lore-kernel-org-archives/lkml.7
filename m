Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F02C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33F420B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IZKVMNXo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IZKVMNXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfDZStb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:49:31 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54820 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbfDZSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:49:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 962A48EE121;
        Fri, 26 Apr 2019 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556304569;
        bh=sOaeFRWJRQo0N2mv0s8k3sDJjYmty9DwZwOp2JV9H2U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IZKVMNXorn56CMx465Owkt0livTWuNAyyC6sg/IgxKPJ2uU/M9GS34oRiRVUkvbkj
         1scd/Qe3vrlgnzd5OzA1+Mx+dDTo51s7SbfKM9bmye6UKGnYSY1KCBR6DZw+sxWIPb
         xMa55mbet2KlO/Rtxu4//+BYpty1QBoW0y+fH6Q4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tVyy7i8XvLsR; Fri, 26 Apr 2019 11:49:29 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 55FF68EE079;
        Fri, 26 Apr 2019 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556304569;
        bh=sOaeFRWJRQo0N2mv0s8k3sDJjYmty9DwZwOp2JV9H2U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IZKVMNXorn56CMx465Owkt0livTWuNAyyC6sg/IgxKPJ2uU/M9GS34oRiRVUkvbkj
         1scd/Qe3vrlgnzd5OzA1+Mx+dDTo51s7SbfKM9bmye6UKGnYSY1KCBR6DZw+sxWIPb
         xMa55mbet2KlO/Rtxu4//+BYpty1QBoW0y+fH6Q4=
Message-ID: <1556304567.2833.62.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system
 call isolation
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Date:   Fri, 26 Apr 2019 11:49:27 -0700
In-Reply-To: <8E695557-1CD2-431A-99CC-49A4E8247BAE@amacapital.net>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
         <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
         <627d9321-466f-c4ed-c658-6b8567648dc6@intel.com>
         <1556290658.2833.28.camel@HansenPartnership.com>
         <54090243-E4C7-4C66-8025-AFE0DF5DF337@amacapital.net>
         <1556291961.2833.42.camel@HansenPartnership.com>
         <8E695557-1CD2-431A-99CC-49A4E8247BAE@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 10:40 -0700, Andy Lutomirski wrote:
> > On Apr 26, 2019, at 8:19 AM, James Bottomley <James.Bottomley@hanse
> > npartnership.com> wrote:
> > 
> > On Fri, 2019-04-26 at 08:07 -0700, Andy Lutomirski wrote:
> > > > On Apr 26, 2019, at 7:57 AM, James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > 
> > > > > > On Fri, 2019-04-26 at 07:46 -0700, Dave Hansen wrote:
> > > > > > On 4/25/19 2:45 PM, Mike Rapoport wrote:
> > > > > > After the isolated system call finishes, the mappings
> > > > > > created during its execution are cleared.
> > > > > 
> > > > > Yikes.  I guess that stops someone from calling write() a
> > > > > bunch of times on every filesystem using every block device
> > > > > driver and all the DM code to get a lot of code/data faulted
> > > > > in.  But, it also means not even long-running processes will
> > > > > ever have a chance of behaving anything close to normally.
> > > > > 
> > > > > Is this something you think can be rectified or is there
> > > > > something fundamental that would keep SCI page tables from
> > > > > being cached across different invocations of the same
> > > > > syscall?
> > > > 
> > > > There is some work being done to look at pre-populating the
> > > > isolated address space with the expected execution footprint of
> > > > the system call, yes.  It lessens the ROP gadget protection
> > > > slightly because you might find a gadget in the pre-populated
> > > > code, but it solves a lot of the overhead problem.
> > > 
> > > I’m not even remotely a ROP expert, but: what stops a ROP payload
> > > from using all the “fault-in” gadgets that exist — any function
> > > that can return on an error without doing to much will fault in
> > > the whole page containing the function.
> > 
> > The address space pre-population is still per syscall, so you don't
> > get access to the code footprint of a different syscall.  So the
> > isolated address space is created anew for every system call, it's
> > just pre-populated with that system call's expected footprint.
> 
> That’s not what I mean. Suppose I want to use a ROP gadget in
> vmalloc(), but vmalloc isn’t in the page tables. Then first push
> vmalloc itself into the stack. As long as RDI contains a sufficiently
> ridiculous value, it should just return without doing anything. And
> it can return right back into the ROP gadget, which is now available.

Yes, it's not perfect, but stack space for a smashing attack is at a
premium and now you need two stack frames for every gadget you chain
instead of one so we've halved your ability to chain gadgets.

> > > To improve this, we would want some thing that would try to check
> > > whether the caller is actually supposed to call the callee, which
> > > is more or less the hard part of CFI.  So can’t we just do CFI
> > > and call it a day?
> > 
> > By CFI you mean control flow integrity?  In theory I believe so,
> > yes, but in practice doesn't it require a lot of semantic object
> > information which is easy to get from higher level languages like
> > java but a bit more difficult for plain C.
> 
> Yes. As I understand it, grsecurity instruments gcc to create some
> kind of hash of all function signatures. Then any indirect call can
> effectively verify that it’s calling a function of the right type.
> And every return verified a cookie.
> 
> On CET CPUs, RET gets checked directly, and I don’t see the benefit
> of SCI.

Presumably you know something I don't but I thought CET CPUs had been
planned for release for ages, but not actually released yet?

> > > On top of that, a robust, maintainable implementation of this
> > > thing seems very complicated — for example, what happens if
> > > vfree() gets called?
> > 
> > Address space Local vs global object tracking is another thing on
> > our list.  What we'd probably do is verify the global object was
> > allowed to be freed and then hand it off safely to the main kernel
> > address space.
> 
> This seems exceedingly complicated.

It's a research project: we're exploring what's possible so we can
choose the techniques that give the best security improvement for the
additional overhead.

James

