Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E130CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19452084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551457426;
	bh=AzRPADFjlRyBOXMelWzI2+owh4AnrH4aaUT6pCqOKqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oxjg13lRMj5q1cdjmnfBubL4inOYrDQS9nynXRZicj0qN+arDCIbbTPQvHnCIY5RU
	 hGnltU2H6qZunxdx0GOc220H/ZiDzwQzx3KOE5kvfdWo5GcMT/MZEOqbIsSdJLJ+TA
	 CHqA6R2iY+ycVjFBvlJiI4p9/Ag2AWgaTyA0JxZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbfCAQXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:23:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388860AbfCAQXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:23:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 349AC2083D;
        Fri,  1 Mar 2019 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551457423;
        bh=AzRPADFjlRyBOXMelWzI2+owh4AnrH4aaUT6pCqOKqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UkgUJ7gO1GTQvTAPCk9w5VyK6/xGoR0HE0mT1msBh0gJ6aGsGo3ZxPVB5lry0UALP
         F3pxoF8+SbZg4hTP/72fYa5fnctedDjKisSBQ6DZyARaM9rv9RHtn83hf/358M4+kk
         cc6pyAX1/i1jgkW6mCidNk/MofclXaqR+w79Jtwk=
Date:   Fri, 1 Mar 2019 17:23:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: make default autosuspend delay configurable
Message-ID: <20190301162341.GC19937@kroah.com>
References: <20190301142646.30831-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301142646.30831-1-mans@mansr.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 02:26:46PM +0000, Mans Rullgard wrote:
> Make the default autosuspend delay configurable at build time.
> This is useful for systems that require a non-standard value as
> it avoids relying on the command line being properly set.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/usb/core/Kconfig | 8 ++++++++
>  drivers/usb/core/usb.c   | 4 ++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
> index 4d75d9a80001..38ed837538c4 100644
> --- a/drivers/usb/core/Kconfig
> +++ b/drivers/usb/core/Kconfig
> @@ -90,3 +90,11 @@ config USB_LEDS_TRIGGER_USBPORT
>  	  This driver allows LEDs to be controlled by USB events. Enabling this
>  	  trigger allows specifying list of USB ports that should turn on LED
>  	  when some USB device gets connected.
> +
> +config USB_AUTOSUSPEND_DELAY
> +	int "Default autosuspend delay"
> +	depends on USB
> +	default 2
> +	help
> +	  The default autosuspend delay in seconds.  Can be overridden
> +	  with the usbcore.autosuspend command line or module parameter.

As everyone is suddenly going to be hit with this for a new kernel
upate, you might want to put something in here that says:
	The default value Linux has always had is 2 seconds.  Change
	this value if you want a different delay timeframe and can not
	modify the command line or module parameter option.

to make people a lot more comfortable with this change.

thanks,

greg k-h
