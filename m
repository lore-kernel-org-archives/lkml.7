Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E63C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BABE20665
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QeHZ0Ror"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbfGPJ6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:58:14 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:53972 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbfGPJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:58:14 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190716095811epoutp04d1ef6cb55b820ab8509d00cc6b6b7738~x2sZTItWW0463304633epoutp04a
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:58:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190716095811epoutp04d1ef6cb55b820ab8509d00cc6b6b7738~x2sZTItWW0463304633epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563271091;
        bh=8m7yojX5VERnehuP4IDCcAS+gpljyXXgYtBRJsLnIn4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QeHZ0RorpZs9FWRbh0uLjGMBwI4qf2R3KXRXbY9vmxM2Q6iCdWhC7dkT6OFIK5/De
         +C+VUO7xBk8WLWMxdkBM9C6WIxtf2LspvccjsMkTsp0dEvxqptwGQvzoBKaWxwnAXp
         wSrggjymoBRc3qyxmIHDNX8WC0MQLHqIBj6y2a8Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190716095810epcas1p29f5c6e495f69535a9e87b54ccf181655~x2sYhhVuz1876318763epcas1p2E;
        Tue, 16 Jul 2019 09:58:10 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 45nwnX0GP1zMqYkd; Tue, 16 Jul
        2019 09:58:08 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.60.04066.FAF9D2D5; Tue, 16 Jul 2019 18:58:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190716095807epcas1p36f57bd2bd104c0c05c53db052ce8b210~x2sWKvmlN3194731947epcas1p30;
        Tue, 16 Jul 2019 09:58:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716095807epsmtrp18101c7cdaf68d6f1cd11d6ebf43d71f2~x2sWJSu9X1917719177epsmtrp1L;
        Tue, 16 Jul 2019 09:58:07 +0000 (GMT)
X-AuditID: b6c32a37-e3fff70000000fe2-c9-5d2d9faff48f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.37.03638.FAF9D2D5; Tue, 16 Jul 2019 18:58:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716095807epsmtip126140c206ac4fd539b9fc01f07544665~x2sV32aHp2724927249epsmtip1Q;
        Tue, 16 Jul 2019 09:58:07 +0000 (GMT)
Subject: Re: [PATCH v1 10/50] clk: samsung: change ACLK100_NOC clocks
 definitions Exynos5x
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
Message-ID: <63cb24f8-5666-3fb4-0c98-ecc54cd4266f@samsung.com>
Date:   Tue, 16 Jul 2019 19:01:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715124417.4787-11-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJsWRmVeSWpSXmKPExsWy7bCmge76+bqxBhuOWVvcWneO1WLjjPWs
        FvOPAFn9j18zW5w/v4Hd4mzTG3aLWw0yFpseX2O1+Nhzj9Xi8q45bBYzzu9jslh75C67xdLr
        F5ksLp5ytbjduILNonXvEXaLw2/aWS3+XdvI4iDksWbeGkaP9zda2T02repk89i8pN7j4Ls9
        TB59W1YxenzeJBfAHpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr
        5OIToOuWmQP0hJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10v
        OT/XytDAwMgUqDAhO2PqxjOMBWflKrYs3sjSwHhAsouRk0NCwERi95tGxi5GLg4hgR2MEl+n
        HWWGcD4xSvzvX8oC4XxjlNhz+SQ7TMvdeVugWvYySvRt/A3V8p5R4tnqNcwgVcICMRKnJnQz
        gtgiAucYJTqeSoPYzALTmCRmzRMFsdkEtCT2v7jBBmLzCyhKXP3xGKyeV8BO4s+tXWBzWARU
        JY7OagKLiwpESJw6Mo8FokZQ4uTMJ2A2p4CDxKdZXYwQ88Ulbj2ZzwRhy0s0b50NdpyEwCl2
        iUdfm5ggXnCR2D3vCNQ7whKvjm+BsqUkXva3QdnVEitPHmGDaO5glNiy/wIrRMJYYv/SyUCD
        OIA2aEqs36UPEVaU2Pl7LtQRfBLvvvawgpRICPBKdLQJQZQoS1x+cBfqBEmJxe2dbBMYlWYh
        eWcWkhdmIXlhFsKyBYwsqxjFUguKc9NTiw0LjJGjexMjOIVrme9g3HDO5xCjAAejEg/viT06
        sUKsiWXFlbmHGCU4mJVEeG2/ascK8aYkVlalFuXHF5XmpBYfYjQFhvZEZinR5HxgfskriTc0
        NTI2NrYwMTQzNTRUEued90czVkggPbEkNTs1tSC1CKaPiYNTqoGxSFndZJ47e+HzQ8XLr60y
        vuW96EjWwX1MEwuDyqaxNFycV5BypTJy813XKSL1fa9drFjamnxCiv1vvhYr+MPpvXS7yeUW
        Vq3OpIYVEadsLVf6y+f1+tSs6PJj4TCU265v4s0YWsAVNSHs21XhB8z7A/62GU6Zx7XxTDTD
        gVMbsnwXnjwnwKvEUpyRaKjFXFScCABuWLF89wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCSnO76+bqxBgcWKFjcWneO1WLjjPWs
        FvOPAFn9j18zW5w/v4Hd4mzTG3aLWw0yFpseX2O1+Nhzj9Xi8q45bBYzzu9jslh75C67xdLr
        F5ksLp5ytbjduILNonXvEXaLw2/aWS3+XdvI4iDksWbeGkaP9zda2T02repk89i8pN7j4Ls9
        TB59W1YxenzeJBfAHsVlk5Kak1mWWqRvl8CVMXXjGcaCs3IVWxZvZGlgPCDZxcjJISFgInF3
        3hbGLkYuDiGB3YwSp1e+ZYFISEpMu3iUuYuRA8gWljh8uBii5i2jxNyri5hBaoQFYiROTegG
        axYROMco0ff3LDtIgllgGpPEifVgRUICJxgl9m8qBbHZBLQk9r+4wQZi8wsoSlz98ZgRxOYV
        sJP4c2sXWD2LgKrE0VlNYHFRgQiJSdd2skDUCEqcnPkEzOYUcJD4NKuLEWKXusSfeZeYIWxx
        iVtP5jNB2PISzVtnM09gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAKC+1XK84Mbe4
        NC9dLzk/dxMjOJa1tHYwnjgRf4hRgINRiYf3xB6dWCHWxLLiytxDjBIczEoivLZftWOFeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MFpkyOdeXqd5VbPF
        icvlaUyJW6L4i5Xen1J6A88Icp98vlS74PjcD7vzr2lsa5poMStRdX7rUbtgF5MNUlLHXf9V
        LUqK5k4yb30TWXwkRDzW7Jz7k9eZt/RcQ4RPmJ5fonv7zd5bn5d3i1oktLZ8PyV7PFr0t79s
        IUfFm3o31U0zH8/LmmW+VomlOCPRUIu5qDgRAEAwu8XhAgAA
X-CMS-MailID: 20190716095807epcas1p36f57bd2bd104c0c05c53db052ce8b210
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190715124441eucas1p29f1205c20e9bea5b33f8f0b5747b1102
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124441eucas1p29f1205c20e9bea5b33f8f0b5747b1102@eucas1p2.samsung.com>
        <20190715124417.4787-11-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I checked the range of ratio as following: Looks good to me.
But, you better to make it to fix the ratio range without adding ID.
Please merge the code related to adding IDs into one patch.
- Exynos5422 TRM ACLK_100_NOC_RATIO [23:20]
- Exynos5420 TRM ACLK_100_NOC_RATIO [22:20]

On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
> The ACLK100_NOC has different topology in Exynos5420 and 5422/5800.  In
> Exynos5420 this clock divider has 3 bits while in 5422/5800 has 4 bits.
> The patch adds needed dividers in the exynos5800_div_clks, updates
> exynos5x_div_clks and exynos5420_div_clks properly. It also adds IDs to
> manage clocks from DT.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 6164d0ca75e0..c13f34d3d9a1 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -471,7 +471,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>  			SRC_TOP0, 4, 3),
>  	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group2_5800_p,
>  			SRC_TOP0, 16, 3),
> -	MUX(0, "mout_aclk100_noc", mout_group1_5800_p, SRC_TOP0, 20, 2),
> +	MUX(CLK_MOUT_ACLK100_NOC, "mout_aclk100_noc", mout_group1_5800_p,
> +			SRC_TOP0, 20, 2),

Please squash this code to the patch which add the IDs.
Actually, it is not related to fix the rate range of clock.

>  
>  	MUX(0, "mout_aclk333_432_gscl", mout_group6_5800_p, SRC_TOP1, 0, 2),
>  	MUX(0, "mout_aclk333_432_isp", mout_group6_5800_p, SRC_TOP1, 4, 2),
> @@ -534,6 +535,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>  static const struct samsung_div_clock exynos5800_div_clks[] __initconst = {
>  	DIV(CLK_DOUT_ACLK400_WCORE, "dout_aclk400_wcore",
>  			"mout_aclk400_wcore", DIV_TOP0, 16, 3),
> +	DIV(CLK_DOUT_ACLK100_NOC, "dout_aclk100_noc", "mout_aclk100_noc",
> +				DIV_TOP0, 20, 4),

>  	DIV(CLK_DOUT_ACLK266_ISP, "dout_aclk266_isp", "mout_aclk266_isp",
>  				DIV_TOP8, 12, 3),
>  	DIV(0, "dout_aclk550_cam", "mout_aclk550_cam",
> @@ -569,7 +572,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
>  			SRC_TOP0, 4, 2),
>  	MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group1_p,
>  			SRC_TOP0, 16, 2),
> -	MUX(0, "mout_aclk100_noc", mout_group1_p, SRC_TOP0, 20, 2),
> +	MUX(CLK_MOUT_ACLK100_NOC, "mout_aclk100_noc", mout_group1_p,
> +			SRC_TOP0, 20, 2),

ditto.
Please squash this code to the patch which add the IDs.
Actually, it is not related to fix the rate range of clock.

>  
>  	MUX(0, "mout_aclk333_432_gscl", mout_group4_p, SRC_TOP1, 0, 2),
>  	MUX(0, "mout_aclk333_432_isp", mout_group4_p,
> @@ -600,6 +604,8 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
>  static const struct samsung_div_clock exynos5420_div_clks[] __initconst = {
>  	DIV(CLK_DOUT_ACLK400_WCORE, "dout_aclk400_wcore",
>  			"mout_aclk400_wcore", DIV_TOP0, 16, 3),
> +	DIV(CLK_DOUT_ACLK100_NOC, "dout_aclk100_noc", "mout_aclk100_noc",
> +			DIV_TOP0, 20, 3),
>  };
>  
>  static const struct samsung_gate_clock exynos5420_gate_clks[] __initconst = {
> @@ -798,8 +804,6 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>  			DIV_TOP0, 8, 3),
>  	DIV(CLK_DOUT_ACLK200_FSYS2, "dout_aclk200_fsys2", "mout_aclk200_fsys2",
>  			DIV_TOP0, 12, 3),
> -	DIV(CLK_DOUT_ACLK100_NOC, "dout_aclk100_noc", "mout_aclk100_noc",
> -			DIV_TOP0, 20, 3),
>  	DIV(CLK_DOUT_PCLK200_FSYS, "dout_pclk200_fsys", "mout_pclk200_fsys",
>  			DIV_TOP0, 24, 3),
>  	DIV(CLK_DOUT_ACLK200_FSYS, "dout_aclk200_fsys", "mout_aclk200_fsys",
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
