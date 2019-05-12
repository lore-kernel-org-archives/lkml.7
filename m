Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFB2C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 06:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F142146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 06:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557642334;
	bh=FopxydH9UPNQppTrvFx7gpSyK5wXsezcfPeEoAD6yCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sSmCKNZKBwpr+q06BnGPRLvKLBS5Kh3jPfu8u9GC6zLPPT44lOlmz6h1ek5ks3uZr
	 QB+mComK5kBUemPKYJObCScGi1jSDgrGO/fVZjJi19705ab0DFFLgpoJzugO1HSVYr
	 WG/wWGEWKLAeJi9+IHXrcQ29jvM/N+nwsnpU2Na8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfELGUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 02:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfELGUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 02:20:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D13F32133D;
        Sun, 12 May 2019 06:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557642012;
        bh=FopxydH9UPNQppTrvFx7gpSyK5wXsezcfPeEoAD6yCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K7HMLxX94uycs1NFF6d3QE5DvesXv6QloXk3426t9Ou7bIPWCOCz+UH9ESTxGMS6t
         iPNL5qX1Dumo3lHARuVvIQy124pverfzUtlD4vKh5xAUugg6UGwKXcjR2k/Ja3LBH6
         0HVw7JESxaQSc7cvZCb9tqTAKe4b2MVefysz/K3k=
Date:   Sun, 12 May 2019 08:20:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file
 of Linux 5.0.14
Message-ID: <20190512062009.GA25153@kroah.com>
References: <CAAie0ar11_mPipN=d=mrgnVdEMO1Np0cCYdqcRfZrij_d-5zaQ@mail.gmail.com>
 <20190510051415.GA6073@kroah.com>
 <CAAie0ao_O0hcUOuUf67oog+dSswdQRpAtX8NyQvDAr_XQr=xQg@mail.gmail.com>
 <20190510151206.GA31186@kroah.com>
 <CAAie0arnSxFvkNE1KSxD1a19_PQy03Q4RSiLZo9t7C9LeKkA9w@mail.gmail.com>
 <20190511060741.GC18755@kroah.com>
 <20190512032719.GA16296@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512032719.GA16296@zhanggen-UX430UQ>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 11:27:19AM +0800, Gen Zhang wrote:
> On Sat, May 11, 2019 at 08:07:41AM +0200, Greg KH wrote:
> > Look at the patch above, all of the whitespace is damaged.  There is no
> > way you took the raw email and then were able to apply that to the
> > kernel tree.
> > 
> > You can not cut/paste patches into gmail, please read the kernel
> > Documentation file all about email clients and how to get them to work
> > properly to send patches.
> Hi Greg,
> I switched to mutt and get rid of cut/paste.
> I patched it successffully with commit 1fb3b526df3bd7647e7854915ae6b22299408baf.
> The patch file is:
> ---
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index fdd12f8..b756609 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3350,10 +3350,14 @@ static int __init con_init(void)
>  
>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> +		if (!vc_cons[currcons].d || !vc)
> +			goto err_vc;
>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  		tty_port_init(&vc->port);
>  		visual_init(vc, currcons, 1);
>  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> +		if (!vc->vc_screenbuf)
> +			goto err_vc_screenbuf;
>  		vc_init(vc, vc->vc_rows, vc->vc_cols,
>  			currcons || !vc->vc_sw->con_save_screen);
>  	}
> @@ -3375,6 +3379,14 @@ static int __init con_init(void)
>  	register_console(&vt_console_driver);
>  #endif
>  	return 0;
> +err_vc:
> +	console_unlock();
> +	return -ENOMEM;
> +err_vc_screenbuf:
> +	console_unlock();
> +	kfree(vc);
> +	vc_cons[currcons].d = NULL;
> +	return -ENOMEM;
>  }
>  console_initcall(con_init);
>  
>  ---
> I hope that the format is not broken any more.

Yes, that worked!  Now, can you resend it in a proper format that I can
apply it in?  (with changelog text, signed-off-by, etc.) as described in
Documentation/SubmittingPatches, I will be glad to review it after the
5.2-rc1 release happens.

thanks,

greg k-h
