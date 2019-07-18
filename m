Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86A6C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729342173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MlWN+kyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfGRFVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 01:21:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38035 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfGRFVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:21:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190718052120euoutp02d42a3f0cb192c73824078149891a9091~yaNP0Jxtd2321123211euoutp02a
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 05:21:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190718052120euoutp02d42a3f0cb192c73824078149891a9091~yaNP0Jxtd2321123211euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563427280;
        bh=MQTJaLsZa5Z66qa56b/K0ThCfRuud/sV++lFtcHn7bo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MlWN+kyKvzlswni5jp/idLYT7ZkJegZoblk6lvPuqjyhRhSysZsegMeJV98DCNZHe
         CfeWEk09iD0RovdLNiK4pVHNwOkkQOmkNCQ4cUNhfML1MAaeLWdz2htVE+BUyOjbz2
         jNxB+lJAGMchG1cj6jk6PmCgrYLMYr+NsVzKdhCU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190718052119eucas1p271934bc88edfaa452cc04b4072bc434a~yaNPBnsLk0210602106eucas1p2S;
        Thu, 18 Jul 2019 05:21:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5A.FE.04377.FC1003D5; Thu, 18
        Jul 2019 06:21:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190718052118eucas1p1499dc82caad876ea9a565b37772298ab~yaNOQD0nU2247022470eucas1p1c;
        Thu, 18 Jul 2019 05:21:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718052118eusmtrp2c76a9532ac52a829d0a52eb9812b3dd2~yaNOB7YKO1144111441eusmtrp2J;
        Thu, 18 Jul 2019 05:21:18 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-2c-5d3001cf3cc4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 67.FC.04146.EC1003D5; Thu, 18
        Jul 2019 06:21:18 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190718052117eusmtip20608f0bdd2d164fa2f4a0bca6c120207~yaNNKA1vF1072010720eusmtip2k;
        Thu, 18 Jul 2019 05:21:17 +0000 (GMT)
Subject: Re: [PATCH v1 04/50] clk: samsung: add IDs to manage aclk400_mscl
 in Exynos5420
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
Message-ID: <00a88d56-92e6-3924-4e50-cb2871758b3e@partner.samsung.com>
Date:   Thu, 18 Jul 2019 07:21:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <ce268a6e-b450-c405-6fd0-4b4bc93def45@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0iTYRj13XfdcvU6Kx80KgaCBWpFP95KMqPLfghFQpQhtexDJZ21z9kV
        2jJrDcuwMvtKzcq0ZZZLU2dWXmrZxSV2ESUxFKJUolzCMCznZ+S/85xz3vM8B16e0nxmgvkU
        Q4ZgNOhTtayKfvjc6w53oyUJS7znKNJd2c6QqoJ7DPno+cKQ4taJMbd/kCJu932OvDk+xBFH
        /weG/MjpZUin8ypLCtyPFeRu6yeOlH7sUJCOl+tJj6WcJdmNrRxpGTrFkPEPVfQaja6iqALp
        vndlczqH/TSre3DzmO5stR3pRhzzN7Pxqqg9QmpKpmCMXL1LlVz77A63bzTwoO1FG21GjdiG
        lDzg5TDa7kI+rMHlCLJ6t9iQagJ7ELxyNjGyMILAaVn870Feq1khm8oQ2EprKXkYRuBqOsH5
        XIE4HoaaRzifMBu/RGDpsyl8AoXzFSAVzbEhnmdxBNTZ9/toNd4AJW01kxYah0L9n9e0D8/B
        26Cz2olkTwC0XR6Y5JU4Gsp+vafkyCDoHiieil8AWTVXJg8CnM3D9cYGzrcL8DoYHwqVGwTC
        N1c1J+N58KdefgtYBPOZEiTjo9CfWzjlWQUtrg7GF0PhRXDPGSnTMVBpPc/K6TOhazhAvmAm
        5D28RMm0GqwnNbI7DKpz3k4tmgtlFfncOaSVpvWSpnWRpnWR/u+9hmg7ChJMYlqSIC4zCAci
        RH2aaDIkRSSmpznQxMd7Ne7y1CHn793NCPNI6682L4xM0DD6TPFQWjMCntLOVvd8naDUe/SH
        DgvG9J1GU6ogNqMQntYGqY/49e3Q4CR9hrBXEPYJxn+qglcGm1H4YGLTyiZVfz6b3tBu8FyE
        rt9jVde6XSm2Gxv7MpWVHu8K59YLtxxbNr1j7TVjflZTgTc2eKQy6mmYyTp8JzfD4eESfj7p
        vDuj583ol1mWWZJ/SwntTIiRMrLiFkS/8EMb4hILVVROb2yPVfkIha3oW7u5TJL8Q+bfjlvW
        vl1Li8n6pYspo6j/C0S5Mlx0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xe7rnGA1iDZZO57O4te4cq8XGGetZ
        La5/ec5qMf8IkNv/+DWzxfnzG9gtzja9YbfY9Pgaq8XHnnusFpd3zWGzmHF+H5PF2iN32S2W
        Xr/IZHHxlKvF7cYVbBate4+wWxx+085q8e/aRhYHIY8189Ywery/0crusWlVJ5vH5iX1Hn1b
        VjF6fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZa
        pG+XoJex/ehq9oJvwhVdJ06yNDDuFehi5OSQEDCRmHSkgamLkYtDSGApo8SW29vZIRJiEpP2
        wdjCEn+udbFBFL1mlHg9ewFYQlggSuLYupvsIAkRgVOMEt2PFrOBJJgFpjFJnFjPDNHxh1Hi
        //rNLF2MHBxsAnoSO1YVgtTwCrhJLDy5lQnEZhFQldj5/wwLiC0qECHR1zabDaJGUOLkzCdg
        cU4Be4nlX68yQ8w3k5i3+SGULS5x68l8JghbXqJ562zmCYxCs5C0z0LSMgtJyywkLQsYWVYx
        iqSWFuem5xYb6hUn5haX5qXrJefnbmIExvq2Yz8372C8tDH4EKMAB6MSD+8NJf1YIdbEsuLK
        3EOMEhzMSiK8t18ChXhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmIbySuINTQ3NLSwNzY3N
        jc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwzpRUVVp01djzV/3xxNf/fnyYvlvOkXlt
        3+6FZZK8SjOFRepY2g/ND3kq3TmTl+fsicMlK2Kbcl15uJIezuxpOPqtOUpxw4wanQiev2Gr
        2jwevpB0PTbz1AW2kzsb+pavzX/8Pswrb5b63x1t17jkupT4/deF5OcxfT1S/fKNjedflZ25
        p2ouKrEUZyQaajEXFScCAJCbXS0LAwAA
X-CMS-MailID: 20190718052118eucas1p1499dc82caad876ea9a565b37772298ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124437eucas1p1827d7b5d7196f060799e5df6c27d29ad
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124437eucas1p1827d7b5d7196f060799e5df6c27d29ad
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124437eucas1p1827d7b5d7196f060799e5df6c27d29ad@eucas1p1.samsung.com>
        <20190715124417.4787-5-l.luba@partner.samsung.com>
        <ce268a6e-b450-c405-6fd0-4b4bc93def45@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 7/16/19 11:17 AM, Chanwoo Choi wrote:
> Hi,
> 
> The patch4~patch7 just add the ID to control the clock from DT.
> You can squash them to one patch instead of splitting out according to
> the type of clock.
Thank you for the review. Yes, you are right it needs to be squashed.

Regards,
Lukasz
> 
> On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
>> Add needed IDs to MUXes which are used from DT to properly set clock
>> hierarchy.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 361ee53fc9fc..8f1d39cb2f1e 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -462,7 +462,8 @@ static const struct samsung_fixed_factor_clock
>>   
>>   static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>>   	MUX(0, "mout_aclk400_isp", mout_group3_5800_p, SRC_TOP0, 0, 3),
>> -	MUX(0, "mout_aclk400_mscl", mout_group3_5800_p, SRC_TOP0, 4, 3),
>> +	MUX(CLK_MOUT_ACLK400_MSCL, "mout_aclk400_mscl", mout_group3_5800_p,
>> +			SRC_TOP0, 4, 3),
>>   	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group2_5800_p,
>>   			SRC_TOP0, 16, 3),
>>   	MUX(0, "mout_aclk100_noc", mout_group1_5800_p, SRC_TOP0, 20, 2),
>> @@ -548,7 +549,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
>>   				TOP_SPARE2, 4, 1),
>>   
>>   	MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
>> -	MUX(0, "mout_aclk400_mscl", mout_group1_p, SRC_TOP0, 4, 2),
>> +	MUX(CLK_MOUT_ACLK400_MSCL, "mout_aclk400_mscl", mout_group1_p,
>> +			SRC_TOP0, 4, 2),
>>   	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group1_p,
>>   			SRC_TOP0, 16, 2),
>>   	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
>> @@ -670,8 +672,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>>   
>>   	MUX(0, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
>>   			SRC_TOP10, 0, 1),
>> -	MUX(0, "mout_sw_aclk400_mscl", mout_sw_aclk400_mscl_p,
>> -			SRC_TOP10, 4, 1),
>> +	MUX(CLK_MOUT_SW_ACLK400_MSCL, "mout_sw_aclk400_mscl",
>> +			mout_sw_aclk400_mscl_p,	SRC_TOP10, 4, 1),
>>   	MUX(CLK_MOUT_SW_ACLK200, "mout_sw_aclk200", mout_sw_aclk200_p,
>>   			SRC_TOP10, 8, 1),
>>   	MUX(0, "mout_sw_aclk200_fsys2", mout_sw_aclk200_fsys2_p,
>>
> 
> 
