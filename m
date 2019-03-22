Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2882C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8129D21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IHEZy86J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfCVQrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:47:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43327 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfCVQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:47:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so1901862pfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K875wjAwkZl75zaoc/3T/DTeSTNRlQQDrBjQ2RVTMHY=;
        b=IHEZy86JyvZfceNIg+Bu7ywr3COVzubuLbQb6Lo1sOkexzBbs4Ayb7FXxyC1CvG+je
         gf/C8iBxD/COjeLM338gLvkUyZWB8w1LQHfqrlO1FDOKb/rru1dgDiGxDQOnkeJok6JK
         vhGOdF8n2CNfKbax+c6rDvIvbIfPr4w7Z/ZKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K875wjAwkZl75zaoc/3T/DTeSTNRlQQDrBjQ2RVTMHY=;
        b=B1WzaPPLNj0ygJUgaOMyoB2sILvteZk6Z2LYzJ2ZjIU2H1aTrqjtNQAAY2dWIin8jI
         Kxkw0ffja9wY50xtHJsf0Bw5eX9TmXZoIFnrTDNzLC+VjWlIkvBFJnFnCy0UGQVpWkyX
         NrYNbz/tGUWaugJy8RdOvM7lVNWAuhGT5AOa8p8A4uGKWXt7kyku/f57u6gyd4LM59QR
         EN73u9t/KlZAs2TAsZsSkMCIsyfiwejq3iDjRZeHo1hZS6HUkLV9ICbtSuQkQtbpos0X
         NF3/7Z1jkgo8HTytfk6YXt3YDYKSXY4NDV+H1yo5QPC0JyXngzrkcKCJIBxT73aVT+lV
         rn2Q==
X-Gm-Message-State: APjAAAXKoR0faV/FKekFmx/yuKI9Mr8k0KWXidMBV+2d8mCDJSURxnhI
        40RNmcZnBCzfRJEYal+I2L+0FaS+QDjdUGWKJRPeNWh+3dMwaAHV0ym61CzT8R+/8PEgo4MPCWR
        SDDeECfpRYoxkIVBHJTobipUqG00tz6WPuYm+eyxw9RCW48lcJF4d2GXYJ8BCnXCU/sH3G1RUlh
        o4dxY=
X-Google-Smtp-Source: APXvYqwvTLBpoq4j8SsqXCtWFBmWzVaMHEyHp2mBB01nhBVjLGdJE3Tzleu8IYjzwQWzDY4edRhNBQ==
X-Received: by 2002:a63:d542:: with SMTP id v2mr9984635pgi.52.1553273236324;
        Fri, 22 Mar 2019 09:47:16 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d3sm10921579pfc.125.2019.03.22.09.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 09:47:15 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: avoid uninitialized variable warning
To:     Arnd Bergmann <arnd@arndb.de>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190322142557.929966-1-arnd@arndb.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <1a302ccb-2f9d-560d-8b07-eb5382684b76@broadcom.com>
Date:   Fri, 22 Mar 2019 09:47:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190322142557.929966-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/2019 7:25 AM, Arnd Bergmann wrote:
> clang -Wuninitialized incorrectly sees a variable being used without
> initialization:
>
> drivers/scsi/lpfc/lpfc_nvme.c:2102:37: error: variable 'localport' is uninitialized when used here
>        [-Werror,-Wuninitialized]
>                  lport = (struct lpfc_nvme_lport *)localport->private;
>                                                    ^~~~~~~~~
> drivers/scsi/lpfc/lpfc_nvme.c:2059:38: note: initialize the variable 'localport' to silence this warning
>          struct nvme_fc_local_port *localport;
>                                              ^
>                                               = NULL
> 1 error generated.
>
> This is clearly in dead code, as the condition leading up to it is
> always false when CONFIG_NVME_FC is disabled, and the variable
> is always initialized when nvme_fc_register_localport() got
> called successfully.
>
> Change the preprocessor conditional to the equivalent C construct,
> which makes the code more readable and gets rid of the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/scsi/lpfc/lpfc_nvme.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
> index 1aa00d2c3f74..9defff711884 100644
> --- a/drivers/scsi/lpfc/lpfc_nvme.c
> +++ b/drivers/scsi/lpfc/lpfc_nvme.c
> @@ -2080,15 +2080,15 @@ lpfc_nvme_create_localport(struct lpfc_vport *vport)
>   		lpfc_nvme_template.max_hw_queues =
>   			phba->sli4_hba.num_present_cpu;
>   
> +	if (!IS_ENABLED(CONFIG_NVME_FC))
> +		return ret;
> +
>   	/* localport is allocated from the stack, but the registration
>   	 * call allocates heap memory as well as the private area.
>   	 */
> -#if (IS_ENABLED(CONFIG_NVME_FC))
> +
>   	ret = nvme_fc_register_localport(&nfcp_info, &lpfc_nvme_template,
>   					 &vport->phba->pcidev->dev, &localport);
> -#else
> -	ret = -ENOMEM;
> -#endif
>   	if (!ret) {
>   		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME | LOG_NVME_DISC,
>   				 "6005 Successfully registered local "

Looks good

Reviewed-By: James Smart <james.smart@broadcom.com>

-- james

