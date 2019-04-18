Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E664C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD720217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BY9g7DIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbfDRPuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:50:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35177 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388301AbfDRPuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:50:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id j132so1993858oib.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iR5C0/1wNvEzxblDdXezM1jlQIqf0fGT/eYaKbBSlHI=;
        b=BY9g7DIB6XglAbf45HGfmPpeQLIqBF+412NtyT1ROM1c7hczLGKXLDQWv+FMqDYsDX
         c89jPLot440lSPeaUTOW40RlyDtw9PDPw14MWDjkmVLem0PSQj3uDkXYCKJ4uJu7TZ3G
         KAOi/mjC3OGG1QT0yWQKmXLOhI0ZmiAC+s1TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iR5C0/1wNvEzxblDdXezM1jlQIqf0fGT/eYaKbBSlHI=;
        b=NX6FG3WWFfYUNIn98z+/1TOd36wIFL3ub/2G86+ovfRsEptp3ELcFUnfOKS8fMnLnX
         KU7QvpBuCSJ7/dwflxyPS6kowIUj5dbj6rFPRbpBlncR2ANtkW1STKCm/N/wbARLHLoc
         X6v64sMbvaZ/ccmmhj1e46XsNE4DqS7gmbezgkMZBXwDwmICxzqgaR5C2Zhu5gOweMDc
         93hOJQJbGVrlNOVZ6rxgoloxbRNH0K4ot6VdPKEUb7N60c6JFVVnqdwLL1hXr5WDS5cD
         aS8iDrP36y57Yrbk6EmjlcqdFSxtxp8lo8PRCB+zstM2J4av9xDtQjZGj6FtuiD4MjO2
         +HHA==
X-Gm-Message-State: APjAAAUcJYl/92W2byP16rq7a3vtZsCr2P/1R2NwI6uwYvci7j4FMjjo
        dYzJoJ/R5C91pvC9w4/LIrMd7S51KZo=
X-Google-Smtp-Source: APXvYqxF7YoDQxd4wsFtfD/So4//RquCSmNyCxHQGjgRMT1gAXtAH4qGyNl9PGUxlhv/OzYJ0H16Bw==
X-Received: by 2002:aca:6c47:: with SMTP id h68mr2637684oic.57.1555602624365;
        Thu, 18 Apr 2019 08:50:24 -0700 (PDT)
Received: from [192.168.1.237] (ip68-5-145-143.oc.oc.cox.net. [68.5.145.143])
        by smtp.gmail.com with ESMTPSA id a23sm847713otf.69.2019.04.18.08.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 08:50:23 -0700 (PDT)
Subject: Re: [PATCH -next] scsi: lpfc: Make lpfc_sli4_oas_verify static
To:     Yue Haibing <yuehaibing@huawei.com>, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190417150554.34844-1-yuehaibing@huawei.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <f6461bd3-dae0-9520-f5f7-01e48338df01@broadcom.com>
Date:   Thu, 18 Apr 2019 08:50:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417150554.34844-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/2019 8:05 AM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> drivers/scsi/lpfc/lpfc_init.c:13091:1: warning:
>   symbol 'lpfc_sli4_oas_verify' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 8e0de48..eaaef68 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -13087,7 +13087,7 @@ lpfc_io_resume(struct pci_dev *pdev)
>    * is destroyed.
>    *
>    **/
> -void
> +static void
>   lpfc_sli4_oas_verify(struct lpfc_hba *phba)
>   {
>   

Looks good. Interesting as there's a prototype for the function earlier 
which defines it as static.

Reviewed-by:  James Smart  <james.smart@broadcom.com>

-- james

