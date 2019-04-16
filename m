Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F0DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A487D20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555415358;
	bh=LtMWpHgsXULS/07QlpvX0V7UMJoYPCNQUz4xMeaOk9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C2A0G4h/UoFrzAdOi0mwJsnKUY/zEf/U8WNs4zZAwuGB4e9rR5bVDJXMdNUNFkjT1
	 60JXaRGchyPU5jIdZ5c5oPFY+ATXUvwjvzid0+GPrcDLn8RPOuYE6orqLZxtFUnbLd
	 8h7cK4T6WVXO8fGA8RKHIrbb3f53W2Avu0yeZXog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfDPLtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfDPLtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:49:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67B1C20868;
        Tue, 16 Apr 2019 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555415356;
        bh=LtMWpHgsXULS/07QlpvX0V7UMJoYPCNQUz4xMeaOk9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUAsyr9JFm02oybxsoiskXtLpIhBKJez8Ae6lSkQQOMLygsqDDWMXHmtkWIRpfgtP
         ULmkTO8gBg5pOj52XezvDytQlpM4+YzSY5TfVnrTMEFWMOSwmXC2j2RYmjJ9FklRh5
         lORPee9tzGQimdCEtM9+4ac7etrZl22dEMceJbDE=
Date:   Tue, 16 Apr 2019 13:37:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Okash Khawaja <okash.khawaja@gmail.com>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Gregory Nowak <greg@gregn.net>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jslaby@suse.com>, speakup@linux-speakup.org,
        John Covici <covici@ccs.covici.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Chris Brannon <chris@the-brannons.com>
Subject: Re: [PATCH 1/2] vt: selection: allow functions to be called from
 inside kernel
Message-ID: <20190416113740.GA18054@kroah.com>
References: <20190404194530.1170-1-okash.khawaja@gmail.com>
 <20190404194530.1170-2-okash.khawaja@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404194530.1170-2-okash.khawaja@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 08:45:29PM +0100, Okash Khawaja wrote:
> This patch breaks set_selection() into two functions so that when
> called from kernel, copy_from_user() can be avoided. It also exports
> set_selection() and paste_selection().
> 
> These changes are used the following patch where speakup's selection
> functionality calls into the above functions, thereby doing away with
> parallel implementation.
> 
> Signed-off-by: Okash Khawaja <okash.khawaja@gmail.com>
> Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Tested-by: Gregory Nowak <greg@gregn.net>
> ---
>  drivers/tty/vt/selection.c | 37 ++++++++++++++++++++++++-------------
>  include/linux/selection.h  |  3 +--
>  2 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index 07496c711d7d..a43f9cd9bdd6 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -80,6 +80,7 @@ void clear_selection(void)
>  		sel_start = -1;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(clear_selection);
>  
>  /*
>   * User settable table: what characters are to be considered alphabetic?
> @@ -164,34 +165,42 @@ static int store_utf8(u32 c, char *p)
>   *	 a lot under the lock but its hardly a performance path
>   */
>  int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *tty)
> +{
> +	struct tiocl_selection v;
> +
> +	if (copy_from_user(&v, sel, sizeof(*sel)))
> +		return -EFAULT;
> +
> +	return do_set_selection(&v, tty);
> +}
> +
> +int do_set_selection(struct tiocl_selection *v, struct tty_struct *tty)

I have no idea what the difference is between set_selection() and
do_set_selection() is now.  Naming is hard, I know :(

How about set_selection_kernel()?  set_selection_tiocl()?

Something to show that one takes a userspace pointer, and the other a
kernel pointer, how about:
	set_selection_user()
	set_selection_kernel()
making it more obvious?

thanks,

greg k-h
