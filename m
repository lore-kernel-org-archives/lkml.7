Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6115AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCAF206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbfDJQKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:10:16 -0400
Received: from foss.arm.com ([217.140.101.70]:57374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730598AbfDJQKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:10:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10F76374;
        Wed, 10 Apr 2019 09:10:15 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01E093F59C;
        Wed, 10 Apr 2019 09:10:13 -0700 (PDT)
Date:   Wed, 10 Apr 2019 17:10:11 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] firmware: arm_scmi: Fix to replace of_match_device
Message-ID: <20190410161011.GE3952@e107155-lin>
References: <20190322215503.13434-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322215503.13434-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:55:03PM -0500, Aditya Pakki wrote:
> of_match_device can return NULL if no matching device is found.
> This patch replaces the function with of_device_get_match_data.
> and returns -EINVAL in such a scenario.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
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

probe won't be called be there's no match. And we mandate data in the
driver, so this should never happen.

> +	desc = of_device_get_match_data(dev);

Having said that, I am happy to use the above function.

> +	if (!desc)
> +		return -EINVAL;
>

NULL check seems totally unnecessary, but it's in probe so I am fine.
Applied with updates to subject and commit message.

--
Regards,
Sudeep
