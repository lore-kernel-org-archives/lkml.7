Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C43DC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE05C206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555530547;
	bh=LIfKUoGrsM+QwrdYm+u54524zcfDJvUPW/bsafPuppo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t9OxSZAw3cHWQUbRT+CGmMapqpSCAJXM3lrykLJmEGzbqdrRPcQ5RFybyhE6zwxRi
	 3ZU8JFtb0WX80APHANKou0KIIcuai80hkOwYE9hWRJm7d9WEhH0G8sFwwCwGLW/Rcr
	 OfPCwsGJhudn7WaK/NcQTb/JN5K9n2xaGpHFI5eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbfDQTtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbfDQTtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:49:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17793205C9;
        Wed, 17 Apr 2019 19:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555530545;
        bh=LIfKUoGrsM+QwrdYm+u54524zcfDJvUPW/bsafPuppo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtAHVKGesQ1yT67p//eq3tjBwVuozoJkYYJalUHQ2sdLn4PjfhGU/07OrqtO/dqas
         50fKhzhRxrU7h5zARGrMFxkC4LSm1nKPpplSiQbV8Q7ULXtQJ0bnVkvAoopGOCwiDk
         lNwohGRvhGR5iHYSTG5/Dssp0ArdYvPS1rWsizHQ=
Date:   Wed, 17 Apr 2019 21:49:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "zhuyan (M)" <zhuyan34@huawei.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb:host: fix divide-by-zero in function
 fhci_queue_urb
Message-ID: <20190417194903.GD28125@kroah.com>
References: <63401dc56ae64aa3a428c4bb8a84034e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63401dc56ae64aa3a428c4bb8a84034e@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 05:05:33PM +0000, zhuyan (M) wrote:
> On Wed, 17 Apr 2019, Alan Stern wrote:
> 
> > On Wed, 17 Apr 2019, zhuyan (M) wrote:
> > 
> > > On Tue, 16 Apr 2019 11:07:56 -0400, Alan Stern wrote:
> > > 
> > > > On Tue, 16 Apr 2019, zhuyan (M) wrote:
> > > > > On Tue, 16 Apr 2019 at 11:45:45 +0200, Greg KH wrote:
> > > > > > On Tue, Apr 09, 2019 at 10:37:12PM +0800, zhuyan wrote:
> > > > > > > In function fhci_queue_urb, the divisor of expression 
> > > > > > > (urb->transfer_buffer_length % usb_maxpacket(urb->dev, 
> > > > > > > urb->pipe,
> > > > > > > usb_pipeout(urb->pipe))) may be zero.
> > > > > > 
> > > > > > How can you hit that?
> > > > > > 
> > > > > > > When it is zero, unexpected results may occur, so it is 
> > > > > > > necessary to ensure that the divisor is not zero.
> > > > > > > 
> > > > > > > Signed-off-by: zhuyan <zhuyan34@huawei.com>
> > > > > > 
> > > > > > I need a "Full" name here, not just a single name.  Whatever you use to sign documents is good.
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > 
> > > > > In function usb_maxpacket, when ep is NULL, its return value is 0.  
> > > > 
> > > > fhci_queue_urb() shouldn't use urb->pipe to compute the maxpacket 
> > > > size anyway.  It should use usb_endpoint_maxp(&urb->ep->desc).
> > > 
> > > Currently, fhci_queue_urb(), call usb_maxpacket() multiple times to 
> > > calculate  the maxpacket size. The usb_maxpacket() will call 
> > > usb_endpoint_maxp() to compute the maxpacket size.
> > 
> > I know that.  What fhci_queue_urb() is doing is wrong.  You should change it: 
> > Make it call usb_endpoint_maxp directly instead of calling usb_maxpacket.
> > 
> 
> >From 1996456d0cc17b5ff7746a598ff355b25d13db3e Mon Sep 17 00:00:00 2001
> From: zhuyan <zhuyan34@huawei.com>
> Date: Thu, 18 Apr 2019 00:53:03 +0800
> Subject: [PATCH] usb: host: fix divide-by-zero in function fhci_queue_urb
> 
> fhci_queue_urb() shouldn't use urb->pipe to compute the maxpacket
> size anyway.It should use usb_endpoint_maxp(&urb->ep->desc).
> 
> In function fhci_queue_urb, the divisor of expression
> (urb->transfer_buffer_length % usb_maxpacket(urb->dev, urb->pipe,
> usb_pipeout(urb->pipe))) may be zero. When it is zero, unexpected results
> may occur, so it is necessary to ensure that the divisor is not zero.
> 
> Signed-off-by: zhuyan <zhuyan34@huawei.com>

I still need a full name here and on the From: line :(

thanks,

greg k-h
