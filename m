Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E67EC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07AB208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfF0WVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:21:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0WVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:21:07 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgclK-0001fn-2g; Fri, 28 Jun 2019 00:21:02 +0200
Date:   Fri, 28 Jun 2019 00:21:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] timekeeping: cleanup _fast_ variety of functions
In-Reply-To: <CAK8P3a3nnrm0pebbA2fx9dHYwH7vkYWuJAQVWRzzQikOkXYqcQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906280019460.32342@nanos.tec.linutronix.de>
References: <20190625081912.14813-1-Jason@zx2c4.com> <CAK8P3a3nnrm0pebbA2fx9dHYwH7vkYWuJAQVWRzzQikOkXYqcQ@mail.gmail.com>
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

On Tue, 25 Jun 2019, Arnd Bergmann wrote:
> On Tue, Jun 25, 2019 at 10:19 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > When Arnd and I discussed this prior, he thought it best that I separate
> > these two commits out into a separate patchset, because they might
> > require additional discussion or consideration from you. They seem
> > straightforward enough to me, but if deliberations require me to make
> > some tweaks, I'm happy to do so.
> 
> One concern I had was whether we want to replace 'fast' with something
> else, such as 'in_nmi' that might be less confusing.  The current naming
> might be easy to confuse between 'fast' and 'coarse'.
> 
> Another point might be whether we actually need more than one
> kind of accessor for each time domain, given how rarely these are
> used. In theory we could have the full set of combinations of fast:
> monotonic/real/boottime/raw (but not clocktai) with ktime_t/ns/seconds/ts64
> for 16 versions.  We currently have four, and you are adding another
> four, but not the final eight. I'm not saying this is wrong, but
> it feels a bit arbitrary and could use an explanation why you feel that
> is the right subset.
> 
> For coarse, we have ktime_t and ts64. The _seconds() accessors are
> coarse by definition, but we probably don't want to add _ns().
> We also don't have the combination of 'raw' with 'coarse' or 'seconds',
> as that seems to have no use case.

Can we please just add those which are actually needed. If new code misses
something we can add them anytime later.

Thanks,

	tglx
