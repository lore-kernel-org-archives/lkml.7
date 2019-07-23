Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A2CC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBCD22543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390209AbfGWNbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:31:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40880 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfGWNbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:31:41 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hputB-0006E3-Cd; Tue, 23 Jul 2019 15:31:33 +0200
Date:   Tue, 23 Jul 2019 15:31:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to
 be reserved
In-Reply-To: <20190723130513.GA25290@kroah.com>
Message-ID: <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de>
References: <7db7da45b435f8477f25e66f292631ff766a844c.1560969363.git.thomas.lendacky@amd.com> <20190713145909.30749-1-mike@fireburn.co.uk> <alpine.DEB.2.21.1907141215350.1669@nanos.tec.linutronix.de> <CAHbf0-EPfgyKinFuOP7AtgTJWVSVqPmWwMSxzaH=Xg-xUUVWCA@mail.gmail.com>
 <alpine.DEB.2.21.1907151011590.1669@nanos.tec.linutronix.de> <CAHbf0-F9yUDJ=DKug+MZqsjW+zPgwWaLUC40BLOsr5+t4kYOLQ@mail.gmail.com> <alpine.DEB.2.21.1907151118570.1669@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907151140080.1669@nanos.tec.linutronix.de>
 <CAMe9rOqMqkQ0LNpm25yE_Yt0FKp05WmHOrwc0aRDb53miFKM+w@mail.gmail.com> <20190723130513.GA25290@kroah.com>
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

On Tue, 23 Jul 2019, Greg KH wrote:
> On Mon, Jul 15, 2019 at 01:16:48PM -0700, H.J. Lu wrote:
> > >
> > 
> > Since building a workable kernel for different kernel configurations isn't a
> > requirement for gold, I don't recommend gold for kernel.
> 
> Um, it worked before this commit, and now it doesn't.  "Some" companies
> are using gold for linking the kernel today...

gold is known to fail the kernel build. x32 vdso linking is not working
since years and just because it 'works' for some configurations and breaks
for no valid reasons even with those configurations is just not good
enough.

As there is obviously no priority for fixing gold to work proper with the
kernel, I'm not at all interested in these 'regression' reports and in odd
'fixes' which just end up reverting or modifying perfectly valid changes
without understanding the root cause, i.e. the most horrible engineering
principle: duct-taping.

TBH, I'm tired of it. We fail the build for clang if it does not support
asm gotos and the clang people are actively working on fixing it and we're
helping them as much as we can. The companies who used clang nevertheless
have been on their own for years and if someone wants to use gold then
nobody is preventing them from doing so. They can keep their duct-tape in
their own trees.

See this thread for further discussion:

 https://lkml.kernel.org/r/alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de

Thanks,

	tglx
