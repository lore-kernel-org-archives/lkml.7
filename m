Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7340C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4E321473
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfCYOPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:15:17 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46544 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729036AbfCYOPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:15:16 -0400
Received: (qmail 1743 invoked by uid 2102); 25 Mar 2019 10:15:15 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2019 10:15:15 -0400
Date:   Mon, 25 Mar 2019 10:15:15 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kangjie Lu <kjlu@umn.edu>
cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: sierra: fix a missing check of device_create_file
In-Reply-To: <20190325030828.14068-1-kjlu@umn.edu>
Message-ID: <Pine.LNX.4.44L0.1903251013140.1485-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019, Kangjie Lu wrote:

> device_create_file() could fail and return an error code. The fix
> captures the error and returns the error code upstream in case it
> indeed failed.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/usb/storage/sierra_ms.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
> index 6ac60abd2e15..e605cbc3d8bf 100644
> --- a/drivers/usb/storage/sierra_ms.c
> +++ b/drivers/usb/storage/sierra_ms.c
> @@ -194,8 +194,6 @@ int sierra_ms_init(struct us_data *us)
>  		kfree(swocInfo);
>  	}
>  complete:
> -	result = device_create_file(&us->pusb_intf->dev, &dev_attr_truinst);
> -
> -	return 0;
> +	return device_create_file(&us->pusb_intf->dev, &dev_attr_truinst);
>  }

Acked-by: Alan Stern <stern@rowland.harvard.edu>

It's possible the original author intended the function to succeed even 
if device_create_file() failed, since the information in the file 
doesn't seem to be very important.  However, I will accept the patch.

Alan Stern

