Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C16C73C64
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920E62064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGJLkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 07:40:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47484 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfGJLkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:40:03 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlAw9-0001Fg-M3; Wed, 10 Jul 2019 13:39:01 +0200
Date:   Wed, 10 Jul 2019 13:39:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pingfan Liu <kernelfans@gmail.com>
cc:     Andy Lutomirski <luto@amacapital.net>, x86@kernel.org,
        Michal Hocko <mhocko@suse.com>,
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
In-Reply-To: <CAFgQCTtK7G9NPQgHa_gJkr8WLzYqagBVLaqBY7-w+tirX-+w-g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907101334230.1758@nanos.tec.linutronix.de>
References: <1562300143-11671-1-git-send-email-kernelfans@gmail.com> <1562300143-11671-2-git-send-email-kernelfans@gmail.com> <alpine.DEB.2.21.1907072133310.3648@nanos.tec.linutronix.de> <CAFgQCTvwS+yEkAmCJnsCfnr0JS01OFtBnDg4cr41_GqU79A4Gg@mail.gmail.com>
 <alpine.DEB.2.21.1907081125300.3648@nanos.tec.linutronix.de> <CAFgQCTvAOeerLHQvgvFXy_kLs=H=CuUFjYE+UAN+vhPCG+s=pQ@mail.gmail.com> <alpine.DEB.2.21.1907090810490.1961@nanos.tec.linutronix.de> <CAFgQCTui7D6_FQ_v_ijj6k_=+TQzQ3PaGvzxd6p+XEGjQ2S6jw@mail.gmail.com>
 <4AF3459B-28F2-425F-8E4B-40311DEF30C6@amacapital.net> <CAFgQCTtK7G9NPQgHa_gJkr8WLzYqagBVLaqBY7-w+tirX-+w-g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1204690592-1562758741=:1758"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1204690592-1562758741=:1758
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 10 Jul 2019, Pingfan Liu wrote:
> On Tue, Jul 9, 2019 at 9:34 PM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > Go for it. I’m not familiar enough with the SMP boot stuff that I would
> > be able to do it any faster than you. I’ll gladly help review it.
> 
> I had sent out a patch to fix maxcpus "[PATCH] smp: force all cpu to
> boot once under maxcpus option"
>
> But for the case of nrcpus, I think things will not be so easy due to
> percpu area, and I think it may take a quite different way.

No.

It's the same problem and it's broken in the same way as maxcpus on x86. So
nr_cpus on x86 has to do:

	if (nr_cpus < num_present_cpus()) {
		pr_info(....);
		max_cpus = nr_cpus;
		nr_cpus = num_present_cpus();
	}

or something like that.

Stop making extra cases which are pointlessly different. X86 boot is a
trainwreck in hardware, so no magic software can fix it.

All you can do is pray that it reaches the point where all present CPUs
have been at least minimaly initialized.

Thanks,

	tglx



--8323329-1204690592-1562758741=:1758--
