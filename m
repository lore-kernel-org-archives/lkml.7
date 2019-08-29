Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3162EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093782073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567060954;
	bh=LUI4hV71RkxJNICcSpNRgTs4BSj0yh0DSutBWm6dN1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jslmwOR688QEUEw1Ers1bJH85wZxZI4SYpp2w+XtO+ViqpNcyrEctj1iRZc2McJib
	 ZkZaexB+rqjinRog7oQZFvO2PYCAgEZn0zMK026PNk4z2VKXdB6UStz8EGtee2FTT7
	 V92tGEnqyYzj6weOaydM6uNizpmyqxPT/MYhOB4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfH2Gmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 02:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2Gmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:42:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EC402073F;
        Thu, 29 Aug 2019 06:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567060951;
        bh=LUI4hV71RkxJNICcSpNRgTs4BSj0yh0DSutBWm6dN1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ksQxfqbw0Qo5gH5tpCVTsvpYOcGOlvDWxehZBThWuSiefXxTar0I7MZfPHpewu5fq
         5HagXVeJ4iJsob7R+YXSyr9j9HAA/E5hM0M17kEIpMQWS3PSsMWj5eU3wgihlj4HlC
         MvOqqkqQ4t/ie5gl/iy8jF3gbMWm5siOcwBeUlkQ=
Date:   Thu, 29 Aug 2019 08:42:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peikan Tsai <peikantsai@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: Use kmem_cache for binder_thread
Message-ID: <20190829064229.GA30423@kroah.com>
References: <20190829054953.GA18328@mark-All-Series>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829054953.GA18328@mark-All-Series>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 01:49:53PM +0800, Peikan Tsai wrote:
> Hi,

No need for that in a changelog text :)

> The allocated size for each binder_thread is 512 bytes by kzalloc.
> Because the size of binder_thread is fixed and it's only 304 bytes.
> It will save 208 bytes per binder_thread when use create a kmem_cache
> for the binder_thread.

Are you _sure_ it really will save that much memory?  You want to do
allocations based on a nice alignment for lots of good reasons,
especially for something that needs quick accesses.

Did you test your change on a system that relies on binder and find any
speed improvement or decrease, and any actual memory savings?

If so, can you post your results?

thanks,

greg k-h
