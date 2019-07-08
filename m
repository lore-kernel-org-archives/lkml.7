Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83464C606A1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FD520651
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfGHJg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:36:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38940 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbfGHJg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:36:56 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkQ3d-00055P-1m; Mon, 08 Jul 2019 11:35:37 +0200
Date:   Mon, 8 Jul 2019 11:35:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pingfan Liu <kernelfans@gmail.com>
cc:     x86@kernel.org, Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Qian Cai <cai@lca.pw>,
        Barret Rhoden <brho@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/numa: instance all parsed numa node
In-Reply-To: <CAFgQCTvwS+yEkAmCJnsCfnr0JS01OFtBnDg4cr41_GqU79A4Gg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907081125300.3648@nanos.tec.linutronix.de>
References: <1562300143-11671-1-git-send-email-kernelfans@gmail.com> <1562300143-11671-2-git-send-email-kernelfans@gmail.com> <alpine.DEB.2.21.1907072133310.3648@nanos.tec.linutronix.de> <CAFgQCTvwS+yEkAmCJnsCfnr0JS01OFtBnDg4cr41_GqU79A4Gg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019, Pingfan Liu wrote:
> On Mon, Jul 8, 2019 at 3:44 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Fri, 5 Jul 2019, Pingfan Liu wrote:
> >
> > > I hit a bug on an AMD machine, with kexec -l nr_cpus=4 option. nr_cpus option
> > > is used to speed up kdump process, so it is not a rare case.
> >
> > But fundamentally wrong, really.
> >
> > The rest of the CPUs are in a half baken state and any broadcast event,
> > e.g. MCE or a stray IPI, will result in a undiagnosable crash.
> Very appreciate if you can pay more word on it? I tried to figure out
> your point, but fail.
> 
> For "a half baked state", I think you concern about LAPIC state, and I
> expand this point like the following:

It's not only the APIC state. It's the state of the CPUs in general.
 
> For IPI: when capture kernel BSP is up, the rest cpus are still loop
> inside crash_nmi_callback(), so there is no way to eject new IPI from
> these cpu. Also we disable_local_APIC(), which effectively prevent the
> LAPIC from responding to IPI, except NMI/INIT/SIPI, which will not
> occur in crash case.

Fair enough for the IPI case.

> For MCE, I am not sure whether it can broadcast or not between cpus,
> but as my understanding, it can not. Then is it a problem?

It can and it does.

That's the whole point why we bring up all CPUs in the 'nosmt' case and
shut the siblings down again after setting CR4.MCE. Actually that's in fact
a 'let's hope no MCE hits before that happened' approach, but that's all we
can do.

If we don't do that then the MCE broadcast can hit a CPU which has some
firmware initialized state. The result can be a full system lockup, triple
fault etc.

So when the MCE hits a CPU which is still in the crashed kernel lala state,
then all hell breaks lose.
 
> From another view point, is there any difference between nr_cpus=1 and
> nr_cpus> 1 in crashing case? If stray IPI raises issue to nr_cpus>1,
> it does for nr_cpus=1.

Anything less than the actual number of present CPUs is problematic except
you use the 'let's hope nothing happens' approach. We could add an option
to stop the bringup at the early online state similar to what we do for
'nosmt'.

Thanks,

	tglx
