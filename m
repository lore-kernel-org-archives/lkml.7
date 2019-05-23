Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD86C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E7A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558603873;
	bh=yaOntg8laCmflIjxaGnFofBQ3cEa0Ur+Y9f3U2oX+jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cxq5wgV3r3WfBJH440IRRuEQwyRMEe9jBwnsMuC4bTN015ojrt3eMtAERRyfSz7ao
	 1414BVIqXZNGld4SP/6iLRo+E3EsigO55IGU0a76RgeeclVtNeywyG147YgF0tG3tk
	 Oer0EwX40RUZeuFdAOLKOSjum2yFMH5gE8i7ukUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfEWJbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfEWJbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:31:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB4620675;
        Thu, 23 May 2019 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558603871;
        bh=yaOntg8laCmflIjxaGnFofBQ3cEa0Ur+Y9f3U2oX+jE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnLXKyYIR4VCCOyGdCM/+TfUtIB03PDm9wSZOr5q+meDOvZnJGfSMAJlVeb0td/Jj
         BvbGs+z/V7oZWX81Sfnk2DbjXABVbMw2Anec130TFuLoiyWj+TKOuX0APuRZJpzDKF
         tslYGw2PQaoVE19j8OOOXck27T2oc8G+ilGHkctw=
Date:   Thu, 23 May 2019 11:31:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tty: drop unused iflag macro
Message-ID: <20190523093109.GA24097@kroah.com>
References: <20190426055925.13430-1-johan@kernel.org>
 <20190523092127.GD568@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523092127.GD568@localhost>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:21:27AM +0200, Johan Hovold wrote:
> On Fri, Apr 26, 2019 at 07:59:22AM +0200, Johan Hovold wrote:
> > I noticed that the RELEVANT_IFLAG() macro was unused in USB serial and
> > turns out there were a few more instances that could be dropped.
> > 
> > I have some pending changes that may conflict with the corresponding
> > change to USB serial so I'll take that one separately through my tree,
> > but perhaps the rest could go through Greg's tty tree.
> 
> > Johan Hovold (3):
> >   tty: simserial: drop unused iflag macro
> >   tty: ipoctal: drop unused iflag macro
> >   tty: cpm_uart: drop unused iflag macro
> > 
> >  arch/ia64/hp/sim/simserial.c                | 2 --
> >  drivers/ipack/devices/ipoctal.h             | 1 -
> >  drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 --
> >  3 files changed, 5 deletions(-)
> 
> Greg, do you still have these clean-ups in your queue? Want me to resend
> with Tony's ack?

They are still in my to-review queue.  Let me dig out from some more
stable patches before I tackle the tty/serial stuff later today or
tomorrow.

thanks,

greg k-h
