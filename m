Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78EDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A549720863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfEVSHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:07:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfEVSHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:07:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2DC98830F;
        Wed, 22 May 2019 18:07:51 +0000 (UTC)
Received: from treble (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D63262660;
        Wed, 22 May 2019 18:07:51 +0000 (UTC)
Date:   Wed, 22 May 2019 13:07:49 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190522180749.qpwdlhkcitxiazco@treble>
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com>
 <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net>
 <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 22 May 2019 18:07:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 04:15:39PM +0800, Kairui Song wrote:
> On Fri, May 17, 2019 at 4:11 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, May 17, 2019 at 09:46:00AM +0200, Peter Zijlstra wrote:
> > > On Thu, May 16, 2019 at 11:51:55PM +0000, Song Liu wrote:
> > > > Hi,
> > > >
> > > > We found a failure with selftests/bpf/tests_prog in test_stacktrace_map (on bpf/master
> > > > branch).
> > > >
> > > > After digging into the code, we found that perf_callchain_kernel() is giving empty
> > > > callchain for tracepoint sched/sched_switch. And it seems related to commit
> > > >
> > > > d15d356887e770c5f2dcf963b52c7cb510c9e42d
> > > > ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
> > > >
> > > > Before this commit, perf_callchain_kernel() returns callchain with regs->ip. With
> > > > this commit, regs->ip is not sent for !perf_hw_regs(regs) case.
> > >
> > > So while I think the below is indeed right; we should store regs->ip
> > > regardless of the unwind path chosen, I still think there's something
> > > fishy if this results in just the 1 entry.
> > >
> > > The sched/sched_switch event really should have a non-trivial stack.
> > >
> > > Let me see if I can reproduce with just perf.
> >
> > $ perf record -g -e "sched:sched_switch" -- make clean
> > $ perf report -D
> >
> > 12 904071759467 0x1790 [0xd0]: PERF_RECORD_SAMPLE(IP, 0x1): 7236/7236: 0xffffffff81c29562 period: 1 addr: 0
> > ... FP chain: nr:10
> > .....  0: ffffffffffffff80
> > .....  1: ffffffff81c29562
> > .....  2: ffffffff81c29933
> > .....  3: ffffffff8111f688
> > .....  4: ffffffff81120b9d
> > .....  5: ffffffff81120ce5
> > .....  6: ffffffff8100254a
> > .....  7: ffffffff81e0007d
> > .....  8: fffffffffffffe00
> > .....  9: 00007f9b6cd9682a
> > ... thread: sh:7236
> > ...... dso: /lib/modules/5.1.0-12177-g41bbb9129767/build/vmlinux
> >
> >
> > IOW, it seems to 'work'.
> >
> 
> Hi, I think the actual problem is that bpf_get_stackid_tp (and maybe
> some other bfp functions) is now broken, or, strating an unwind
> directly inside a bpf program will end up strangely. It have following
> kernel message:
> 
> WARNING: kernel stack frame pointer at 0000000070cad07c in
> test_progs:1242 has bad value 00000000ffd4497e
> 
> And in the debug message:
> 
> [  160.460287] 000000006e117175: ffffffffaa23a0e8
> (get_perf_callchain+0x148/0x280)
> [  160.460287] 0000000002e8715f: 0000000000c6bba0 (0xc6bba0)
> [  160.460288] 00000000b3d07758: ffff9ce3f9790000 (0xffff9ce3f9790000)
> [  160.460289] 0000000055c97836: ffff9ce3f9790000 (0xffff9ce3f9790000)
> [  160.460289] 000000007cbb140a: 000000010000007f (0x10000007f)
> [  160.460290] 000000007dc62ac9: 0000000000000000 ...
> [  160.460290] 000000006b41e346: 1c7da01cd70c4000 (0x1c7da01cd70c4000)
> [  160.460291] 00000000f23d1826: ffffd89cffc3ae80 (0xffffd89cffc3ae80)
> [  160.460292] 00000000f9a16017: 000000000000007f (0x7f)
> [  160.460292] 00000000a8e62d44: 0000000000000000 ...
> [  160.460293] 00000000cbc83c97: ffffb89d00d8d000 (0xffffb89d00d8d000)
> [  160.460293] 0000000092842522: 000000000000007f (0x7f)
> [  160.460294] 00000000dafbec89: ffffb89d00c6bc50 (0xffffb89d00c6bc50)
> [  160.460296] 000000000777e4cf: ffffffffaa225d97 (bpf_get_stackid+0x77/0x470)
> [  160.460296] 000000009942ea16: 0000000000000000 ...
> [  160.460297] 00000000a08006b1: 0000000000000001 (0x1)
> [  160.460298] 000000009f03b438: ffffb89d00c6bc30 (0xffffb89d00c6bc30)
> [  160.460299] 000000006caf8b32: ffffffffaa074fe8 (__do_page_fault+0x58/0x90)
> [  160.460300] 000000003a13d702: 0000000000000000 ...
> [  160.460300] 00000000e2e2496d: ffff9ce300000000 (0xffff9ce300000000)
> [  160.460301] 000000008ee6b7c2: ffffd89cffc3ae80 (0xffffd89cffc3ae80)
> [  160.460301] 00000000a8cf6d55: 0000000000000000 ...
> [  160.460302] 0000000059078076: ffffd89cffc3ae80 (0xffffd89cffc3ae80)
> [  160.460303] 00000000c6aac739: ffff9ce3f1e18eb0 (0xffff9ce3f1e18eb0)
> [  160.460303] 00000000a39aff92: ffffb89d00c6bc60 (0xffffb89d00c6bc60)
> [  160.460305] 0000000097498bf2: ffffffffaa1f4791 (bpf_get_stackid_tp+0x11/0x20)
> [  160.460306] 000000006992de1e: ffffb89d00c6bc78 (0xffffb89d00c6bc78)
> [  160.460307] 00000000dacd0ce5: ffffffffc0405676 (0xffffffffc0405676)
> [  160.460307] 00000000a81f2714: 0000000000000000 ...
> 
> # Note here is the invalid frame pointer
> [  160.460308] 0000000070cad07c: ffffb89d00a1d000 (0xffffb89d00a1d000)
> [  160.460308] 00000000f8f194e4: 0000000000000001 (0x1)
> [  160.460309] 000000002134f42a: ffffd89cffc3ae80 (0xffffd89cffc3ae80)
> [  160.460310] 00000000f9345889: ffff9ce3f1e18eb0 (0xffff9ce3f1e18eb0)
> [  160.460310] 000000008ad22a42: 0000000000000000 ...
> [  160.460311] 0000000073808173: ffffb89d00c6bce0 (0xffffb89d00c6bce0)
> [  160.460312] 00000000c9effff4: ffffffffaa1f48d1 (trace_call_bpf+0x81/0x100)
> [  160.460313] 00000000c5d8ebd1: ffffb89d00c6bcc0 (0xffffb89d00c6bcc0)
> [  160.460315] 00000000bce0b072: ffffffffab651be0
> (event_sched_migrate_task+0xa0/0xa0)
> [  160.460316] 00000000355cf319: 0000000000000000 ...
> [  160.460316] 000000003b67f2ad: ffffd89cffc3ae80 (0xffffd89cffc3ae80)
> [  160.460316] 000000009a77e20b: ffff9ce3fba25000 (0xffff9ce3fba25000)
> [  160.460317] 0000000032cf7376: 0000000000000001 (0x1)
> [  160.460317] 000000000051db74: ffffb89d00c6bd20 (0xffffb89d00c6bd20)
> [  160.460318] 0000000040eb3bf7: ffffffffaa22be81
> (perf_trace_run_bpf_submit+0x41/0xb0)

Is there an easy way to recreate this?

-- 
Josh
