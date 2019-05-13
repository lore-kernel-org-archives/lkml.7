Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03C9C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3B2208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557732983;
	bh=wc9NZUreQghyl3dBxtE5NSp2+xKrNiH/bPdVGNTC6YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iLFtrEQJhrrFdsGc1C/lC3W/I7aV/Fr6rCxJ4rwAZyjxQLmxCeHHUBK6he+8ChMHf
	 p6Yk3dEPWWiNT7abG4viYoR0vWbpHLewIW6W/8NIlPxUrIh0fuqlMc49dBAQHoWI2T
	 83MLNPh5xJBujVHFpeKJD74YNWg55JexZXyWCTPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfEMHgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfEMHgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:36:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2EF3208C3;
        Mon, 13 May 2019 07:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557732981;
        bh=wc9NZUreQghyl3dBxtE5NSp2+xKrNiH/bPdVGNTC6YY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KW9nnrMDiQ9QRbJON9bnQe0/od4g6Masay1QNeqbLuGcN9nYUx/w8GA1JSaP3cffQ
         irdprW0rkdmVKuPL3q//vxAvJTiiQ/3fEQvCPfaTblCZuf0GbwieYnz7+WA8aw0EZU
         SxkRWgO2tcdQ1AogJNdbNv7pbKZVmkau2wSV6fh4=
Date:   Mon, 13 May 2019 09:36:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file
 of Linux 5.0.14
Message-ID: <20190513073619.GA5580@kroah.com>
References: <CAAie0ar11_mPipN=d=mrgnVdEMO1Np0cCYdqcRfZrij_d-5zaQ@mail.gmail.com>
 <20190510051415.GA6073@kroah.com>
 <CAAie0ao_O0hcUOuUf67oog+dSswdQRpAtX8NyQvDAr_XQr=xQg@mail.gmail.com>
 <20190510151206.GA31186@kroah.com>
 <CAAie0arnSxFvkNE1KSxD1a19_PQy03Q4RSiLZo9t7C9LeKkA9w@mail.gmail.com>
 <20190511060741.GC18755@kroah.com>
 <20190512032719.GA16296@zhanggen-UX430UQ>
 <20190512062009.GA25153@kroah.com>
 <20190512084916.GA4615@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512084916.GA4615@zhanggen-UX430UQ>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 04:49:39PM +0800, Gen Zhang wrote:
> On Sun, May 12, 2019 at 08:20:09AM +0200, Greg KH wrote:
> > Yes, that worked!  Now, can you resend it in a proper format that I can
> > apply it in?  (with changelog text, signed-off-by, etc.) as described in
> > Documentation/SubmittingPatches, I will be glad to review it after the
> > 5.2-rc1 release happens.
> > 
> > thanks,
> > 
> > greg k-h
> From: Gen Zhang <blackgod016574@gmail.com>
> Date: Sun, 11 May 2019 15:31:30 +0000
> Subject: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file of Linux 5.0.14

Better, but no need for this to be in the body, just send it like any
other patch on the mailing list.

> 
> Hi,
> I found this missing-check bug in drivers/tty/vt/vt.c when I was examining the source code. 

That doesn't need to be in the changelog text.

> 
> In function con_init(), the pointer variable vc_cons[currcons].d, vc and vc->vc_screenbuf is allocated a memory space via kzalloc(). 
> And they are used in the following codes. 

Properly wrap your lines at 72 columns please.

> 
> However, when there is a memory allocation error, kzalloc can  be failed. 
> Thus null pointer (vc_cons[currcons].d, vc and vc->vc_screenbuf) dereference may happen. 
> And it will cause the kernel to crash. Therefore, we should check return value and handle an error.
> 
> And this patch works in 5.1.1.

No need to say that.

> 
> Thank you!
> 
> Kind regards
> Gen

Or that :)


> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---
> --- drivers/tty/vt/vt.c
> +++ drivers/tty/vt/vt.c
> @@ -3349,10 +3349,14 @@ static int __init con_init(void)
>  
>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> +		if (!vc_cons[currcons].d || !vc)
> +			goto err_vc;

What about the other memory that was allocated?  You never free that.

>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  		tty_port_init(&vc->port);
>  		visual_init(vc, currcons, 1);
>  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> +		if (!vc->vc_screenbuf)
> +			goto err_vc_screenbuf;

Same here, you are now leaking memory.

Did you test this patch out with a kmalloc function that can fail?  If
not, please try to do so.

thanks,

greg k-h
