Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557B1C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CA3233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfH2RfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:35:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbfH2RfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:35:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF05A881346;
        Thu, 29 Aug 2019 17:35:01 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3DEA5B681;
        Thu, 29 Aug 2019 17:35:00 +0000 (UTC)
Date:   Thu, 29 Aug 2019 12:34:58 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
Message-ID: <20190829173458.skttfjlulbiz5s25@treble>
References: <20190827145102.p7lmkpytf3mngxbj@treble>
 <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble>
 <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble>
 <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Thu, 29 Aug 2019 17:35:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 05:28:50PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 28, 2019 at 5:22 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Wed, Aug 28, 2019 at 05:13:59PM +0200, Arnd Bergmann wrote:
> > > On Wed, Aug 28, 2019 at 11:00 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Aug 27, 2019 at 11:22 PM 'Nick Desaulniers' via Clang Built Linux <clang-built-linux@googlegroups.com> wrote:
> > > I figured this one out as well:
> > >
> > > > http://paste.ubuntu.com/p/XjdDsypRxX/
> > > > 0x5BA1B7A1:arch/x86/ia32/ia32_signal.o: warning: objtool:
> > > > ia32_setup_rt_frame()+0x238: call to memset() with UACCESS enabled
> > > > 0x5BA1B7A1:arch/x86/kernel/signal.o: warning: objtool:
> > > > __setup_rt_frame()+0x5b8: call to memset() with UACCESS enabled
> > >
> > > When CONFIG_KASAN is set, clang decides to use memset() to set
> > > the first two struct members in this function:
> > >
> > >  static inline void sas_ss_reset(struct task_struct *p)
> > >  {
> > >         p->sas_ss_sp = 0;
> > >         p->sas_ss_size = 0;
> > >         p->sas_ss_flags = SS_DISABLE;
> > >  }
> > >
> > > and that is called from save_altstack_ex(). Adding a barrier() after
> > > the sas_ss_sp() works around the issue, but is certainly not the
> > > best solution. Any other ideas?
> >
> > Wow, is the compiler allowed to insert memset calls like that?  Seems a
> > bit overbearing, at least in a kernel context.  I don't recall GCC ever
> > doing it.
> 
> Yes, it's free to assume that any standard library function behaves
> as defined, so it can and will turn struct assignments into memcpy
> or back, or replace string operations with others depending on what
> seems better for optimization.
> 
> clang is more aggressive than gcc here, and this has caused some
> other problems in the past, but it's usually harmless.
> 
> In theory, we could pass -ffreestanding to tell the compiler
> not to make assumptions about standard library function behavior,
> but that turns off all kinds of useful optimizations. The problem
> is really that the kernel is neither exactly hosted nor freestanding.

Adding a few people who may be interested in this discussion.

Peter suggested to try WRITE_ONCE for the two zero writes to see if that
"fixes" it.

However, according to Peter and Paul, but not Mary, Linus has argued
that normal aligned word stores shouldn't tear.  If that's our story
then it sounds like it's a compiler issue and WRITE_ONCE shouldn't
really be needed here to prevent the memset() call.

-- 
Josh
