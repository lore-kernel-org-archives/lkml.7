Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC89C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EAA212F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560081704;
	bh=G8/in7R21RsUtZZHdNcIkpjzk8Scmd913EvSVjGESxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e/8iBP61jcx/FRd6WcNIIVXEFi5TSDuaNa2Bosr4TGk4xo4cKEMwVH/AKjyeVVIf7
	 e2dbwm8l1VNzVcg5lXg1JJqvIzzHAABWXWLRxBSTRPGRYpT+XdAfBGHS/vy2L0ADvq
	 v0F4+2be6gPbTYhiISC+lkRyBUO/rQOk+q3iN/v4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfFIMBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfFIMBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:01:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F418E2070B;
        Sun,  9 Jun 2019 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560081702;
        bh=G8/in7R21RsUtZZHdNcIkpjzk8Scmd913EvSVjGESxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAxxTUBkh32oNo5nFKv+UTVsa38RujGrVDjCQLwKrG25qzjEB2CLZ0MuJZJ7DoTqG
         aC0BqPkx1RkmlmvonrfNwY3aLH0DQCYFQFqn4fYDYA1yYUp9FwD6ZJmKcC2fk/Qq0N
         TC1Ga1ANBRdnFy3aFpyC4zMH7rjtKOIbsfB4ZYCc=
Date:   Sun, 9 Jun 2019 14:01:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Kumar Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, straube.linux@gmail.com
Subject: Re: [PATCH v4 0/6] staging: rtl8712: cleanup struct _adapter
Message-ID: <20190609120139.GA19925@kroah.com>
References: <cover.1559990697.git.linux.dkm@gmail.com>
 <20190609111010.GA28875@kroah.com>
 <933b8890-986c-8bdb-93ef-90edf248fb43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <933b8890-986c-8bdb-93ef-90edf248fb43@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 05:16:48PM +0530, Deepak Kumar Mishra wrote:
> Hi Greg,
> 
> On 09/06/19 4:40 PM, Greg KH wrote:
> > On Sat, Jun 08, 2019 at 04:26:55PM +0530, Deepak Mishra wrote:
> > > In process of cleaning up rtl8712 struct _adapter in drv_types.h I have
> > > tried to remove some unused variables and redundant lines of code
> > > associated with those variables. I have also fixed some CamelCase
> > > reported by checkpatch.pl
> > > 
> > > Deepak Mishra (6):
> > >    staging: rtl8712: Fixed CamelCase for EepromAddressSize
> > >    staging: rtl8712: Removed redundant code from function
> > >      oid_rt_pro_write_register_hdl
> > >    staging: rtl8712: Fixed CamelCase cmdThread rename to cmd_thread
> > >    staging: rtl8712: removed unused variables from struct _adapter
> > >    staging: rtl8712: Renamed CamelCase wkFilterRxFF0 to wk_filter_rx_ff0
> > >    staging: rtl8712: Renamed CamelCase lockRxFF0Filter to
> > >      lock_rx_ff0_filter
> > If this is a "v4" series, I do not see a list of what has changed from
> > the previous versions at all here :(
> > 
> > Please list it somewhere, usually in the individual patches below the
> > --- line, or you can put it here in the 00/XX email as well.
> > 
> > v5 please?
> In my previous versions I mainly tried to correct the patch submission based
> on your suggestion for example
> 1.keeping every individual task separate.
> 2. Not only just fix CamelCase but if those variables are unused remove
> those.
> 3. If any variable is assigned but never used then remove those.
> 
> So should I put these review comments in my 0/6 file and send you the v5 of
> the patch set,
> 
> or remove version number and send a new patch set again as if it is a fresh
> patch set ?

Put all of the information in the 00/XX email and send a new version.

thanks,

greg k-h
