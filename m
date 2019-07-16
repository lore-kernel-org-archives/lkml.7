Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BD6C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC2F21743
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JprzL/3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbfGPJOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:14:47 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:25075 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfGPJOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:14:47 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190716091445epoutp03b019e63f6b469dd808713b8c8ea0ce21~x2GeQ-8Zx0868008680epoutp03O
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:14:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190716091445epoutp03b019e63f6b469dd808713b8c8ea0ce21~x2GeQ-8Zx0868008680epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563268485;
        bh=zBu4gOUZIJPkwABGufXzWlLGcekITc9MN5DsL/nJYAo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JprzL/3DcqjjQWfHeuAI+L6NvZz2Y2yQeIXh+kv1rwJfXNBsxmFlXeDr/Nl8tC3n5
         G3riGPb/d4lTDxQXNb0XO3KOA87r1tAsxoCwqJ1PBCTK4kDOg2WvzdKbL0ztrNgPfR
         YFkXGCKvxjWTB1SN02Rbnc9nX3bgsn7ysxqyzbxY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190716091444epcas1p211c275ef689a959e57cc43c1894d9766~x2Gdvi2LI0536605366epcas1p2T;
        Tue, 16 Jul 2019 09:14:44 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45nvqP0cy3zMqYkb; Tue, 16 Jul
        2019 09:14:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.B6.04066.1859D2D5; Tue, 16 Jul 2019 18:14:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190716091440epcas1p4a076cdb435e969787951ff4a0135e07d~x2GaRNw3X2468124681epcas1p40;
        Tue, 16 Jul 2019 09:14:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716091440epsmtrp16d05bb4d95ad6e876cd04be72ab3d772~x2GaP9UvY2700827008epsmtrp10;
        Tue, 16 Jul 2019 09:14:40 +0000 (GMT)
X-AuditID: b6c32a37-e3fff70000000fe2-72-5d2d9580d31c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.05.03706.0859D2D5; Tue, 16 Jul 2019 18:14:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716091440epsmtip29d2a42d1413a959f5c4c095a67fd3e8b~x2GZxgy7a2701527015epsmtip2s;
        Tue, 16 Jul 2019 09:14:40 +0000 (GMT)
Subject: Re: [PATCH v1 04/50] clk: samsung: add IDs to manage aclk400_mscl
 in Exynos5420
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
Message-ID: <ce268a6e-b450-c405-6fd0-4b4bc93def45@samsung.com>
Date:   Tue, 16 Jul 2019 18:17:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715124417.4787-5-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmvm7jVN1YgwO/mSxurTvHarFxxnpW
        i/lHgKz+x6+ZLc6f38BucbbpDbvFrQYZi02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfdYun1
        i0wWF0+5WtxuXMFm0br3CLvF4TftrBb/rm1kcRDyWDNvDaPH+xut7B6bVnWyeWxeUu9x8N0e
        Jo++LasYPT5vkgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
        cvEJ0HXLzAF6QkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66X
        nJ9rZWhgYGQKVJiQnbF61XOWglNCFTvuljcwHuTvYuTkkBAwkXjc3c8OYgsJ7GCUOHObsYuR
        C8j+xCix5+8lFgjnG6PE8RkT2WE6Vpx9DFW1FyixfDIzhPOeUeLv5yNsIFXCAlESbw59BusQ
        ETjHKNHxVBrEZhaYxiQxa54oiM0moCWx/8UNsHp+AUWJqz9ApnJy8ArYSVx8fJoVxGYRUJWY
        dmkGmC0qECFx6sg8FogaQYmTM5+A2ZwC9hI3jq9khZgvLnHryXwmCFteonnrbLDjJAROsUus
        /POeBeIFF4nrl+eyQtjCEq+Ob4F6TUriZX8blF0tsfIkyDMgzR2MElv2X4BqMJbYv3Qy0AYO
        oA2aEut36UOEFSV2/p7LCLGYT+Ld1x5WkBIJAV6JjjYhiBJlicsP7jJB2JISi9s72SYwKs1C
        8s4sJC/MQvLCLIRlCxhZVjGKpRYU56anFhsWGCNH9iZGcPrWMt/BuOGczyFGAQ5GJR7eE3t0
        YoVYE8uKK3MPMUpwMCuJ8Np+1Y4V4k1JrKxKLcqPLyrNSS0+xGgKDO2JzFKiyfnA3JJXEm9o
        amRsbGxhYmhmamioJM47749mrJBAemJJanZqakFqEUwfEwenVAOjxoyN7UnLea9pzOISa5g0
        +9fNyQ9WC82T/mnQYMzdqNiQ2F64e3VDxKJFfyMEv1hav7SofXjw9dU/s2f5HpwSPXu3XOPd
        izdYUt5skTeRvRsx96Dkwx3BgbOm3ltxN8dN94Gm2buboWuXh2jZHyw9Gn7wfOYqpmrOJ7/N
        99R3ifydua9x0jS2jUosxRmJhlrMRcWJAJTIR471AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSvG7DVN1Yg+NPVS1urTvHarFxxnpW
        i/lHgKz+x6+ZLc6f38BucbbpDbvFrQYZi02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfdYun1
        i0wWF0+5WtxuXMFm0br3CLvF4TftrBb/rm1kcRDyWDNvDaPH+xut7B6bVnWyeWxeUu9x8N0e
        Jo++LasYPT5vkgtgj+KySUnNySxLLdK3S+DKWL3qOUvBKaGKHXfLGxgP8ncxcnJICJhIrDj7
        mBHEFhLYzShx+oUnRFxSYtrFo8xdjBxAtrDE4cPFXYxcQCVvGSUO3XvHDFIjLBAlcWzdTXaQ
        hIjAOUaJvr9n2UESzALTmCROrGeG6DjOKPFu9SMWkASbgJbE/hc32EBsfgFFias/IDbzCthJ
        XHx8mhXEZhFQlZh2aQaYLSoQITHp2k4WiBpBiZMzn4DZnAL2EjeOr2SFWKYu8WfeJWYIW1zi
        1pP5TBC2vETz1tnMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7N
        S9dLzs/dxAiOZC3NHYyXl8QfYhTgYFTi4T2xRydWiDWxrLgy9xCjBAezkgiv7VftWCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoY5TRkeDkqrq0LzKzw
        lJPauP9ryrtjT9eZRrkITQub/vjhtYJfqV2s/Iv1vvWlnTOyPqwu2NDt8O+zuvPuWynmdSnP
        Mi4o7L4WfndJC7/Nk//vz9ff4++S/9we8c7y+b99n9YX/WouOLzxU6W4Jtu2E/eq5Bpmfdyj
        Plv02v/3n6N//tJkbxEOUWIpzkg01GIuKk4EAPoGYeTgAgAA
X-CMS-MailID: 20190716091440epcas1p4a076cdb435e969787951ff4a0135e07d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190715124437eucas1p1827d7b5d7196f060799e5df6c27d29ad
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124437eucas1p1827d7b5d7196f060799e5df6c27d29ad@eucas1p1.samsung.com>
        <20190715124417.4787-5-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch4~patch7 just add the ID to control the clock from DT.
You can squash them to one patch instead of splitting out according to
the type of clock.

On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
> Add needed IDs to MUXes which are used from DT to properly set clock
> hierarchy.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 361ee53fc9fc..8f1d39cb2f1e 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -462,7 +462,8 @@ static const struct samsung_fixed_factor_clock
>  
>  static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>  	MUX(0, "mout_aclk400_isp", mout_group3_5800_p, SRC_TOP0, 0, 3),
> -	MUX(0, "mout_aclk400_mscl", mout_group3_5800_p, SRC_TOP0, 4, 3),
> +	MUX(CLK_MOUT_ACLK400_MSCL, "mout_aclk400_mscl", mout_group3_5800_p,
> +			SRC_TOP0, 4, 3),
>  	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group2_5800_p,
>  			SRC_TOP0, 16, 3),
>  	MUX(0, "mout_aclk100_noc", mout_group1_5800_p, SRC_TOP0, 20, 2),
> @@ -548,7 +549,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
>  				TOP_SPARE2, 4, 1),
>  
>  	MUX(0, "mout_aclk400_isp", mout_group1_p, SRC_TOP0, 0, 2),
> -	MUX(0, "mout_aclk400_mscl", mout_group1_p, SRC_TOP0, 4, 2),
> +	MUX(CLK_MOUT_ACLK400_MSCL, "mout_aclk400_mscl", mout_group1_p,
> +			SRC_TOP0, 4, 2),
>  	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group1_p,
>  			SRC_TOP0, 16, 2),
>  	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
> @@ -670,8 +672,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>  
>  	MUX(0, "mout_sw_aclk400_isp", mout_sw_aclk400_isp_p,
>  			SRC_TOP10, 0, 1),
> -	MUX(0, "mout_sw_aclk400_mscl", mout_sw_aclk400_mscl_p,
> -			SRC_TOP10, 4, 1),
> +	MUX(CLK_MOUT_SW_ACLK400_MSCL, "mout_sw_aclk400_mscl",
> +			mout_sw_aclk400_mscl_p,	SRC_TOP10, 4, 1),
>  	MUX(CLK_MOUT_SW_ACLK200, "mout_sw_aclk200", mout_sw_aclk200_p,
>  			SRC_TOP10, 8, 1),
>  	MUX(0, "mout_sw_aclk200_fsys2", mout_sw_aclk200_fsys2_p,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
