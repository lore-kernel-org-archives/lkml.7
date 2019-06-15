Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB21DC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B930F21773
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 04:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfFOE1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 00:27:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfFOE1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 00:27:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8CD43082E06;
        Sat, 15 Jun 2019 04:27:54 +0000 (UTC)
Received: from treble (ovpn-120-9.rdu2.redhat.com [10.10.120.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B4A01001B23;
        Sat, 15 Jun 2019 04:27:50 +0000 (UTC)
Date:   Fri, 14 Jun 2019 23:27:47 -0500
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
Subject: Re: [PATCH v2 4/5] x86/bpf: Fix 64-bit JIT frame pointer usage
Message-ID: <20190615042747.awyy4djqe6vfmles@treble>
References: <cover.1560534694.git.jpoimboe@redhat.com>
 <178097de8c1bd6a877342304f3469eac4067daa4.1560534694.git.jpoimboe@redhat.com>
 <20190614210555.q4ictql3tzzjio4r@ast-mbp.dhcp.thefacebook.com>
 <20190614211916.jnxakyfwilcv6r57@treble>
 <CAADnVQJ0dmxYTnaQC1UiSo7MhcTy2KRWJWJKw4jyxFWby-JgRg@mail.gmail.com>
 <20190614231311.gfeb47rpjoholuov@treble>
 <CAADnVQKOjvhpMQqjHvF-oX2U99WRCi+repgqmt6hiSObovxoaQ@mail.gmail.com>
 <20190614235417.7oagddee75xo7otp@treble>
 <CAADnVQ+mjtgZExhtKDu6bbaVSHUfOYb=XeJodPB5+WdjtLYvCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQ+mjtgZExhtKDu6bbaVSHUfOYb=XeJodPB5+WdjtLYvCA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 15 Jun 2019 04:27:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 05:02:36PM -0700, Alexei Starovoitov wrote:
> On Fri, Jun 14, 2019 at 4:54 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > The previous patch you posted has my patch description, push/pop and
> > comment changes, with no credit:
> >
> > https://lkml.kernel.org/r/20190614210555.q4ictql3tzzjio4r@ast-mbp.dhcp.thefacebook.com
> 
> I'm sorry for reusing one sentence from your commit log and
> not realizing you want credit for that.
> Will not happen again.

Um.  What are you talking about?  The entire patch was clearly derived
from mine.  Not just "one sentence from your commit log".  The title,
the pushes/pops in the prologue/epilogue, the removal of the
"ebpf_from_cbpf" argument, the code spacing, and some of the non trivial
comment changes were the same.

> I also suggest you never touch anything bpf related.
> Just to avoid this credit claims and threads like this one.

Wth.  I made a simple request for credit.  Anybody can see the patch was
derived from mine.  It's not like I really care.  It's just basic human
decency.

-- 
Josh
