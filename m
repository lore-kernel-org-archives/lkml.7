Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A25C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA8A21019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfCMSBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:01:09 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:53864 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725876AbfCMSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:01:09 -0400
Received: (qmail 6912 invoked by uid 2102); 13 Mar 2019 14:01:08 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Mar 2019 14:01:08 -0400
Date:   Wed, 13 Mar 2019 14:01:08 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Aditya Pakki <pakki001@umn.edu>
cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: storage: Fix potential NULL pointer derefernce
In-Reply-To: <20190313174858.23859-1-pakki001@umn.edu>
Message-ID: <Pine.LNX.4.44L0.1903131355570.1405-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019, Aditya Pakki wrote:

> Allocating memory via kcalloc for pba_to_lba and lba_to_pba can
> fail. The fix avoids a potential NULL pointer dereference.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/usb/storage/alauda.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 6b8edf6178df..41d979e70784 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -438,6 +438,11 @@ static int alauda_init_media(struct us_data *us)
>  	MEDIA_INFO(us).pba_to_lba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
>  	MEDIA_INFO(us).lba_to_pba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
>  
> +	if (!MEDIA_INFO(us).pba_to_lba || !MEDIA_INFO(us).lba_to_pba) {
> +		pr_warn("%s: Failed to allocate memory\n", __func__);
> +		return USB_STOR_TRANSPORT_ERROR;
> +	}
> +
>  	if (alauda_reset_media(us) != USB_STOR_XFER_GOOD)
>  		return USB_STOR_TRANSPORT_ERROR;

In fact this won't accomplish anything, because the return value from 
alauda_init_media() isn't used.  The driver appears to need more than 
a single change.

Alan Stern

