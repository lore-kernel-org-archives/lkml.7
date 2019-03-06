Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00DAC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9E8206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Pr/pMqyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfCFHFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:05:50 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47511 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbfCFHFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:05:49 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190306070547euoutp02780e6b2ccb4e7288147941b7b46001f0~JTMMd8NAO2145921459euoutp02T
        for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2019 07:05:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190306070547euoutp02780e6b2ccb4e7288147941b7b46001f0~JTMMd8NAO2145921459euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551855947;
        bh=qF/Oc9P1p22Zb45SLhIvfhGHz28eojww70QyrrjneRs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Pr/pMqyIrxeHMkw0j983xUpyBFogZsWQYZp5xPqs1XgEfl1/iQDGRrUQi3QEmP/iI
         Egp+H2hsqa7sq+N0FddSkO8ed6lpQ0EXwOK/VAPR/Kh6xSZs6c1EPg/+57gLOszumE
         fhEqfNfl5YASuQYi0x/wSmgNRy10cO2vqVeGX/ho=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190306070546eucas1p2b46074699a0766c36f32cf4c841aad8a~JTMLvukZP2183021830eucas1p2w;
        Wed,  6 Mar 2019 07:05:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6C.DC.04294.A417F7C5; Wed,  6
        Mar 2019 07:05:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190306070545eucas1p26d8b66b8709ba2b3caf3076220940f73~JTMLAFbFo2183421834eucas1p26;
        Wed,  6 Mar 2019 07:05:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190306070545eusmtrp2437a78ac43dbf90a8564e96c468e0ef7~JTMKw7YUD0309503095eusmtrp2G;
        Wed,  6 Mar 2019 07:05:45 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-68-5c7f714aaa8a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 09.FF.04284.9417F7C5; Wed,  6
        Mar 2019 07:05:45 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190306070545eusmtip126f0f32ed05bb3b63c786a98c87936ac~JTMKP6GZz1776617766eusmtip1S;
        Wed,  6 Mar 2019 07:05:45 +0000 (GMT)
Subject: Re: [PATCH v5 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <551b6d5c-b92c-9d68-920b-153ae8f9fbe1@partner.samsung.com>
Date:   Wed, 6 Mar 2019 08:05:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a35136da-79b1-17fe-3c97-8eb06da39cd6@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djPc7pehfUxBvemSFtsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVmsPXKX3eJ24wo2i8Nv2lkd
        eDw2repk8+jbsorR4/MmuQDmKC6blNSczLLUIn27BK6Mt3t+shScEav4+mEGSwPjcaEuRk4O
        CQETiZdHprN1MXJxCAmsYJR4fHMhK4TzhVHiVtczZpAqIYHPjBIXv8TCdPz8/Y0NIr6cUeLY
        HzeIhreMEitfvWUBSQgLBEu8+LeUHSQhIrCYUWLqyt9MIA6zwCpGic1TVzF2MXJwsAnoSexY
        VQhi8gq4SbT3ZYP0sgioSBxoXQK2QFQgQuJw7ztGEJtXQFDi5MwnYPM5Bewllk7fyQ5iMwuI
        S9x6Mp8JwpaXaN46mxlklYTAOXaJST0TWCCudpH4fOs9M4QtLPHq+BZ2CFtG4v9OiGYJgWKJ
        sx2r2CDsGon2kzugaqwlDh+/yApyJ7OApsT6XfoQYUeJ5qOfwcISAnwSN94KQpzAJzFp23Rm
        iDCvREcbNKA1JLb0XIBaJCaxfM009gmMSrOQPDYLyTOzkDwzC2HvAkaWVYziqaXFuempxUZ5
        qeV6xYm5xaV56XrJ+bmbGIHJ6fS/4192MO76k3SIUYCDUYmHd0JrXYwQa2JZcWXuIUYJDmYl
        EV7PrPoYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYy1
        vh3mu269LGNmagteqPdgklXIjel3zQONzneV+FWZLbpxsrQ9OHV+4I+N/zd8yZMxYpBcr/5F
        R+XW+WciZ/guL+CSzj0t3ey4Lr8l4Y5pp1hcy3Kz+rULVoi9MOjhYXN8M3en+LvmyfNyPn7Y
        mXThUKOv6vwLjWt+GCxW1rz4avXFxyHW/LlKLMUZiYZazEXFiQAP6SalSgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7qehfUxBg3H1Sw2zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdouzTW/YLS7vmsNm8bn3CKPFjPP7mCzWHrnLbnG7cQWbxeE37awO
        PB6bVnWyefRtWcXo8XmTXABzlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamS
        vp1NSmpOZllqkb5dgl7G2z0/WQrOiFV8/TCDpYHxuFAXIyeHhICJxM/f39hAbCGBpYwSNz+a
        QMTFJCbt284OYQtL/LnWBVTDBVTzmlHiyfaDjCAJYYFgic4tE5hAbBGBxYwSX1urQYqYBVYx
        Srz7O5cZomMSk8SGR8eBOjg42AT0JHasKgQxeQXcJNr7skF6WQRUJA60LgE7QlQgQuLj031g
        M3kFBCVOznzCAmJzCthLLJ2+E+wgZgEziXmbHzJD2OISt57MZ4Kw5SWat85mnsAoNAtJ+ywk
        LbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYERuO/Zz8w7GSxuDDzEKcDAq
        8fBOaK2LEWJNLCuuzD3EKMHBrCTC65lVHyPEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cBk
        kVcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgVHiRtbiBXxel9dl
        a4Z66F4W8mrusNm5cPq2bYVsHy99m/L8oebTF1+YVoRwmLBHuvOYv5jC9XHlD0UeycbV+1yy
        7HTPS6Q+2vzvzvTUX0U+yRx3Wr1/ZhgeZ5mioPf82hnjbYvaVHYt26AjZLyjioHR9Z36bqXZ
        80K4he0urb2x4NKag+dkz3UosRRnJBpqMRcVJwIAuNLddt4CAAA=
X-CMS-MailID: 20190306070545eucas1p26d8b66b8709ba2b3caf3076220940f73
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101926eucas1p158d6241bd6851b3d98ed9aae6cba502c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101926eucas1p158d6241bd6851b3d98ed9aae6cba502c
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101926eucas1p158d6241bd6851b3d98ed9aae6cba502c@eucas1p1.samsung.com>
        <1551781151-5562-4-git-send-email-l.luba@partner.samsung.com>
        <a35136da-79b1-17fe-3c97-8eb06da39cd6@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 3/6/19 2:31 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> I'm talking about it repeatedly. How many times already, I mentioned
> that you have to resend the patch after completed the discussion.
> 
> 
> I replied this v3 patch[2]. But, you didn't reply or answer anything
> and then just send the same patch without any consent.
> 
> - Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos 5422 SoC
> [2] https://lkml.org/lkml/2019/2/11/198
The second table from the example is not compiled and never be.
The rates where tested and they work. As I said the BPLL is used only
for DMC, thus it can be used instead of the default
exynos5420_pll2550x_24mhz_tbl.
It is worth to keep it as a separate table because adding
these entries to generic PLL table might cause issues for other PLLs.

Regards,
Lukasz
> 
> 
> 
> On 19. 3. 5. 오후 7:19, Lukasz Luba wrote:
>> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
>> Controller frequencies for driver's DRAM timings.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 6da5875..6f5db70 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -1331,6 +1331,17 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>>   	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
>>   };
>>   
>> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
>> +	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
>> +	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
>> +	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
>> +	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
>> +	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
>> +};
>> +
>>   static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>>   	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
>>   	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
>> @@ -1473,7 +1484,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>>   		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>   		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>>   		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>> -		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>> +		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
>>   	}
>>   
>>   	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
>>
> 
> 
