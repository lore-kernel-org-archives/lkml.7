Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD52C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B168206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfHLRwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:52:07 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:51767 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbfHLRwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:52:06 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id B1683182D3681
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 17:42:31 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 83FA9182CF666;
        Mon, 12 Aug 2019 17:42:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: truck80_6d27145108e3b
X-Filterd-Recvd-Size: 3646
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Aug 2019 17:42:29 +0000 (UTC)
Message-ID: <b27facb8d794c58353736f88a60c24f7b2c001d7.camel@perches.com>
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Mon, 12 Aug 2019 10:42:28 -0700
In-Reply-To: <CAKwvOdmAj34xDcMUn7Fu_aXdtD-7xHjHuU20qY=rFcr_Kz7gpg@mail.gmail.com>
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
         <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
         <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
         <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
         <20190811020442.GA22736@archlinux-threadripper>
         <871efd6113ee2f6491410409511b871b7637f9e3.camel@perches.com>
         <CAKwvOdmAj34xDcMUn7Fu_aXdtD-7xHjHuU20qY=rFcr_Kz7gpg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-12 at 09:28 -0700, Nick Desaulniers wrote:
> Isn't [[fallthrough]] the C++ style attribute?

double brackets will likely at some point become the default
attribute style for c as well.  It is not now though and
linux will continue to support gcc 7+ and the __attribute__
style for quite a while.

The minimum gcc version just moved to 4.6 which was
released in 2013 so likely linux won't move to something
that requires [[<attribute>]] for a decade or more.

> **eek** Seems to be a
> waste for Clang to implement __attribute__((fallthrough)) just as we
> switch the kernel to not use it.

clang already supports the __attribute__((<foo>)) style for
gcc compatibility.

This is just clang supporting a new <foo> type which would
nominally be required for gcc compatibility anyway.

> Also, I'd recommend making the
> preprocessor define all caps to help folks recognize it's a
> preprocessor define.

It's more a matching styles thing.

I rather suspect that the c committees would choose to add
fallthrough as a keyword if it was possible, but it is not
possible without risking breaking existing code.

linux source code is not constrained by this requirement.

In my opinion, case statement blocks should always use a
terminating keyword.  I think the best option is to add
fallthrough as a keyword, but there are other options:

IMO the best option is:
	break;; goto; return; fallthrough;
or (slightly worse)
	break; goto; return; __fallthrough;
or (even worse)
	break; goto; return; FALLTHROUGH;


Generic arguments pro/con for each style:
----------------------------------------
fallthrough looks like normal code but could not be
used in uapi headers.

__fallthrough is underscore prefixed, so reserved and
generic, and could be used in uapi headers.  __fallthrough
is rather unnatural looking when used to terminate a case
statement block.

FALLTHROUGH looks like a macro, but could not be used in
uapi headers.  It is also rather unnatural looking when
used to terminate a case statement block.
----------------------------------------

There are no existing uses of fallthrough in uapi headers.


