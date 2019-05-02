Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930FAC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5308020873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556781574;
	bh=BkSh3FIMwtQhnHhI9uVzzrmkVqCsaczpGUTBFako1F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gyJwdrAEtEwsNwrfxsSkeeg3d1dDhEDVqwzTdFSjECWV5fOCe/Uk9V7b5Vyg6SxYI
	 LyM1EoEctBU6iQBSXIL8/meGytJocDALAA/h9LW5KC83Ran2iGWXYivKuymWYDdoGj
	 MIYMIYclX4zd+HC78BbzLIWnA45JGDXA1MkzbiCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfEBHTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfEBHTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:19:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EE5A2085A;
        Thu,  2 May 2019 07:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556781571;
        bh=BkSh3FIMwtQhnHhI9uVzzrmkVqCsaczpGUTBFako1F0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDNXVSmG9ZZmNQhafwrMk+Wouh+FE5BDIAFxhOWExL/pCWm6dq9krH1gbEiSXb7A1
         1bL9WQ4VZSFJhHxZlZdSgaywgcspow1qvXMwjI4uOhusMBmPMtiy3J8N3tPU85NFtJ
         XRRBQp/bdA2OR1Vd8SMYFox0hvPDI4RD6VBRNc3I=
Date:   Thu, 2 May 2019 09:19:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kobject_init_and_add() confusion
Message-ID: <20190502071929.GD16247@kroah.com>
References: <20190430233803.GB10777@eros.localdomain>
 <20190501111022.GA15959@kroah.com>
 <20190501215858.GE18827@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501215858.GE18827@eros.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 07:58:58AM +1000, Tobin C. Harding wrote:
> On Wed, May 01, 2019 at 01:10:22PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, May 01, 2019 at 09:38:03AM +1000, Tobin C. Harding wrote:
> > > Hi,
> > > 
> > > Looks like I've created a bit of confusion trying to fix memleaks in
> > > calls to kobject_init_and_add().  Its spread over various patches and
> > > mailing lists so I'm starting a new thread and CC'ing anyone that
> > > commented on one of those patches.
> > > 
> > > If there is a better way to go about this discussion please do tell me.
> > > 
> > > The problem
> > > -----------
> > > 
> > > Calls to kobject_init_and_add() are leaking memory throughout the kernel
> > > because of how the error paths are handled.
> > 
> > s/are leaking/have the potential to leak/
> > 
> > Note, no one ever hits these error paths, so it isn't a big issue, and
> > is why no one has seen this except for the use of syzbot at times.
> 
> One day I'll find an important issue to fix in the kernel.  At the
> moment sweeping these up is good practice/learning.  If you have any
> _real_ issues that need someone to turn the crank on feel free to dump
> them on me :)

Once you get this done, I do have some "fun" ideas about the cdev api
and how it can be "fixed up".

Your knowledge of reference counts and kobjects will come in handy
there, so talk to me off-list when you are ready :)

keep up the great work,

greg k-h
