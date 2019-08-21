Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24608C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F9822D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfHUA6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:58:32 -0400
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:60035 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbfHUA6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:58:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id F224E18011250;
        Wed, 21 Aug 2019 00:58:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: month89_fcc67fbeb43c
X-Filterd-Recvd-Size: 3518
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Aug 2019 00:58:28 +0000 (UTC)
Message-ID: <b77a3752d9b9897b8e65003ad88991b18ee33029.camel@perches.com>
Subject: stracpy
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Tue, 20 Aug 2019 17:58:27 -0700
In-Reply-To: <CAHk-=wg8vLmmwTGhXM51NpSWJW8RFEAKoXxG0Hu_Q9Uwbjj8kw@mail.gmail.com>
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
         <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
         <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
         <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
         <4398924f28a58fca296d101dae11e7accce80656.camel@perches.com>
         <ad42da450ccafcb571cca9289dcf52840dbb53d3.camel@perches.com>
         <20190820092451.791c85e5@canb.auug.org.au>
         <14723fccc2c3362cc045df17fc8554f37c8a8529.camel@perches.com>
         <CAHk-=wgqQKoAnhmhGE-2PBFt7oQs9LLAATKbYa573UO=DPBE0Q@mail.gmail.com>
         <edd8efd53fadd07992f804cc595c6ae5fdb60e73.camel@perches.com>
         <CAHk-=wg8vLmmwTGhXM51NpSWJW8RFEAKoXxG0Hu_Q9Uwbjj8kw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 17:43 -0700, Linus Torvalds wrote:
> On Tue, Aug 20, 2019 at 5:20 PM Joe Perches <joe@perches.com> wrote:
> > Umm, btw: have you actually looked at stracpy?
> 
> Yes, Joe, I have.
> 
> What part of "there are now so many of them that no human being can
> keep track of them" didn't you see as a problem?

Well, the actual post-conversion uses to stracpy make the old ones
(strcpy/strlcpy/strncpy) exceptional uses that can be analyzed
quite a bit more easily.

btw: I really don't care what any convenience macro is named.

Most all of the strlcpy and strscpy uses actually _do_ copy to
a char array and strscpy is a simple interface that is somewhat
frequently misused.

> How many broken string functions are we going to do, adding yet
> another one when you notice that the _last_ one wasn't great?
>
> We never seem to remove the broken ones. We just add yet another one,
> and have a never-ending jumble of random letters.

<shrug> Intermediate problems.

> I would seriously suggest doing something like
>  and 
>    copy_string( dst, dstsize, src, srcsize, FLAGS );
> 
> where FLAGS migth be "pad" or whatever. Make it return the size of the
> resulting string, because while it can be convenient to pass 'dst" on,
> it's not useful.

That's simply not convenient for pointers.

Auditing the kernel for those unsized uses is a
large scope problem.  Even anything that uses
PAGE_SIZE sized allocations does sprintf
instead of snprintf.  Any show_<foo> for instance.

> And then maybe just add the helper macro that turns an array into a
> "pointer, size" combination, rather than yet another letter jumble.

Good luck with that when an unsized char pointer is the thing
passed to a function.

There are _way_ too many of those already in the kernel.
Simple strcpy is already used > 2000 times.



