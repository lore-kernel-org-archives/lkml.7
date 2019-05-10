Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D990FC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97D52177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557501131;
	bh=f4MQPxrZJwdsz9l31WAcMpX2ASghqyP38otGOYNA0hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FmM/LHzeR7MlTPzCVph/uVFA+P5IbvfqugTnfGgiqvH4/HRIfD0vdDml4vJkHC/ho
	 19lLDLOftbbh4ZYeYbyRpYgckQu+Uz+ACsiu0SPcJyugGkC6kV2Khu5z8dv6f8Y5or
	 ZQuu9rnY/LMqDBejGby2emxmzMGPrg3GSt5CKPGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfEJPMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfEJPMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:12:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE034216C4;
        Fri, 10 May 2019 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557501129;
        bh=f4MQPxrZJwdsz9l31WAcMpX2ASghqyP38otGOYNA0hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWR2TYoa9cUNd2RFyyj47jWOoCbQbulFIO5hz2isDoTZj2nFPaLUUgI1Cy18QEEKy
         wJ70A+iC7QivtgZbnvbLkY+JqS/L17hGwjAJr2cPFHXx9AHA7AALkXAYqdna5ROF5Q
         v8iy6AxkIV36MvP9s6PxTuY6RoOTsXX8brTcaNQo=
Date:   Fri, 10 May 2019 17:12:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file
 of Linux 5.0.14
Message-ID: <20190510151206.GA31186@kroah.com>
References: <CAAie0ar11_mPipN=d=mrgnVdEMO1Np0cCYdqcRfZrij_d-5zaQ@mail.gmail.com>
 <20190510051415.GA6073@kroah.com>
 <CAAie0ao_O0hcUOuUf67oog+dSswdQRpAtX8NyQvDAr_XQr=xQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAie0ao_O0hcUOuUf67oog+dSswdQRpAtX8NyQvDAr_XQr=xQg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 10:24:50PM +0800, Gen Zhang wrote:
> On Fri, May 10, 2019 at 13:14:02PM +0800, Greg KH <
> gregkh@linuxfoundation.org> wrote:
> >Note, your email client ate all of the tabs and made the patch
> >impossible to apply, so please fix this up before you resend it.
> >
> >thanks,
> >
> >greg k-h
> From: Gen Zhang <blackgod016574@gmail.com>
> Date: Fri, 10 May 2019 09:31:30 +0000
> Subject: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file of
> Linux 5.0.14
> 
> Hi,
> I found this missing-check bug in Linux-5.0.14/drivers/tty/vt/vt.c when I
> was examining the source code.
> 
> In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> vc->vc_screenbuf is allocated a memory space via kzalloc().
> And they are used in the following codes.
> 
> However, when there is a memory allocation error, kzalloc can  be failed.
> Thus null pointer (vc_cons[currcons].d, vc and vc->vc_screenbuf)
> dereference may happen.
> And it will cause the kernel to crash. Therefore, we should check return
> value and handle an error.
> 
> Below is the patch file, and I am ready to sumbit it to the kernel tree.
> I am looking forward to a reply on this, thank you!
> 
> Kind regards
> Gen
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---
> 
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3322,10 +3322,14 @@ static int __init con_init(void)
> 
>   for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>   vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> + if (!vc_cons[currcons].d || !vc)
> + goto err_vc;
>   INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>   tty_port_init(&vc->port);
>   visual_init(vc, currcons, 1);
>   vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> + if (!vc->vc_screenbuf)
> + goto err_vc_screenbuf;
>   vc_init(vc, vc->vc_rows, vc->vc_cols,
>   currcons || !vc->vc_sw->con_save_screen);
>   }
> @@ -3347,6 +3351,14 @@ static int __init con_init(void)
>   register_console(&vt_console_driver);
>  #endif
>   return 0;
> +err_vc:
> + console_unlock();
> + return -ENOMEM;
> +err_vc_screenbuf:
> + console_unlock();
> + kfree(vc);
> + vc_cons[currcons].d = NULL;
> + return -ENOMEM;
>  }
>  console_initcall(con_init);

Still impossible to apply :(

Also, what about Dave's response to you?  This really can never be hit,
like other early-init tty allocations that we do not check because of
this issue, correct?

thanks,

greg k-h
