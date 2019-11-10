Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF7EC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7542085B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 10:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573381178;
	bh=Ie+dgLqKvr2JBQVgfRGusbWY2OpfrRoyd7wBp188sT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kEXvKv+1+tVMaTkbCpOj47oxfghigmsFJ76hygtLApT+rfaaGCmUMJjUDPNf1IK6C
	 80ZrnRL/qHx4Ix2MGhDbYKafVd1AbFWi5q4AW2Y6mPOFG5ows9sxlDo19C39XQZCcP
	 qvM5Sc4DLuwk/XYLqVnBZ+JdXV9KP3ymp2/dFNpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfKJKTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 05:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfKJKTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:19:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A952F20818;
        Sun, 10 Nov 2019 10:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573381176;
        bh=Ie+dgLqKvr2JBQVgfRGusbWY2OpfrRoyd7wBp188sT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7f7Casm8USY1br1iB+NGiVA65gZGaOiJ+N/v0wwpylRWoT9Qgt92xcutTS91/eNv
         afN09lE0yMFZ1dQjHWthRYy+dryWfMBmfw9IMs00eQ4v9UxNuit3VZQr4erDAjDCT5
         AGJzy53r+QIOEbnriOS2l9TLOOW0ukAnx0d92hsc=
Date:   Sun, 10 Nov 2019 11:19:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: "statsfs" API design
Message-ID: <20191110101933.GA1442498@kroah.com>
References: <20191109184441.GA5092@avx2>
 <20191110091435.GC1435668@kroah.com>
 <20191110100913.GA5064@onstation.org>
 <20191110101418.GA1441328@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110101418.GA1441328@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 11:14:18AM +0100, Greg KH wrote:
> On Sun, Nov 10, 2019 at 05:09:13AM -0500, Brian Masney wrote:
> > On Sun, Nov 10, 2019 at 10:14:35AM +0100, Greg KH wrote:
> > > On Sat, Nov 09, 2019 at 09:44:41PM +0300, Alexey Dobriyan wrote:
> > > > > statsfs is a proposal for a new Linux kernel synthetic filesystem,
> > > > > to be mounted in /sys/kernel/stats
> > > > 
> > > > I think /proc experiment teaches pretty convincingly that dressing
> > > > things into a filesystem can be done but ultimately is a stupid idea.
> > > > It adds so much overhead for small-to-medium systems.
> > > > 
> > > > > The first user of statsfs would be KVM, which is currently exposing
> > > > > its stats in debugfs
> > > > 
> > > > > Google has KVM patches to gather statistics in a binary format
> > > > 
> > > > Which is a right thing to do.
> > > 
> > > It's always "simpler" to just take binary data and suck it in.  That
> > > works for a year or so until another value needs to be supported.  Or
> > > removed.  Or features are backported.
> > > 
> > > The reason text values in individual files work is they are "self
> > > describable" and "self discoverable".  You "know" what the value is and
> > > that it is supported because the file is there or not.  With binary
> > > values in a single file you do not know any of that.
> > > 
> > > So you need some way of describing the data to userspace in order for
> > > this to work properly over the next 20+ years.
> > > 
> > > Maybe something like varlink which describes the data coming from the
> > > kernel in an easy-to-handle format?  Or something else, but just using
> > > blobs does not work over the long-term, sorry.
> > 
> > What about using a text format like YAML? Here's some benefits:
> > 
> >   - The fields are self describing based on the key name.
> >   - New fields can be easily added without breaking compatibility.
> >   - Allows for a script to easily parse the contents while keeping
> >     human readability.
> >   - Would work for systems that run busybox as their userspace without
> >     having to install additional tools.
> >   - Allows for a nested data structure.
> 
> varlink was created to solve the issues that people have had with YAML
> over time, so you might want to look into that :)
> 	https://varlink.org/

Well, varlink really is JSON, but at least there's example code for
userspace and kernelspace to pull from to knock up tests for people who
want to look into it.

thanks,

greg k-h
