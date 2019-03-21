Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8371C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B552190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553189521;
	bh=v2TQMq23QbTOEbKHgWNa09VLDZxFZJIt3CkJ1R8Us9w=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=2gOKRNRvt3P19UuSTCRHkftUC82RIdYMAcvl8DwVpelqX5kWixju/z53vH73BXikj
	 xmDKN3193FZ/RgNN2g9dpgXQFbv6VTnysdTiMIt793neQgd3uYYhpF79m81D1J0miZ
	 UMmpRZSuFAHEFOp+rLEjimyDCqvVz/weNW7dQEzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfCURcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbfCURcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:32:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C4F21874;
        Thu, 21 Mar 2019 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553189519;
        bh=v2TQMq23QbTOEbKHgWNa09VLDZxFZJIt3CkJ1R8Us9w=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=qeLeYDCbIjiayvHB1TDUISB8FCfRXb604QHz8ljPKGiGbu9/JFbFBh7kIrbORCYRg
         AUkruLa+BgixD+gnQa1QNz4dHh24KAsG9JSaVwedYDQEgZv0vrKrbS50/29HG0VO7R
         Td/H4vNA5tAN/gryIvIJ26nBoOvM0l4l32fu8DXk=
Date:   Thu, 21 Mar 2019 18:31:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     dsterba@suse.cz, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Stable patches that don't apply to older kernels and how to get
 them
Message-ID: <20190321173156.GA4171@kroah.com>
References: <20190321151413.GB8120@suse.cz>
 <20190321163941.GA11121@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321163941.GA11121@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 05:39:41PM +0100, Greg KH wrote:
> On Thu, Mar 21, 2019 at 04:14:14PM +0100, David Sterba wrote:
> > Hi,
> > 
> > would it be possible to have a git repository with all patches that are
> > submitted to stable@ but don't apply directly?
> > 
> > I get notified by mail, that's fine though it's not that convenient to
> > see all the pending patches for backport to a given version.
> > 
> > My proposal:
> > 
> > - create a separate stable-unapplied git repository
> > 
> > - if a patch does not apply to a given version, it's stored as-is to a
> >   directory of the base version (like 4.4)
> > 
> > - once a fixed version is applied to stable-queue.git/released-4.4, the
> >   patch in the other repo is deleted
> > 
> > I believe this can be highly automated and once implemented would not
> > too much additional work to the stable workflow. I could possibly write
> > a scraper of the mail archives to pick the patches and manage the
> > repository but I think that a central repository could help other
> > maintainers too or to spread the load to all interested developers.
> > 
> > If something like that already exists, please let me know.
> 
> Nothing like this exists, sorry.
> 
> And if you want to automate this, wonderful, but I do not have any time
> to do so, and it does not fit into my workflow at all.  Patches that do
> not apply are the exception by far, not the rule, so I doubt this would
> really help out much.
> 
> And of course, the i915 developers would just ignore it, as they hold
> the record for patches that never apply, and then never send patches in
> as they are already 6-8 months ahead :)

Note, what does work today is Sasha's bot that finds patches that are
 cc: stable and tries to apply them to older kernels and sends you an
email if the patch fails.  That is running today in semi-frequent waves,
and we have gotten backports sent to the list before the patch lands in
Linus's tree, which is great.  So you can take advantage of this now if
you want to.

thanks,

greg k-h
