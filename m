Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD714C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905EA2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="OyerzEpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfE0MeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:34:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36356 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfE0MeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:34:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id s17so16800875wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vqu/vuzdkEYXoKFeag0Gx7i/C6AwfCJXqtUJbGQjm2g=;
        b=OyerzEpWHETbFpy0c+A9OY8Lt73C0idp+PGHMM5Hk+LLRx9wwPHZQozpo8l5Eb9Ku2
         BLL+C1+bX579kmC98+XU2vwo/p2jktBSuDST+iVX7syTwLwbwx/6JX64Ub9OuDZusIdp
         kKDJjsTRUzHPtW0urZeRIYOMxMDrYawpqD1NAjav0wkLUtufk55DmMuotx1mhFELtMN4
         Q60vEqDPAiRagFtyMVs2GMDqFy7ESvJPNzV96xt/3RBuo6MVwbffzkmsBK2QQuquT8WB
         BK7IAAbiz5k5ehEhuF37CxBmtc7DPqcYWzk5hOTDEz1nr5FgutMoVyt1M6U6NprWQjVX
         RLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vqu/vuzdkEYXoKFeag0Gx7i/C6AwfCJXqtUJbGQjm2g=;
        b=nkxJNi2PfMzX7MJVo05UuieE9HIRue2FDiFxTIwEH0A4Z6ybOnOYnkMeSS1LcKDM9S
         7Qmj/60GfngBoZa9RQSq48W1iw2gBbduy9y+lPU9ZN2Q/Iuego1xH4sl3gaEwN9XxVJk
         mE0KLu59t3cRl2ROi/IPTwNz6acFt3HF8sPoVYe2GQ4XPUYtpthILdJoT2Z8cnwfwRnE
         ZOTBJA3x5zaKlE7CVZkgS5cB8C6vm7U50MZLjDzGMg5MBMyByGcMg714t/urf4iRvnyF
         lRjvv7nVeJaWR6fI4PG0PEblOC9huifggJn9lzfSKALEsK3B8CGzuXy0Xqo7YbgGX82M
         K+ig==
X-Gm-Message-State: APjAAAX0DS4JJu5y5tDjzrgaXebK90MkKKOQ7HdkNoHyxINFPTLXbGHL
        JrsFmq8vTmMZxojfD0YJeDxYchvaJMBkxg==
X-Google-Smtp-Source: APXvYqxwrvDMfYdjYL3oXDcnUR6fu2NOHf3e/9SAIT1sxwsepQqVIryqUvD3CwCzUoQ/rcFzeIspgQ==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr37257590wrj.272.1558960457999;
        Mon, 27 May 2019 05:34:17 -0700 (PDT)
Received: from brauner.io (p5097b50e.dip0.t-ipconnect.de. [80.151.181.14])
        by smtp.gmail.com with ESMTPSA id r4sm8102395wrv.34.2019.05.27.05.34.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 05:34:17 -0700 (PDT)
Date:   Mon, 27 May 2019 14:34:15 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 2/2] arch: wire-up clone6() syscall on x86
Message-ID: <20190527123414.rv2r6g6de6y3ay6w@brauner.io>
References: <20190526102612.6970-1-christian@brauner.io>
 <20190526102612.6970-2-christian@brauner.io>
 <CAK8P3a1Ltsna_rtKxhMU7X0t=UOXDA75tKpph6s=OZ4itJe7VQ@mail.gmail.com>
 <20190527104528.cao7wamuj4vduh3u@brauner.io>
 <CAK8P3a3q=5Ca0xoMp+kyCvOqNDRzDTgu28f+U8J-buMVcZcVaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3q=5Ca0xoMp+kyCvOqNDRzDTgu28f+U8J-buMVcZcVaw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 02:28:33PM +0200, Arnd Bergmann wrote:
> On Mon, May 27, 2019 at 12:45 PM Christian Brauner <christian@brauner.io> wrote:
> > On Mon, May 27, 2019 at 12:02:37PM +0200, Arnd Bergmann wrote:
> > > On Sun, May 26, 2019 at 12:27 PM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > Wire up the clone6() call on x86.
> > > >
> > > > This patch only wires up clone6() on x86. Some of the arches look like they
> > > > need special assembly massaging and it is probably smarter if the
> > > > appropriate arch maintainers would do the actual wiring.
> > >
> > > Why do some architectures need special cases here? I'd prefer to have
> > > new system calls always get defined in a way that avoids this, and
> > > have a common entry point for everyone.
> > >
> > > Looking at the m68k sys_clone comment in
> > > arch/m68k/kernel/process.c, it seems that this was done as an
> > > optimization to deal with an inferior ABI. Similar code is present
> > > in h8300, ia64, nios2, and sparc. If all of them just do this to
> > > shave off a few cycles from the system call entry, I really
> > > couldn't care less.
> >
> > I'm happy to wire all arches up at the same time in the next revision. I
> > just wasn't sure why some of them were assemblying the living hell out
> > of clone; especially ia64. I really didn't want to bother touching all
> > of this just for an initial RFC.
> 
> Don't worry about doing all architectures for the RFC, I mainly want this
> to be done consistently by the time it gets into linux-next.
> 
> One thing to figure out though is whether we need the stack_size argument
> that a couple of architectures pass. It's usually hardwired to zero,
> but not all the time, and I don't know the history of this.

Afaict, stack_size is *only* used on ia64:

/*
 * sys_clone2(u64 flags, u64 ustack_base, u64 ustack_size, u64 parent_tidptr, u64 child_tidptr,
 *	      u64 tls)
 */
GLOBAL_ENTRY(sys_clone2)
	/*
	 * Allocate 8 input registers since ptrace() may clobber them
	 */
	.prologue ASM_UNW_PRLG_RP|ASM_UNW_PRLG_PFS, ASM_UNW_PRLG_GRSAVE(8)
	alloc r16=ar.pfs,8,2,6,0
	DO_SAVE_SWITCH_STACK
	adds r2=PT(R16)+IA64_SWITCH_STACK_SIZE+16,sp
	mov loc0=rp
	mov loc1=r16				// save ar.pfs across do_fork
	.body
	mov out1=in1
	mov out2=in2
	tbit.nz p6,p0=in0,CLONE_SETTLS_BIT
	mov out3=in3	// parent_tidptr: valid only w/CLONE_PARENT_SETTID
	;;
(p6)	st8 [r2]=in5				// store TLS in r16 for copy_thread()
	mov out4=in4	// child_tidptr:  valid only w/CLONE_CHILD_SETTID or CLONE_CHILD_CLEARTID
	mov out0=in0				// out0 = clone_flags
	br.call.sptk.many rp=do_fork
.ret1:	.restore sp
	adds sp=IA64_SWITCH_STACK_SIZE,sp	// pop the switch stack
	mov ar.pfs=loc1
	mov rp=loc0
	br.ret.sptk.many rp
END(sys_clone2)

I'm not sure if this needs to be because of architectural constraints or
if it just is a historic artifact.
(Ccing ia64 now to see what they have to say.)

Christian
