Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F464C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553562166E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564814804;
	bh=1dLxmQz7MmTPHPcPV2oG34M03+qQWgSoagR/hWotRvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QiLTl/X6+i1MqiKOzMFLKPcYdD110Ef6zpBpstu0INi+/ixvZHLSO/y63DxZkidBz
	 n09RhaWY9qj3WMna+rQxv7rBL3tvOp8qKkgRf44MKhoTBmOX4syrQ+XpsAsm0sw5r8
	 +u3T6GjOlRljCR/FIOdoY55mqMpQIyTfw9nay8NA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfHCGqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 02:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbfHCGqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 02:46:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AB442073D;
        Sat,  3 Aug 2019 06:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564814802;
        bh=1dLxmQz7MmTPHPcPV2oG34M03+qQWgSoagR/hWotRvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zl5KxrQADXPvOXSf+wD/mMgSWRM4Ge//olN9LaRqJpmDbYYiHpoJRmtpWK+odXpvT
         KYTI2X3tp8nwOSlWxEgHhU2xridzXyOSHxC89hGtFcEn8np+zthHcIHdNgRJLAPXZs
         SoaoPJa9Dp+7JGChVBpUIB1hZIHoYK5PKg16J424=
Date:   Sat, 3 Aug 2019 08:46:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: Device to write to all (serial) consoles
Message-ID: <20190803064639.GB10855@kroah.com>
References: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
 <20190802160243.GA15484@kroah.com>
 <cab1fe06-0dc7-e7c1-50ac-cc01773c5ef5@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cab1fe06-0dc7-e7c1-50ac-cc01773c5ef5@molgen.mpg.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 09:59:06PM +0200, Paul Menzel wrote:
> Dear Greg,
> 
> 
> On 02.08.19 18:02, Greg Kroah-Hartman wrote:
> > On Fri, Aug 02, 2019 at 03:23:08PM +0200, Paul Menzel wrote:
> 
> > > On a lot of devices, like servers, you have more than one serial console,
> > > and you do not always know, how they are numbered. Therefore, we start a
> > > console on ttyS0 and ttyS1.
> > > 
> > > In user space, we also would like to write to both consoles to not worry
> > > about the numbering. Writing to `/dev/console` only write to the active
> > > console.
> > 
> > So the same data to multiple console devices with just one userspace
> > call?  Why?
> 
> Because the cable is always connected to the port on the back side, and
> sometimes the port in the front has ID 0, and the one in the back 1, and
> other times vice versa. We do not want to track that, and it would be
> convenient to just write to both ports.
> 
> > >      $ more /proc/consoles # I think
> > >      tty0                 -WU (EC p  )    4:1
> > >      ttyS0                -W- (E  p a)    4:65
> > >      ttyS1                -W- (E  p a)    4:65
> > > 
> > > Does a device exist, or can a device be configured so you can write to
> > > all (serial) consoles from user space?
> > 
> > With one syscall, not that I know of, sorry.
> 
> Can such a device be created with udev or so?

No, a single device node can not reference multiple device nodes at the
same time, sorry.  That's just not how they work at all.

thanks,

greg k-h
