Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0B8C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3083B2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfGLHGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:06:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42874 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfGLHGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:06:54 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlpdh-0000a5-6M; Fri, 12 Jul 2019 09:06:41 +0200
Date:   Fri, 12 Jul 2019 09:06:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Gal Pressman <galpress@amazon.com>,
        Allison Randal <allison@lohutok.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scatterlist: Allocate a contiguous array instead of
 chaining
In-Reply-To: <20190712065613.GA3036@ming.t460p>
Message-ID: <alpine.DEB.2.21.1907120901190.11639@nanos.tec.linutronix.de>
References: <20190712063657.17088-1-sultan@kerneltoast.com> <20190712065613.GA3036@ming.t460p>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019, Ming Lei wrote:
> On Thu, Jul 11, 2019 at 11:36:56PM -0700, Sultan Alsawaf wrote:
> > From: Sultan Alsawaf <sultan@kerneltoast.com>
> > 
> > Typically, drivers allocate sg lists of sizes up to a few MiB in size.
> > The current algorithm deals with large sg lists by splitting them into
> > several smaller arrays and chaining them together. But if the sg list
> > allocation is large, and we know the size ahead of time, sg chaining is
> > both inefficient and unnecessary.
> > 
> > Rather than calling kmalloc hundreds of times in a loop for chaining
> > tiny arrays, we can simply do it all at once with kvmalloc, which has
> > the proper tradeoff on when to stop using kmalloc and instead use
> > vmalloc.
> 
> vmalloc() may sleep, so it is impossible to be called in atomic context.

Allocations from atomic context should be avoided wherever possible and you
really have to have a very convincing argument why an atomic allocation is
absolutely necessary. I cleaned up quite some GFP_ATOMIC users over the
last couple of years and all of them were doing it for the very wrong
reasons and mostly just to silence the warning which is triggered with
GFP_KERNEL when called from a non-sleepable context.

So I suggest to audit all call sites first and figure out whether they
really must use GFP_ATOMIC and if possible clean them up, remove the GFP
argument and then do the vmalloc thing on top.

Thanks,

	tglx
