Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813DC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48AA206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfG2NoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:44:22 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58619 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726926AbfG2NoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:44:22 -0400
Received: (qmail 23760 invoked by uid 500); 29 Jul 2019 09:44:21 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jul 2019 09:44:21 -0400
Date:   Mon, 29 Jul 2019 09:44:21 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
cc:     gregkh@linuxfoundation.org, USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: storage: sddr55: Fix a possible null-pointer
 dereference in sddr55_transport()
In-Reply-To: <20190729114936.6103-1-baijiaju1990@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1907290939250.22244-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019, Jia-Ju Bai wrote:

> In sddr55_transport(), there is an if statement on line 836 to check
> whether info->lba_to_pba is NULL:
>     if (info->lba_to_pba == NULL || ...)
> 
> When info->lba_to_pba is NULL, it is used on line 948:
>     pba = info->lba_to_pba[lba];
> 
> Thus, a possible null-pointer dereference may occur.
> 
> To fix this bug, info->lba_to_pba is checked before being used.
> 
> This bug is found by a static analysis tool STCheck written by us.

This is not the right way to fix the bug.

The code already contains a test on line 938:

		if (lba >= info->max_log_blks) {

If this test fails, the driver doesn't try to dereference 
info->lba_to_pba.

The problem is that info->max_log_blks may be set even though 
info->lba_to_pba is NULL, because the READ_CAPACITY case in 
sddr55_transport() doesn't check the return code from 
sddr55_read_map().  _That_ is what needs to be fixed.

Alan Stern

> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> v2:
> * Avoid uninitialized access of pba.
>   Thank Oliver for helpful advice.
> 
> ---
>  drivers/usb/storage/sddr55.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
> index b8527c55335b..d23aff16091e 100644
> --- a/drivers/usb/storage/sddr55.c
> +++ b/drivers/usb/storage/sddr55.c
> @@ -945,7 +945,7 @@ static int sddr55_transport(struct scsi_cmnd *srb, struct us_data *us)
>  			return USB_STOR_TRANSPORT_FAILED;
>  		}
>  
> -		pba = info->lba_to_pba[lba];
> +		pba = info->lba_to_pba ? info->lba_to_pba[lba] : 0;
>  
>  		if (srb->cmnd[0] == WRITE_10) {
>  			usb_stor_dbg(us, "WRITE_10: write block %04X (LBA %04X) page %01X pages %d\n",
> 

