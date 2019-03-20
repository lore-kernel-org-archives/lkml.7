Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32001C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009582083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dcTPzul+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DmCrZIIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfCTTwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:52:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTTwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:52:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5B91D60159; Wed, 20 Mar 2019 19:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553111521;
        bh=yVpeiPP6mlYt2xxK6BXnqAwRJSxd7Qa6Fu23dTeQ+Mk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dcTPzul+JQuNiGBEZ3wa7eEVoK6OfX7n69ajg0iLhG72KpF19ZwU7xxRjYEa2YnVq
         z8sJK6wqVuJgZ7lBaschgBGt8hTsxI2y94w8FUlCk6CDDYJwWwv0hF0dVoZxsl4roj
         UgYy9TabXmGc6l+szmPMXNLHq/6YUXO0QVS1PkVM=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4772960159;
        Wed, 20 Mar 2019 19:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553111520;
        bh=yVpeiPP6mlYt2xxK6BXnqAwRJSxd7Qa6Fu23dTeQ+Mk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DmCrZIIeCxiucLiKLP7RdmQdWruTpa/uRvTkuAUkuHO0WVslWpwVWQZiMmi3tQ4Pt
         H0+39tgvDRgFfb5il3NoZv6bznedkl//GOp/taIFJ7ZLx6CDxZOkgtkn2DxhyLwg6E
         jMna+HxCzJpfCq2srDuXLODqAdt+XsGCAZQKAokw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4772960159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] usb: typec: fusb302: Make fusb302_irq_work static
To:     Yue Haibing <yuehaibing@huawei.com>, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20190320141202.19452-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <43561c26-2d17-7237-e887-ddea7d992aab@codeaurora.org>
Date:   Thu, 21 Mar 2019 01:21:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320141202.19452-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

