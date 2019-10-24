Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7DACA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96F121A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfJXU5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:57:21 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:46311
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727924AbfJXU5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:57:21 -0400
X-IronPort-AV: E=Sophos;i="5.68,226,1569276000"; 
   d="scan'208";a="324196663"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 22:57:18 +0200
Date:   Thu, 24 Oct 2019 22:57:18 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Paul Burton <paulburton@kernel.org>
cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        gregkh@linuxfoundation.org, outreachy-kernel@googlegroups.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH v2 1/5] staging: octeon: remove
 typedef declaration for cvmx_wqe
In-Reply-To: <20191024205420.u7z3bhcjgetsyh3w@lantea.localdomain>
Message-ID: <alpine.DEB.2.21.1910242255290.2621@hadrien>
References: <cover.1570821661.git.wambui.karugax@gmail.com> <fa82104ea8d7ff54dc66bfbfedb6cca541701991.1570821661.git.wambui.karugax@gmail.com> <20191024050011.2ziewy6dkxkcxzvo@lantea.localdomain> <alpine.DEB.2.21.1910240722070.2771@hadrien>
 <20191024100020.GA13343@wambui> <20191024205420.u7z3bhcjgetsyh3w@lantea.localdomain>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Oct 2019, Paul Burton wrote:

> Hi Wambui, Julia,
>
> Side-note: Wambui, your mail client seems to have added this header:
>
>   Reply-To: alpine.DEB.2.21.1910240722070.2771@hadrien
>
> This is the ID of the message you replied to (ie. this is the same value
> that the In-Reply-To: header has). You should probably figure out how
> that happened, or you're going to miss responses when people reply
> without noticing the bogus email address.

This is somehow related to me...  I don't know if the problem comes from
me or from Wambui.

julia

>
> On Thu, Oct 24, 2019 at 01:00:20PM +0300, Wambui Karuga wrote:
> > On Thu, Oct 24, 2019 at 07:26:59AM +0200, Julia Lawall wrote:
> > > > If you're making significant changes to this driver, please test them
> > > > using the MIPS cavium_octeon_defconfig which is where this driver is
> > > > actually used.
> > > >
> > > > This driver has broken builds a few times recently which makes me very
> > > > tempted to ask that we stop allowing it to be built with COMPILE_TEST.
> > > > The whole octeon-stubs.h thing is a horrible hack anyway...
> > >
> > > Wambui,
> > >
> > > Please figure out what went wrong here.  Are there two sets of typedefs
> > > that should have been updated?
> > >
> > I managed to reproduce these build errors and finally noticed that the
> > "octeon-stubs.h" header is only included when CONFIG_CAVIUM_OCTEON_SOC
> > is not defined, therefore compiling properly for COMPILE_TEST but will
> > actually fail when compiled with CONFIG_CAVIUM_OCTEON_SOC is set since
> > the functions will try to use the definitions in
> > arch/mips/include/asm/octeon/ that don't have the changes.
> >
> > Paul, please tell me if this is correct?
>
> Yes, that's correct. The driver was written to use the headers in
> arch/mips/include/asm/octeon, and then recently the octeon-stubs.h
> header was added which duplicates lots of the MIPS & Octeon-specific
> header content in one huge monstrous file.
>
> I'm all for improving compile test coverage, but I think octeon-stubs.h
> in its short life has already proven itself to be a bad way to achieve
> that goal[1][2][3].
>
> > > Others,
> > >
> > > Would it be reasonable to put the information about how the driver should
> > > be compied in the TODO file?  git grep cavium_octeon_defconfig in the
> > > octeon directory turns up nothing.
>
> It wouldn't hurt. I'd argue that Kconfig already provides enough
> information to figure this out easily though - OCTEON_ETHERNET depends
> on CAVIUM_OCTEON_SOC || COMPILE_TEST, which ought to tell people that
> its real use is when CAVIUM_OCTEON_SOC=y. That doesn't necessarily point
> you to cavium_octeon_defconfig (though grepping for CAVIUM_OCTEON_SOC=y
> would), but that's not strictly needed anyway - any old config with
> CAVIUM_OCTEON_SOC=y would do.
>
> Thanks,
>     Paul
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0228ecf6128c92b47eadd2ac270c5574d9150c09
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/staging/octeon?id=17a29fea086ba18b000d28439bd5cb4f2b0a527b
> [3] https://storage.kernelci.org/next/master/next-20191024/mips/cavium_octeon_defconfig/gcc-8/build.log
>
