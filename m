Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782D2C282DC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2F42183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L96mUivZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbfDRAVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:21:08 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:14573 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387442AbfDRAVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:21:07 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190418002104epoutp01796a1e37253dfeb98927c0d5b21c68bc~WaaGeqFWg3259632596epoutp01S
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 00:21:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190418002104epoutp01796a1e37253dfeb98927c0d5b21c68bc~WaaGeqFWg3259632596epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555546864;
        bh=up/L7/I+gm//GqAal9zR/TQd9QBXWl5OM8Q50aTwBpQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=L96mUivZg97sfl1LO1fLUUpA5jM2VcLMekasM8fQ0Ye0CblURu1AXF3ovX6V81kJM
         eVOw+HuT81F9olxao7/bmJLHGDMxdMAESHj/KFSgcyEhBdJ3UkITlnLu3hBDzsrsoy
         um/RTbA0bn3Uujc9C0hUZRTdthZVzxxw0LBsSRcc=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190418002101epcas1p3c23e97f02f88447150a1aafe58aabd13~WaaD1C4Cp0039400394epcas1p3H;
        Thu, 18 Apr 2019 00:21:01 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.81.04142.BE2C7BC5; Thu, 18 Apr 2019 09:20:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190418002058epcas1p3f59080bc24bacc811ce3c364c87f24e6~WaaBTtEGd0632506325epcas1p3N;
        Thu, 18 Apr 2019 00:20:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190418002058epsmtrp295780168e86b633e73ffcdcad0aecdc3~WaaBS8MnX1515115151epsmtrp2Q;
        Thu, 18 Apr 2019 00:20:58 +0000 (GMT)
X-AuditID: b6c32a36-ce1ff7000000102e-1c-5cb7c2eb0f7a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.C0.03662.AE2C7BC5; Thu, 18 Apr 2019 09:20:58 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190418002058epsmtip1a8ed49f4a88c388860185dc856280ef7~WaaBFjBrj0550505505epsmtip14;
        Thu, 18 Apr 2019 00:20:58 +0000 (GMT)
Subject: Re: [PATCH v3 13/16] PM / devfreq: tegra: Support Tegra30
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0df0f931-ae07-77d1-330e-6b33a34d4071@samsung.com>
Date:   Thu, 18 Apr 2019 09:21:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417222925.5815-14-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmnu7rQ9tjDK78lLJY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLG43rmCz+LlrHotF39pLbA6cHjvuLmH02DnrLrtHb/M7
        No++LasYPT5vkgtgjcq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
        cvEJ0HXLzAE6SEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66X
        nJ9rZWhgYGQKVJiQnfH+8wv2gq08FZf+T2RsYJzA1cXIySEhYCJx/el/pi5GLg4hgR2MEgcv
        vGCHcD4xSlyZuAfK+cYosfZjOztMy48pWxghEnsZJSZ1/YGqes8o0XpsLyNIlbCAk8TdY50s
        IAkRgX+MEp92zWAFSTALREp8PbiUGcRmE9CS2P/iBhuIzS+gKHH1x2OwZl4BO4kVx7aygNgs
        AqoSS//sZQKxRQUiJO4f28AKUSMocXLmE7AaTgEziesPG5kg5otL3HoyH8qWl2jeOpsZ5AgJ
        gd9sEmfvHmKC+MFF4tW/bWwQtrDEq+NboH6Tkvj8bi9UvFpi5ckjbBDNHYwSW/ZfYIVIGEvs
        XzoZaBAH0AZNifW79CGW8Um8+9rDChKWEOCV6GgTgqhWlrj84C7UWkmJxe2dUOM9JPoWNDFO
        YFScheSdWUhemIXkhVkIyxYwsqxiFEstKM5NTy02LDBCju9NjODkqmW2g3HROZ9DjAIcjEo8
        vAwa22OEWBPLiitzDzFKcDArifA6pmyJEeJNSaysSi3Kjy8qzUktPsRoCgzticxSosn5wMSf
        VxJvaGpkbGxsYWJoZmpoqCTOu97BOUZIID2xJDU7NbUgtQimj4mDU6qB0dn++EnOgJ7v3FO1
        lv+NLZPbzhFtbFBf4WVQe2z5bJ2JPvuDmVcFvAs4pXf8c5/4hQ0bl2wOniay8oOK27yek5y8
        BZ9dLzLMtm/I3/b7t86jVSu814bx/JihUid5MNbS2aej/uftO6pJbSGeNg72FbuzTxw+P+NE
        te06I6l326weqN2y1u2KVWIpzkg01GIuKk4EAMYUQ0zEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnO6rQ9tjDG7ekbdY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLG43rmCz+LlrHotF39pLbA6cHjvuLmH02DnrLrtHb/M7
        No++LasYPT5vkgtgjeKySUnNySxLLdK3S+DKeP/5BXvBVp6KS/8nMjYwTuDqYuTkkBAwkfgx
        ZQtjFyMXh5DAbkaJKSfvsUAkJCWmXTzK3MXIAWQLSxw+XAxR85ZRovPjSkaQGmEBJ4m7xzpZ
        QBIiAk1MEp8ftjCBJJgFIiX6H3WzgthCAlsYJWb/rgGx2QS0JPa/uMEGYvMLKEpc/fEYbBCv
        gJ3EimNbwRazCKhKLP2zF2yOqECExJn3K1ggagQlTs58AmZzCphJXH/YCLVLXeLPvEvMELa4
        xK0n86Hi8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0
        L10vOT93EyM4xrS0djCeOBF/iFGAg1GJh3eF6vYYIdbEsuLK3EOMEhzMSiK8jilbYoR4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1OTS1ILYLJMnFwSjUw6m4yYlv+MGlbQFSR
        soH8QzZp1fNN2fPbVvoJOJfPPn2r/bVlQJG24UP99yezgp1FLV6+nu/3+9GJ6Nh3685klr7O
        K62XntVmJa6h4tLqnX2NK8TJ1aPGOOmrFVuM3ZnQU05rb2X2pTMtsQ/U1KsI1NzbwTubI7fU
        4Ji8WUpC1ZfVphvdDZRYijMSDbWYi4oTAcEg1YKtAgAA
X-CMS-MailID: 20190418002058epcas1p3f59080bc24bacc811ce3c364c87f24e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417224121epcas5p11781595ff22c987a9a9f81738b4a10ca
References: <20190417222925.5815-1-digetx@gmail.com>
        <CGME20190417224121epcas5p11781595ff22c987a9a9f81738b4a10ca@epcas5p1.samsung.com>
        <20190417222925.5815-14-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 4. 18. 오전 7:29, Dmitry Osipenko wrote:
> The devfreq driver can be used on Tegra30 without any code change and
> it works perfectly fine, the default Tegra124 parameters are good enough
> for Tegra30.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/Kconfig         | 4 ++--
>  drivers/devfreq/tegra-devfreq.c | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index a78dffe603c1..56db9dc05edb 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -92,8 +92,8 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	  This does not yet operate with optimal voltages.
>  
>  config ARM_TEGRA_DEVFREQ
> -	tristate "Tegra DEVFREQ Driver"
> -	depends on ARCH_TEGRA_124_SOC
> +	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
> +	depends on ARCH_TEGRA
>  	select PM_OPP
>  	help
>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index e9ab49394d35..029afc5fb6a9 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -738,6 +738,7 @@ static int tegra_devfreq_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id tegra_devfreq_of_match[] = {
> +	{ .compatible = "nvidia,tegra30-actmon" },
>  	{ .compatible = "nvidia,tegra124-actmon" },
>  	{ },
>  };
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
