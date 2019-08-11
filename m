Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E2AC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 03:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD4D20880
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 03:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfHKDyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 23:54:25 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:46405 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbfHKDyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 23:54:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 75143182CED2A;
        Sun, 11 Aug 2019 03:54:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: eye33_6065040b72711
X-Filterd-Recvd-Size: 2953
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 11 Aug 2019 03:54:22 +0000 (UTC)
Message-ID: <0c96ff086dc1b92034a8ca19d341f2db16cc802c.camel@perches.com>
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
From:   Joe Perches <joe@perches.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Date:   Sat, 10 Aug 2019 20:54:21 -0700
In-Reply-To: <20190811031715.GA22334@archlinux-threadripper>
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
         <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
         <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
         <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
         <20190811020442.GA22736@archlinux-threadripper>
         <871efd6113ee2f6491410409511b871b7637f9e3.camel@perches.com>
         <20190811031715.GA22334@archlinux-threadripper>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-10 at 20:17 -0700, Nathan Chancellor wrote:
> On Sat, Aug 10, 2019 at 08:06:05PM -0700, Joe Perches wrote:
> > On Sat, 2019-08-10 at 19:04 -0700, Nathan Chancellor wrote:
> > > On a tangential note, how are you planning on doing the fallthrough
> > > comment to attribute conversion? The reason I ask is clang does not
> > > support the comment annotations, meaning that when Nathan Huckleberry's
> > > patch is applied to clang (which has been accepted [1]), we are going
> > > to get slammed by the warnings. I just ran an x86 defconfig build at
> > > 296d05cb0d3c with his patch applied and I see 27673 instances of this
> > > warning... (mostly coming from some header files so nothing crazy but it
> > > will be super noisy).
> > > 
> > > If you have something to share like a script or patch, I'd be happy to
> > > test it locally.
> > > 
> > > [1]: https://reviews.llvm.org/D64838
> > 
> > Something like this patch:
> > 
> > https://lore.kernel.org/patchwork/patch/1108577/
> > 
> > Maybe use:
> > 
> > #define fallthrough [[fallthrough]]
> > 
> > if the compiler supports that notation
> > 
> 
> That patch as it stands will work with D64838, as it is adding support
> for the GNU fallthrough attribute.
> 
> However, I assume that all of the /* fall through */ comments will need
> to be converted to the attribute macro, was that going to be done with
> Coccinelle or something else?

Coccinelle doesn't support transforming comments
so I am using a perl script for those transforms
that I will post when I'm happy enough with it.



