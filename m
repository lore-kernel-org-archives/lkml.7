Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173D5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F5C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfCYLIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:08:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45492 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbfCYLIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:08:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D95881596;
        Mon, 25 Mar 2019 04:08:30 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C11F53F575;
        Mon, 25 Mar 2019 04:08:29 -0700 (PDT)
Subject: Re: [PATCH v2] firmware: arm_scmi: Fix to replace of_match_device
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20190322215503.13434-1-pakki001@umn.edu>
From:   Steven Price <steven.price@arm.com>
Message-ID: <59855f4f-9099-a8a9-c8dd-918b5fc637ea@arm.com>
Date:   Mon, 25 Mar 2019 11:08:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322215503.13434-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2019 21:55, Aditya Pakki wrote:
> of_match_device can return NULL if no matching device is found.
> This patch replaces the function with of_device_get_match_data.
> and returns -EINVAL in such a scenario.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Reviewed-by: Steven Price <steven.price@arm.com>

> 
> ---
> v1: Replace of_match_device with of_device_get_match_data
> ---
>  drivers/firmware/arm_scmi/driver.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 8f952f2f1a29..a44852a1d5bc 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -798,7 +798,9 @@ static int scmi_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	desc = of_match_device(scmi_of_match, dev)->data;
> +	desc = of_device_get_match_data(dev);
> +	if (!desc)
> +		return -EINVAL;
>  
>  	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>  	if (!info)
> 

