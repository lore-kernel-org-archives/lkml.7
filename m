Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343A5C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8B920869
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="DZzvnqcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfKJKJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 05:09:15 -0500
Received: from onstation.org ([52.200.56.107]:40598 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfKJKJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:09:14 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id E3F2B3E953;
        Sun, 10 Nov 2019 10:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1573380554;
        bh=tZRQ63Y3L1MwJPdKlkwcnVT/yKu4ORB6C4tSAe1YhkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZzvnqcN6fru0pg4LVSvX5YZ/MRTw8jUQg8DfOjutNhK6VvhSdWQhbIjnCPl+jB1R
         XbmP8Bc3OxPWJL2HHTFVhzug/FI43ej6hMU7amAoJsX0ZYgWR2gLVS5norh9glQitv
         fENBU9WHvc1Qvex6KFRWjgXdv1bO0Yqgk5zPtHqI=
Date:   Sun, 10 Nov 2019 05:09:13 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: "statsfs" API design
Message-ID: <20191110100913.GA5064@onstation.org>
References: <20191109184441.GA5092@avx2>
 <20191110091435.GC1435668@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110091435.GC1435668@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 10:14:35AM +0100, Greg KH wrote:
> On Sat, Nov 09, 2019 at 09:44:41PM +0300, Alexey Dobriyan wrote:
> > > statsfs is a proposal for a new Linux kernel synthetic filesystem,
> > > to be mounted in /sys/kernel/stats
> > 
> > I think /proc experiment teaches pretty convincingly that dressing
> > things into a filesystem can be done but ultimately is a stupid idea.
> > It adds so much overhead for small-to-medium systems.
> > 
> > > The first user of statsfs would be KVM, which is currently exposing
> > > its stats in debugfs
> > 
> > > Google has KVM patches to gather statistics in a binary format
> > 
> > Which is a right thing to do.
> 
> It's always "simpler" to just take binary data and suck it in.  That
> works for a year or so until another value needs to be supported.  Or
> removed.  Or features are backported.
> 
> The reason text values in individual files work is they are "self
> describable" and "self discoverable".  You "know" what the value is and
> that it is supported because the file is there or not.  With binary
> values in a single file you do not know any of that.
> 
> So you need some way of describing the data to userspace in order for
> this to work properly over the next 20+ years.
> 
> Maybe something like varlink which describes the data coming from the
> kernel in an easy-to-handle format?  Or something else, but just using
> blobs does not work over the long-term, sorry.

What about using a text format like YAML? Here's some benefits:

  - The fields are self describing based on the key name.
  - New fields can be easily added without breaking compatibility.
  - Allows for a script to easily parse the contents while keeping
    human readability.
  - Would work for systems that run busybox as their userspace without
    having to install additional tools.
  - Allows for a nested data structure.

The downside is that the output would be larger than a binary interface
but it's more maintainable in my opinion.

Brian
