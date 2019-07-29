Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB03AC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DB620C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbfG2LPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:15:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:37792 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387575AbfG2LPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:15:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A69DFAF0B;
        Mon, 29 Jul 2019 11:15:29 +0000 (UTC)
Message-ID: <1564398922.25582.6.camel@suse.com>
Subject: Re: [PATCH] usb: storage: sddr55: Fix a possible null-pointer
 dereference in sddr55_transport()
From:   Oliver Neukum <oneukum@suse.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Mon, 29 Jul 2019 13:15:22 +0200
In-Reply-To: <20190729100555.2081-1-baijiaju1990@gmail.com>
References: <20190729100555.2081-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 29.07.2019, 18:05 +0800 schrieb Jia-Ju Bai:

Hi,

> In sddr55_transport(), there is an if statement on line 836 to check
> whether info->lba_to_pba is NULL:
>     if (info->lba_to_pba == NULL || ...)
> 
> When info->lba_to_pba is NULL, it is used on line 948:
>     pba = info->lba_to_pba[lba];
> 
> Thus, a possible null-pointer dereference may occur.

Yes, in practice READ_CAPACITY will always be called and set
up the correct translation table, but you can probably exploit
this.

> To fix this bug, info->lba_to_pba is checked before being used.
> 
> This bug is found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/usb/storage/sddr55.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
> index b8527c55335b..50afc39aa21d 100644
> --- a/drivers/usb/storage/sddr55.c
> +++ b/drivers/usb/storage/sddr55.c
> @@ -945,7 +945,8 @@ static int sddr55_transport(struct scsi_cmnd *srb, struct us_data *us)
>  			return USB_STOR_TRANSPORT_FAILED;
>  		}
>  
> -		pba = info->lba_to_pba[lba];
> +		if (info->lba_to_pba)
> +			pba = info->lba_to_pba[lba];

If you use that fix, pba will be uninitialized when used. It should be
something like:

pba = info->lba_to_pba ? info->lba_to_pba[lba] : 0;

	Regards
		Oliver

