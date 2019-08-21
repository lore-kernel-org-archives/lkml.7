Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57871C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EF42087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfHUAUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:20:48 -0400
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:55756 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726215AbfHUAUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:20:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 3D9DE181D33FC;
        Wed, 21 Aug 2019 00:20:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crush78_7af148c290837
X-Filterd-Recvd-Size: 3059
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Aug 2019 00:20:44 +0000 (UTC)
Message-ID: <edd8efd53fadd07992f804cc595c6ae5fdb60e73.camel@perches.com>
Subject: Re: rfc: treewide scripted patch mechanism? (was: Re: [PATCH]
 Makefile: Convert -Wimplicit-fallthrough=3 to just -Wimplicit-fallthrough
 for clang)QUILT
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Tue, 20 Aug 2019 17:20:43 -0700
In-Reply-To: <CAHk-=wgqQKoAnhmhGE-2PBFt7oQs9LLAATKbYa573UO=DPBE0Q@mail.gmail.com>
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
         <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
         <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
         <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
         <4398924f28a58fca296d101dae11e7accce80656.camel@perches.com>
         <ad42da450ccafcb571cca9289dcf52840dbb53d3.camel@perches.com>
         <20190820092451.791c85e5@canb.auug.org.au>
         <14723fccc2c3362cc045df17fc8554f37c8a8529.camel@perches.com>
         <CAHk-=wgqQKoAnhmhGE-2PBFt7oQs9LLAATKbYa573UO=DPBE0Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 16:28 -0700, Linus Torvalds wrote:
> On Mon, Aug 19, 2019 at 5:08 PM Joe Perches <joe@perches.com> wrote:
> > 2: would be Julia Lawall's stracpy change done
> > with coccinelle: (attached)
> 
> I'm not actually convinced about stracpy() and friends.
> 
> It seems to be yet another badly thought out string interface, and
> there are now so many of them that no human being can keep track of
> them.
> 
> The "badly thought out" part is that it (like the original strlcpy
> garbage from BSD) thinks that there is only one size that matters -
> the destination.
> 
> Yes, we fixed part of the "source is also limited" with strscpy(). It
> didn't fix the problem with different size limits, but at least it
> fixed the fundamentally broken assumption that the source has no size
> limit at all.

Umm, btw: have you actually looked at stracpy?

It's just a convenience wrapper around strscpy
and dest must be a char array and its size
does not need to be specified as a somewhat
useless argument otherwise prone to misuse.

#define stracpy(dest, src)						\
({									\
	size_t count = ARRAY_SIZE(dest);				\
	BUILD_BUG_ON(!(__same_type(dest, char[]) ||			\
		       __same_type(dest, unsigned char[]) ||		\
		       __same_type(dest, signed char[])));		\
									\
	strscpy(dest, src, count);					\
})

I sent several patches for those misuses.

