Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9026EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADA7217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLnYDhLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbfDQVaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:30:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35957 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:30:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck15so104931plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UDomdzyZTZup4EOGSaPJuyg3NDPnNWzjsCTMNgGlulE=;
        b=iLnYDhLALoEyptEO7vYKL20g+IWsawH5T6vdUOmHRogsjMhrAxf61lawdw1zSg4dbF
         lzxBstRir++GMuFR9y7sZS1so1Nce8McQGuxAdAA7lG39E9ReUa3mEy1holMa/0S/uAT
         0CKoexNPevXP+UAh9KUzspFOGPM1vlwtoHsg+jtFN3892/sJvB0+2w3pEh+xFN6kGZgf
         YG0Ln4UtnEsoEOFXdtLUYIDDZcmkAJOrhOfizeYwKicg6dx0m9yvFI+cbAgFE1EB58WE
         GOWbV8CYqethwQzOBss5L648FVoXPCgkfs3cWxIsZdhHqMryaYH7xExn4/EGDM53nzku
         60eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UDomdzyZTZup4EOGSaPJuyg3NDPnNWzjsCTMNgGlulE=;
        b=Sjpr8m27FOQAnjgjbsthEzmdnFl2LNeksisroE4zb/DF5qsBJqeCBaqdh/NOMShPSF
         gLF5T28D3CupubfZjuAJVymFil3ms9u3mWp+v4XSM9/zzHYZzIfIKV4GJZrP3C+jm0jS
         t0MC6qkb8mxO92NNsk236GAtIGj4c3I9u5UcVApqiHYulCZxMi2B/iWbPDMDxEquF9LJ
         yKaXRxPDWQC7VwRhWnaYS+PK1cOLBUdPJSS0XIfKxv6mc/LSjpzRQAfNsUje/sWrj0NG
         LC4+ABaFoQf/ytxJKk86GQ5oHT1gdI0DRhX3PKoDSAkHVLAcdkwxxwLHcgmqhsZHXygi
         eShg==
X-Gm-Message-State: APjAAAWxZ7QcRpXyup9sqGWcrrJKCvZkCG5KpSi5aI2pOPRsVgkeFmCe
        0LHP7q/vKyEsta4owHKQR5A=
X-Google-Smtp-Source: APXvYqyzepSIt+hlFoaOGyDjJ+rck/iaHWtjOCbUlQklQIbBEK1eIyu9V74px0vX+law7nLMW+Rm4A==
X-Received: by 2002:a17:902:7893:: with SMTP id q19mr90885686pll.154.1555536620417;
        Wed, 17 Apr 2019 14:30:20 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:80e8:2:4415:95ba:6d7:2a33])
        by smtp.gmail.com with ESMTPSA id v20sm149151pfe.118.2019.04.17.14.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 14:30:19 -0700 (PDT)
Subject: Re: [PATCH] nvme: determine the number of IO queues
To:     Aaron Ma <aaron.ma@canonical.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, axboe@fb.com
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
From:   "Edmund Nadolski (Microsoft)" <edmund.f.nadolski@gmail.com>
Message-ID: <08ac5733-596b-598d-c821-f1aa2dc32650@gmail.com>
Date:   Wed, 17 Apr 2019 14:30:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/19 7:12 AM, Aaron Ma wrote:
> Some controllers support limited IO queues, when over set
> the number, it will return invalid field error.
> Then NVME will be removed by driver.
> 
> Find the max number of IO queues that controller supports.
> When it still got invalid result, set 1 IO queue at least to
> bring NVME online.
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>   drivers/nvme/host/core.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2c43e12b70af..fb7f05c310c8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1134,14 +1134,24 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
>   
>   int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>   {
> -	u32 q_count = (*count - 1) | ((*count - 1) << 16);
> +	u32 q_count;
>   	u32 result;
> -	int status, nr_io_queues;
> -
> -	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
> -			&result);
> -	if (status < 0)
> -		return status;
> +	int status = -1;
> +	int nr_io_queues;
> +	int try_count;
> +
> +	for (try_count = *count; try_count > 0; try_count--) {
> +		q_count = (try_count - 1) | ((try_count - 1) << 16);

A macro here might help readability.

> +		status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES,
> +				q_count, NULL, 0, &result);
> +		if (status < 0)
> +			return status;
> +		else if (status == 0) {

else following return is not needed.


> +			nr_io_queues = min(result & 0xffff, result >> 16) + 1;

Likewise, a macro as above.


Ed

> +			*count = min(try_count, nr_io_queues);
> +			break;
> +		}
> +	}
>   
>   	/*
>   	 * Degraded controllers might return an error when setting the queue
> @@ -1150,10 +1160,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>   	 */
>   	if (status > 0) {
>   		dev_err(ctrl->device, "Could not set queue count (%d)\n", status);
> -		*count = 0;
> -	} else {
> -		nr_io_queues = min(result & 0xffff, result >> 16) + 1;
> -		*count = min(*count, nr_io_queues);
> +		*count = 1;
>   	}
>   
>   	return 0;
> 

