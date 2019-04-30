Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF69C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D814D2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfD3RER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:04:17 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:32848 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfD3RER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:04:17 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1hLWAm-0000Av-00; Tue, 30 Apr 2019 17:04:04 +0000
Date:   Tue, 30 Apr 2019 13:04:04 -0400
From:   Rich Felker <dalias@libc.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "devel@uclibc-ng.org" <devel@uclibc-ng.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Detecting libc in perf (was Re: perf tools build broken after
 v5.1-rc1)
Message-ID: <20190430170404.GX23599@brightrain.aerifal.cx>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <20190425214800.GC21829@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2505837@us01wembx1.internal.synopsys.com>
 <20190430011818.GE7857@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A250601B@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A250601B@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 03:53:18PM +0000, Vineet Gupta wrote:
> On 4/29/19 6:18 PM, Arnaldo Carvalho de Melo wrote:
> >>> Auto-detecting system features:
> >>> ...                         dwarf: [ OFF ]
> >>> ...            dwarf_getlocations: [ OFF ]
> >>> ...                         glibc: [ on  ]
> >> Not related to current issue, this run uses a uClibc toolchain and yet it is
> >> detecting glibc - doesn't seem right to me.
> > Ok, I'll improve that, I think it just tries to detect a libc, yeah,
> > see:
> >
> > [acme@quaco linux]$ cat tools/build/feature/test-glibc.c
> > // SPDX-License-Identifier: GPL-2.0
> > #include <stdlib.h>
> >
> > #if !defined(__UCLIBC__)
> > #include <gnu/libc-version.h>
> > #else
> > #define XSTR(s) STR(s)
> > #define STR(s) #s
> > #endif
> >
> > int main(void)
> > {
> > #if !defined(__UCLIBC__)
> > 	const char *version = gnu_get_libc_version();
> > #else
> > 	const char *version = XSTR(__GLIBC__) "." XSTR(__GLIBC_MINOR__);
> > #endif
> >
> > 	return (long)version;
> > }
> > [acme@quaco linux]$
> >
> > [perfbuilder@59ca4b424ded /]$ grep __GLIBC__ /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/*.h
> > /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/features.h:   The macros `__GNU_LIBRARY__', `__GLIBC__', and `__GLIBC_MINOR__' are
> > /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/features.h:#define	__GLIBC__	2
> > /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/features.h:	((__GLIBC__ << 16) + __GLIBC_MINOR__ >= ((maj) << 16) + (min))
> > [perfbuilder@59ca4b424ded /]$
> >
> > Isn't that part of uClibc?
> 
> Right you are. Per the big fat comment right above that code, this gross hack in
> uclibc is unavoidable as applications tend to rely on that define.
> So a better fix would be to check for various !GLIBC libs explicitly.
> 
> #ifdef __UCLIBC__
> 
> #elseif defined __MUSL__
> 
> ....
> 
> Not pretty from app usage pov, but that seems to be the only sane way of doing it.

What are you trying to achieve? I was just CC'd and I'm missing the
context.

Rich
