Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B954FC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5D5206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3Tcex77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbfG2Lva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:51:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38825 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387482AbfG2Lva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:51:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id az7so27408357plb.5;
        Mon, 29 Jul 2019 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WqRMMRupBKE7/qZ1bepdmX1qSW8ae9qt5Rfev+leb0o=;
        b=o3Tcex775jyj393JOvhgfSQii40lor3lqmNDKnKYrp4RyejYNoFeZbb8c+8pHt4RUG
         mB6AxYPQvl7abU759YyuyhcmO5iL9CsftWKLqXLuZ+S+1GPKKB34WV/RuoFQFOEVbtCl
         ADt6brn5ZQXcjAG8WBkjUJ5DanrJmS8CEQ1YB5Kd2yIM6RdocFKPgm8hayCic59SN1NX
         sMca4fzw6Dy1UYzEsTTAOO5yFzj8bkDh902E2aNoZpDIoZA/4pw0hC+g6NH3cIyrEjCN
         CdaXtKIq5jL3Enwq94oGP4JwHwlboX/YjQMY1pDRMJvNLeOJaoDblYQy5h+WpCFcpYFu
         Ulcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WqRMMRupBKE7/qZ1bepdmX1qSW8ae9qt5Rfev+leb0o=;
        b=F0w+F5xlo06yYxujSZGfIi3Bn5zYNp7dagM6Xv6S4Hi8oiTnTU0F5GsPoM6fR8tdOv
         M8c8jS1XK31KYhnj5t2pBOANZ+L/BRMBmHq2+U1CIiZ8QvdzDQYPaOGNzZHweHn61gFF
         CxjIx07hXzzvZVaL1tJDRGtLEB7lDGsjPGU9c0JJbLwkOjI6BrT76N3/jHAd9/g2Mhwp
         4LXB7edcxt7QTR32528NK7mdd2Q6v2r6Lc1Wap+Zv//Ua/S81VKkqWa+cRT7MobSe4ls
         jo3Cx/lJ2GLo7N+ZqRbGdmb2IIb+vAIWHZ19FUT5/vy5t/e3CE+/q2kUkh9VUOXS+TMD
         7vgw==
X-Gm-Message-State: APjAAAXvQ8TrmEqZErZpOJe4JmEullBLJA6Q1Iv2k6TBq/QBOpaKwH0F
        SWmUwPxrHGSD8uvorD8GL5ZRqu0AkMw=
X-Google-Smtp-Source: APXvYqxoLosNXhTxkQU9yUOK5c7Ht5RUsb+YjkuU+pomYjU99vvynJxGwZxviUZ+S7Apez3HVTQGyw==
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr107924212plp.262.1564401089268;
        Mon, 29 Jul 2019 04:51:29 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id h11sm62244985pfn.120.2019.07.29.04.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 04:51:28 -0700 (PDT)
Subject: Re: [PATCH v2] usb: storage: sddr55: Fix a possible null-pointer
 dereference in sddr55_transport()
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        Oliver Neukum <oneukum@suse.com>
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
References: <20190729114936.6103-1-baijiaju1990@gmail.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <b843a770-2262-3d0a-75ee-8c714d804963@gmail.com>
Date:   Mon, 29 Jul 2019 19:51:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729114936.6103-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to send to Oliver, so send it again.

On 2019/7/29 19:49, Jia-Ju Bai wrote:
> In sddr55_transport(), there is an if statement on line 836 to check
> whether info->lba_to_pba is NULL:
>      if (info->lba_to_pba == NULL || ...)
>
> When info->lba_to_pba is NULL, it is used on line 948:
>      pba = info->lba_to_pba[lba];
>
> Thus, a possible null-pointer dereference may occur.
>
> To fix this bug, info->lba_to_pba is checked before being used.
>
> This bug is found by a static analysis tool STCheck written by us.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> v2:
> * Avoid uninitialized access of pba.
>    Thank Oliver for helpful advice.
>
> ---
>   drivers/usb/storage/sddr55.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
> index b8527c55335b..d23aff16091e 100644
> --- a/drivers/usb/storage/sddr55.c
> +++ b/drivers/usb/storage/sddr55.c
> @@ -945,7 +945,7 @@ static int sddr55_transport(struct scsi_cmnd *srb, struct us_data *us)
>   			return USB_STOR_TRANSPORT_FAILED;
>   		}
>   
> -		pba = info->lba_to_pba[lba];
> +		pba = info->lba_to_pba ? info->lba_to_pba[lba] : 0;
>   
>   		if (srb->cmnd[0] == WRITE_10) {
>   			usb_stor_dbg(us, "WRITE_10: write block %04X (LBA %04X) page %01X pages %d\n",

