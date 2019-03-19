Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F9BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE3220989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfCSAnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:43:18 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:54200 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfCSAnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:43:18 -0400
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.130])
        by lucky1.263xmail.com (Postfix) with ESMTP id 49D0C4FF9E;
        Tue, 19 Mar 2019 08:43:15 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P11837T140293670135552S1552956193192771_;
        Tue, 19 Mar 2019 08:43:14 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <82fdc2618a9f8efcd820b58b56d8953b>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, kjlu@umn.edu,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_mmc=3a_dw=5fmmc=3a_Fix_to_avoid_potenti?=
 =?UTF-8?B?YWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNl44CQ6K+35rOo5oSP77yM6YKu5Lu2?=
 =?UTF-8?B?55SxbGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7o+WPkeOAkQ==?=
To:     Aditya Pakki <pakki001@umn.edu>
References: <20190319001918.12042-1-pakki001@umn.edu>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <74f8916b-72ce-fc8c-a1c2-0f38ea99ab6d@rock-chips.com>
Date:   Tue, 19 Mar 2019 08:43:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190319001918.12042-1-pakki001@umn.edu>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/19 8:19, Aditya Pakki wrote:
> of_match_node can fail and return NULL in case no matching structure.
> The patches checks for such a scenario and returns -ENXIO.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/mmc/host/dw_mmc-exynos.c | 2 ++
>   drivers/mmc/host/dw_mmc-k3.c     | 2 ++
>   drivers/mmc/host/dw_mmc-pltfm.c  | 2 ++
>   3 files changed, 6 insertions(+)
> 

Could you check dw_mmc-zx.c and dw_mmc-rockchip.c as well?

> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index d46c3439b508..8a75d7314606 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -554,6 +554,8 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
>   	int ret;
>   
>   	match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
>   	drv_data = match->data;
>   
>   	pm_runtime_get_noresume(&pdev->dev);
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 89cdb3d533bb..cc50b7546a20 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -459,6 +459,8 @@ static int dw_mci_k3_probe(struct platform_device *pdev)
>   	const struct of_device_id *match;
>   
>   	match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
>   	drv_data = match->data;
>   
>   	return dw_mci_pltfm_register(pdev, drv_data);
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 58c13e21bd5a..b1948989f617 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -82,6 +82,8 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
>   
>   	if (pdev->dev.of_node) {
>   		match = of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
> +		if (!match)
> +			return -ENXIO;
>   		drv_data = match->data;
>   	}
>   
> 


