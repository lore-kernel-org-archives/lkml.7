Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD392ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F380206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbfJNTMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:12:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:48079 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732490AbfJNTMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:12:06 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9EJBhSD000977;
        Mon, 14 Oct 2019 14:11:43 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x9EJBgBM000976;
        Mon, 14 Oct 2019 14:11:42 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 14 Oct 2019 14:11:41 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] powerpc/prom_init: Use -ffreestanding to avoid a reference to bcmp
Message-ID: <20191014191141.GK28442@gate.crashing.org>
References: <20190911182049.77853-1-natechancellor@gmail.com> <20191014025101.18567-1-natechancellor@gmail.com> <20191014025101.18567-4-natechancellor@gmail.com> <20191014093501.GE28442@gate.crashing.org> <CAKwvOdmcUT2A9FG0JD9jd0s=gAavRc_h+RLG6O3mBz4P1FfF8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmcUT2A9FG0JD9jd0s=gAavRc_h+RLG6O3mBz4P1FfF8w@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 08:56:12AM -0700, Nick Desaulniers wrote:
> On Mon, Oct 14, 2019 at 2:35 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > On Sun, Oct 13, 2019 at 07:51:01PM -0700, Nathan Chancellor wrote:
> > > r374662 gives LLVM the ability to convert certain loops into a reference
> > > to bcmp as an optimization; this breaks prom_init_check.sh:
> >
> > When/why does LLVM think this is okay?  This function has been removed
> > from POSIX over a decade ago (and before that it always was marked as
> > legacy).
> 
> Segher, do you have links for any of the above? If so, that would be
> helpful to me.

Sure!

https://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xsh_chap03.html

Older versions are harder to find online, unfortunately.  But there is

https://kernel.org/pub/linux/docs/man-pages/man-pages-posix/

in which man3p/bcmp.3p says:

FUTURE DIRECTIONS
       This function may be withdrawn in a future version.

Finally, the Linux man pages say (man bcmp):

CONFORMING TO
       4.3BSD.   This  function   is   deprecated   (marked   as   LEGACY   in
       POSIX.1-2001): use memcmp(3) in new programs.  POSIX.1-2008 removes the
       specification of bcmp().


> I'm arguing against certain transforms that assume that
> one library function is faster than another, when such claims are
> based on measurements from one stdlib implementation.

Wow.  The difference between memcmp and bcmp is trivial (just the return
value is different, and that costs hardly anything to add).  And memcmp
is guaranteed to exist since C89/C90 at least.

> The rationale for why it was added was that memcmp takes a measurable
> amount of time in Google's fleet, and most calls to memcmp don't care
> about the position of the mismatch; bcmp is lower overhead (or at
> least for our libc implementation, not sure about others).

You just have to do the read of the last words you compare as big-endian,
and then you can just subtract the two words, convert that to "int" (which
is very inconvenient to do, but hardly expensive), and there you go.

Or on x86 use the bswap insn, or something like it.

Or, if you use GCC, it has __builtin_memcmp but also __builtin_memcmp_eq,
and those are automatically used, too.


Segher
