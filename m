Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB14C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DAB20828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JIxEx1F5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfCFIL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:11:56 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:27297 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfCFILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:11:55 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190306081151epoutp0118761fd2a48ad499668a05c3fdbf7c26~JUF4j2tbj1641716417epoutp01B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2019 08:11:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190306081151epoutp0118761fd2a48ad499668a05c3fdbf7c26~JUF4j2tbj1641716417epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551859911;
        bh=Aev+Fd8au7QBY1y/6GD+am7XmFP8qS7GYfmBm23OrgI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JIxEx1F5sl8E8x+J/R2n0hkbiS9teJ6OtopecKqUO2mh0wbkkEbBTF0Vex6lf4M00
         336FeDGAHbNwby3vtkt6HARCvWAfsViBCkIGOPSogJuoV1sXYgK0nUaoOiKMT3C9ud
         MoLXtnsPfr4Totq2YUHknB57l3U7sxIL9fpMc+AY=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190306081149epcas1p4f5e3fb5c066c72063a2cf10b0dcb25ae~JUF2AeVEs0437804378epcas1p46;
        Wed,  6 Mar 2019 08:11:49 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.B5.04206.2C08F7C5; Wed,  6 Mar 2019 17:11:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190306081146epcas1p284ab5e689f28e5f50c0f8517935333c2~JUFzg-iVi1544315443epcas1p2c;
        Wed,  6 Mar 2019 08:11:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190306081146epsmtrp2a8aec9e1a2f98696dc135d759f13abb0~JUFzfO---0937909379epsmtrp2T;
        Wed,  6 Mar 2019 08:11:46 +0000 (GMT)
X-AuditID: b6c32a39-d65ff7000000106e-74-5c7f80c2fd54
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.4C.03601.2C08F7C5; Wed,  6 Mar 2019 17:11:46 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190306081146epsmtip2df878678fee1229cae60817c373ec4db~JUFzUiRzn0965809658epsmtip2E;
        Wed,  6 Mar 2019 08:11:46 +0000 (GMT)
Subject: Re: [PATCH v5 2/8] clk: samsung: add new clocks for DMC for
 Exynos5422 SoC
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d92cd97e-32fa-fd21-fd5d-bb7eb36bc2ab@samsung.com>
Date:   Wed, 6 Mar 2019 17:11:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551781151-5562-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmge7hhvoYg5X/mSw2zljPajH/yDlW
        i/7Hr5ktzp/fwG5xtukNu8WtBhmLy7vmsFl87j3CaDHj/D4mi7VH7rJb3G5cwWZx+E07qwOP
        x6ZVnWweB9/tYfLo27KK0ePzJrkAlqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNL
        C3MlhbzE3FRbJRefAF23zBygy5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BZYF
        esWJucWleel6yfm5VoYGBkamQIUJ2RlTN/5kL/huU/HhyULGBsavRl2MnBwSAiYSZ1dtY+5i
        5OIQEtjBKDHh22l2COcTo8SnV7+gnG+MEjMnzmOEaek4sYsdxBYS2MsosfGJHIT9nlHi2EwX
        EFtYIFTiR+NbVpBmEYHljBL7pt5lBHGYBVYxSmyeugpsEpuAlsT+FzfYQGx+AUWJqz8eA8U5
        OHgF7CQ+no8DCbMIqEisXfMcrERUIELi/dPdLCA2r4CgxMmZT8BsTgEviY1fXzOB2MwC4hK3
        nsyHsuUlmrfOBvtNQqCfXeLFmT9sEB+4SKx9OosJwhaWeHV8CzuELSXx+d1eqJpqiZUnj7BB
        NHcwSmzZf4EVImEssX/pZCaQQ5kFNCXW79KHWMYn8e5rDytIWEKAV6KjTQiiWlni8oO7UKsk
        JRa3d0KN95B4vmkBywRGxVlI3pmF5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCU+TY3sQITrVa
        ljsYj53zOcQowMGoxMM7obUuRog1say4MvcQowQHs5IIb15tfYwQb0piZVVqUX58UWlOavEh
        RlNgaE9klhJNzgfmgbySeENTI2NjYwsTQzNTQ0Mlcd71Ds4xQgLpiSWp2ampBalFMH1MHJxS
        DYzOXGV2XxWMv159+npje/9uu7y9/reZ1t6Si7DZq2x75nPnO4Ny70ihBTtvZ4mtNC+dnL2h
        t9vlKd++m4ZCDp43L+7g+316eWXifYMlswOOuU+qFZjOF/5mp8b82uxLj5SC+g9miisKvbir
        bfB8wroL5Qkt793ZLT9WOqUqFobqLX+5kHufVYUSS3FGoqEWc1FxIgCj8KFiywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSvO6hhvoYg8vXxCw2zljPajH/yDlW
        i/7Hr5ktzp/fwG5xtukNu8WtBhmLy7vmsFl87j3CaDHj/D4mi7VH7rJb3G5cwWZx+E07qwOP
        x6ZVnWweB9/tYfLo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujKkbf7IXfLep+PBkIWMD41ej
        LkZODgkBE4mOE7vYuxi5OIQEdjNK3OjtY4RISEpMu3iUuYuRA8gWljh8uBii5i2jxOIff9lA
        aoQFQiV+NL5lBUmICCxnlJj7dykLiMMssIpR4t3fucwQLXcZJc43PAFrYRPQktj/4gaYzS+g
        KHH1x2NGkBW8AnYSH8/HgYRZBFQk1q55DlYiKhAhcffiCxYQm1dAUOLkzCdgNqeAl8TGr6+Z
        QGxmAXWJP/MuMUPY4hK3nsyHistLNG+dzTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTc
        YsMCo7zUcr3ixNzi0rx0veT83E2M4LjT0trBeOJE/CFGAQ5GJR7eCa11MUKsiWXFlbmHGCU4
        mJVEePNq62OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ88rnH4sUEkhPLEnNTk0tSC2CyTJxcEo1
        MBaG5Ctwezhmm621zZq/PsnFdevmkgPnnuldWSz/Neq1tVV0Vntg8Y4zU9ZrPeJsfcTukNlw
        T+bBHS8ThmCJXxIsIq9+dEudX7VH13u6fdps1YfTN6VHBd3Kf7vdasur3YvkthuEtPkZz1Q6
        GcPUG32n9pFL8Qn3pNgzZ2eut2T4u1LhrfHrBiWW4oxEQy3mouJEALcI1WG3AgAA
X-CMS-MailID: 20190306081146epcas1p284ab5e689f28e5f50c0f8517935333c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190305101925eucas1p22d36ab220829bc6df98c92bb6c5e0395
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101925eucas1p22d36ab220829bc6df98c92bb6c5e0395@eucas1p2.samsung.com>
        <1551781151-5562-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

You are missing some answer on v4 patch[1] and then
send the patch without modification. On many times,
I mentioned that please answer from the comment.

Please check the comments from reviewers
carefully without any lost.

- [v4,2/8] clk: samsung: add new clocks for DMC for Exynos5422 SoC
[1] https://lkml.org/lkml/2019/2/12/12

Please answer from the following comment.

[Following comments on v4 patch]
>>> +       DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
>>
>> Before applied this patch, on line 809, DIV_CDREX0[28:30] was already
>> defined with "dout_pclk_cdrex" gate clock name.
> In my previous email, I have mentioned that the same bits
> (8 combinations) are controlling 3 dividers, which re-branch to 3 edges
> in the clock tree named:
> CLKDIV_PCLK_CDREX, CLKDIV_PCLK_DREX0, CLKDIV_PCLK_DREX1.
> It is in the Exynos5422_UM_REV0.10 documentation section:
> 7.9.6.7 CLK_DIV_CDREX0

It is my missing point. I checked it on Exynos5422 TRM.
I want to develop the clocks according to H/W clock.
Please keep it without removal.

Instead,
It is very strange case. So, you need to add
the detailed comment when defining the multiple clocks
with same register/same bits. Also, in order to reduce
the confusion of this strange case, IMO you better to
define the three clocks at the nearby in this driver.
(CLKDIV_PCLK_CDREX, CLKDIV_PCLK_DREX0, CLKDIV_PCLK_DREX1)
If they are scattered, it is difficult for understanding
why they are developed like this.



On 19. 3. 5. 오후 7:19, Lukasz Luba wrote:
> This patch provides support for clocks needed for Dynamic Memory Controller
> in Exynos5422 SoC. It adds CDREX base register addresses, new DIV, MUX and
> GATE entries.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 54 +++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 34cce3c..6da5875 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -134,6 +134,10 @@
>  #define SRC_CDREX		0x20200
>  #define DIV_CDREX0		0x20500
>  #define DIV_CDREX1		0x20504
> +#define GATE_BUS_CDREX0		0x20700
> +#define GATE_BUS_CDREX1		0x20704
> +#define CDREX_PAUSE		0x2091c
> +#define CDREX_LPDDR3PHY_CON3	0x20a20
>  #define KPLL_LOCK		0x28000
>  #define KPLL_CON0		0x28100
>  #define SRC_KFC			0x28200
> @@ -248,6 +252,10 @@ static const unsigned long exynos5x_clk_regs[] __initconst = {
>  	DIV_CDREX1,
>  	SRC_KFC,
>  	DIV_KFC0,
> +	GATE_BUS_CDREX0,
> +	GATE_BUS_CDREX1,
> +	CDREX_PAUSE,
> +	CDREX_LPDDR3PHY_CON3,
>  };
>  
>  static const unsigned long exynos5800_clk_regs[] __initconst = {
> @@ -425,6 +433,9 @@ PNAME(mout_group13_5800_p)	= { "dout_osc_div", "mout_sw_aclkfl1_550_cam" };
>  PNAME(mout_group14_5800_p)	= { "dout_aclk550_cam", "dout_sclk_sw" };
>  PNAME(mout_group15_5800_p)	= { "dout_osc_div", "mout_sw_aclk550_cam" };
>  PNAME(mout_group16_5800_p)	= { "dout_osc_div", "mout_mau_epll_clk" };
> +PNAME(mout_mx_mspll_ccore_phy_p) = { "sclk_bpll", "mout_sclk_dpll",
> +					"mout_sclk_mpll", "ff_dout_spll2",
> +					"mout_sclk_spll", "mout_sclk_epll"};
>  
>  /* fixed rate clocks generated outside the soc */
>  static struct samsung_fixed_rate_clock
> @@ -450,7 +461,7 @@ static const struct samsung_fixed_factor_clock
>  static const struct samsung_fixed_factor_clock
>  		exynos5800_fixed_factor_clks[] __initconst = {
>  	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
> -	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
> +	FFACTOR(CLK_FF_DOUT_SPLL2, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
>  };
>  
>  static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
> @@ -472,11 +483,14 @@ static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
>  	MUX(0, "mout_aclk300_disp1", mout_group5_5800_p, SRC_TOP2, 24, 2),
>  	MUX(0, "mout_aclk300_gscl", mout_group5_5800_p, SRC_TOP2, 28, 2),
>  
> +	MUX(CLK_MOUT_MX_MSPLL_CCORE_PHY, "mout_mx_mspll_ccore_phy",
> +		mout_mx_mspll_ccore_phy_p, SRC_TOP7, 0, 3),
> +
>  	MUX(CLK_MOUT_MX_MSPLL_CCORE, "mout_mx_mspll_ccore",
> -			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 2),
> +			mout_mx_mspll_ccore_p, SRC_TOP7, 16, 3),
>  	MUX_F(CLK_MOUT_MAU_EPLL, "mout_mau_epll_clk", mout_mau_epll_clk_5800_p,
>  			SRC_TOP7, 20, 2, CLK_SET_RATE_PARENT, 0),
> -	MUX(0, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
> +	MUX(CLK_SCLK_BPLL, "sclk_bpll", mout_bpll_p, SRC_TOP7, 24, 1),
>  	MUX(0, "mout_epll2", mout_epll2_5800_p, SRC_TOP7, 28, 1),
>  
>  	MUX(0, "mout_aclk550_cam", mout_group3_5800_p, SRC_TOP8, 16, 3),
> @@ -648,7 +662,7 @@ static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
>  
>  	MUX(0, "mout_sclk_mpll", mout_mpll_p, SRC_TOP6, 0, 1),
>  	MUX(CLK_MOUT_VPLL, "mout_sclk_vpll", mout_vpll_p, SRC_TOP6, 4, 1),
> -	MUX(0, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
> +	MUX(CLK_MOUT_SCLK_SPLL, "mout_sclk_spll", mout_spll_p, SRC_TOP6, 8, 1),
>  	MUX(0, "mout_sclk_ipll", mout_ipll_p, SRC_TOP6, 12, 1),
>  	MUX(0, "mout_sclk_rpll", mout_rpll_p, SRC_TOP6, 16, 1),
>  	MUX_F(CLK_MOUT_EPLL, "mout_sclk_epll", mout_epll_p, SRC_TOP6, 20, 1,
> @@ -817,6 +831,8 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
>  	DIV(CLK_DOUT_CLK2X_PHY0, "dout_clk2x_phy0", "dout_sclk_cdrex",
>  			DIV_CDREX0, 3, 5),
>  
> +	DIV(0, "dout_pclk_drex0", "dout_cclk_drex0", DIV_CDREX0, 28, 3),
> +
>  	DIV(CLK_DOUT_PCLK_CORE_MEM, "dout_pclk_core_mem", "mout_mclk_cdrex",
>  			DIV_CDREX1, 8, 3),
>  
> @@ -1170,6 +1186,36 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>  			GATE_TOP_SCLK_ISP, 12, CLK_SET_RATE_PARENT, 0),
>  
>  	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
> +
> +	/* CDREX */
> +	GATE(CLK_CLKM_PHY0, "clkm_phy0", "dout_sclk_cdrex",
> +			GATE_BUS_CDREX0, 0, 0, 0),
> +	GATE(CLK_CLKM_PHY1, "clkm_phy1", "dout_sclk_cdrex",
> +			GATE_BUS_CDREX0, 1, 0, 0),

nitpick. Add the blank line because of clocks of the different register.

> +	GATE(0, "mx_mspll_ccore_phy", "mout_mx_mspll_ccore_phy",
> +			SRC_MASK_TOP7, 0, CLK_IGNORE_UNUSED, 0),
> +
> +	GATE(CLK_ACLK_PPMU_DREX1_1, "aclk_ppmu_drex1_1", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 12, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_PPMU_DREX1_0, "aclk_ppmu_drex1_0", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 13, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_PPMU_DREX0_1, "aclk_ppmu_drex0_1", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 14, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_ACLK_PPMU_DREX0_0, "aclk_ppmu_drex0_0", "dout_aclk_cdrex1",
> +			GATE_BUS_CDREX1, 15, CLK_IGNORE_UNUSED, 0),
> +
> +	GATE(CLK_PCLK_PPMU_DREX1_1, "pclk_ppmu_drex1_1", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 26, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PPMU_DREX1_0, "pclk_ppmu_drex1_0", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 27, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PPMU_DREX0_1, "pclk_ppmu_drex0_1", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 28, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_PCLK_PPMU_DREX0_0, "pclk_ppmu_drex0_0", "dout_pclk_cdrex",
> +			GATE_BUS_CDREX1, 29, CLK_IGNORE_UNUSED, 0),
> +
> +	GATE(CLK_CDREX_PAUSE, "clk_cdrex_pause", NULL, CDREX_PAUSE, 0, 0, 0),

nitpick. Add the blank line because of clocks of the different register.

> +	GATE(CLK_CDREX_TIMING_SET, "clk_cdrex_timing_set", NULL,
> +			CDREX_LPDDR3PHY_CON3, 28, 0, 0),
>  };
>  
>  static const struct samsung_div_clock exynos5x_disp_div_clks[] __initconst = {
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
