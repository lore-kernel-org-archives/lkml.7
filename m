Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3896C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D75E21874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567147188;
	bh=7/rlq7vaiQOs31GzJFIA6k/xmE5490eBtARLEuRFq7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dG26oJ3Xedpwc6sE4zsqjtFpx4PS/g1Xd0NkDwhGPCGaP/jQ9L/+dlZuMhM5NAfNJ
	 iTuuFnGFwYVXbEl/zTgqh5alp1bJSJ6KC4qzwT25h5SkeT34uylhHkVaURcw+yqHJb
	 OEZTsS2fzgxwJtb8bL2Jh1JOROqeM8rlgoOmOmps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfH3Gjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfH3Gjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:39:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C431421726;
        Fri, 30 Aug 2019 06:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567147186;
        bh=7/rlq7vaiQOs31GzJFIA6k/xmE5490eBtARLEuRFq7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLua+rWZfK61axwTbxetb7LZfM7o5wumj8OLYbaDAq4Dbw4SnLP64ExzXhrtBV6PE
         R4xhiF3XthsZRRTmTKpxP7R+X6necCQY2PuG14kcWtklm4XHPs1zPu7SRbhEZmrmWy
         +wK//lHXUFRzZRT/AhPZ8J9iXo5HGB7ylBYjLv/4=
Date:   Fri, 30 Aug 2019 08:39:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peikan Tsai <peikantsai@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com,
        Joel Fernandes <joel@joelfernandes.org>, maco@android.com
Subject: Re: [PATCH] binder: Use kmem_cache for binder_thread
Message-ID: <20190830063943.GH15257@kroah.com>
References: <20190829054953.GA18328@mark-All-Series>
 <20190829064229.GA30423@kroah.com>
 <20190829135359.GB63638@google.com>
 <20190829152721.ttsyfwaeygmwmcu7@wittgenstein>
 <20190829185901.GA4680@mark-All-Series>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829185901.GA4680@mark-All-Series>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 02:59:01AM +0800, Peikan Tsai wrote:
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
> > 
> 
> Agree. Thanks for yours comments and suggestions.
> I'll put SLAB_HWCACHE_ALIGN it in patch v2.
> 
> > > 
> > > > Did you test your change on a system that relies on binder and find any
> > > > speed improvement or decrease, and any actual memory savings?
> > > > 
> > > > If so, can you post your results?
> > > 
> > > That's certainly worth it and I thought of asking for the same, but spoke too
> > > soon!
> > 
> > Yeah, it'd be interesting to see what difference this actually makes. 
> > 
> > Christian
> 
> I tested this change on an Android device(arm) with AOSP kernel 4.19 and
> observed
> memory usage of binder_thread. But I didn't do binder benchmark yet.
> 
> On my platform the memory usage of binder_thread reduce about 90 KB as
> the
> following result.
>         nr obj          obj size        total
> 	before: 624             512             319488 bytes
> 	after:  728             312             227136 bytes

You have more objects???

