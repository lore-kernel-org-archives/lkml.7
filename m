Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85680C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D1E218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553105980;
	bh=4SJ/Up3cDDPePUJg/0kKUL6GnPbqbPguuFBh6AwGmy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kRKSmnXsl8HsO2/9gObIxh9Xa4BN4ftzGb+KSbpA9bSwSA2vb1S3gW6JApq+vOrF3
	 oHhyubu63CZcOGAfDol7GBFMX5EJdmmOdop6OMhNlktGMo/Bnvy/yZVihoKpws/eE7
	 H6QmCCUIQEEIuD+V86ljcYloVllw7Df4mSoyxRTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfCTSTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfCTSTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:19:38 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7800218C3;
        Wed, 20 Mar 2019 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553105977;
        bh=4SJ/Up3cDDPePUJg/0kKUL6GnPbqbPguuFBh6AwGmy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0ufPN6ZmHafDJPnX6bN8mc5sqaopIpAekuEaxciqf31eiTA4mzeKLcEHrRrzDrSl
         IUysqgJFj1c5lbQSmll++h157RhnxiF6H9tVI5EhvchQDLUvvFGGQOjoyYxgx0x9T+
         xJhXPZw2lgsH3mgmP75pP8I6mcF7dDtTFsbB750I=
Date:   Wed, 20 Mar 2019 19:19:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Thayer <michael.thayer@oracle.com>,
        "Knut St . Osmundsen" <knut.osmundsen@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] virt: vbox: Implement passing requestor info to the host
 for VirtualBox 6.0.x
Message-ID: <20190320181934.GA3907@kroah.com>
References: <20190320093519.26029-1-hdegoede@redhat.com>
 <20190320094601.GA30735@kroah.com>
 <29c6e212-6233-364f-5a90-564f91bca989@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29c6e212-6233-364f-5a90-564f91bca989@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:52:05AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 20-03-19 10:46, Greg Kroah-Hartman wrote:
> > On Wed, Mar 20, 2019 at 10:35:19AM +0100, Hans de Goede wrote:
> > > VirtualBox 6.0.x has a new feature where the guest kernel driver passes
> > > info about the origin of the request (e.g. userspace or kernelspace) to
> > > the hypervisor.
> > > 
> > > If we do not pass this information then when running the 6.0.x userspace
> > > guest-additions tools on a 6.0.x host, some requests will get denied
> > > with a VERR_VERSION_MISMATCH error, breaking vboxservice.service and
> > > the mounting of shared folders marked to be auto-mounted.
> > > 
> > > This commit implements passing the requestor info to the host, fixing this.
> > > 
> > > Cc: stable@vger.kernel.org
> > 
> > This feels like support for a "new feature", so why would this need to
> > go to older kernels?
> > 
> > It's not our fault that vb implemented a non-backwards-compatible change
> > for their new release, right?  So why should we be forced to add new
> > features to stable kernels?
> 
> From a technical point of view I completely agree with you and I'm unhappy
> with this breakage after vb agreed with me to keep ABI compatibility so
> that we could add a version of the vboxguest driver to the mainline kernel.

So they broke that agreement, ugh.  That implies they will do it again?

> OTOH this is going to bite users out there, which is why I added the Cc:
> stable. But this is entirely your call.

Let me think about it...

> > I have no problem to add this for 5.2, but not for older stuff.
> 
> Can we at least at it as a fix to 5.1 ? It is not very adventurous.

Sure, let me go review it now.

thanks,

greg k-h
