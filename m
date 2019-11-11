Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6CDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E53221E6F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfKKOOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:14:45 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2083 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726853AbfKKOOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:14:44 -0500
Received: from lhreml708-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 36B1291DAC2EB7F3BE6C;
        Mon, 11 Nov 2019 14:14:43 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml708-cah.china.huawei.com (10.201.108.49) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Nov 2019 14:14:42 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 11 Nov
 2019 14:14:42 +0000
Subject: Re: [PATCH] arm64: Kconfig: make CMDLINE_FORCE depend on CMDLINE
To:     Anders Roxell <anders.roxell@linaro.org>, <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191111085956.6158-1-anders.roxell@linaro.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ea4ee177-f72a-1803-45d1-1b2deabdc532@huawei.com>
Date:   Mon, 11 Nov 2019 14:14:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191111085956.6158-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2019 08:59, Anders Roxell wrote:
> When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
> CONFIG_CMDLINE_FORCE gets enabled. Which forces the user to pass the
> full cmdline to CONFIG_CMDLINE="...".
> 
> Rework so that CONFIG_CMDLINE_FORCE gets set only if CONFIG_CMDLINE is
> set to something except an empty string.
> 
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---

This looks ok.

Were you also going to propose a patch to introduce a LITTLE ENDIAN 
config option?

For me, this would mean that ACPI module is built for allmodconfig, 
which is a good thing.

Thanks,
john


>   arch/arm64/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 50df79d4aa3b..64764ca92fca 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1629,6 +1629,7 @@ config CMDLINE
>   
>   config CMDLINE_FORCE
>   	bool "Always use the default kernel command string"
> +	depends on CMDLINE != ""
>   	help
>   	  Always use the default kernel command string, even if the boot
>   	  loader passes other arguments to the kernel.
> 

