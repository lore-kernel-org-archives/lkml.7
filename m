Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610D7C2D0BE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3997120836
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FNFsQi1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLIRs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:48:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37569 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfLIRsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:48:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so235227wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 09:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X/QxkqoCfNiDwbQBCosbR1xXW2Kn7mUOpxj7Z6Ec4tQ=;
        b=FNFsQi1Ziq/g/TKpDjaB0oQo/xJ2w1yIoCHEIB+IWEbbT4RHkwM++ZkmUJhfYnK/4f
         DC+M843zmrYieXNJUjLeJFMOhGkF/81Hn4G3BYMZm3Y8F68htLlFurK7quXInOmRpH1u
         3I1MeGlEko3ljtZKwhKApuHKK9J2hiRkzk9Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X/QxkqoCfNiDwbQBCosbR1xXW2Kn7mUOpxj7Z6Ec4tQ=;
        b=Km9jOR4wQ9DABiQTOG46qfMkS1vBxGajVz/iOltOL7S0zVaEiicFLyhe05/l+MUK/6
         FmAuZUShlMlP1Feu9hYRINV1/ckAff0Wf2UchNLGfH0nz4L0T/APxn4d2jM9s53bgDHi
         3rr2T07MUxBzYI57npyq5UU63mknk3y5tCdVk7JYUxzRGCz0wBKYUNoZ/VwwIvV3tugj
         iNmpISOw+HUEXpGOGIlEHj32G6uEUCc+XwMxR9zoI12DdXuluePrmLwtlNJgQa4FOMfz
         5dOEeu00A5TcUXEBNIYC4rgp2Ess8gKhMAV+VZLEdoJhou1h/8Pn5DbNOXK8PfSoKcEW
         ACWQ==
X-Gm-Message-State: APjAAAWOzZMxyd51pKbdtCDaxHkJ94eeCj7FrkJpff7U2Gzt8gmyUAaZ
        0MqJUxC9GOS9Iqjwg6f3VAJJwg==
X-Google-Smtp-Source: APXvYqzhlTWGpGQUoj9DvSwIF0wdyqpSte9sh0cRZC2pBSzgYOQm+C5Kw7pJkCaSFtgwmOixc6RSFw==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr242739wmi.152.1575913728145;
        Mon, 09 Dec 2019 09:48:48 -0800 (PST)
Received: from [10.69.49.110] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n12sm131452wmd.1.2019.12.09.09.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 09:48:47 -0800 (PST)
Subject: Re: [PATCH] scsi:lpfc:Fix memory leak on lpfc_bsg_write_ebuf_set func
To:     "wubo (T)" <wubo40@huawei.com>,
        "dick.kennedy@broadcom.com" <dick.kennedy@broadcom.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>
References: <EDBAAA0BBBA2AC4E9C8B6B81DEEE1D6915E7A966@DGGEML525-MBS.china.huawei.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <4afb52b8-c3ff-8c29-2597-11b8428e75b1@broadcom.com>
Date:   Mon, 9 Dec 2019 09:48:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <EDBAAA0BBBA2AC4E9C8B6B81DEEE1D6915E7A966@DGGEML525-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2019 7:22 PM, wubo (T) wrote:
> When phba->mbox_ext_buf_ctx.seqNum != phba->mbox_ext_buf_ctx.numBuf,
> dd_data should be freed before return SLI_CONFIG_HANDLED.
>
> When lpfc_sli_issue_mbox func return fails, pmboxq should be also freed in job_error tag.
>
>
> Signed-off-by:Bo wu <wubo40@huawei.com>
> Reviewed-by:Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>   drivers/scsi/lpfc/lpfc_bsg.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
> index 39a736b887b1..6c2b03415a2c 100644
> --- a/drivers/scsi/lpfc/lpfc_bsg.c
> +++ b/drivers/scsi/lpfc/lpfc_bsg.c
> @@ -4489,12 +4489,6 @@ lpfc_bsg_write_ebuf_set(struct lpfc_hba *phba, struct bsg_job *job,
>   	phba->mbox_ext_buf_ctx.seqNum++;
>   	nemb_tp = phba->mbox_ext_buf_ctx.nembType;
>   
> -	dd_data = kmalloc(sizeof(struct bsg_job_data), GFP_KERNEL);
> -	if (!dd_data) {
> -		rc = -ENOMEM;
> -		goto job_error;
> -	}
> -
>   	pbuf = (uint8_t *)dmabuf->virt;
>   	size = job->request_payload.payload_len;
>   	sg_copy_to_buffer(job->request_payload.sg_list,
> @@ -4531,6 +4525,13 @@ lpfc_bsg_write_ebuf_set(struct lpfc_hba *phba, struct bsg_job *job,
>   				"2968 SLI_CONFIG ext-buffer wr all %d "
>   				"ebuffers received\n",
>   				phba->mbox_ext_buf_ctx.numBuf);
> +
> +		dd_data = kmalloc(sizeof(struct bsg_job_data), GFP_KERNEL);
> +		if (!dd_data) {
> +			rc = -ENOMEM;
> +			goto job_error;
> +		}
> +
>   		/* mailbox command structure for base driver */
>   		pmboxq = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
>   		if (!pmboxq) {
> @@ -4579,6 +4580,8 @@ lpfc_bsg_write_ebuf_set(struct lpfc_hba *phba, struct bsg_job *job,
>   	return SLI_CONFIG_HANDLED;
>   
>   job_error:
> +	if (pmboxq)
> +		mempool_free(pmboxq, phba->mbox_mem_pool);
>   	lpfc_bsg_dma_page_free(phba, dmabuf);
>   	kfree(dd_data);
>   

Looks good!

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james


