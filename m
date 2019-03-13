Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48545C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A0C2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ad/otPZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfCMNwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:52:21 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16562 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfCMNuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:50:37 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c890aab0001>; Wed, 13 Mar 2019 06:50:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 06:50:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 Mar 2019 06:50:36 -0700
Received: from [10.25.74.242] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 13:50:28 +0000
Subject: Re: [PATCH 1/5] irqchip/gic-pm: add driver remove support
To:     Marc Zyngier <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <catalin.marinas@arm.com>,
        <heiko@sntech.de>, <horms+renesas@verge.net.au>,
        <maxime.ripard@bootlin.com>, <andy.gross@linaro.org>,
        <olof@lixom.net>, <bjorn.andersson@linaro.org>,
        <jagan@amarulasolutions.com>, <enric.balletbo@collabora.com>,
        <stefan.wahren@i2se.com>, <ezequiel@collabora.com>,
        <marc.w.gonzalez@free.fr>, <christoffer.dall@arm.com>,
        <drjones@redhat.com>, <julien.thierry@arm.com>
CC:     <will.deacon@arm.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <1552474956-25513-1-git-send-email-spujar@nvidia.com>
 <0cd78fb7-4bcb-b735-54ca-24a179b9ff72@arm.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <bc00b804-2248-4f8b-1537-3e3db151d74d@nvidia.com>
Date:   Wed, 13 Mar 2019 19:20:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <0cd78fb7-4bcb-b735-54ca-24a179b9ff72@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552485035; bh=3SwpHPghf1PqiRkFu6VgQya4xF3Yy7DP0MzigPG3dio=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=ad/otPZ1oUlxT2cHsukFKIZALv39qKjqcA9njbns5fadavCS99yAgDjBckBtwy9dN
         TGzRjXd6V9izsLnxsnpAtLmqhRY/IrSTj2RP4oPlGQRN/7htED4JGoRUt+BJccJyd9
         0THPYzNGWqwJbxtM4jVXXr11sI/cLsIxKEA5pIZNXMB7HCeqADxm/JQxdxNFYGSYKq
         CqsUcPaHkYOYLVKEUGN1byAdKdhsIkoOMAYiNLl9Mt+dzAZIf1cLvW76h+H28qjvdZ
         zM6zyGj+P8U3QjbiqxmN6/3WjiU/1UCPsAaGqiarbEXDCdRIQdcSm+NW5Xksmq+RWH
         R2sSxPEKjwB2Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/13/2019 4:52 PM, Marc Zyngier wrote:
> First things first:
>
> - Where is the cover letter?
> - This series should be flagged as v2, as it not the same as the one you
> sent last week.
I had the dilemma whether to name this series as v2 or not, thought the 
commits
in the series are different and v2 may not be necessary.
Also felt commit messages are descriptive enough and all belong to 
irq-gic-pm,
hence did not send cover letter.
If you suggest so, I will send a cover letter next patch version(v2)
>
> On 13/03/2019 11:02, Sameer Pujar wrote:
>> This is a preparatory patch for using irq-gic-pm driver as module and thus
>> implement remove() call for the driver. Details of remove() are as below,
>>
>>   * pm_runtime_force_suspend() is added to balance runtime PM, otherwise
>>     following is seen: "agic-controller: Unbalanced pm_runtime_enable!"
>>   * Function gic_teardown() is exported from gic driver and called in remove
>>     to perform io unmap.
>>   * pm_clk_destroy() to free clock resources
>>   * irq is unmapped and freed with irq_dispose_mapping()
>>
> Let's be clear, I have no desire to export any GIC symbol at all. Why
> should we do this? This "driver" is the tiniest thing, and making it
> modular doesn't get us anything.
>
> So what's the rational for doing so?
Reason for this was, the driver gets used for AGIC block and audio is not
boot critical and hence module option was preferred.

Thanks,
Sameer.

>
> Thanks,
>
> 	M.
