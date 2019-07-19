Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98914C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734D021850
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h2ZRrvKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfGSKGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:06:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39890 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGSKGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:06:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6JA5ubt031335;
        Fri, 19 Jul 2019 05:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563530756;
        bh=kEvJafuT1mgVbVr5vHN42Lk/YX5x6Xiii0b77v5ee/M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=h2ZRrvKub8w1lRclaH1XGeYI9et46t8uhXdTmcqPzYSwd6/I3wcpVc0YY1YNCYDmL
         NBS5iKvrV9p0iuw/30ExYNkaY/SxlfIiceAeUG1utTmQHJcP3PwYgMfNnrkjfF74C/
         YUikXxhCOljROFaSjLWqyolVLMJlZA+w1Kicecbw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6JA5uou020375
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jul 2019 05:05:56 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 19
 Jul 2019 05:05:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 19 Jul 2019 05:05:56 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6JA5sIR062705;
        Fri, 19 Jul 2019 05:05:54 -0500
Subject: Re: [PATCH] phy: core: document calibrate() method
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-usb@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20190719095254eucas1p29c9e6c7aac20cf89b589fd2f2036c485@eucas1p2.samsung.com>
 <20190719095245.17401-1-m.szyprowski@samsung.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <085b8093-d7bc-d960-f0d8-8776818ebab0@ti.com>
Date:   Fri, 19 Jul 2019 15:34:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190719095245.17401-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 19/07/19 3:22 PM, Marek Szyprowski wrote:
> Commit 36914111e682 ("drivers: phy: add calibrate method") added support
> for generic phy_calibrate() method, but it didn't explain in detail when
> such method is supposed to be called. Add some more documentation directly
> to the phy.h to make it clean that it is intended to be called after every
> host controller reset.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  include/linux/phy/phy.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 15032f145063..46775e8b0ed9 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -101,6 +101,18 @@ struct phy_ops {
>  	int	(*validate)(struct phy *phy, enum phy_mode mode, int submode,
>  			    union phy_configure_opts *opts);
>  	int	(*reset)(struct phy *phy);
> +
> +	/**
> +	 * @calibrate:
> +	 *
> +	 * Optional.
> +	 *
> +	 * Used to calibrate phy, typically by adjusting some parameters
> +	 * in runtime, which are otherwise lost after host controller
> +	 * reset and cannot be set in phy_init() and phy_power_on().
> +	 *
> +	 * Returns: 0 if successful, an negative error code otherwise
> +	 */
>  	int	(*calibrate)(struct phy *phy);

This should be added in drivers/phy/phy-core.c before phy_calibrate()? We could
add a separate section in Documentation/phy.txt to document these phy_ops.

Thanks
Kishon
