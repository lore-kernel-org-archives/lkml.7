Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D56C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2549120679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfH1R5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:57:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfH1R5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:57:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C667308219F;
        Wed, 28 Aug 2019 17:57:17 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E42E45D70D;
        Wed, 28 Aug 2019 17:57:15 +0000 (UTC)
Date:   Wed, 28 Aug 2019 12:57:13 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
Message-ID: <20190828175713.s7jub3sf6l7vyfoj@treble>
References: <CAK8P3a3G=GCpLtNztuoLR4BuugAB=zpa_Jrz5BSft6Yj-nok1g@mail.gmail.com>
 <20190827145102.p7lmkpytf3mngxbj@treble>
 <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble>
 <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <20190828145102.o7h3la3ofb2b4aie@treble>
 <CAK8P3a1gkA4cqbKbLLCAukiX-0tA9fV_FTG6PLTfv+DSHp44GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1gkA4cqbKbLLCAukiX-0tA9fV_FTG6PLTfv+DSHp44GQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 28 Aug 2019 17:57:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 05:29:39PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 28, 2019 at 4:51 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Wed, Aug 28, 2019 at 11:00:04AM +0200, Arnd Bergmann wrote:
> > > On Tue, Aug 27, 2019 at 11:22 PM 'Nick Desaulniers' via Clang Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > > On Tue, Aug 27, 2019 at 12:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > Only a few unique objtool warnings remain now, here are the ones I
> > > currently see,
> > > along with .config files. Let me know which ones I should investigate further,
> > > I assume a lot of these are known issues:
> >
> > None of those look necessarily familiar.  What are the remaining "known"
> > clang issues which were found by objtool?
> 
> Maybe Nick can identify some.
> 
> > If you share .o files I can look at them.
> 
> Attaching the ones I could easily recreate here.

adm1275.o: warning: objtool: adm1275_probe()+0x756: unreachable instruction
- known issue: clang switch table has invalid entries
- also an objtool bug: need to report it as "falls through to next function"

atom.o: warning: objtool: atom_op_move() falls through to next function atom_op_and()
evergreen_cs.o: warning: objtool: evergreen_cs_parse() falls through to next function evergreen_dma_cs_parse()
- known issue: clang switch table has invalid entries

common.o: warning: objtool: kasan_report()+0x52: call to __stack_chk_fail() with UACCESS enabled
trace_branch.o: warning: objtool: ftrace_likely_update()+0x6c: call to __stack_chk_fail() with UACCESS enabled
- objtool bug: need to add __stack_chk_fail to uaccess whitelist

cxd2880_tnrdmd_dvbt2.o: warning: objtool: x_tune_dvbt2_demod_setting()+0x7f6: can't find switch jump table
- objtool bug: tricky switch table issue

exit.o: warning: objtool: abort()+0x3: unreachable instruction
hugetlb.o: warning: objtool: hugetlb_vm_op_fault()+0x3: unreachable instruction
idle.o: warning: objtool: switched_to_idle()+0x3: unreachable instruction
madvise.o: warning: objtool: hugepage_madvise()+0x3: unreachable instruction
privcmd.o: warning: objtool: privcmd_ioctl_mmap_batch()+0x5dd: unreachable instruction
process.o: warning: objtool: play_dead()+0x3: unreachable instruction
rmap.o: warning: objtool: anon_vma_clone()+0x1c2: unreachable instruction
s5c73m3-core.o: warning: objtool: s5c73m3_probe()+0x262: unreachable instruction
videobuf2-core.o: warning: objtool: vb2_core_dqbuf()+0xae6: unreachable instruction
xfrm_output.o: warning: objtool: xfrm_outer_mode_output()+0x109: unreachable instruction
- clang issue: trying to finish frame pointer setup after BUG() in unreachable code path

pinctrl-ingenic.o: warning: objtool: ingenic_pinconf_set()+0x10d: sibling call from callable instruction with modified stack frame
- bad clang bug: sibling call without first popping registers

-- 
Josh
