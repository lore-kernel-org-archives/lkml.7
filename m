Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B8AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646ED20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="piDQCK/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfCFBb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:31:29 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:40022 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfCFBb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:31:28 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190306013125epoutp03f7214541dbee0f0adecf89804eb6e7b7~JOoP8tmcq1733217332epoutp039
        for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2019 01:31:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190306013125epoutp03f7214541dbee0f0adecf89804eb6e7b7~JOoP8tmcq1733217332epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551835885;
        bh=Ga06ib/Hft1LhZsJxng9Q0GQlQrYggFDog5G5fzO8pU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=piDQCK/QUWsPnWsW6avG4ZmrviRJatKdhzYYhL8HORderuCbvQQDP6ADiKOzcJ8nP
         eflXxQ8QM0n40e+6kiSiFQ9xhi+tXbtU3sCSgKDlNzB6WHZpTDToRl7X9FGDRwFiEF
         lmk1G3ID+HQkPMqfyeARX+rtEgfiii29L5VURYOc=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190306013121epcas1p13dab17fd4fe61233331255e4d3f1e093~JOoM60Evj1855418554epcas1p1V;
        Wed,  6 Mar 2019 01:31:21 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.70.04069.9E22F7C5; Wed,  6 Mar 2019 10:31:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190306013121epcas1p367627d25c4d9f84b98a2273f9a0d9125~JOoMdwCbm0156501565epcas1p33;
        Wed,  6 Mar 2019 01:31:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190306013121epsmtrp25aae187bd7e135681e8f09d11b8c4770~JOoMca4Lc3234832348epsmtrp2J;
        Wed,  6 Mar 2019 01:31:21 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-b0-5c7f22e9e5a4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.E5.03971.9E22F7C5; Wed,  6 Mar 2019 10:31:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190306013121epsmtip264f86e6efcdc0811262b81cc0bce5a96~JOoML7Q103013330133epsmtip2P;
        Wed,  6 Mar 2019 01:31:21 +0000 (GMT)
Subject: Re: [PATCH v5 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a35136da-79b1-17fe-3c97-8eb06da39cd6@samsung.com>
Date:   Wed, 6 Mar 2019 10:31:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551781151-5562-4-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmru5LpfoYg5YnphYbZ6xntZh/5Byr
        Rf/j18wW589vYLc42/SG3eJWg4zF5V1z2Cw+9x5htJhxfh+Txdojd9ktbjeuYLM4/Kad1YHH
        Y9OqTjaPg+/2MHn0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGl
        hbmSQl5ibqqtkotPgK5bZg7QZUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAssC
        veLE3OLSvHS95PxcK0MDAyNToMKE7Ix1Oz+zFbQIV/y8ptHA+Jy/i5GTQ0LAROLu3x7WLkYu
        DiGBHYwSqybfY4ZwPjFKrLl4hAXC+cYosWDObhaYlnfvnjFCJPYySlxq6oTqf88o0TzhGliV
        sECwxIt/S9lBEiICyxkl9k29C9bCLLCKUWLz1FWMIFVsAloS+1/cYAOx+QUUJa7+eAwW5xWw
        k7j9oJ0JxGYRUJGYePo8M4gtKhAh8f4pxB28AoISJ2c+AbM5Bbwkvn+cDNbLLCAucevJfCYI
        W16ieetssI8kBPrZJV5PX8AK8YSLRPPCGWwQtrDEq+Nb2CFsKYnP7/ZCxaslVp48wgbR3MEo
        sWX/BahmY4n9SycDbeAA2qApsX6XPsQyPol3X0FhyQFUwivR0SYEUa0scfnBXSYIW1JicXsn
        1HgPie1ne1knMCrOQvLOLCQvzELywiyEZQsYWVYxiqUWFOempxYbFhgjx/cmRnC61TLfwbjh
        nM8hRgEORiUe3gmtdTFCrIllxZW5hxglOJiVRHgvMdXHCPGmJFZWpRblxxeV5qQWH2I0BYb2
        RGYp0eR8YC7IK4k3NDUyNja2MDE0MzU0VBLnXe/gHCMkkJ5YkpqdmlqQWgTTx8TBKdXAyBhT
        M7HC5d2XLlY2oTNRx9sDLrzY/ChVUKkzjO1UcJEQ387y2V1f/k67Oq97me6i+B+zXkdlPPR7
        dnzLxq0sgrW1h4Iy7RdqrOu0mRIVbaKoJ1s8seTOm8KLG9XaZh+/z/421kRd1CD6dUzIa/2P
        dcZP0qsVZgXdmSLmMXXG7ezCl+fcf+YaKLEUZyQaajEXFScCAPGu3yXNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSvO5LpfoYg0NLhCw2zljPajH/yDlW
        i/7Hr5ktzp/fwG5xtukNu8WtBhmLy7vmsFl87j3CaDHj/D4mi7VH7rJb3G5cwWZx+E07qwOP
        x6ZVnWweB9/tYfLo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujHU7P7MVtAhX/Lym0cD4nL+L
        kZNDQsBE4t27Z4xdjFwcQgK7GSV2/lzADJGQlJh28SiQzQFkC0scPlwMUfOWUWLVhglgNcIC
        wRKdWyYwgSREBJYzSsz9u5QFxGEWWMUo8e7vXGaIlruMEmtf7GYHaWET0JLY/+IGG4jNL6Ao
        cfXHY0YQm1fATuL2g3YmEJtFQEVi4unzYCtEBSIk7l58wQJRIyhxcuYTMJtTwEvi+8fJYL3M
        AuoSf+ZdYoawxSVuPZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLD
        AsO81HK94sTc4tK8dL3k/NxNjOC409LcwXh5SfwhRgEORiUe3gmtdTFCrIllxZW5hxglOJiV
        RHgvMdXHCPGmJFZWpRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cDI
        H9G7ZdrBhxM0rTnlG7hC1rxdMXGRltik/+d9m1r1vYMWzhaImby+jjf//Y3kC8c3vX/9f++c
        Yms/1z8rti3cdy5ybqxi3OIn5zQMjtzblPf3zpnKBK7YtxM0Gq96R+TZP87YFHPnXqDKmsOs
        p+QM3k6LtA0+vVNX5OSmrVUOi3WuqXvMLnnzUImlOCPRUIu5qDgRAGZDdDe3AgAA
X-CMS-MailID: 20190306013121epcas1p367627d25c4d9f84b98a2273f9a0d9125
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190305101926eucas1p158d6241bd6851b3d98ed9aae6cba502c
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101926eucas1p158d6241bd6851b3d98ed9aae6cba502c@eucas1p1.samsung.com>
        <1551781151-5562-4-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

I'm talking about it repeatedly. How many times already, I mentioned
that you have to resend the patch after completed the discussion.


I replied this v3 patch[2]. But, you didn't reply or answer anything
and then just send the same patch without any consent.

- Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos 5422 SoC
[2] https://lkml.org/lkml/2019/2/11/198



On 19. 3. 5. 오후 7:19, Lukasz Luba wrote:
> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
> Controller frequencies for driver's DRAM timings.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 6da5875..6f5db70 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1331,6 +1331,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>  	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
>  };
>  
> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
> +	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
> +	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
> +	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
> +	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
> +	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
> +	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
> +	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
> +	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
> +};
> +
>  static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>  	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
>  	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
> @@ -1473,7 +1484,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>  		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>  		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>  		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> -		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> +		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
>  	}
>  
>  	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
