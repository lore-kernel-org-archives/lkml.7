Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F178C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D862206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ACHd+HqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfGPKTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 06:19:55 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:53552 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731732AbfGPKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 06:19:54 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190716101951epoutp03f6958eeb7631771cadec76ed23eeb544~x2-UEYoSR0239902399epoutp03K
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 10:19:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190716101951epoutp03f6958eeb7631771cadec76ed23eeb544~x2-UEYoSR0239902399epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563272391;
        bh=li7ESFc2xgRYcwa9WScTiDWW9Wi1EvOiqBpY40/8aVc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ACHd+HqDb0UQPol0WzucuZvE6c/vhC5HFUD9vbv7W2sIJqpzYjgtjWpBtRYSO8LJY
         gtZswW9V5CfxuQbPUliS+f3U83vnbaFI4yugeNgUDsvk9UlQzMSuATjmz/Ca203b+n
         +rwOvbAfAPSM4dNNBMyLMjtixhGyJMrlpw/nPc5Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190716101950epcas1p1ded6661b61b328d3586cc5dc7c97d191~x2-TX_5UQ3240732407epcas1p1X;
        Tue, 16 Jul 2019 10:19:50 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45nxGW6NXdzMqYkd; Tue, 16 Jul
        2019 10:19:47 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.21.04088.3C4AD2D5; Tue, 16 Jul 2019 19:19:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190716101947epcas1p15db99ace732fffd2b306aaae399c0846~x2-QhmQWr3240732407epcas1p1N;
        Tue, 16 Jul 2019 10:19:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716101947epsmtrp2a413298d92059196ae9ede662408dff5~x2-Qd792O2006020060epsmtrp2U;
        Tue, 16 Jul 2019 10:19:47 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-5d-5d2da4c31778
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.38.03706.2C4AD2D5; Tue, 16 Jul 2019 19:19:46 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716101946epsmtip2ce454fe010487ec55227faff672c6d99~x2-QA088I0196001960epsmtip2K;
        Tue, 16 Jul 2019 10:19:46 +0000 (GMT)
Subject: Re: [PATCH v1 08/50] clk: samsung: change aclk266_isp clocks
 definitions Exynos5420
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
Message-ID: <5ac878fa-21c8-afcd-9afe-13ed3cd36afb@samsung.com>
Date:   Tue, 16 Jul 2019 19:22:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715124417.4787-9-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmru7hJbqxBvvXGljcWneO1WLjjPWs
        FvOPAFn9j18zW5w/v4Hd4mzTG3aLWw0yFpseX2O1+Nhzj9Xi8q45bBYzzu9jslh75C67xdLr
        F5ksLp5ytbjduILNonXvEXaLw2/aWS3+XdvI4iDksWbeGkaP9zda2T02repk89i8pN7j4Ls9
        TB59W1YxenzeJBfAHpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr
        5OIToOuWmQP0hJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10v
        OT/XytDAwMgUqDAhO+PlkYXsBfNVK57PaWVvYFwh38XIySEhYCLxYd8vxi5GLg4hgR2MEn/2
        nWCBcD4xSqz7+ZYVwvnGKHFn/XpGmJbdD05DVe1llNiweCuU855RYtGaDuYuRg4OYYE4ic0d
        QSANIgLnGCU6nkqD2MwC05gkZs0TBbHZBLQk9r+4wQZi8wsoSlz98ZgRpJVXwE5i7Q0mkDCL
        gKrE/GmrWEBsUYEIiVNH5oHZvAKCEidnPgGzOQXsJf4+3MEMMV5c4taT+UwQtrxE89bZzCCn
        SQicY5d4OPEW1AMuEgdXbWaBsIUlXh3fwg5hS0l8freXDcKullh58ggbRHMHo8SW/RdYIRLG
        EvuXTmYCOZRZQFNi/S59iLCixM7fcxkhFvNJvPvawwpSIiHAK9HRJgRRoixx+cFdJghbUmJx
        eyfbBEalWUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRiwwJD5MjexAhO31qmOxinnPM5xCjA
        wajEw6uwXydWiDWxrLgy9xCjBAezkgiv7VftWCHelMTKqtSi/Pii0pzU4kOMpsDQnsgsJZqc
        D8wteSXxhqZGxsbGFiaGZqaGhkrivPP+aMYKCaQnlqRmp6YWpBbB9DFxcEo1MG4VLxTa/2p5
        cdAVmwJO1s1Zq26WLHskcmLWa+l2rUztz4+Us7SvToswF9mx5VfoiwnGXdz7qytmvVXZ83pF
        gXPFdd8EhVlNczapJ5x5yDn10HulyKuOh/WyrsY6pZsd7vHq9To82yRwganaumkObWd+LRK2
        /ZNuaOl/9dG5RztrXorJWRyfxa7EUpyRaKjFXFScCADNnSeO9QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSvO6hJbqxBls7bCxurTvHarFxxnpW
        i/lHgKz+x6+ZLc6f38BucbbpDbvFrQYZi02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfdYun1
        i0wWF0+5WtxuXMFm0br3CLvF4TftrBb/rm1kcRDyWDNvDaPH+xut7B6bVnWyeWxeUu9x8N0e
        Jo++LasYPT5vkgtgj+KySUnNySxLLdK3S+DKeHlkIXvBfNWK53Na2RsYV8h3MXJySAiYSOx+
        cJqli5GLQ0hgN6PE8o65bBAJSYlpF48ydzFyANnCEocPF0PUvGWU2LCxkQUkLiwQJ7G5Iwgk
        LiJwjlGi7+9ZdpBeZoFpTBIn1jNDNBxnlNgzeTYzSIJNQEti/4sbYAv4BRQlrv54zAgyiFfA
        TmLtDSaQMIuAqsT8aatYQGxRgQiJSdd2gtm8AoISJ2c+AbM5Bewl/j7cwQyxS13iz7xLULa4
        xK0n85kgbHmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtc
        mpeul5yfu4kRHMlamjsYLy+JP8QowMGoxMN7Yo9OrBBrYllxZe4hRgkOZiURXtuv2rFCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1MAq+KBBv1c2d/21Z
        WsiU9EvXH+17EZ50X3ztr3q/X78rT79gnLrrv8wOli6TlOLWF6YPIwt6EuXWpP6fKb15itev
        hNquo3P4VHh2LyxsmbQy6P4a3p+aMVwhr2Yx7D1Z1aFrwHmjdkHHjHnlr7emnayp5bu/bqWY
        bIPVN8Pp997qH5zH2LnEVV+JpTgj0VCLuag4EQBDt+tT4AIAAA==
X-CMS-MailID: 20190716101947epcas1p15db99ace732fffd2b306aaae399c0846
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190715124440eucas1p10bb25e412f32f0da95761f96831893e6
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124440eucas1p10bb25e412f32f0da95761f96831893e6@eucas1p1.samsung.com>
        <20190715124417.4787-9-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
> The ACLK266_ISP has different topology in Exynos5420 and 5422/5800.  In
> Exynos5420 this clock does not have dedicated MUX which chooses PLL instead
> it takes the clock from 2-level mux from ACLK266.  In Exynos5422 there is a
> dedicated clock tree and the PLL can be chosen.  The patch adds needed
> MUXes in the exynos5800_mux_cloks, updates exynos5x_mux_clks and
> exynos5420_mux_clks properly. It also adds IDs to mange these clocks from
> DT.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 9d54856dbcda..5f251279b4c8 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -432,6 +432,10 @@ PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
>  PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
>  					"mout_sclk_mpll", "ff_dout_spll2",
>  					"mout_sclk_spll", "mout_sclk_epll"};
> +PNAME(mout_group17_5800_p)	= { "dout_aclk266_isp", "dout_sclk_sw" };
> +PNAME(mout_group18_5800_p)	= { "dout_osc_div", "mout_sw_aclk266_isp" };
> +PNAME(mout_group19_5800_p)	= { "mout_sclk_cpll", "mout_sclk_dpll",
> +					"mout_sclk_mpll", "mout_sclk_ipll"};
>  
>  /* fixed rate clocks generated outside the soc */
>  static struct samsung_fixed_rate_clock
> @@ -494,6 +498,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>  	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>  	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>  
> +	MUX(CLK_MOUT_ACLK266_ISP, "mout_aclk266_isp", mout_group19_5800_p,
> +			SRC_TOP8, 12, 2),
>  	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
>  	MUX(0, "mout_aclkfl1_550_cam", mout_group3_5800_p, SRC_TOP8, 20, 3),
>  	MUX(0, "mout_aclk432_cam", mout_group6_5800_p, SRC_TOP8, 24, 2),
> @@ -501,6 +507,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>  
>  	MUX_F(CLK_MOUT_USER_MAU_EPLL, "mout_user_mau_epll", mout_group16_5800_p,
>  			SRC_TOP9, 8, 1, CLK_SET_RATE_PARENT, 0),
> +	MUX(CLK_MOUT_USER_ACLK266_ISP, "mout_user_aclk266_isp",
> +			mout_group18_5800_p, SRC_TOP9, 12, 1),
>  	MUX(0, "mout_user_aclk550_cam", mout_group15_5800_p,
>  							SRC_TOP9, 16, 1),
>  	MUX(0, "mout_user_aclkfl1_550_cam", mout_group13_5800_p,
> @@ -510,6 +518,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>  	MUX(0, "mout_user_aclk432_scaler", mout_group9_5800_p,
>  							SRC_TOP9, 28, 1),
>  
> +	MUX(CLK_MOUT_SW_ACLK266_ISP, "mout_sw_aclk266_isp", mout_group17_5800_p,
> +			SRC_TOP13, 12, 1),
>  	MUX(0, "mout_sw_aclk550_cam", mout_group14_5800_p, SRC_TOP13, 16, 1),
>  	MUX(0, "mout_sw_aclkfl1_550_cam", mout_group12_5800_p,
>  							SRC_TOP13, 20, 1),
> @@ -524,6 +534,8 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>  static const struct samsung_div_clock exynos5800_div_clks[] __initconst = {
>  	DIV(CLK_DOUT_ACLK400_WCORE, "dout_aclk400_wcore",
>  			"mout_aclk400_wcore", DIV_TOP0, 16, 3),
> +	DIV(CLK_DOUT_ACLK266_ISP, "dout_aclk266_isp", "mout_aclk266_isp",
> +				DIV_TOP8, 12, 3),
>  	DIV(0, "dout_aclk550_cam", "mout_aclk550_cam",
>  				DIV_TOP8, 16, 3),
>  	DIV(0, "dout_aclkfl1_550_cam", "mout_aclkfl1_550_cam",
> @@ -574,6 +586,9 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
>  	MUX(0, "mout_aclk300_disp1", mout_group1_p, SRC_TOP2, 24, 2),
>  	MUX(0, "mout_aclk300_gscl", mout_group1_p, SRC_TOP2, 28, 2),
>  
> +	MUX(CLK_MOUT_USER_ACLK266_ISP, "mout_user_aclk266_isp",
> +			mout_user_aclk266_isp_p, SRC_TOP4, 16, 1),
> +
>  	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
>  			mout_group5_5800_p, SRC_TOP7, 16, 2),
>  	MUX_F(0, "mout_mau_epll_clk", mout_mau_epll_clk_p, SRC_TOP7, 20, 2,
> @@ -641,8 +656,6 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>  			SRC_TOP4, 8, 1),
>  	MUX(0, "mout_user_aclk333_432_isp0", mout_user_aclk333_432_isp0_p,
>  			SRC_TOP4, 12, 1),
> -	MUX(0, "mout_user_aclk266_isp", mout_user_aclk266_isp_p,
> -			SRC_TOP4, 16, 1),
>  	MUX(0, "mout_user_aclk266", mout_user_aclk266_p, SRC_TOP4, 20, 1),
>  	MUX(0, "mout_user_aclk166", mout_user_aclk166_p, SRC_TOP4, 24, 1),
>  	MUX(CLK_MOUT_USER_ACLK333, "mout_user_aclk333", mout_user_aclk333_p,
> 

I checked it on Exynos5420/5422 TRM.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
