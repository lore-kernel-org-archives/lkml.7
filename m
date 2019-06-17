Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203C0C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BB92084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfFQNTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:19:21 -0400
Received: from foss.arm.com ([217.140.110.172]:49700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfFQNTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:19:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BAED28;
        Mon, 17 Jun 2019 06:19:20 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C45D13F246;
        Mon, 17 Jun 2019 06:19:19 -0700 (PDT)
Subject: Re: [PATCH] coresight: platform: add OF/APCI dependency
To:     arnd@arndb.de, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190617125908.1674177-1-arnd@arndb.de>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f91b2cad-a16e-6474-59a6-82ad890a3a54@arm.com>
Date:   Mon, 17 Jun 2019 14:19:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617125908.1674177-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 17/06/2019 13:58, Arnd Bergmann wrote:
> When neither CONFIG_OF nor CONFIG_ACPI are set, we get a harmless
> build warning:
> 
> drivers/hwtracing/coresight/coresight-platform.c:26:12: error: unused function 'coresight_alloc_conns'
>        [-Werror,-Wunused-function]
> static int coresight_alloc_conns(struct device *dev,
>             ^
> drivers/hwtracing/coresight/coresight-platform.c:46:1: error: unused function 'coresight_find_device_by_fwnode'
>        [-Werror,-Wunused-function]
> coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
> 
> As the code is useless in that configuration anyway, just add
> a Kconfig dependency that only allows building when at least
> one of the two is set.
> 
> This should not hinder compile-testing, as CONFIG_OF can be
> enabled on any architecture.

Ok, that justifies why "not using ARM || ARM64" is better.


> 
> Fixes: ac0e232c12f0 ("coresight: platform: Use fwnode handle for device search")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   drivers/hwtracing/coresight/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 5487d4a1abc2..14638db4991d 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -4,6 +4,7 @@
>   #
>   menuconfig CORESIGHT
>   	bool "CoreSight Tracing Support"
> +	depends on OF || ACPI
>   	select ARM_AMBA
>   	select PERF_EVENTS
>   	help
> 
