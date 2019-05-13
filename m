Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C24C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE26208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfEMPv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:51:26 -0400
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:43016 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727983AbfEMPvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:51:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B7749100E86CA;
        Mon, 13 May 2019 15:51:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paste52_62f1a3945021d
X-Filterd-Recvd-Size: 2483
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 May 2019 15:51:19 +0000 (UTC)
Message-ID: <a28b0616aca51aed38fd99fb85632628e6fd8d60.camel@perches.com>
Subject: Re: [Proposal] end of file checks by checkpatch.pl
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Mon, 13 May 2019 08:51:18 -0700
In-Reply-To: <CAK7LNAQxsUheo2dHn5E=4ACafcYL9zNubgiVkJkANuZkx2RgpA@mail.gmail.com>
References: <CAK7LNAR5j1ygbq9TLqUhbJ+tkMdrtD3BgQoUWZErUrnEoWKYMw@mail.gmail.com>
         <b5e2a4d9eb49290d6dc3449c90cdf07797b1aba6.camel@perches.com>
         <CAK7LNAQxsUheo2dHn5E=4ACafcYL9zNubgiVkJkANuZkx2RgpA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-13 at 19:11 +0900, Masahiro Yamada wrote:
> Hi Joe,

Hello again.

> On Fri, May 10, 2019 at 2:20 AM Joe Perches <joe@perches.com> wrote:
> > On Fri, 2019-05-10 at 00:27 +0900, Masahiro Yamada wrote:
> > > Does it make sense to check the following
> > > by checkpatch.pl ?
> > > [1] blank line at end of file
> > > [2] no new line at end of file
> > 
> > I'm pretty sure checkpatch does one this already.
[]
> Looks like the report depends on the file type.
> 
> scripts/checkpatch.pl  -f  arch/sparc/lib/NG4clear_page.S
> scripts/checkpatch.pl  -f  tools/power/cpupower/bench/cpufreq-bench_plot.sh
> 
> reported it, but
> 
> scripts/checkpatch.pl  -f  drivers/media/dvb-frontends/cxd2880/Kconfig
> scripts/checkpatch.pl  -f  drivers/parport/Makefile
> 
> did not.

Yes, this check is after a test for filename extension.

Currently the only file types it reports as missing an EOF
newline are done on files with the following extensions:

	.h
	.c
	.s
	.S
	.sh
	.dtsi
	.dts

So the existing test is not done on many file types.
The same file types are used for the proposed patch.

It's possible to have the existing missing newline at EOF
test and the proposed test for a blank line at EOF to be
done on all file types.

Is this reasonable or could it cause some other issue
for any other file types?  Should _any_ file extension
be excluded?

I believe not, but perhaps it's best to ask.


