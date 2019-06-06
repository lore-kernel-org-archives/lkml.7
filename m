Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFA4C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B1320868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hbOr96z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfFFTXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:23:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42935 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfFFTXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:23:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so1886435pgd.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+S0wcX87X5waHh8++2TADiUtaixAR2MJn95+UMpUzAk=;
        b=hbOr96z/lV1V2iEqt9jxbsE6ILd7Bs3hopfYNeYNzpr452iz+JGuknFUGvylLoGbf6
         PaKmhDAXZZzR+RiA8JzSZtuPTOTt8ZLSVVYCnw5gxbH5RSfZMBUb7NZXKdzNd2qEggev
         A7ULi3KbHZ+irfw1cDar/VzedEmemzkFTTeGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+S0wcX87X5waHh8++2TADiUtaixAR2MJn95+UMpUzAk=;
        b=KOXjPqzRAp8LBrbdUauiD5zdQrXR+zB1ElvFd6p8jebUIHF9pJk5nlxbq9i6ZXmueN
         xvkZbGZ9oNNWE3tpMcHeD2QUNZjD7DkYBjuIdl+iWH+q3XK+kNYL0PxmLvDKArzXPT0+
         zBH3TZoxFyKhc3EZTN4SCPY0lxpXT4uwIIsHsY9L1xhWqGZH05TyMG+AyaYaH7zi672p
         njYOVcILqCw0Vdteqc7RoV+Q3RITfxcE7yceDKAnUeIdeXFVgtpAl2onKaTSPJ64WBdf
         PQrYwlR1HuBtBCxWkp9tNgGkDpUXXveiUnLaTFtD4Vtb5okKNLLG0cSB7sQ+wlB9RTzM
         4rkw==
X-Gm-Message-State: APjAAAVHaakKbe4p2cSdZvelSPmhUlK61L9G2iv+6oTQSUHQ0hEcGI6F
        R/ggElvmSTJk6Llio8VAWEjK7w==
X-Google-Smtp-Source: APXvYqw6/H0bTzmD1NtNFdjKXRgiTyCLyusI7VLYczAQnMPAF5yw1qPTSosMoYo5kE9VEEJioyBovw==
X-Received: by 2002:a63:2ad2:: with SMTP id q201mr139088pgq.94.1559848980654;
        Thu, 06 Jun 2019 12:23:00 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j13sm3262132pfh.13.2019.06.06.12.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 12:23:00 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: Fix backport of faf5a744f4f8 ("scsi: lpfc:
 avoid uninitialized variable warning")
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
References: <20190606165346.GB3249@kroah.com>
 <20190606174125.4277-1-natechancellor@gmail.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <de9bab03-437f-d4ab-df93-5f36b4216f03@broadcom.com>
Date:   Thu, 6 Jun 2019 12:22:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174125.4277-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/2019 10:41 AM, Nathan Chancellor wrote:
> Prior to commit 4c47efc140fa ("scsi: lpfc: Move SCSI and NVME Stats to
> hardware queue structures") upstream, we allocated a cstat structure in
> lpfc_nvme_create_localport. When commit faf5a744f4f8 ("scsi: lpfc: avoid
> uninitialized variable warning") was backported, it was placed after the
> allocation so we leaked memory whenever this function was called and
> that conditional was true (so whenever CONFIG_NVME_FC is disabled).
>
> Move the IS_ENABLED if statement above the allocation since it is not
> needed when the condition is true.
>
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_nvme.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
> index 099f70798fdd..645ffb5332b4 100644
> --- a/drivers/scsi/lpfc/lpfc_nvme.c
> +++ b/drivers/scsi/lpfc/lpfc_nvme.c
> @@ -2477,14 +2477,14 @@ lpfc_nvme_create_localport(struct lpfc_vport *vport)
>   	lpfc_nvme_template.max_sgl_segments = phba->cfg_nvme_seg_cnt + 1;
>   	lpfc_nvme_template.max_hw_queues = phba->cfg_nvme_io_channel;
>   
> +	if (!IS_ENABLED(CONFIG_NVME_FC))
> +		return ret;
> +
>   	cstat = kmalloc((sizeof(struct lpfc_nvme_ctrl_stat) *
>   			phba->cfg_nvme_io_channel), GFP_KERNEL);
>   	if (!cstat)
>   		return -ENOMEM;
>   
> -	if (!IS_ENABLED(CONFIG_NVME_FC))
> -		return ret;
> -
>   	/* localport is allocated from the stack, but the registration
>   	 * call allocates heap memory as well as the private area.
>   	 */

Reviewed-by: James Smart <james.smart@broadcom.com>


