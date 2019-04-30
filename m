Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60477C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3107A2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556639089;
	bh=rrcsqZYKEnEJrIdXuKxxMtHlVHbhSKZ1Kz45Y55dS2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1847cjq7l1aa8E8lMES06QiYwI7xL6+ed80Mm+SuyOv+jVF/vIlVjvy+7c1QXu5p/
	 cKhBF8yVdeKIyjMcD2mNyFuI7a0zBjYIcn2woCPY7wn0SQxBjfKkjxqsJvMk0IVMiV
	 1uvdecLSqSSVCQvkrwfkzUtiHz0h88fFErVJlQL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfD3Pos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfD3Por (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:44:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA30C21734;
        Tue, 30 Apr 2019 15:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556639087;
        bh=rrcsqZYKEnEJrIdXuKxxMtHlVHbhSKZ1Kz45Y55dS2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FirvzScPjS7RmCBuQQS2UfrvORNpS6ms7ZN8jkKNd/7jz8fuGSfnsarVTtu+qTtam
         kWtSTyY4vCTCPe1lNlvQzSiLcAPFcveskn0IRfmsrv3rKIixB8Mzp/gK+sGFIOXXFQ
         VWrcQBTR5q9vwahfuQp4KuIM0UZclWBjJVQ9Gnjo=
Date:   Tue, 30 Apr 2019 17:44:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] usbip: vhci_hcd: Mark expected switch fall-through
Message-ID: <20190430154444.GA4224@kroah.com>
References: <20190429143957.GA6725@embeddedor>
 <1daec8c8929e4d18b2059ab1dfbfdf4a@AcuMS.aculab.com>
 <287c8504-eafa-ebbb-aa39-babb86fdeb94@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <287c8504-eafa-ebbb-aa39-babb86fdeb94@embeddedor.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:05:51AM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 4/29/19 9:44 AM, David Laight wrote:
> > From: Gustavo A. R. Silva
> >> Sent: 29 April 2019 15:40
> >> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >> cases where we are expecting to fall through.
> > ...
> >> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> >> index 667d9c0ec905..000ab7225717 100644
> >> --- a/drivers/usb/usbip/vhci_hcd.c
> >> +++ b/drivers/usb/usbip/vhci_hcd.c
> >> @@ -508,6 +508,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> >>  		case USB_PORT_FEAT_U1_TIMEOUT:
> >>  			usbip_dbg_vhci_rh(
> >>  				" SetPortFeature: USB_PORT_FEAT_U1_TIMEOUT\n");
> >> +			/* Fall through */
> >>  		case USB_PORT_FEAT_U2_TIMEOUT:
> >>  			usbip_dbg_vhci_rh(
> >>  				" SetPortFeature: USB_PORT_FEAT_U2_TIMEOUT\n");
> > 
> > That doesn't look right, both debug messages seem to get printed.
> > 
> 
> At first sight, I thought the same way, then I took a look into
> commit:
> 
> 1c9de5bf428612458427943b724bea51abde520a
> 
> and noticed that the original developer properly added fall-through
> comments in other places in the same switch() code, that gave me the
> impression he knew what he was doing; then I noticed the following
> error message in case USB_PORT_FEAT_U2_TIMEOUT:
> 
> 	if (hcd->speed != HCD_USB3) {
> 		pr_err("USB_PORT_FEAT_U1/2_TIMEOUT req not "
> 		       "supported for USB 2.0 roothub\n");
> 		goto error;
> 	}
> 
> this error message is what makes me think the fall-through is
> intentional; otherwise I think it would look like this instead:
> 
> 	if (hcd->speed != HCD_USB3) {
> 		pr_err("USB_PORT_FEAT_U2_TIMEOUT req not "
> 		       "supported for USB 2.0 roothub\n");
> 		goto error;
> 	}

I think you are right, that's horrid, but correct :(

Will go queue this up, thanks.

greg k-h
