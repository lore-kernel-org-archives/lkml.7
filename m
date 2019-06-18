Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402AFC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141EC20873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVC13Eod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbfFRWrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:47:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32980 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbfFRWrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:47:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id r6so9740482qkc.0;
        Tue, 18 Jun 2019 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rJ2uZJ6XqB8/2Fk6uQ8PHbaqDyVHTlFhc7tBGwxJahY=;
        b=kVC13Eod3AfTi6bVjTwaWvE25nMGmsoUfESPEb/DTyq0GmaaWZcNaymkesOL5AN9Fl
         /opIrrNlTBw52esOfMKS/ZznjP+EBsfkDFug5ZLT+GMIEXssJ3P9x8a7jAmVbvEp8ZRz
         S8/9s92bZWq4Z3EqkutzGnISv1r4UXjq/sqtDVJZIoj0ifEe3AZEi2zxGv03WrHM08t7
         xD5ykdEcAx37+djj79xGHHcpFr7Lv53ekIp3NBJjalzBGU2p06oQr/0oWYELDqY9KHNW
         77xn8gYh47g3twkAqbHifox/lFsh04HNeWAY346CXxwdu+upuul9iG0q2SPA7r+kNIOx
         oFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rJ2uZJ6XqB8/2Fk6uQ8PHbaqDyVHTlFhc7tBGwxJahY=;
        b=E7gXQz3T3GP9lG4sTCX52XMAKO4piFiJ4gWTYPGB9W3dA17Fpc3S5d1xP7fFaEn6LD
         a3Fuk4rVLoet8VdWqPRf4HcOTlq4KuZwXcL9cZXwZmQ+kJwoZQlzFWoQRAZ5M361kNpw
         sb4HCgHZ6X5SxvK1MCp7vEFb9WqB01nha9F00Sb8j21g09p4lL/+tdUVV8MMongrJnB8
         nAXU6mFAJM3K742scPcSTe0cJdcIcZq2haSHF0SwV+Qq9KNnrvTjNmYs1vhawf9HnEQ4
         N2Z1zAa7Dyf794rfQyqyfJObTURJu3zx9zsMw/w3EyU4QpySjY/w4kllsaskZ2GJuJ3c
         7lEg==
X-Gm-Message-State: APjAAAWddOihuRCU1yTAc1UrIirUz+DAh+Ygvk4rUqfpBnUdUJs1eEDM
        /1+ocz8qL9B4rQrvnPEsO+CIZiO1ka4=
X-Google-Smtp-Source: APXvYqxZRxGEhPfD1o5gmQKDINNgHyFWAU6ItUa0Mmw/JFz4B8sShNRfJA/OmSM+KFJqrfhQIwZuiQ==
X-Received: by 2002:a37:4d16:: with SMTP id a22mr94974865qkb.103.1560898023004;
        Tue, 18 Jun 2019 15:47:03 -0700 (PDT)
Received: from continental ([186.212.50.252])
        by smtp.gmail.com with ESMTPSA id b23sm10253809qte.19.2019.06.18.15.47.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 15:47:02 -0700 (PDT)
Date:   Tue, 18 Jun 2019 19:47:36 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] scsi: scsi_sysfs.c: Hide wwid sdev attr if VPD is not
 supported
Message-ID: <20190618224734.GB11899@continental>
References: <20190612020828.8140-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612020828.8140-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping? Can anybody take a look at this patch?

Thanks,
Marcos

On Tue, Jun 11, 2019 at 11:08:28PM -0300, Marcos Paulo de Souza wrote:
> WWID composed from VPD data from device, specifically page 0x83. So,
> when a device does not have VPD support, for example USB storage devices
> where VPD is specifically disabled, a read into <blk device>/device/wwid
> file will always return ENXIO. To avoid this, change the
> scsi_sdev_attr_is_visible function to hide wwid sysfs file when the
> devices does not support VPD.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  drivers/scsi/scsi_sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index dbb206c90ecf..bfd890fa0c69 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -1159,6 +1159,9 @@ static umode_t scsi_sdev_attr_is_visible(struct kobject *kobj,
>  	struct device *dev = container_of(kobj, struct device, kobj);
>  	struct scsi_device *sdev = to_scsi_device(dev);
>  
> +	/* do not present wwid if the device does not support VPD */
> +	if (attr == &dev_attr_wwid.attr && sdev->skip_vpd_pages)
> +		return 0;
>  
>  	if (attr == &dev_attr_queue_depth.attr &&
>  	    !sdev->host->hostt->change_queue_depth)
> -- 
> 2.21.0
> 
