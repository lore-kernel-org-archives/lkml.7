Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E9AC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 04:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1A6217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 04:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfHJEUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 00:20:53 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:57877 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbfHJEUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 00:20:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 29E67181D33FB;
        Sat, 10 Aug 2019 04:20:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: vest68_7baf73a3d031c
X-Filterd-Recvd-Size: 2960
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 10 Aug 2019 04:20:49 +0000 (UTC)
Message-ID: <667995275e6a1cbcdaa93029c1b33e6b52fc6803.camel@perches.com>
Subject: Re: [PATCH] sh: Drop -Werror from kernel Makefile
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 09 Aug 2019 21:20:48 -0700
In-Reply-To: <6a06245f-33f2-1d92-0d0e-c8b270dc24af@embeddedor.com>
References: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
         <20190805032441.GO9017@brightrain.aerifal.cx>
         <20190809195630.GA15606@roeck-us.net>
         <5f26547f-b48e-4b9f-b8ef-858283915e3d@embeddedor.com>
         <20190809215608.GA11065@roeck-us.net>
         <6a06245f-33f2-1d92-0d0e-c8b270dc24af@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-09 at 21:47 -0500, Gustavo A. R. Silva wrote:
> On 8/9/19 4:56 PM, Guenter Roeck wrote:
> > On Fri, Aug 09, 2019 at 04:36:01PM -0500, Gustavo A. R. Silva wrote:
> > > On 8/9/19 2:56 PM, Guenter Roeck wrote:
> > > > On Sun, Aug 04, 2019 at 11:24:41PM -0400, Rich Felker wrote:
> > > > > On Sun, Aug 04, 2019 at 07:14:23PM -0700, Guenter Roeck wrote:
> > > > > > Since commit a035d552a93b ("Makefile: Globally enable fall-through
> > > > > > warning"), all sh builds fail with errors such as
> > > > > > 
> > > > > > arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
> > > > > > arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
> > > > > > 
> > > > > > Since this effectively disables all build and boot tests for the
> > > > > > architecture, let's drop -Werror from the sh kernel Makefile until
> > > > > > the problems are fixed.
[]
> On second thought it seems to me that this is not a good idea, at least
> for mainline. For the time being I'll take this patch for linux-next only.
> 
> Who is the maintainer of sh?

But whoever it may be, isn't particularly active.

MAINTAINERS-SUPERH
MAINTAINERS-M:  Yoshinori Sato <ysato@users.sourceforge.jp>
MAINTAINERS-M:  Rich Felker <dalias@libc.org>
MAINTAINERS-L:  linux-sh@vger.kernel.org
MAINTAINERS-Q:  http://patchwork.kernel.org/project/linux-sh/list/
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  Documentation/sh/
MAINTAINERS:F:  arch/sh/
MAINTAINERS-F:  drivers/sh/

> The best solution is to fix those fall-through warnings you see. Could you
> please send me all the warnings you see? I can try to fix them.

It's true it's a warning, but adding -Werror is rarely
a good idea as gcc error output can change with every
version.


