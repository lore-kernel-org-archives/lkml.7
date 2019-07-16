Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE136C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD76B217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lD9Ldx/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfGPJ2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:28:05 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:31300 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfGPJ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:28:04 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190716092801epoutp03ef0de2fa612301c76c42e6d8ab352a4f~x2SDm6FkB1981419814epoutp03o
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:28:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190716092801epoutp03ef0de2fa612301c76c42e6d8ab352a4f~x2SDm6FkB1981419814epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563269281;
        bh=Q5UakLD205wShaSTG+f5fz7cKkprRmkmPhAwjsEjUTQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lD9Ldx/Y/mMBR6ZW5ZHRuPU029wHqBo5B/Gl632i5MyX61PfexMubcmbwALkSoSXF
         bMUaWrk6L5MI7X4zizajHkZaqJuc/lwWvz5AaitelfHSGjh3q9G18uBMSIboLgv8ri
         AjvWAfk5SYzD9z6Ei09a+KshrpFR+GFr6o89xhPA=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190716092800epcas1p10e3eab11167bd1f10ed9e92473413872~x2SDGgeD02702727027epcas1p1Q;
        Tue, 16 Jul 2019 09:28:00 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 45nw6j5K5rzMqYkc; Tue, 16 Jul
        2019 09:27:57 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.09.04160.D989D2D5; Tue, 16 Jul 2019 18:27:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190716092757epcas1p3f1040feadd8e767b7861cf8d6e95a9fe~x2SAMdMTR2981129811epcas1p3N;
        Tue, 16 Jul 2019 09:27:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716092757epsmtrp2d3d0ada13ab4e98b5376d63895727349~x2SALa3b22184421844epsmtrp2k;
        Tue, 16 Jul 2019 09:27:57 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-a1-5d2d989dcd69
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.B5.03638.D989D2D5; Tue, 16 Jul 2019 18:27:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716092756epsmtip14e25281fc922a010605e07c6c892694b~x2R-xBEP41188811888epsmtip1n;
        Tue, 16 Jul 2019 09:27:56 +0000 (GMT)
Subject: Re: [PATCH v1 13/50] clk: samsung: add DPLL rate table in
 Exynos5420
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
Message-ID: <9095a5be-3002-93c6-9d08-92eb84f5c103@samsung.com>
Date:   Tue, 16 Jul 2019 18:31:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715124417.4787-14-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmnu7cGbqxBs+vq1ncWneO1WLjjPWs
        FvOPAFn9j18zW5w/v4Hd4mzTG3aLWw0yFpseX2O1+Nhzj9Xi8q45bBYzzu9jslh75C67xdLr
        F5ksLp5ytbjduILNonXvEXaLw2/aWS3+XdvI4iDksWbeGkaP9zda2T02repk89i8pN7j4Ls9
        TB59W1YxenzeJBfAHpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr
        5OIToOuWmQP0hJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10v
        OT/XytDAwMgUqDAhO2PJit+sBcuFKg4uaGJtYJzI38XIySEhYCKx71ojYxcjF4eQwA5GiXXT
        LrJCOJ8YJWZPWwOV+cYo8fXsS/YuRg6wlgOXrSHie4Hij3+wQzjvGSWmvTvJDDJXWMBfYsHl
        fYwgtojAOUaJjqfSIDazwDQmiVnzREFsNgEtif0vbrCB2PwCihJXfzwGq+cVsJM4sPAh2BwW
        AVWJC99awGpEBSIkTh2ZxwJRIyhxcuYTFpCDOAUcJN6eEoAYLy5x68l8JghbXqJ562xmkNsk
        BE6xS7SsfsIG8bOLxK+V/1kgbGGJV8e3sEPYUhKf3+2FqqmWWHnyCBtEcwejxJb9F1ghEsYS
        +5dOZgJZzCygKbF+lz5EWFFi5++5jBCL+STefe1hhQQWr0RHmxBEibLE5Qd3mSBsSYnF7Z1s
        ExiVZiH5ZhaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQtMkCN7EyM4fWtZ7GDcc87nEKMAB6MS
        D++JPTqxQqyJZcWVuYcYJTiYlUR4bb9qxwrxpiRWVqUW5ccXleakFh9iNAUG9kRmKdHkfGBu
        ySuJNzQ1MjY2tjAxNDM1NFQS5533RzNWSCA9sSQ1OzW1ILUIpo+Jg1OqgdH4s3D9tuJtB1qv
        R93Sd3zMyu76VLQn1SP9acF20/BL+juXuH94vSjoj+Ph6q/VIVqTfpmt6/7CszA52+rgrvQF
        1Ybcp29vPX9rWkWGc9MfufCn4j2lVrW5Lf26rwL4Aqo+JuopG62ubF0nKq3GZGvde0B2wbwd
        m0zn+roWtRlFdJ47pNdbrcRSnJFoqMVcVJwIABIUyHT1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTUQDHOfexXafD22Z5fKC4iGLT5aIPJywRenAhgj5aMeySFzXdg101
        jSKzNBJRM/AxSw2sRNS5aeJqpnMma+FjaiaTnpMIXxWyiB6S2wj27Qf/3++cA4fCJa+IWCpP
        W8gZtGyBTCAiBh2yhJT7TSnq1KX+SOTpnSKRuclEorbxbar1ruJoerpPiCbL14TIUxaPLN4F
        En2vfkeiuaf3BKhp+jmGesbfCtHDN24MuV3H0dL1TgGqGB4XIsfaLRJtLZiJDAnT3doNmK+L
        FULG0nVbwPR3XGPsGzaMqRnoAsymJeG08KzocDZXkFfMGfannxfldnT+JvWPJSX29nKyDNyJ
        rAIUBemDcHQurQqEURL6GYAt9n1+hnQMbHC/wIOKFDocfBUQbSvrALorTQK/I6VPwcHJ98A/
        RNFTANb8nRT6B5xuwKDThAcPdQLY2XjIzwJaDke+LAbiSDoJvv7pBX4W0+lw9MHHgE/Qe+DM
        j5sBZyedCesXrETQ2QFfNi8T/geF0Rlw3UUHr9oL/7TO4kGOhp7lNizIifDGkxa8DkiNIbUx
        JDGGJMaQpB0QXSCG0/OaHA2v0h/QcpeUPKvhi7Q5ygs6jQUEvlguHwJOZ9YYoCkgixA7bclq
        CckW86WaMQApXBYlPuJTqCXibLb0MmfQZRmKCjh+DMRRhCxanKibOCOhc9hCLp/j9Jzh/4pR
        YbFlgBlumEnivFm9qQrz7jjTmqfomzJNcwK3dobXXe3ZtKrO/RqaT8ddZl1+ychK8tS8KyK8
        /mj8AP6pBqu9i/s+9CtVmvoIpBY/Emdi1ZTONHtyKxe1snE2naLxmC/Rro3yWVfVldI+x/rE
        Y5+CihY098pXFq/kf7Zd3LUhI/hcViXHDTz7D0D1eH7eAgAA
X-CMS-MailID: 20190716092757epcas1p3f1040feadd8e767b7861cf8d6e95a9fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190715124444eucas1p2683c9896e8be45d6a0cd4afeb681a2ea
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124444eucas1p2683c9896e8be45d6a0cd4afeb681a2ea@eucas1p2.samsung.com>
        <20190715124417.4787-14-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Also, you better to merge patch13/patch15/patch16 to one patch
in order to add the PLL table for DPLL/MPLL/SPLL.

And I have a question. Are there any use-case to change
the PLL frequency for DPLL/MPLL/SPLL?

On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
> The DPLL has fixed frequency left by the bootloader and it is not possible
> to change it. With this patch the DPLL gets rate table the same for the
> whole  PLL family (similar as APLL, KPLL according to RM) so the frequency
> might be changed to one of the values defined there.
> It is needed for further patches which change the DPLL frequency to feed
> the clocks with proper base.
> It also sets CLK_IS_CRITICAL for SCLK_DPLL due to some drivers which could
> disable master clock, which is then populated higher and tries to disable
> PLL, which casues system crash. The flag is needed for this kind of use
> cases.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 7f8221527633..2395b02ce8c5 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -694,7 +694,8 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>  	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>  	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
>  			CLK_SET_RATE_PARENT, 0),
> -	MUX(0, "mout_sclk_dpll", mout_dpll_p, SRC_TOP6, 24, 1),
> +	MUX_F(CLK_MOUT_SCLK_DPLL, "mout_sclk_dpll", mout_dpll_p,
> +			SRC_TOP6, 24, 1, CLK_IS_CRITICAL, 0),
>  	MUX(0, "mout_sclk_cpll", mout_cpll_p, SRC_TOP6, 28, 1),
>  
>  	MUX(CLK_MOUT_SW_ACLK400_ISP, "mout_sw_aclk400_isp",
> @@ -1514,6 +1515,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>  
>  	if (_get_rate("fin_pll") == 24 * MHZ) {
>  		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> +		exynos5x_plls[dpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>  		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>  		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>  	}
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
