Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C371AC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F39217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfEUUx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:53:27 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:54526 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfEUUxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:53:25 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2406172CCD5;
        Tue, 21 May 2019 23:53:24 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id F14024A4A14;
        Tue, 21 May 2019 23:53:23 +0300 (MSK)
Date:   Tue, 21 May 2019 23:53:23 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl when system kernel headers
 are ahead of the kernel
Message-ID: <20190521205322.pasqqgpaaxjx7buy@altlinux.org>
Mail-Followup-To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>, Kim Phillips <kim.phillips@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20190521030203.1447-1-vt@altlinux.org>
 <20190521132838.GB26253@kernel.org>
 <alpine.LRH.2.20.1905211632300.4243@Diego>
 <20190521151918.GD26253@kernel.org>
 <20190521180354.GE26253@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190521180354.GE26253@kernel.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo,

On Tue, May 21, 2019 at 03:03:54PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 21, 2019 at 12:19:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, May 21, 2019 at 04:34:47PM +0200, Michael Petlan escreveu:
> > > On Tue, 21 May 2019, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, May 21, 2019 at 06:02:03AM +0300, Vitaly Chikunov escreveu:
> > > > > When a host system has kernel headers that are newer than a compiling
> > > > > kernel, mksyscalltbl fails with errors such as:
> 
> > > > >   <stdin>: In function 'main':
> > > > >   <stdin>:271:44: error: '__NR_kexec_file_load' undeclared (first use in this function)
> > > > >   <stdin>:271:44: note: each undeclared identifier is reported only once for each function it appears in
> > > > >   <stdin>:272:46: error: '__NR_pidfd_send_signal' undeclared (first use in this function)
> > > > >   <stdin>:273:43: error: '__NR_io_uring_setup' undeclared (first use in this function)
> > > > >   <stdin>:274:43: error: '__NR_io_uring_enter' undeclared (first use in this function)
> > > > >   <stdin>:275:46: error: '__NR_io_uring_register' undeclared (first use in this function)
> > > > >   tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: line 48: /tmp/create-table-xvUQdD: Permission denied
> 
> > > > > mksyscalltbl is compiled with default host includes, but run with
> 
> > > > It shouldn't :-\ So with this you're making it use the ones shipped in
> > > > tools/include? Good, I'll test it, thanks!
> 
> > > I've hit the issue too, this patch fixes it for me.
> > > Tested.
> 
> > Thanks, I'll add your Tested-by, appreciated.
> 
> Was this in a cross-build environment? Native?

It was native build on aarch64 with both 'hostcc' and 'gcc' arguments of
mksyscalltbl being set to gcc.

> I'm asking because I test
> this on several cross build environments, like on ubuntu 19.04 cross
> building to aarch64:
> ... 
> I.e. it didn't fail the build, but in the end these new syscalls are not
> there, while with your patch, they are:

Probably in your case system headers was older than kernel you are
building so you just silently losing syscalls.

> Thanks, applied.

Thanks!

> 
> - Arnaldo
