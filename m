Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4365CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AAC21721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZRRIt5Hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390611AbfJ1Rmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:42:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39880 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbfJ1Rmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:42:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id r141so10064183wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vVtXee5nxv2u75A7+ctwOesvx1t8UgvI2w0D0KkHg4w=;
        b=ZRRIt5HprYlG+1cr1tzPUEyYXdOrAMdSuiEdioPux3me66fIAKy2nO0qdGcBlQu3cC
         JGC92vLNnMMXgOLNyqMoh6CK/VtL03HA1vMOdcJf2u/8MX7s+npstZzQzBq+ECRcrEHs
         ZGuaywKEBHso1s5X/SMLzQpYRIjVNZKucpexE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vVtXee5nxv2u75A7+ctwOesvx1t8UgvI2w0D0KkHg4w=;
        b=srq8TIj5Fe2nU9ui1kkoUMxH87nyen6EyAyh7GREH5J6kg5vkKS7DodrodrOV+dpu2
         H8d1NqQq5VMCD/xvVex5yZPtbwceUw9i+MvVwimLxdQif8Z9ZvT5QiRg2wN99V8ZPzAX
         ya4nXSGtSTZ+5PtjhAVJaMr1hm4IckvYfiROPS2zIZA4iPa6wJuV2Qy1B9bXduMEPnAA
         X0V1UpAMbvgXRzEFySanMBA4FpN/UVzxHubO1nxRFnzteSrFFj68006dXS8yjZ61tVhI
         k5MiQR3pLz6Xr91HxOLim+3kMJ5fo1hOM1jDcQn4K/SJAbKdK2a2FV+FWFSebbyzHoRx
         gykg==
X-Gm-Message-State: APjAAAUMjSgqB7ayiZp7YRPPMg7DoYWUeuHjRshVIC8UnLFwVs55dT59
        Xg2iV9qBGaCSr2eqb1/qHIj2KVCPkWg=
X-Google-Smtp-Source: APXvYqxC2Ys/r/aL0RALWTf5448B3u3BcKzOVdH5dc6n51nsmhMTtcXphw8mK4kTEnCJzWQ7U2n9dg==
X-Received: by 2002:a05:600c:295:: with SMTP id 21mr417226wmk.168.1572284556652;
        Mon, 28 Oct 2019 10:42:36 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a71sm300846wme.11.2019.10.28.10.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 10:42:35 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: Fix NULL check before mempool_destroy is not
 needed
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <20191026194712.GA22249@saurav>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <7fb64c36-52aa-ab69-0637-9abfe3fdf19b@broadcom.com>
Date:   Mon, 28 Oct 2019 10:42:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191026194712.GA22249@saurav>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/2019 12:47 PM, Saurav Girepunje wrote:
> mempool_destroy has taken null pointer check into account.
> so remove the redundant check.
>
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index e91377a4cafe..f620ecae3428 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -13346,8 +13346,7 @@ lpfc_sli4_oas_verify(struct lpfc_hba *phba)
>   		phba->cfg_fof = 1;
>   	} else {
>   		phba->cfg_fof = 0;
> -		if (phba->device_data_mem_pool)
> -			mempool_destroy(phba->device_data_mem_pool);
> +		mempool_destroy(phba->device_data_mem_pool);
>   		phba->device_data_mem_pool = NULL;
>   	}
>   
Looks fine.

Thanks

Reviewed-by:  James Smart <james.smart@broadcom.com>

-- james

