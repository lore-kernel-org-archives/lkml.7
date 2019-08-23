Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF98BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 17:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858EF21848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 17:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566582240;
	bh=5+lhchtJYRPd1IgdCHPyEugqeonz+HlG1kNBjHafB3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Puy6nRpdMu3lQY9yTnmhtUgTBlcy+zJEtTq3LOJptyw5gXGWFpevqMKJI2j82Z8Zp
	 UOKPrYdGvCrkLVhMNIFM1BtGjfkpmPg3yXNOUvhqUDZCE8zTS42QiKnRDjZZc3Z42H
	 q9+KGzMe/NZLecsFBMW9oFnf49ZL+RB0trx5G/sQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbfHWRn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 13:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfHWRn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 13:43:59 -0400
Received: from localhost (unknown [104.129.198.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A782082F;
        Fri, 23 Aug 2019 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566582238;
        bh=5+lhchtJYRPd1IgdCHPyEugqeonz+HlG1kNBjHafB3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sguKy5qxO5G+XQgTyhqcxRAp7a5BJU7Wx6e07cSjbuBIKQPDE7m9kfXuQTL/cFssZ
         Up6hbdt2HozekL5jClJAnX6Tgk7L5zDfx4H8EYNfRhuoyxLrGYVmvrBamtb0lSh0Qy
         kDzHg+U6j0Cw/qGrqzyC1c8X8Pt9zyzjSpO2QuCI=
Date:   Fri, 23 Aug 2019 10:43:57 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adam Zerella <adam.zerella@gmail.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia/i82092: Refactored dprintk macro for pr_debug().
Message-ID: <20190823174357.GA8052@kroah.com>
References: <20190823062951.1168-1-adam.zerella@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823062951.1168-1-adam.zerella@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 04:29:49PM +1000, Adam Zerella wrote:
> As pointed out in https://kernelnewbies.org/KernelJanitors/Todo
> this patch replaces the outdated macro of DPRINTK for pr_debug()
> 
> To: Dominik Brodowski <linux@dominikbrodowski.net>
> To: Thomas Gleixner <tglx@linutronix.de>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> To: Adam Zerella <adam.zerella@gmail.com>
> To: linux-kernel@vger.kernel.org
> Signed-off-by: Adam Zerella <adam.zerella@gmail.com>
> ---
>  drivers/pcmcia/i82092.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
> index ec54a2aa5cb8..e1929520c20e 100644
> --- a/drivers/pcmcia/i82092.c
> +++ b/drivers/pcmcia/i82092.c
> @@ -117,9 +117,9 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
>  		
>  		if (card_present(i)) {
>  			sockets[i].card_state = 3;
> -			dprintk(KERN_DEBUG "i82092aa: slot %i is occupied\n",i);
> +			pr_debug("i82092aa: slot %i is occupied\n", i);
>  		} else {
> -			dprintk(KERN_DEBUG "i82092aa: slot %i is vacant\n",i);
> +			pr_debug("i82092aa: slot %i is vacant\n", i);

These really should use dev_dbg() instead, as this is a driver and you
have access to a real device here.


>  		}
>  	}
>  		
> @@ -128,7 +128,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
>  	pci_write_config_byte(dev, 0x50, configbyte); /* PCI Interrupt Routing Register */
>  
>  	/* Register the interrupt handler */
> -	dprintk(KERN_DEBUG "Requesting interrupt %i \n",dev->irq);
> +	pr_debug("Requesting interrupt %i\n", dev->irq);

Same here.

thanks,

greg k-h
