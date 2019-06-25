Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCD3C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E6B20863
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561447855;
	bh=4epmSJ7jd5ByQ7pNK6zUj/oXuoSovcWeH6v4vssgIIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UbLEGJbKS5QjgHOE6X22RVNkITXSJBB9QHERrwOq2HcZ1Z0FHM6C+06JDvGmA6D/U
	 SI3+pgKP7jrG30GuzU04lFa89GOC4+eGL25pWE7QOwo5opgwJjoIStdO75Zy4vkMlW
	 2+qY674OYzCAd88q1dZmGAmjDISwIQ/+X9enhwYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfFYHax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfFYHax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:30:53 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 115A72085A;
        Tue, 25 Jun 2019 07:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561447852;
        bh=4epmSJ7jd5ByQ7pNK6zUj/oXuoSovcWeH6v4vssgIIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2cHmo2pJI4ZbLSNajdR8C1HfNEzADIySNJJJxfU3WrRJjFGTMd7Tj4NZsusZXPd5
         3nAepyNZW5/ttcQvB315a2rWjAL6kZhytnMwzTIqgpGC0tYNMSi6PT8CYJpivwWamZ
         kNGQYa7q9J/a4ZY67R5lhT9nSq6mcmMZKUuYpUSk=
Date:   Tue, 25 Jun 2019 15:24:07 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Alistair Popple <alistair@popple.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fsi: sbefifo: Don't fail operations when in SBE IPL state
Message-ID: <20190625072407.GA18197@kroah.com>
References: <1548090958-25908-1-git-send-email-eajames@linux.ibm.com>
 <1780173.icGFXHrAMq@townsend>
 <CACPK8XfqSyMB4pWLffzx+8qOj+m54h=aWUhYsKMV4TQR0fKVUg@mail.gmail.com>
 <CACPK8Xfns=dSD5gaVJ--OkmVe7ggqF8acGsszdPqM1AqpPSAiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xfns=dSD5gaVJ--OkmVe7ggqF8acGsszdPqM1AqpPSAiA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 04:35:50AM +0000, Joel Stanley wrote:
> Hi Greg,
> 
> On Mon, 17 Jun 2019 at 05:41, Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Mon, 17 Jun 2019 at 02:09, Alistair Popple <alistair@popple.id.au> wrote:
> > >
> > > On Monday, 21 January 2019 11:15:58 AM AEST Eddie James wrote:
> > > > SBE fifo operations should be allowed while the SBE is in any of the
> > > > "IPL" states. Operations should succeed in this state.
> > > >
> > > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > >
> > > This fixed the problem I was having trying to issue istep operations to the
> > > SBE.
> > >
> > > Tested-by: Alistair Popple <alistair@popple.id.au>
> >
> > This one slipped through the cracks.
> >
> > Fixes: 9f4a8a2d7f9d fsi/sbefifo: Add driver for the SBE FIFO
> > Reviewed-by: Joel Stanley <joel@jsm.id.au>
> >
> > Greg, can you please queue this one up for 5.3?
> 
> Ping?

I don't see this in my queue at all, sorry.  Can someone resend it in a
format that I can apply it in with the needed tested-by and reviewed-by
added to it?

thanks,

greg k-h
