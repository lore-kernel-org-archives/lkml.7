Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EA2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942E220659
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbfKTQXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:23:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48386 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfKTQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:23:03 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6715128CFC2
Subject: Re: [PATCH] platform/chrome: cros_usbpd_logger: add missed
 destroy_workqueue in remove
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org
References: <20191113063821.8896-1-hslester96@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <0d4c340d-7b4f-6efe-7643-97f848fa1f04@collabora.com>
Date:   Wed, 20 Nov 2019 17:22:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113063821.8896-1-hslester96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/11/19 7:38, Chuhong Yuan wrote:
> The driver forgets to destroy workqueue in remove.
> Add the missed call to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied for 5.5

Thanks,
 Enric

> ---
>  drivers/platform/chrome/cros_usbpd_logger.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
> index 2430e8b82810..374cdd1e868a 100644
> --- a/drivers/platform/chrome/cros_usbpd_logger.c
> +++ b/drivers/platform/chrome/cros_usbpd_logger.c
> @@ -224,6 +224,7 @@ static int cros_usbpd_logger_remove(struct platform_device *pd)
>  	struct logger_data *logger = platform_get_drvdata(pd);
>  
>  	cancel_delayed_work_sync(&logger->log_work);
> +	destroy_workqueue(logger->log_workqueue);
>  
>  	return 0;
>  }
> 
