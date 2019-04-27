Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CA8C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1612087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556361983;
	bh=OqdY/Pfh7FQNnzidebfJ54kG3VLTvi9f3CcjSYFqtGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=munji0LHTJESVXBiOHru2fMLFJRWwRQ3rCrEHX1pTS7XrBIaLYCz32nwhp2iC0FDh
	 BrbVMOqdd19zxPSeh2bsQgDgQnSlGnyS0LdrA4XOJdaBT+yromlHIpdXyVvSpYwUJ1
	 ijVuwalMsLZtAXltDhdhj34w8l9KLKbrSWDrNhh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfD0KqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:46:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39158 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfD0KqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:46:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id a9so8067890wrp.6;
        Sat, 27 Apr 2019 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xPSO7oJ3TTHplWc4133d26O3LVrGQFrQK7ot/N5WKb8=;
        b=iHWAeykZHCFDxFy3680Aunv30P6sD1QDGJ2K2UX7UeCJZs4+FMT5RWJb7Hog4/R5r9
         dm464UwSg9xMQ+y/Z5uVB2BGznF0SE9F8Kg3VXIWarHzUo2Zv1Wvbj/ZAtT1g6jIh9b7
         y/3PLs3P3keba5yFj4miN1eRmesniXQJIk4eHjBfjfQoYfFitAejpaMGYBnli3jGX1lc
         6U94wTq2CKBAYQ2kqNH2xUHuguqjvm5FdcCaujFsNqEHr1Y6JHrRclOlTD4kgUR+ogfH
         UKNk7HQQDKIYlryRPWZXYC93srNNuZYpAYiUqhrBOsdQ05mCl/nJZnj/D+45V25B6rVL
         o/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xPSO7oJ3TTHplWc4133d26O3LVrGQFrQK7ot/N5WKb8=;
        b=qfxgOT/qkWBGkV+HNbuXqB0HymfiNgSti1XoxamAuWue5CSF7heLV2qbNHhy1QJwzk
         3g80rqPS8ycSJIFSpHTg1y+YZmJV/fcTKMKbG0vZf1cpBxfE9EJ5Q+JT7xEErtzuHgEf
         WUun5AZEsLb/c/d0Rcozxxvorp+04CBwtkR1RzIvCFjugRZjF1/S+VaBzleMXfDblRpr
         G796wDK3NmbQ8EymaKsXUpQtOr9pt4drDoTrMDiukVhifVBUTi85Hbe5txs+lqRhSWn5
         YXjOR0PRRTKjc8+H3VH4r8fDnd9jmMI4Gpd9YbnEWpkcaKR1tsbSnDUmFnl8ZLSUJPcJ
         JKsg==
X-Gm-Message-State: APjAAAXZHXTAlyJjxTSbRdvHbSNy7YkKro0Dp76o/KgfVIRmIV2Ljmsf
        kDdjdKYQRQUmSlx/G4+1Rjw=
X-Google-Smtp-Source: APXvYqxY/dnkrLpW/gF+xVDmMuF7QvDiCj7GAGdhfgtGKCgk/7ONprlc+TDqzgFDBPe+eG8Nb+V+zw==
X-Received: by 2002:a5d:6b46:: with SMTP id x6mr32608036wrw.313.1556361978927;
        Sat, 27 Apr 2019 03:46:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x14sm9639485wmi.32.2019.04.27.03.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 03:46:18 -0700 (PDT)
Date:   Sat, 27 Apr 2019 12:46:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call
 isolation
Message-ID: <20190427104615.GA55518@gmail.com>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
 <20190426083144.GA126896@gmail.com>
 <20190426095802.GA35515@gmail.com>
 <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
 <20190427084752.GA99668@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190427084752.GA99668@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> * Andy Lutomirski <luto@kernel.org> wrote:
> 
> > > And no, I'm not arguing for Java or C#, but I am arguing for a saner
> > > version of C.
> > 
> > IMO three are three credible choices:
> > 
> > 1. C with fairly strong CFI protection. Grsecurity has this (supposedly 
> > — there’s a distinct lack of source code available), and clang is 
> > gradually working on it.
> > 
> > 2. A safe language for parts of the kernel, e.g. drivers and maybe 
> > eventually filesystems.  Rust is probably the only credible candidate. 
> > Actually creating a decent Rust wrapper around the core kernel 
> > facilities would be quite a bit of work.  Things like sysfs would be 
> > interesting in Rust, since AFAIK few or even no drivers actually get 
> > the locking fully correct.  This means that naive users of the API 
> > cannot port directly to safe Rust, because all the races won't compile
> > :)
> > 
> > 3. A sandbox for parts of the kernel, e.g. drivers.  The obvious 
> > candidates are eBPF and WASM.
> > 
> > #2 will give very good performance.  #3 gives potentially stronger
> > protection against a sandboxed component corrupting the kernel overall, 
> > but it gives much weaker protection against a sandboxed component 
> > corrupting itself.
> > 
> > In an ideal world, we could do #2 *and* #3.  Drivers could, for 
> > example, be written in a language like Rust, compiled to WASM, and run 
> > in the kernel.
> 
> So why not go for #1, which would still outperform #2/#3, right? Do we 
> know what it would take, roughly, and how the runtime overhead looks 
> like?

BTW., CFI protection is in essence a compiler (or hardware) technique to 
detect stack frame or function pointer corruption after the fact.

So I'm wondering whether there's a 4th choice as well, which avoids 
control flow corruption *before* it happens:

 - A C language runtime that is a subset of current C syntax and 
   semantics used in the kernel, and which doesn't allow access outside 
   of existing objects and thus creates a strictly enforced separation 
   between memory used for data, and memory used for code and control 
   flow.

 - This would involve, at minimum:

    - tracking every type and object and its inherent length and valid 
      access patterns, and never losing track of its type.

    - being a lot more organized about initialization, i.e. no 
      uninitialized variables/fields.

    - being a lot more strict about type conversions and pointers in 
      general.

    - ... and a metric ton of other details.

 - If such a runtime could co-exist without big complications with 
   regular C kernel code then we could convert particular pieces of C 
   code into this safe-C runtime step by step, and would also allow the 
   compilation of a piece of code as regular C, or into the safe runtime.

 - If a particular function can be formally proven to be safe, it can be 
   compiled as C - otherwise it would be compiled as safe-C.

 - ... or something like this.

The advantage would be: data corruption could never be triggered by code 
itself, if the compiler and runtime is correct. Return addresses and 
stacks wouldn't have to be 'hardened' or 'checked', because they'd never 
be corrupted in the first place. WX memory wouldn't be an issue as kernel 
code could never jump into generated shell code or ROP gadgets.

The disadvantage: the overhead of managing this, and any loss of 
flexibility on the kernel programming side.

Does this make sense, and if yes, does such a project exist already?
(And no, I don't mean Java or C#.)

Or would we in essence end up with a Java runtime, with C syntax?

Thanks,

	Ingo
