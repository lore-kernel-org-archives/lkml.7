Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06DCC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDBD21721
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K0ucOrWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfGPJXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:23:08 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:38655 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfGPJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:23:07 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190716092304epoutp04a8455ba09ded902e06ab0c0a216e6e45~x2NvnzPKR0652806528epoutp04Y
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:23:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190716092304epoutp04a8455ba09ded902e06ab0c0a216e6e45~x2NvnzPKR0652806528epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563268984;
        bh=0F9bzj/24+LD+R/SMr1QYOgsuPHsRGm2VoKUJPK2MS0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=K0ucOrWwS8yeG6z5eShzbw04ie4Ai5M6WJNpQILAAuYR1Dgm47S18Gy7oTwrCAuAI
         dKZQkRjeqvY9Ol6pYu3lv44lvRfEsTmOC1A7uDe4NFZOvedBJDkDxWmxcdOpAg1Ru2
         uzsWfYWNAXsDBk80Os6R4F0sBzDwL6UZXDzrCS4c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190716092303epcas1p2f805b1e6ddd363aa2796ee334f7e644a~x2Nu6wfO43199531995epcas1p25;
        Tue, 16 Jul 2019 09:23:03 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45nw110r4xzMqYlt; Tue, 16 Jul
        2019 09:23:01 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.09.04066.5779D2D5; Tue, 16 Jul 2019 18:23:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190716092300epcas1p480da14cd60097e8628f6d8e13b5ea488~x2NrqlzeJ0540705407epcas1p4X;
        Tue, 16 Jul 2019 09:23:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716092300epsmtrp242e8f5f4d884e75645c8ffe5a553434c~x2NrptIYc2069720697epsmtrp2P;
        Tue, 16 Jul 2019 09:23:00 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-f1-5d2d9775e082
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.85.03706.4779D2D5; Tue, 16 Jul 2019 18:23:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716092259epsmtip13ac67680cae8023e5b2bdb44e9c6238e~x2NrPLPqR1303213032epsmtip1N;
        Tue, 16 Jul 2019 09:22:59 +0000 (GMT)
Subject: Re: [PATCH v1 02/50] clk: samsung: add IDs for Exynos5420 NoC
 clocks
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        kyungmin.park@samsung.com, a.hajda@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b8503015-732f-7ac5-1b25-50e943d27e55@samsung.com>
Date:   Tue, 16 Jul 2019 18:26:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715124417.4787-3-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRmVeSWpSXmKPExsWy7bCmgW7pdN1YgxdzWS1urTvHarFxxnpW
        i/lHgKz+x6+ZLc6f38BucbbpDbvFrQYZi02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfdYun1
        i0wWF0+5WtxuXMFm0br3CLvF4TftrBb/rm1kcRDyWDNvDaPH+xut7B6bVnWyeWxeUu9x8N0e
        Jo++LasYPT5vkgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
        cvEJ0HXLzAF6QkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66X
        nJ9rZWhgYGQKVJiQndHf/Zmt4IVIxd9DT9gbGLcIdjFyckgImEicnvSZrYuRi0NIYAejxLLX
        z1khnE+MEm+urGQGqRIS+MYocecGXMeKXdPYIYr2MkpMmrgFquM9o8ShN+/AOoQF/CVW3DnN
        BmKLCJxjlOh4Kg1iMwtMY5KYNU8UxGYT0JLY/+IGWA2/gKLE1R+PGbsYOTh4BewkVm7QATFZ
        BFQlrk72AKkQFYiQOHVkHguIzSsgKHFy5hMWkBJOAXuJ5uMSEMPFJW49mc8EYctLNG+dzQxy
        mYTAOXaJaa3HWCHud5E49vYjE4QtLPHq+BZ2CFtK4vO7vWwQdrXEypNH2CCaOxgltuy/ANVs
        LLF/6WQmkMXMApoS63fpQ4QVJXb+nssIsZhP4t3XHlaQEgkBXomONiGIEmWJyw/uQq2VlFjc
        3sk2gVFpFpJvZiF5YRaSF2YhLFvAyLKKUSy1oDg3PbXYsMAYOao3MYJTt5b5DsYN53wOMQpw
        MCrx8J7YoxMrxJpYVlyZe4hRgoNZSYTX9qt2rBBvSmJlVWpRfnxRaU5q8SFGU2BYT2SWEk3O
        B+aVvJJ4Q1MjY2NjCxNDM1NDQyVx3nl/NGOFBNITS1KzU1MLUotg+pg4OKUaGO1f6Ex4Ja9h
        Ylyaqnna7Wa6steduA86Dxe4M/HNNA56rK9q7GiTrb5n3o4wqd8SE0p5I5jnsdoxejf1Xs18
        HvJNoSPmu+xjpXDtZSfSL248f6x4rn91R3paJItilrPidW/J2durz0vZnxXinRldMaHndpma
        h7pFm+ENz+/WKiIxQjf6G14rsRRnJBpqMRcVJwIAFuvaXfMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSnG7JdN1Yg0+bRCxurTvHarFxxnpW
        i/lHgKz+x6+ZLc6f38BucbbpDbvFrQYZi02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfdYun1
        i0wWF0+5WtxuXMFm0br3CLvF4TftrBb/rm1kcRDyWDNvDaPH+xut7B6bVnWyeWxeUu9x8N0e
        Jo++LasYPT5vkgtgj+KySUnNySxLLdK3S+DK6O/+zFbwQqTi76En7A2MWwS7GDk5JARMJFbs
        msbexcjFISSwm1Hi7J/3zBAJSYlpF48C2RxAtrDE4cPFEDVvGSUWnr/MClIjLOAr8eHmHFaQ
        hIjAOUaJvr9n2UESzALTmCROrGeG6DjOKPFg3hw2kASbgJbE/hc3wGx+AUWJqz8eM4Js4BWw
        k1i5QQfEZBFQlbg62QOkQlQgQmLStZ0sIDavgKDEyZlPWEBKOAXsJZqPS0BsUpf4M+8SM4Qt
        LnHryXwmCFteonnrbOYJjMKzkHTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YW
        l+al6yXn525iBMexluYOxstL4g8xCnAwKvHwntijEyvEmlhWXJl7iFGCg1lJhNf2q3asEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYwSLHs2fL/257sN
        1yblSdO+NSVOUhfbqZE4TW7LlszYSPd3If5mNqdSv5cv/fY+SUo9wdLAd/6X3u4Jl3fUmbw2
        /ffXKGPN8/5KjvefDFTOieyzO+naobzPzznoueGx7TWxbiohOqbRv261rJR9pqt5MeW6e9I5
        x7VOM/syI4/ktbN6zovqnabEUpyRaKjFXFScCABX7fED3wIAAA==
X-CMS-MailID: 20190716092300epcas1p480da14cd60097e8628f6d8e13b5ea488
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190715124435eucas1p2099cd7670a3d85d9b11eb0ff86041a2a
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124435eucas1p2099cd7670a3d85d9b11eb0ff86041a2a@eucas1p2.samsung.com>
        <20190715124417.4787-3-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You don't need to make the separate patches according to
the type of clock just in order to add the ID by handling them
from devicetree.

Please merge following patches to one patch 
- patch2, patch4~patch7, patch9, patch11, patch12, patch14, patch17
and separate from patch13, patch15, patch16 for adding the ID


On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
> The patch adds NoC WCORE clock IDs needed used for changing parent of the
> main NoC clock from the DT device.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 16ad498e3f3f..d353870e7fda 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -463,7 +463,8 @@ static const struct samsung_fixed_factor_clock
>  static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>  	MUX(0, "mout_aclk400_isp", mout_group3_5800_p, SRC_TOP0, 0, 3),
>  	MUX(0, "mout_aclk400_mscl", mout_group3_5800_p, SRC_TOP0, 4, 3),
> -	MUX(0, "mout_aclk400_wcore", mout_group2_5800_p, SRC_TOP0, 16, 3),
> +	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group2_5800_p,
> +			SRC_TOP0, 16, 3),
>  	MUX(0, "mout_aclk100_noc", mout_group1_5800_p, SRC_TOP0, 20, 2),
>  
>  	MUX(0, "mout_aclk333_432_gscl", mout_group6_5800_p, SRC_TOP1, 0, 2),
> @@ -548,7 +549,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
>  
>  	MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
>  	MUX(0, "mout_aclk400_mscl", mout_group1_p, SRC_TOP0, 4, 2),
> -	MUX(0, "mout_aclk400_wcore", mout_group1_p, SRC_TOP0, 16, 2),
> +	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group1_p,
> +			SRC_TOP0, 16, 2),
>  	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
>  
>  	MUX(0, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
> @@ -674,8 +676,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>  			SRC_TOP10, 8, 1),
>  	MUX(0, "mout_sw_aclk200_fsys2", mout_sw_aclk200_fsys2_p,
>  			SRC_TOP10, 12, 1),
> -	MUX(0, "mout_sw_aclk400_wcore", mout_sw_aclk400_wcore_p,
> -			SRC_TOP10, 16, 1),
> +	MUX(CLK_MOUT_SW_ACLK400_WCORE, "mout_sw_aclk400_wcore",
> +			mout_sw_aclk400_wcore_p, SRC_TOP10, 16, 1),
>  	MUX(0, "mout_sw_aclk100_noc", mout_sw_aclk100_noc_p,
>  			SRC_TOP10, 20, 1),
>  	MUX(0, "mout_sw_pclk200_fsys", mout_sw_pclk200_fsys_p,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
