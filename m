Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E345C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3033249DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfFDMFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:05:00 -0400
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:44039 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727250AbfFDME7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:04:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 6F9BE100E86D1;
        Tue,  4 Jun 2019 12:04:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: class59_827f50f7dee18
X-Filterd-Recvd-Size: 2744
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue,  4 Jun 2019 12:04:56 +0000 (UTC)
Message-ID: <2674b675063812e7c422a7964afdef6b7c712e4b.camel@perches.com>
Subject: Re: [PATCH] media: do not use C++ style comments in uapi headers
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 04 Jun 2019 05:04:55 -0700
In-Reply-To: <CAK7LNAR9iz8_wvybmrVFqDaiP3bzxjQ18EUwkvC1LMjR96WWag@mail.gmail.com>
References: <20190604111334.22182-1-yamada.masahiro@socionext.com>
         <8cf48e20064eabdfe150795365e6ca6f36032e9f.camel@perches.com>
         <CAK7LNAR9iz8_wvybmrVFqDaiP3bzxjQ18EUwkvC1LMjR96WWag@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-04 at 20:48 +0900, Masahiro Yamada wrote:
> On Tue, Jun 4, 2019 at 8:24 PM Joe Perches <joe@perches.com> wrote:
> > On Tue, 2019-06-04 at 20:13 +0900, Masahiro Yamada wrote:
> > > On the other hand, uapi headers are written in more strict C, where
> > > the C++ comment style is forbidden.
> > 
> > Is this a real problem for any toolchain?
> 
> I was waiting for this comment!
> 
> Which standard should UAPI headers follow?
> Is it defined somewhere?
> 
> If there is no rule, is it up to subsystem maintainers?
> 
> We have a certain of unknowledge in user-space,
> I do not know it it is a real problem.
> 
> Actually, this patch is related to this thread:
> https://lkml.org/lkml/2019/5/22/1441
> 
> Thomas and you agreed
> // should be avoided for SPDX tags in UAPI headers.

If it's really a generic issue, I think there are more
uses of // comments in uapi files.

$ git grep '//' include/uapi/ | grep -vP '(http://|https://|ftp:/)' | wc -l
101

> So, I just thought C99 was forbidden for user-space.

No idea, I just believe if it's really a problem
it likely would have been reported already.

> If C89/C90 is already fantasy,
> let's clearly say "Kernel requires C99 for user-space",
> and use // everywhere for SPDX tags?

OK by me.

I have a checkpatch patch waiting to submit to remove the
requirement to use the /* */ comment style in .h files.

The docs need to be updated too.

cheers, Joe

