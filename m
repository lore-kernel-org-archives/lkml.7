Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744AEC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449BB20B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556354880;
	bh=o7Zi2OFSlMO9Xm/vsc1KoauxoLseTvhz7SzXC91A+TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tC07Mnl8Gtl2N7w5tFWeDS+vvVoBgddHq+WmUXDpODbl3eCtIWyNoW6X9ZiDkgj5f
	 rhT4YJsOAylNraRrFc/15Wao4c0v0iPFXcmq7KVSf5JgN2NhVBH3jIzRthHdgGBAvX
	 U5kTZRzwpch6XmcpbPxdJaBRdnwy/Ajrl/n8PlPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfD0Ir7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:47:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53618 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfD0Ir6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:47:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id 26so6834185wmj.3;
        Sat, 27 Apr 2019 01:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/zv5yuIaeqOlk8OEMKio4/MAmsvMLSORpRGpKpNIa0M=;
        b=ERD2HjondX4lBfKJLBLv2Ss5GXQQY/STVBfBPYT50ndwhwjcnyhGpzKBcY+P/5gqVX
         w39JEIwrjrv1D8YsV6gZaMSlv0/aPtoDVw4XzB/u66gtqut4JfKoKqsbemJ1J6nZvea5
         UiDPM58uIPtco+tUA8J3RZmOjIECRVxK8EYwLbB1YWRMQuOdZlsaZCb70X4enzQJreJC
         W5zQ9ei4PVkSjhEWsVUUeCfsFCeB2DxGsfcX6ZKw0wIx8NHxSGAnOMVVgGF0YfA2nTN5
         P0LSA84kLOwfiAkPj8TA6dbAWkxPO2EjupV1We6AwPXETRj923vp+j4kHSclcKFS98JM
         53PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/zv5yuIaeqOlk8OEMKio4/MAmsvMLSORpRGpKpNIa0M=;
        b=iKBp4fjIPSof4i2oWVNOVsmBC/NAFXh1w1BrML+XeBBBjkbUfRci9zLJHGIGDQNavz
         QasRiabPFoo+aFw2FFglFElPFtpWKvEPtpem75Gr+OlLRX/2eEWosTFpjEcsWDnx7DIZ
         KLdAk2r5vEb4j1VeyE73gwNUS4RzhdDoGhtBUp1Zat44YdAh+JwExiYx9paPIWxKwZXS
         lP9jxqY6KEgQHOMULC3ZYat7NXY+tVcgJLruEmLK6pTOKuslH7TgVyiYEJxIcNBQmd1P
         QHC4ziELtsT943rdRVCF529OEpXkLnrwP/9hm5Pjnyx/LHrw414fcwZOXldjoec5q01Q
         Ixwg==
X-Gm-Message-State: APjAAAWTUIwd3cmypTJoaW04r4vpViFoRKoqgN3KiBzMNjaWf8k+n2aw
        82UHcVNwzm1CX+wlxQh7Cz4=
X-Google-Smtp-Source: APXvYqx7ZHqoLPTZteFydYJTzzPWBSczcrfxeg7zOhMoGoDZ6X/mErWp4KPIp06cwHTPRrgKIYe+iw==
X-Received: by 2002:a1c:9942:: with SMTP id b63mr11267225wme.116.1556354876436;
        Sat, 27 Apr 2019 01:47:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v192sm27592490wme.24.2019.04.27.01.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 01:47:55 -0700 (PDT)
Date:   Sat, 27 Apr 2019 10:47:52 +0200
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
Message-ID: <20190427084752.GA99668@gmail.com>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
 <20190426083144.GA126896@gmail.com>
 <20190426095802.GA35515@gmail.com>
 <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> > On Apr 26, 2019, at 2:58 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ingo Molnar <mingo@kernel.org> wrote:
> >
> >> I really don't like it where this is going. In a couple of years I
> >> really want to be able to think of PTI as a bad dream that is mostly
> >> over fortunately.
> >>
> >> I have the feeling that compiler level protection that avoids
> >> corrupting the stack in the first place is going to be lower overhead,
> >> and would work in a much broader range of environments. Do we have
> >> analysis of what the compiler would have to do to prevent most ROP
> >> attacks, and what the runtime cost of that is?
> >>
> >> I mean, C# and Java programs aren't able to corrupt the stack as long
> >> as the language runtime is corect. Has to be possible, right?
> >
> > So if such security feature is offered then I'm afraid distros would be
> > strongly inclined to enable it - saying 'yes' to a kernel feature that
> > can keep your product off CVE advisories is a strong force.
> >
> > To phrase the argument in a bit more controversial form:
> >
> >   If the price of Linux using an insecure C runtime is to slow down
> >   system calls with immense PTI-alike runtime costs, then wouldn't it be
> >   the right technical decision to write the kernel in a language runtime
> >   that doesn't allow stack overflows and such?
> >
> > I.e. if having Linux in C ends up being slower than having it in Java,
> > then what's the performance argument in favor of using C to begin with?
> > ;-)
> >
> > And no, I'm not arguing for Java or C#, but I am arguing for a saner
> > version of C.
> >
> >
> 
> IMO three are three credible choices:
> 
> 1. C with fairly strong CFI protection. Grsecurity has this (supposedly 
> — there’s a distinct lack of source code available), and clang is 
> gradually working on it.
> 
> 2. A safe language for parts of the kernel, e.g. drivers and maybe 
> eventually filesystems.  Rust is probably the only credible candidate. 
> Actually creating a decent Rust wrapper around the core kernel 
> facilities would be quite a bit of work.  Things like sysfs would be 
> interesting in Rust, since AFAIK few or even no drivers actually get 
> the locking fully correct.  This means that naive users of the API 
> cannot port directly to safe Rust, because all the races won't compile
> :)
> 
> 3. A sandbox for parts of the kernel, e.g. drivers.  The obvious 
> candidates are eBPF and WASM.
> 
> #2 will give very good performance.  #3 gives potentially stronger
> protection against a sandboxed component corrupting the kernel overall, 
> but it gives much weaker protection against a sandboxed component 
> corrupting itself.
> 
> In an ideal world, we could do #2 *and* #3.  Drivers could, for 
> example, be written in a language like Rust, compiled to WASM, and run 
> in the kernel.

So why not go for #1, which would still outperform #2/#3, right? Do we 
know what it would take, roughly, and how the runtime overhead looks 
like?

Thanks,

	Ingo
