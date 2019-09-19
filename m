Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AA8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638F321924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfISNGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:06:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40276 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731332AbfISNGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:06:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7C76228E9DE
Subject: Re: [PATCH] platform/chrome: null check create_singlethread_workqueue
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20190911201100.11483-1-navid.emamdoost@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c2c9c9a0-98f0-2d1b-ecc7-7c4d03a141d7@collabora.com>
Date:   Thu, 19 Sep 2019 15:06:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190911201100.11483-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/9/19 22:10, Navid Emamdoost wrote:
> In cros_usbpd_logger_probe the return value of
> create_singlethread_workqueue may be null, it should be checked.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---

Applied for 5.4, the patch went to linux-next some time ago, so sorry for late
notice.

Thanks,
 Enric


>  drivers/platform/chrome/cros_usbpd_logger.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
> index 7c7b267626a0..c83397955cc3 100644
> --- a/drivers/platform/chrome/cros_usbpd_logger.c
> +++ b/drivers/platform/chrome/cros_usbpd_logger.c
> @@ -209,6 +209,9 @@ static int cros_usbpd_logger_probe(struct platform_device *pd)
>  	/* Retrieve PD event logs periodically */
>  	INIT_DELAYED_WORK(&logger->log_work, cros_usbpd_log_check);
>  	logger->log_workqueue =	create_singlethread_workqueue("cros_usbpd_log");
> +	if (!logger->log_workqueue)
> +		return -ENOMEM;
> +
>  	queue_delayed_work(logger->log_workqueue, &logger->log_work,
>  			   CROS_USBPD_LOG_UPDATE_DELAY);
>  
> 
