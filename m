Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111DAC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D956820656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfF1KuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:50:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53340 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfF1KuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:50:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2D1F8276DF1
Subject: Re: [PATCH] platform/chrome: lightbar: Get drvdata from parent in
 suspend/resume
To:     Rajat Jain <rajatja@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com,
        evgreen@google.com, gwendal@google.com
References: <20190627214738.112614-1-rajatja@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <b34fb026-7924-204c-99ed-7e2a5a8ebc87@collabora.com>
Date:   Fri, 28 Jun 2019 12:50:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627214738.112614-1-rajatja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/6/19 23:47, Rajat Jain wrote:
> The lightbar driver never assigned the drvdata in probe method, and
> thus there is nothing there. Need to get the ec_dev from the parent's
> drvdata.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Queued for 5.3

Thanks,
~ Enric

> ---
>  drivers/platform/chrome/cros_ec_lightbar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> index d30a6650b0b5..26117a8991b3 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -600,7 +600,7 @@ static int cros_ec_lightbar_remove(struct platform_device *pd)
>  
>  static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
>  {
> -	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev);
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>  
>  	if (userspace_control)
>  		return 0;
> @@ -610,7 +610,7 @@ static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
>  
>  static int __maybe_unused cros_ec_lightbar_suspend(struct device *dev)
>  {
> -	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev);
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
>  
>  	if (userspace_control)
>  		return 0;
> 
