Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD1C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55582054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEFOVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:21:37 -0400
Received: from mail5.windriver.com ([192.103.53.11]:34068 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfEFOVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:21:37 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x46EKWH9001979
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 6 May 2019 07:20:43 -0700
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 May 2019 07:20:11 -0700
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 06B1B2E063C; Mon,  6 May 2019 10:20:10 -0400 (EDT)
Date:   Mon, 6 May 2019 10:20:10 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: Fwd: linux-next: build failure after merge of the kbuild tree
Message-ID: <20190506142010.GC2649@windriver.com>
References: <20190506094609.08e930f2@canb.auug.org.au>
 <CAK7LNASH4CuVBjfEJsT+aBx4aLrj9j2=aOD3B4f9+Tdcm=x2pg@mail.gmail.com>
 <20190506033151.GB2649@windriver.com>
 <CAK7LNAS=D96B_OgnRu-NK0-G+y8itvhe3qvwfYxZUCSqdC0gEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK7LNAS=D96B_OgnRu-NK0-G+y8itvhe3qvwfYxZUCSqdC0gEA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: Fwd: linux-next: build failure after merge of the kbuild tree] On 06/05/2019 (Mon 21:07) Masahiro Yamada wrote:

> Hi Paul,
> 
> 
> On Mon, May 6, 2019 at 12:34 PM Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> >
> > [Fwd: linux-next: build failure after merge of the kbuild tree] On 06/05/2019 (Mon 11:19) Masahiro Yamada wrote:
> >
> > > Hi Paul,
> > >
> > > In today's linux-next build testing,
> > > more "make ... explicitly non-modular"
> > > candidates showed up.
> > >
> >
> > Hi Masahiro,
> >
> > I am not 100% clear on what you are asking me.  There are lots and lots
> > of these in the kernel.... many fixed, and many remain unfortunately.
> >
> > > arch/arm/plat-omap/dma.c
> > > drivers/clocksource/timer-ti-dm.c
> > > drivers/mfd/omap-usb-host.c
> > > drivers/mfd/omap-usb-tll.c
> >
> > None of these are "new".  I just checked, and I have had patches for all
> > these for a long time, in my personal queue, found by my audits.
> 
> 
> OK, I saw many patches from you
> addressing this issue,
> so I just thought you might be motivated to
> fix them.
> 
> Anyway, I have a reason to fix them
> because a patch in my tree is causing build errors.

I understand now.  I missed the connection between these drivers and the
Kbuild change when I read this last night.  Sorry about that.

I can send the changes to those four files, but since I can't guarantee
they will be merged quickly (or at all!) - that will leave the commit in
the Kbuild tree causing build regressions for days or likely even weeks.

> So, I will do something for them
> if you do not have a plan to send patches soon.

I will be happy to send them, but we just opened the two week merge
window, and a lot of maintainers don't like getting sent new patches
until the two week merge window has closed - so we should avoid that.

I'm not sure how you would like to proceed - one way would be that we
get the drivers above changed in 5.2 and you delay your kbuild change
until we start v5.3 - to that end I'd be happy to add the Kbuild change
to my internal build testing in the meantime, if you would like.

Now that I understand the problem, let me know what you would like to
do, and I'll do what I can to help out.

Thanks,
Paul.
