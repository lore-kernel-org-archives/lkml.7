Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9C6C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D434206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403966AbfGXUUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:20:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44820 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390805AbfGXUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:20:42 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqNkZ-00060B-OU; Wed, 24 Jul 2019 22:20:35 +0200
Date:   Wed, 24 Jul 2019 22:20:34 +0200 (CEST)
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
In-Reply-To: <alpine.DEB.2.21.1907242153320.1791@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1907242208590.1791@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907151118570.1669@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907151140080.1669@nanos.tec.linutronix.de> <CAMe9rOqMqkQ0LNpm25yE_Yt0FKp05WmHOrwc0aRDb53miFKM+w@mail.gmail.com> <20190723130513.GA25290@kroah.com>
 <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de> <20190723134454.GA7260@kroah.com> <20190724153416.GA27117@kroah.com> <alpine.DEB.2.21.1907241746010.1791@nanos.tec.linutronix.de> <20190724155735.GC5571@kroah.com> <alpine.DEB.2.21.1907241801320.1791@nanos.tec.linutronix.de>
 <20190724161634.GB10454@kroah.com> <alpine.DEB.2.21.1907242153320.1791@nanos.tec.linutronix.de>
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

On Wed, 24 Jul 2019, Thomas Gleixner wrote:

> On Wed, 24 Jul 2019, Greg KH wrote:
> > On Wed, Jul 24, 2019 at 06:03:41PM +0200, Thomas Gleixner wrote:
> > > > Gotta love old tool-chains :(
> > > 
> > > Oh yes. /me does archaeology to find a VM with old stuff
> > 
> > I can provide a binary if you can't find anything.
> 
> Found GNU ld (GNU Binutils for Debian) 2.25 and after fiddling with
> LD_PRELOAD it builds without failure.
> 
> ld.gold from that binutils version dies with a segfault on various files ...

Then tried that old ld.bfd with GCC8 and that causes ld.bfd to segfault on
every other file.

Copied that config to the clang build directory and it causes the same
explosions with ld.bfd.

What a time waste...



