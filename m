Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148F2ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE0020640
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570606564;
	bh=u62iNippa5w88chTaJSrpi3M6YT+mGPG5fZ77H/XMDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2Wp5oHS0eSCNQ8TB8KkwMX8TYYzYqf395fHrZ9tzuEgEnLpdh0Xs6a1s9wWSvSVkK
	 Q0/1UD7EjOGJHAbqPPu0CK1uraoApCyb/s+H+mtWeKVnGRnEV9UJin2hGFXWFiZ1s8
	 l4DyLzqcd6DfbnktbawyxPbLe/PAQDU3pOeOjc+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfJIHgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:36:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39182 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIHgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:36:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id 72so860419lfh.6;
        Wed, 09 Oct 2019 00:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H4s22O9yrONV6K2bKGNRmMX7WZ/qHYrSHJaAVj/civE=;
        b=pizxNY8W9ehmGmgodyQUM12lLcRix788SpoMTj1qtSWPEyYBeIb6L61t2hpIXqG1bK
         4zUPMhNZvCqHtxc+ZnuFeyH2Z2EbyxF0r/sbI03YcH5u4Y9HVEJT7dAf2dRM9LcgGiVD
         sqC9y7tuMMGx1RBybnLkZK7m2l8k2Pb7eAspJ+5g1L2CN+8eTg2ItyVyCa7hznohX394
         OBTrCa8hEbv+mBq6zzBosN6vgLDMP83w5iCTPSMGUj7OghGJ+PrRQNeaHl7SIJuR6cfi
         W9dSIXOINDCiOSUnhEmnMYjjkU9tLpdU0yJnbNtPFqWiEZV9iBRFaRqRhKMrk4G4xuWL
         LVuQ==
X-Gm-Message-State: APjAAAVdgHjIWpEr3ef3++I+Sh/khwihCIMtaygGaILGieehwd7938qz
        62t/1jzWFtUvc0+vvi2+mYk=
X-Google-Smtp-Source: APXvYqzC/rsxc92Fbh12EafJ9Kag2ILA+2fy0RYYuAPqPj9U1HDpjk7vqWVLo2FGxgushW0cVEW2bA==
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr1087087lfq.72.1570606559683;
        Wed, 09 Oct 2019 00:35:59 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id t8sm271579ljd.18.2019.10.09.00.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 00:35:58 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iI6Vz-0003e8-RG; Wed, 09 Oct 2019 09:36:07 +0200
Date:   Wed, 9 Oct 2019 09:36:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+0761012cebf7bdb38137@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: iowarrior: fix access to freed data structure
Message-ID: <20191009073607.GB27819@localhost>
References: <20191008222307.18587-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008222307.18587-1-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 12:23:07AM +0200, Valentin Vidic wrote:
> struct iowarrior gets freed prematurely in iowarrior_release while
> it is still being referenced from usb_interface, so let only
> iowarrior_disconnect call iowarrior_delete.

The proposed fix is broken since release() may happen long after
disconnect(), in which case you'd now leak memory.

> Fixes: KMSAN: uninit-value in iowarrior_disconnect

Fixes tags are supposed to refer to the commit introducing the issue.

> Reported-by: syzbot+0761012cebf7bdb38137@syzkaller.appspotmail.com
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
>  drivers/usb/misc/iowarrior.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> index f5bed9f29e56..0492ea76c4bf 100644
> --- a/drivers/usb/misc/iowarrior.c
> +++ b/drivers/usb/misc/iowarrior.c
> @@ -638,7 +638,6 @@ static int iowarrior_open(struct inode *inode, struct file *file)
>  static int iowarrior_release(struct inode *inode, struct file *file)
>  {
>  	struct iowarrior *dev;
> -	int retval = 0;
>  
>  	dev = file->private_data;
>  	if (!dev)
> @@ -650,27 +649,23 @@ static int iowarrior_release(struct inode *inode, struct file *file)
>  	mutex_lock(&dev->mutex);
>  
>  	if (dev->opened <= 0) {
> -		retval = -ENODEV;	/* close called more than once */
>  		mutex_unlock(&dev->mutex);
> -	} else {
> -		dev->opened = 0;	/* we're closing now */
> -		retval = 0;
> -		if (dev->present) {
> -			/*
> -			   The device is still connected so we only shutdown
> -			   pending read-/write-ops.
> -			 */
> -			usb_kill_urb(dev->int_in_urb);
> -			wake_up_interruptible(&dev->read_wait);
> -			wake_up_interruptible(&dev->write_wait);
> -			mutex_unlock(&dev->mutex);
> -		} else {
> -			/* The device was unplugged, cleanup resources */
> -			mutex_unlock(&dev->mutex);
> -			iowarrior_delete(dev);

So you cannot just remove this bit.

> -		}
> +		return -ENODEV;	/* close called more than once */
>  	}
> -	return retval;
> +
> +	dev->opened = 0;	/* we're closing now */
> +	if (dev->present) {
> +		/*
> +		 * The device is still connected so we only shutdown
> +		 * pending read/write ops.
> +		 */
> +		usb_kill_urb(dev->int_in_urb);
> +		wake_up_interruptible(&dev->read_wait);
> +		wake_up_interruptible(&dev->write_wait);
> +	}
> +
> +	mutex_unlock(&dev->mutex);
> +	return 0;
>  }
>  
>  static __poll_t iowarrior_poll(struct file *file, poll_table * wait)

Johan
