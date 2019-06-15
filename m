Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFE0C31E51
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05DB2080A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfFOACu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 20:02:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfFOACt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 20:02:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CCA83082E4F;
        Sat, 15 Jun 2019 00:02:49 +0000 (UTC)
Received: from treble (ovpn-112-39.rdu2.redhat.com [10.10.112.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BA0B1001B23;
        Sat, 15 Jun 2019 00:02:44 +0000 (UTC)
Date:   Fri, 14 Jun 2019 19:02:42 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     X86 ML <x86@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Laight <David.Laight@aculab.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 2/5] objtool: Fix ORC unwinding in non-JIT BPF
 generated code
Message-ID: <20190615000242.e5tcogffvyuuhnrs@treble>
References: <cover.1560534694.git.jpoimboe@redhat.com>
 <c0add777a2e0207c1474ce99baa492a7ce3502d6.1560534694.git.jpoimboe@redhat.com>
 <20190614205841.s4utbpurntpr6aiq@ast-mbp.dhcp.thefacebook.com>
 <20190614210745.kwiqm5pkgabruzuj@treble>
 <CAADnVQLK3ixK1JWF_mfScZoFzFF=6O8f1WcqkYqiejKeex1GSQ@mail.gmail.com>
 <20190614211929.drnnawbi7guqj2ck@treble>
 <CAADnVQ+BCxsKEK=ZzYOZkgTJAg_7jz1_f+FCX+Ms0vTOuW8Mxw@mail.gmail.com>
 <20190614231717.xukbfpc2cy47s4xh@treble>
 <CAADnVQJn+TnSj82MJ0ry1UTNGXD0qzESqfp7E1oi_HAYC-xTXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQJn+TnSj82MJ0ry1UTNGXD0qzESqfp7E1oi_HAYC-xTXg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 15 Jun 2019 00:02:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:30:15PM -0700, Alexei Starovoitov wrote:
> On Fri, Jun 14, 2019 at 4:17 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Fri, Jun 14, 2019 at 02:22:59PM -0700, Alexei Starovoitov wrote:
> > > On Fri, Jun 14, 2019 at 2:19 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > > > > > >
> > > > > > > > +#define JUMP_TABLE_SYM_PREFIX "jump_table."
> > > > > > >
> > > > > > > since external tool will be looking at it should it be named
> > > > > > > "bpf_jump_table." to avoid potential name conflicts?
> > > > > > > Or even more unique name?
> > > > > > > Like "bpf_interpreter_jump_table." ?
> > > > > >
> > > > > > No, the point is that it's a generic feature which can also be used any
> > > > > > non-BPF code which might also have a jump table.
> > > > >
> > > > > and you're proposing to name all such jump tables in the kernel
> > > > > as static foo jump_table[] ?
> > > >
> > > > That's the idea.
> > >
> > > Then it needs much wider discussion.
> >
> > Why would it need wider discussion?  It only has one user.  If you
> > honestly believe that it will be controversial to require future users
> > to call a static jump table "jump_table" then we can have that
> > discussion when it comes up.
> 
> It's clearly controversial.
> I nacked it already on pointless name change
> from "jumptable" to "jump_table" and now you're saying
> that no one will complain about "jump_table" name
> for all jump tables in the kernel that will ever appear?

Let me get this straight.  You're saying that "jumptable" and
"bpf_interpreter_jump_table" are both acceptable.

But NACK to "jump_table".

Ok...

-- 
Josh
