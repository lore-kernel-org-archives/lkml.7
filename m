Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDA921900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfCVQow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:44:52 -0400
Received: from foss.arm.com ([217.140.101.70]:49338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfCVQov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:44:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F85BA78;
        Fri, 22 Mar 2019 09:44:51 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7204A3F59C;
        Fri, 22 Mar 2019 09:44:50 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_scmi: Fix to check return value of
 of_match_device
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20190318230430.8273-1-pakki001@umn.edu>
From:   Steven Price <steven.price@arm.com>
Message-ID: <6053ea18-f092-bb4a-fe0a-a40eda1abfdd@arm.com>
Date:   Fri, 22 Mar 2019 16:44:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318230430.8273-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2019 23:04, Aditya Pakki wrote:
> of_match_device can return NULL if no matching device is found. This patch
> checks and returns -ENODEV in such a scenario.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/firmware/arm_scmi/driver.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 8f952f2f1a29..0e0330b44b7b 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -799,6 +799,8 @@ static int scmi_probe(struct platform_device *pdev)
>  	}
>  
>  	desc = of_match_device(scmi_of_match, dev)->data;
> +	if (!desc)
> +		return -ENODEV;

If of_match_device() returns NULL, we've already dereferenced it due to
the "->data" access.

This would be better changed to be a call to of_device_get_match_data()
which handles the NULL return gracefully.

Steve
