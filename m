Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F8BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E7620883
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GH+z6/gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfCXQ21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:28:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35855 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfCXQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:28:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id r124so4753395pgr.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VXwpoS+h3xjN5pJ/V+yCiT4vMyEiH4ugZ/4gb/F1+r8=;
        b=GH+z6/gdMxPJM/xzd/L3k/7CPY6VE7HGQ88sIR/Vl/3WhR3V8Q3coXSD9UHq8FJVXh
         RWMky1uJX72YZdUEWV2Gtw12diOawUBTlJD1+vxzzCOm3sAsmv+VXhAY6SqUKrjzD83G
         CiOeL9HerWnKh4wGe3PVPxNmyHW0nh7nqp1ig8pCrqWMFkTrUSQDhufNXfHeO47ZXBkX
         Nu25qCnX6Ogd5NK6XPTwbOJr/UHk126MktWyDaS96Zf1F5QeSwltiWfh7aEgF2qOhl5z
         dc0yMN3SmGwd3GLn97biMqQA33ioJniIe/GSlpUITDUHL8P9UKP7cIzu1reix/RJ8Erj
         JzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VXwpoS+h3xjN5pJ/V+yCiT4vMyEiH4ugZ/4gb/F1+r8=;
        b=Fz7QgnLjk3bX+mu+Tj5vml2+f183eHSt2te31/+whe9w//h6tobuGbM9dqF0c/wZag
         cJj5NVYfaUhVkz9muXtEjF4BnCPHD8zMyZUP3DbywRPB6uzMnIePN5bWN1T3iaYKgdZ9
         DrvcFbb5rh9pC3SI4vka6UHI0PTuAXSqYLgcy5b2hEqBN+SGJFEwjtq67ANXwz016MhO
         hMo5kO+oM12AGH7uSLHRoV/0N6vIzI/a40JvKdrPYaHbqYzhPZfZdL0GrOMFyYnS8kgP
         3QxcLzupOBeUl8qyUc+O4XdHeOTiqtdhhHcTXMGTlwHApKqeEP4ZtX4bv3BJtjRd6UCW
         3Row==
X-Gm-Message-State: APjAAAUKB40F7yYSFYQpfR/+yH0++dj55k1k/p8ixzBmJeLv1BswPkcR
        KRTrNVsSBST9pUan+U2RHOoAB2aTGZcOuIly
X-Google-Smtp-Source: APXvYqynrN0eiUy5tHA8E7zazNcAHU+Xv//XTX1uznmgodhkEtZuhpEfZ20DHJ1b+z2UzwVXoIXcjw==
X-Received: by 2002:aa7:9389:: with SMTP id t9mr19599697pfe.60.1553444906208;
        Sun, 24 Mar 2019 09:28:26 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t82sm7838497pfa.153.2019.03.24.09.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:28:25 -0700 (PDT)
Subject: Re: [PATCH] ata: dwc_460ex: Avoid potential NULL pointer dereference
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190304230858.13387-1-pakki001@umn.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <66403341-fa27-4b80-ab6b-2413b6b6fb98@kernel.dk>
Date:   Sun, 24 Mar 2019 10:28:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304230858.13387-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 4:08 PM, Aditya Pakki wrote:
> dma_async_tx_descriptor can contain a NULL variable and using
> it in dmaengine_submit without checking can crash the process.
> This patch avoids such a scenario.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/ata/sata_dwc_460ex.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 6f142aa54f5f..44a0d7a1ef54 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1052,8 +1052,10 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
>  					SATA_DWC_DMACR_RXCHEN);
>  
>  		/* Enable AHB DMA transfer on the specified channel */
> -		dmaengine_submit(desc);
> -		dma_async_issue_pending(hsdevp->chan);
> +		if (desc) {
> +			dmaengine_submit(desc);
> +			dma_async_issue_pending(hsdevp->chan);
> +		}
>  	}
>  }

Hmm, if desc == NULL, is that an error condition?

-- 
Jens Axboe

