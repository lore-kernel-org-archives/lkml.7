Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA7AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6305218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfCVTo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:44:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56646 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfCVTo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:44:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D7DFF281D0D
Subject: Re: [PATCH] mfd: cros_ec: Only register a positive IRQ number
To:     egranata@chromium.org, lee.jones@linaro.org, bleung@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org
Cc:     gwendal@google.com, amstan@google.com
References: <20190321210347.34793-1-egranata@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <b3d3cb61-b7c1-3455-938d-645e5cc3e260@collabora.com>
Date:   Fri, 22 Mar 2019 20:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321210347.34793-1-egranata@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On 21/3/19 22:03, egranata@chromium.org wrote:
> From: Enrico Granata <egranata@chromium.org>
> 
> Add a layer of sanity checking to cros_ec_register against attempting to
> register IRQ values that are not strictly greater than 0.
> 
> Signed-off-by: Enrico Granata <egranata@chromium.org>
> ---
>  drivers/mfd/cros_ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 6acfe036d5222..ff8984a2b8c21 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -118,7 +118,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  		return err;
>  	}
>  
> -	if (ec_dev->irq) {
> +	if (ec_dev->irq > 0) {
>  		err = devm_request_threaded_irq(dev, ec_dev->irq, NULL,
>  				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  				"chromeos-ec", ec_dev);
> 

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric
