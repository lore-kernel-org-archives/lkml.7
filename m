Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEA6C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8483A2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfGYNXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:23:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:43593 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfGYNXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:23:02 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6PDMX5o003118;
        Thu, 25 Jul 2019 08:22:34 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x6PDMWpp003114;
        Thu, 25 Jul 2019 08:22:32 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 25 Jul 2019 08:22:32 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
Message-ID: <20190725132232.GQ20882@gate.crashing.org>
References: <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr> <20190709064952.GA40851@archlinux-threadripper> <20190719032456.GA14108@archlinux-threadripper> <20190719152303.GA20882@gate.crashing.org> <20190719160455.GA12420@archlinux-threadripper> <20190721075846.GA97701@archlinux-threadripper> <20190721180150.GN20882@gate.crashing.org> <87imru74ul.fsf@concordia.ellerman.id.au> <20190722151801.GC20882@gate.crashing.org> <875znt7izy.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875znt7izy.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 09:21:53AM +1000, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> >> can use both RA and RB to compute the address, rather than us forcing RA
> >> to 0.
> >> 
> >> But at least with my compiler here (GCC 8 vintage) I don't actually see
> >> GCC ever using both GPRs even with the patch. Or at least, there's no
> >> difference before/after the patch as far as I can see.
> >
> > The benefit is small, certainly.
> 
> Zero is small, but I guess some things are smaller? :P

Heh.  0 out of 12 is small.

It actually is quite easy to do trigger the macros to generate two-reg
dcb* instructions; but all the places where that is especially useful,
in loops for example, already use hand-written assembler code (and yes,
using two-reg forms).

You probably will not want to write those routines as plain C ever
given how important those are for performance (memset, clear-a-page),
so the dcb* macros won't ever be very hot, oh well.

> >> So my inclination is to revert the original patch. We can try again in a
> >> few years :D
> >> 
> >> Thoughts?
> >
> > I think you should give the clang people time to figure out what is
> > going on.
> 
> Yeah fair enough, will wait and see what their diagnosis is.

Thanks!


Segher
