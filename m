Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69043C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8F721927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568885377;
	bh=KrLnWU/9gwbq35alpkpIodhigbzAcDozcpZYhH1dTL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KzsV9hU7GdHFxEwChVPNizzVib6n9i5eFsvcXbudhMIrRTF6tx06SCcgJK3XjRm7H
	 jpMSLy9faAH4rCtq+SrGGIs1RbaY69XKbPkbAui9Udk0JUtQ5RMuVgNonPoi1jpMtc
	 9c7IPjZ9P93g7c0CyWr1l/gpiep6gYCWYqcKFTkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388760AbfISJ3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbfISJ3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:29:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F321721924;
        Thu, 19 Sep 2019 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568885375;
        bh=KrLnWU/9gwbq35alpkpIodhigbzAcDozcpZYhH1dTL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVwcLDwJ3Hk953YT1U2lwnhjYSvxCDSm3xvYHSVOCFgXTLW+WenSOPm+g2wfU193Q
         rnqLwW+6a+NGWTIgll6+45eoh+a8xhtUia0XurNzMPRbsTwZnxvoGB6r0VeUN6GD72
         OXYDsjHleJnaiAL1zChT4IAXZq+BU96wbGHeImHc=
Date:   Thu, 19 Sep 2019 11:29:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     penberg@cs.helsinki.fi, jslaby@suse.com, nico@fluxnic.net,
        textshell@uchuujin.de, sam@ravnborg.org, daniel.vetter@ffwll.ch,
        mpatocka@redhat.com, ghalat@redhat.com,
        linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        yuehaibing@huawei.com, zengweilin@huawei.com
Subject: Re: [PATCH] tty:vt: Add check the return value of kzalloc to avoid
 oops
Message-ID: <20190919092933.GA2684163@kroah.com>
References: <1568884695-56789-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568884695-56789-1-git-send-email-nixiaoming@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 05:18:15PM +0800, Xiaoming Ni wrote:
> Using kzalloc() to allocate memory in function con_init(), but not
> checking the return value, there is a risk of null pointer references
> oops.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

We keep having this be "reported" :(

> ---
>  drivers/tty/vt/vt.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 34aa39d..db83e52 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3357,15 +3357,33 @@ static int __init con_init(void)
>  
>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> +		if (unlikely(!vc)) {
> +			pr_warn("%s:failed to allocate memory for the %u vc\n",
> +					__func__, currcons);
> +			break;
> +		}

At init, this really can not happen.  Have you see it ever happen?

>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  		tty_port_init(&vc->port);
>  		visual_init(vc, currcons, 1);
>  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> +		if (unlikely(!vc->vc_screenbuf)) {

Never use likely/unlikely unless you can actually measure the speed
difference.  For something like this, the compiler will always get it
right without you having to do anything.

And again, how can this fail?  Have you seen it fail?

> +			pr_warn("%s:failed to allocate memory for the %u vc_screenbuf\n",
> +					__func__, currcons);
> +			visual_deinit(vc);
> +			tty_port_destroy(&vc->port);
> +			kfree(vc);
> +			vc_cons[currcons].d = NULL;
> +			break;
> +		}
>  		vc_init(vc, vc->vc_rows, vc->vc_cols,
>  			currcons || !vc->vc_sw->con_save_screen);
>  	}
>  	currcons = fg_console = 0;
>  	master_display_fg = vc = vc_cons[currcons].d;
> +	if (unlikely(!vc)) {

Again, never use likely/unlikely unless you can measure it.

thanks,

greg k-h
