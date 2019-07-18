Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B41C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D5F2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GiCzdX0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfGRGBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:01:21 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44970 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfGRGBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:01:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190718060119euoutp029d384d2ad4d159ff25c97fd02f5996ab~yawKJDHe61090310903euoutp02G
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 06:01:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190718060119euoutp029d384d2ad4d159ff25c97fd02f5996ab~yawKJDHe61090310903euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563429679;
        bh=z61fGzgHQ0VATyWTsCRxlQY0ElDRLc0lESOGpAN4rSY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GiCzdX0NcnAKFHqRNkmiRAwX2L066zuAit/OznwTknFlRIpWeajcTGhl1XidVpjHy
         1kkz8NceWRTLMXuG4pSsFak8XTppcSiejiyws4mhI3UgUA6tEoLwWSzFAdtYVWvto/
         NILrTPQpaxvpBsn+46puxGKGDaNkKIHzr7Zbo1RM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190718060118eucas1p1eccd454fd23a1f1395ed249a6e0faf69~yawJajnaG2681526815eucas1p1n;
        Thu, 18 Jul 2019 06:01:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 93.5D.04325.E2B003D5; Thu, 18
        Jul 2019 07:01:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190718060117eucas1p284ee6f2d6ce65627101cceb784cb62eb~yawIhrwH-1953619536eucas1p2J;
        Thu, 18 Jul 2019 06:01:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718060117eusmtrp27cfac19e6333c33d6297ff62e0ca2465~yawITds1x0409204092eusmtrp23;
        Thu, 18 Jul 2019 06:01:17 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-e0-5d300b2e9a92
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 59.E6.04140.D2B003D5; Thu, 18
        Jul 2019 07:01:17 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190718060116eusmtip219833ca52c831fc34803533efb850f3b~yawHmJ34m2012520125eusmtip2n;
        Thu, 18 Jul 2019 06:01:16 +0000 (GMT)
Subject: Re: [PATCH v1 13/50] clk: samsung: add DPLL rate table in
 Exynos5420
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        kyungmin.park@samsung.com, a.hajda@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <8d361a79-4147-e613-5b05-faf8efcef434@partner.samsung.com>
Date:   Thu, 18 Jul 2019 08:01:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <9095a5be-3002-93c6-9d08-92eb84f5c103@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0zMYRzuvbvvj67O3r7FfRahmzY/5mKYd/JzC/cH04bNpOnStx9TyX2l
        wqYi0VLCyIViUjsXuk4qE6t0K3SdG1LD2YWhWCS1tej6XtN/z+d5ns/7PJ/tZaWck/Jn45MO
        8LokbYKKlstqWobbF6q9FkUsetcmJ1232ylSVXSHIq8HPlOkpHlsLHB+kxKr9S5Dnmf1MsTk
        fEWR/rx3FLHXX6ZJkbVBQiqb3zKk7LVNQmxt60l3ZgVNsh82M6SpN4cio6+qZGs5jfGqEWl+
        dGYzGpPhFK2pvnFUk282IM0v08wweqd8ZTSfEH+Q1wWvjpTHfThXJklu9k8r+9RKZ6AXU3OR
        Jwt4KVQYrlC5SM5yuAKB0TbIuAQODyC4Vb9cFH4hGLUcpyY2njkrpaJQjuD6RQstDn0IivuL
        xl2+eAuU2huQS/DDbQgyHbkSlyDFFySgvzoWzrI0VkOtYb+LVuAN8KCqB7mwDAeBs9s6jqfi
        HWA31yPR4wOtl3pkLuyJ18Bjw3n3k0ro6ilx41lw7F7xeDvA2SyUPs2nxdqhUPGk1I194avF
        zIh4BvytE5cBC5Bx+hoS8RFwFlxxe0KgyWKjXJ2leB7cqQ8W6XXw+76edtGAp0Bnn49YYQqc
        rbkoFWkFnDzBie65YM7rcAdNg3LjBeYMUuknHaafdIx+0jH6/7mlSGZASj5FSIzlhSVJfKpa
        0CYKKUmx6j37Ek1o7Os9HbX8rkUNI1GNCLNI5a3ImB0cwVHag0J6YiMCVqryU3R/GaMU0dr0
        Q7xu325dSgIvNKLprEylVBz2cIRzOFZ7gN/L88m8bkKVsJ7+GWjVy2pvQ0nyxxx7mJIzD/6J
        7EdqxeK4z461oYNVJ+0mhi/cvHWES20yBhQ/iuLTwmyqupLCwOKOuWnD1Tcb7sY+W9FS3eGt
        XGaN8Vj+pss/OgY6NxaFDATwP8Mj/3zPWjFr24I5Qbvbvp8dUgz17criNnl9ep/naA98sT1C
        aI9Wq2RCnHbxfKlO0P4DU/BqHnYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xe7q63AaxBmuPCFjcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFtsenyN1eJjzz1Wi8u75rBZzDi/j8li7ZG77BZL
        r19ksrh4ytXiduMKNovWvUfYLQ6/aWe1+HdtI4uDkMeaeWsYPd7faGX32LSqk81j85J6j74t
        qxg9Pm+SC2CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst
        0rdL0Mt4OHkpU8ERqYqlz06yNTBeEu1i5OSQEDCROPN4LXMXIxeHkMBSRol/Nx8wQyTEJCbt
        284OYQtL/LnWxQZR9JpR4uX8K2BFwgK+EtvO3mcESYgInGKU6H60mA0kwSwwjUnixHqosX8Z
        JRoe/gRyODjYBPQkdqwqBKnhFXCT2L3xCSOIzSKgKvH49nkwW1QgQqKvbTYbRI2gxMmZT1hA
        bE4Be4kDq6YwQcw3k5i3+SEzhC0ucevJfKi4vETz1tnMExiFZiFpn4WkZRaSlllIWhYwsqxi
        FEktLc5Nzy020itOzC0uzUvXS87P3cQIjPVtx35u2cHY9S74EKMAB6MSD+8NJf1YIdbEsuLK
        3EOMEhzMSiK8t18ChXhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmIbySuINTQ3NLSwNzY3N
        jc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwWt8t/35nr1pYGq9T3Z2b66o8/cI9/9xi
        TPmyvFdMXOrlob6/VeaNx4/qxPHX/HMHOosn7H7G14edJzw4zlW15L0/O4f9SJxVpkhyXv9M
        lgXpodG/jrHFiS9+0H+PYxvXx1NHRSNM2V6Jvz2hcdePZ+b/1MTmjQuV7N9v5J2xeQEfw3P2
        vfVKLMUZiYZazEXFiQAKIyRuCwMAAA==
X-CMS-MailID: 20190718060117eucas1p284ee6f2d6ce65627101cceb784cb62eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124444eucas1p2683c9896e8be45d6a0cd4afeb681a2ea
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124444eucas1p2683c9896e8be45d6a0cd4afeb681a2ea
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124444eucas1p2683c9896e8be45d6a0cd4afeb681a2ea@eucas1p2.samsung.com>
        <20190715124417.4787-14-l.luba@partner.samsung.com>
        <9095a5be-3002-93c6-9d08-92eb84f5c103@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 7/16/19 11:31 AM, Chanwoo Choi wrote:
> Hi,
> 
> Also, you better to merge patch13/patch15/patch16 to one patch
> in order to add the PLL table for DPLL/MPLL/SPLL.
OK
> 
> And I have a question. Are there any use-case to change
> the PLL frequency for DPLL/MPLL/SPLL?
Yes, when you set a PLL frequency i.e. DPLL to 1200MHz (from 600MHz)
you can attach a child to it which is running with 400, 300, 150 MHz
and these frequencies are set only on this child clock divider
(/3, /4, /8 - 3bit div) (and there is no set parent rate and
reprogramming the master PLL). While 600MHz cannot satisfy 400MHz
and 300MHz OPPs at the same time.
If the child cannot change the PLL, because it could affect other
children of this PLL and cause misalignment in their frequency after
their dividers, it is better to stick with a rule: pin children to the
PLL with frequency rate which could be divided without a rest and gives
all OPPs rates of all children. This PLL rate could be calculated by
hand, finding least common multiple, keeping in mind clock dividers
width (i.e. 3bit).

That's why I am changing the PLLs' rates and connect children to them
also aligning OPPs to the values which are possible after DIV (3bit).

Regards,
Lukasz

> 
> On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
>> The DPLL has fixed frequency left by the bootloader and it is not possible
>> to change it. With this patch the DPLL gets rate table the same for the
>> whole  PLL family (similar as APLL, KPLL according to RM) so the frequency
>> might be changed to one of the values defined there.
>> It is needed for further patches which change the DPLL frequency to feed
>> the clocks with proper base.
>> It also sets CLK_IS_CRITICAL for SCLK_DPLL due to some drivers which could
>> disable master clock, which is then populated higher and tries to disable
>> PLL, which casues system crash. The flag is needed for this kind of use
>> cases.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 7f8221527633..2395b02ce8c5 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -694,7 +694,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>>   	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>>   	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
>>   			CLK_SET_RATE_PARENT, 0),
>> -	MUX(0, "mout_sclk_dpll", mout_dpll_p, SRC_TOP6, 24, 1),
>> +	MUX_F(CLK_MOUT_SCLK_DPLL, "mout_sclk_dpll", mout_dpll_p,
>> +			SRC_TOP6, 24, 1, CLK_IS_CRITICAL, 0),
>>   	MUX(0, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1),
>>   
>>   	MUX(CLK_MOUT_SW_ACLK400_ISP, "mout_sw_aclk400_isp",
>> @@ -1514,6 +1515,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>>   
>>   	if (_get_rate("fin_pll") == 24 * MHZ) {
>>   		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>> +		exynos5x_plls[dpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>   		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>>   		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>   	}
>>
> 
> 
