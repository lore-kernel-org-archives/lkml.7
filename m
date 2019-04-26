Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FB5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650B4208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HXUTW1NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfDZIGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:06:36 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1209 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfDZIGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:06:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc2bc0f0002>; Fri, 26 Apr 2019 01:06:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Apr 2019 01:06:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Apr 2019 01:06:33 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 08:06:31 +0000
Subject: Re: [PATCH 1/3] dt-bindings: phy: tegra-xusb: List PLL power supplies
To:     Thierry Reding <thierry.reding@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     JC Kuo <jckuo@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20190425153444.6281-1-thierry.reding@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2ca553b9-a744-534b-6b64-634c14500077@nvidia.com>
Date:   Fri, 26 Apr 2019 09:06:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425153444.6281-1-thierry.reding@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556265999; bh=S2XulIm5jxVNmJKizU12ndvmPW7a5jRKoyo722LKe5A=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HXUTW1NGP+BSs++XggWFAV2n+Nv2MD2jCfmTTflIqIH3xYWjDM3FNB0yHxH3hThgq
         k8L9+C6J+Vihfy+XwrJA0uet+V9DTVFAtmmiq2hpQ7UrxQe+q/3HSEv9FfSnglfA7M
         pG7IdwK2q8VyDpOrmaEH5r3wyGJgIHREoyRb62P6FOdzmZyV4jw+uuJcU85QL+mdOT
         +3papKnsVfz/1V/p1NOjDZ8ll4F7FBWYmK1MJU/xcAqnsQ0EHQ2w3JR/exJdjHZ/1P
         bOSum4BAysMtlMZradgKCuihGN0D6RlDhL6KSWXuyppk2o9LdbODa7wC4F4Pr7HBYd
         WlthrDruibvuQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/04/2019 16:34, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> These power supplies provide power for various PLLs that are set up and
> driven by the XUSB pad controller. These power supplies were previously
> improperly added to the PCIe and XUSB controllers, but depending on the
> driver probe order, power to the PLLs will not be supplied soon enough
> and cause initialization to fail.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
For the series ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
