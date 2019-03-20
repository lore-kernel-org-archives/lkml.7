Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673BAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D09B21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WlGyyA0R";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bRKmb0Nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfCTTZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:25:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTTZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:25:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0B4896053D; Wed, 20 Mar 2019 19:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553109926;
        bh=vpgY8Qa4c8xopifn0D9Jft2tZalFf8ktbCdVjJtdiUQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WlGyyA0RDa6pooGjPgF0ytFW58c2LIi9yGFGgUoZjK79w/fXXFSz82ZDoISOxhIke
         6drIShD4wDMss/tvA3aQ8+urfz+qMlIevxKlUaNmM8vVvm2ZlQjO0NllpcfTieAvPt
         FI6WUoVwu/XIByw0nHmuNBe3Wdix4ZLj0y2ZSHrw=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F51060909;
        Wed, 20 Mar 2019 19:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553109924;
        bh=vpgY8Qa4c8xopifn0D9Jft2tZalFf8ktbCdVjJtdiUQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bRKmb0NrG+2lCpC2LV2rUgR3U6ZMYaqAEST4fqQuhDQZFOd9bpCNlB5+t6D7363OT
         bSfGHVY54vG3n5ohvV06eD+N/uXsRnmcjFqDEhbkZ8AX3F0qnHSTtOV8fUbIO1iOJH
         oNPxJG0pBW6RWbjPyoQoaND4N2LIqQ/M8fM6/Vx4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F51060909
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] usb: typec: fusb302: Make fusb302_irq_work static
To:     Yue Haibing <yuehaibing@huawei.com>, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20190320141202.19452-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <365d56d1-708d-072b-22da-cb02924383de@codeaurora.org>
Date:   Thu, 21 Mar 2019 00:55:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320141202.19452-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 7:42 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> drivers/usb/typec/tcpm/fusb302.c:1454:6: warning:
>   symbol 'fusb302_irq_work' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/usb/typec/tcpm/fusb302.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 261b829..457fe7a 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -1451,7 +1451,7 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> -void fusb302_irq_work(struct work_struct *work)
> +static void fusb302_irq_work(struct work_struct *work)
>   {
>   	struct fusb302_chip *chip = container_of(work, struct fusb302_chip,
>   						 irq_work);

Good  to see the work on sparse warning as well.


Acked-by: Mukesh Ojha <mojha@codeaurora.org>

Thanks,
Mukesh

