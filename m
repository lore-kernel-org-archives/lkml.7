Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D5EC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109A32085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfFZUeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:34:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39192 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZUeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:34:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id CABEE260E5C
Subject: Re: [PATCH] platform/chrome: lightbar: Assign drvdata during probe
To:     Rajat Jain <rajatja@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     evgreen@google.com, rajatxjain@gmail.com
References: <20190625205101.33032-1-rajatja@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <a755588b-1062-7c4f-7c03-f35ca23f39a4@collabora.com>
Date:   Wed, 26 Jun 2019 22:34:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625205101.33032-1-rajatja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

On 25/6/19 22:51, Rajat Jain wrote:
> The lightbar driver never assigned the drvdata in probe method, and thus
> causes a panic when it is accessed at the suspend time.

Good catch, that's one of the problems I currently have with mainline on Samus.
The other one, that I didn't find time to look at is, that for some reason, when
I suspend the system reboots. Is suspend/resume working for you in current mainline?

There is no drvdata because we don't really need extra private data for this
driver, the ec_dev is directly the drvdata provided by device parent. I am
wondering if you can just do

   struct cros_ec_dev *ec_dev = to_cros_ec_dev(dev);

in the suspend/resume calls like we do in the show/store calls or get the
drvdata from its parent. I guess I prefer the first one.

> 

Would be nice have a fixes tag here.

> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/platform/chrome/cros_ec_lightbar.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> index d30a6650b0b5..98e514fc5830 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -578,11 +578,14 @@ static int cros_ec_lightbar_probe(struct platform_device *pd)
>  
>  	ret = sysfs_create_group(&ec_dev->class_dev.kobj,
>  				 &cros_ec_lightbar_attr_group);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(dev, "failed to create %s attributes. err=%d\n",
>  			cros_ec_lightbar_attr_group.name, ret);
> +		return ret;
> +	}
>  
> -	return ret;
> +	platform_set_drvdata(pd, ec_dev);
> +	return 0;
>  }
>  
>  static int cros_ec_lightbar_remove(struct platform_device *pd)
> 

Thanks,
~ Enric
