Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51337C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF8E21897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfH3MOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:14:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51897 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfH3MOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:14:41 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1i3flt-0003iW-0H; Fri, 30 Aug 2019 12:12:53 +0000
Date:   Fri, 30 Aug 2019 14:12:52 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Peikan Tsai <peikantsai@gmail.com>, arve@android.com,
        tkjos@android.com, maco@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Use kmem_cache for binder_thread
Message-ID: <20190830121251.rvdhohyykekhh25r@wittgenstein>
References: <20190829054953.GA18328@mark-All-Series>
 <20190829064229.GA30423@kroah.com>
 <20190829135359.GB63638@google.com>
 <20190829152721.ttsyfwaeygmwmcu7@wittgenstein>
 <20190830063851.GG15257@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190830063851.GG15257@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 08:38:51AM +0200, Greg KH wrote:
> On Thu, Aug 29, 2019 at 05:27:22PM +0200, Christian Brauner wrote:
> > On Thu, Aug 29, 2019 at 09:53:59AM -0400, Joel Fernandes wrote:
> > > On Thu, Aug 29, 2019 at 08:42:29AM +0200, Greg KH wrote:
> > > > On Thu, Aug 29, 2019 at 01:49:53PM +0800, Peikan Tsai wrote:
> > > [snip] 
> > > > > The allocated size for each binder_thread is 512 bytes by kzalloc.
> > > > > Because the size of binder_thread is fixed and it's only 304 bytes.
> > > > > It will save 208 bytes per binder_thread when use create a kmem_cache
> > > > > for the binder_thread.
> > > > 
> > > > Are you _sure_ it really will save that much memory?  You want to do
> > > > allocations based on a nice alignment for lots of good reasons,
> > > > especially for something that needs quick accesses.
> > > 
> > > Alignment can be done for slab allocations, kmem_cache_create() takes an
> > > align argument. I am not sure what the default alignment of objects is
> > > though (probably no default alignment). What is an optimal alignment in your
> > > view?
> > 
> > Probably SLAB_HWCACHE_ALIGN would make most sense.
> 
> This isn't memory accessing hardware, so I don't think it would, right?

I was more thinking of cacheline bouncing under contention. But maybe
that's not worth it in this case...
