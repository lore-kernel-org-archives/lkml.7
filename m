Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FFFC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DC721907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfIROji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:39:38 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:53284 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725902AbfIROji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:39:38 -0400
Received: (qmail 3498 invoked by uid 2102); 18 Sep 2019 10:39:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Sep 2019 10:39:37 -0400
Date:   Wed, 18 Sep 2019 10:39:37 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Matthias Maennich <maennich@google.com>
cc:     linux-kernel@vger.kernel.org, <kernel-team@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH] usb-storage: SCSI glue: use pr_fmt and pr_err
In-Reply-To: <20190917231031.81341-1-maennich@google.com>
Message-ID: <Pine.LNX.4.44L0.1909181036090.1507-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019, Matthias Maennich wrote:

> Follow common practice and retire printk(KERN_ERR ...) in favor of
> pr_fmt and pr_err.

As long as you're changing this, why not change it to dev_err() 
instead?  That would be a lot more useful.

> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: usb-storage@lists.one-eyed-alien.net
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>  drivers/usb/storage/scsiglue.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> index 6737fab94959..0b6fa225b352 100644
> --- a/drivers/usb/storage/scsiglue.c
> +++ b/drivers/usb/storage/scsiglue.c
> @@ -28,6 +28,8 @@
>   * status of a command.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/blkdev.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/module.h>
> @@ -379,8 +381,7 @@ static int queuecommand_lck(struct scsi_cmnd *srb,
>  
>  	/* check for state-transition errors */
>  	if (us->srb != NULL) {
> -		printk(KERN_ERR "usb-storage: Error in %s: us->srb = %p\n",
> -			__func__, us->srb);
> +		pr_err("Error in %s: us->srb = %p\n", __func__, us->srb);
>  		return SCSI_MLQUEUE_HOST_BUSY;
>  	}

		dev_err(&us->pusb_intf->dev, "Error in ...

Alan Stern

