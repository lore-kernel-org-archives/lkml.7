Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43995C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1731020673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgAIJGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:06:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38404 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbgAIJGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:06:41 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1551C293290
Subject: Re: [PATCH] platform/chrome: wilco_ec: Fix unregistration order
To:     Daniel Campello <campello@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Benson Leung <bleung@chromium.org>
References: <20200108093459.2.Ia8f971d42dcf892541a806b906414ddfbe4fea36@changeid>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <9cf68a0b-ed58-168a-4c04-753a7a9f55bd@collabora.com>
Date:   Thu, 9 Jan 2020 10:06:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200108093459.2.Ia8f971d42dcf892541a806b906414ddfbe4fea36@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Many thanks for the patch, some comments below.

On 8/1/20 17:35, Daniel Campello wrote:
> Fixes the unregistration order on the Wilco EC core driver to follow the
> christmas tree pattern.
> 

It is logical to cleanup in remove's function in reverse order to probe, but
that's not related to the Christmas tree pattern. I changed the commit
description and queued for the autobuilders to play with. If all goes well will
appear in chrome-platform-5.5

> Signed-off-by: Daniel Campello <campello@chromium.org>

Is this patch fixing an actual issue?

Thanks,
 Enric

> ---
> 
>  drivers/platform/chrome/wilco_ec/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
> index 5210c357feefd4..2d5f027d8770f8 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -137,9 +137,9 @@ static int wilco_ec_remove(struct platform_device *pdev)
>  {
>  	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
> 
> +	platform_device_unregister(ec->telem_pdev);
>  	platform_device_unregister(ec->charger_pdev);
>  	wilco_ec_remove_sysfs(ec);
> -	platform_device_unregister(ec->telem_pdev);
>  	platform_device_unregister(ec->rtc_pdev);
>  	if (ec->debugfs_pdev)
>  		platform_device_unregister(ec->debugfs_pdev);
> --
> 2.24.1.735.g03f4e72817-goog
> 
