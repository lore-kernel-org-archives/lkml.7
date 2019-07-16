Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DCDC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B7D2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sln+luGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbfGPJqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:46:52 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:41647 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfGPJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:46:51 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190716094648epoutp025166222dc174896311b5e6f66dc33027~x2idsNN2r1154011540epoutp02P
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:46:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190716094648epoutp025166222dc174896311b5e6f66dc33027~x2idsNN2r1154011540epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563270408;
        bh=4bfSgfYoCpxhiF8FXK5rSogZNO+K2iF9TeI2hAAgd80=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=sln+luGgK+4yeGiHOrvaFfkvarEH2NYw8PG8OMNe1LtimLobdePJQ9wMdngD0vLta
         uDk0Puvg0Xq0aODqdvmLvN7jZuZ5i1Ay9aVfIluAnkQ4BpOLma/6uGZFW+s9iMQTJc
         Byl0+leQ1Qi9iXq4CBWqMQvLVWSFatLqd2yX7Ux8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190716094647epcas1p386efce8c9b0b24d25009925624c13438~x2idC4con0776707767epcas1p3T;
        Tue, 16 Jul 2019 09:46:47 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 45nwXP3PtTzMqYln; Tue, 16 Jul
        2019 09:46:45 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.FA.04088.50D9D2D5; Tue, 16 Jul 2019 18:46:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190716094644epcas1p2905f90d0067a302244b4cac39ca17cad~x2iaPB5AJ2000420004epcas1p27;
        Tue, 16 Jul 2019 09:46:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716094644epsmtrp23e07c5c0a50a4932ff52915493bd109d~x2iaOEvCc0052500525epsmtrp2T;
        Tue, 16 Jul 2019 09:46:44 +0000 (GMT)
X-AuditID: b6c32a35-85dff70000000ff8-10-5d2d9d051238
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.96.03706.40D9D2D5; Tue, 16 Jul 2019 18:46:44 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716094644epsmtip2758a371fe6a83b23d1b4692c4a1031ee~x2iZynVEa1526415264epsmtip2K;
        Tue, 16 Jul 2019 09:46:44 +0000 (GMT)
Subject: Re: [PATCH v1 01/50] clk: samsung: add new IDs for Exynos5420
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
Message-ID: <f8ff72f9-4a55-40c6-fdb9-bb4cddd00cf9@samsung.com>
Date:   Tue, 16 Jul 2019 18:49:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715124417.4787-2-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmni7rXN1Yg+krBC1urTvHarFxxnpW
        i/lHgKz+x6+ZLc6f38BucbbpDbvFrQYZi02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfdYun1
        i0wWF0+5WtxuXMFm0br3CLvF4TftrBb/rm1kcRDyWDNvDaPH+xut7B6bVnWyeWxeUu9x8N0e
        Jo++LasYPT5vkgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
        cvEJ0HXLzAF6QkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66X
        nJ9rZWhgYGQKVJiQndG4tZe94Ltyxe8evQbGjeJdjJwcEgImEi0Lm9i7GLk4hAR2MEpcXv2X
        CSQhJPCJUaJzkRxE4hujRMuER8wwHWdvPGKCSOxllDh7bD+U8x6ofcp3sCphAX+Jx6v/soHY
        IgLnGCU6nkqD2MwC05gkZs0TBbHZBLQk9r+4AVbDL6AocfXHY0YQm1fATuLYkrWsIDaLgKrE
        r3kv2UFsUYEIiVNH5rFA1AhKnJz5BMzmFLCXuNV9nw1ivrjErSfzmSBseYnmrbOZQY6TEDjF
        LnFkxy0miBdcJL7NesMKYQtLvDq+hR3ClpL4/G4vG4RdLbHy5BE2iOYORokt+y9ANRhL7F86
        GWgQB9AGTYn1u/QhwooSO3/PZYRYzCfx7msPK0iJhACvREebEESJssTlB3ehTpCUWNzeyTaB
        UWkWkndmIXlhFpIXZiEsW8DIsopRLLWgODc9tdiwwBA5sjcxgtO3lukOxinnfA4xCnAwKvHw
        KuzXiRViTSwrrsw9xCjBwawkwmv7VTtWiDclsbIqtSg/vqg0J7X4EKMpMLQnMkuJJucDc0te
        SbyhqZGxsbGFiaGZqaGhkjjvvD+asUIC6YklqdmpqQWpRTB9TBycUg2Mght88wqynh3fmb5Y
        +ufWLYn8L0pOzapRYfn/9ryr7aHvkkKL33HI/RAWMrlyTcSj0/85q/A5LrOtszbpRL/dW6e7
        wG6FziwXNyXLSLYWx9SbLFGS4fmiv7SLmJz0Ju789XeVWe6i5/+Nnk45HGyw89F3PxX2imhZ
        hb8OzWI5NtsEzJ5p661VYinOSDTUYi4qTgQAzu9yMvUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSvC7LXN1Yg4d7NS1urTvHarFxxnpW
        i/lHgKz+x6+ZLc6f38BucbbpDbvFrQYZi02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfdYun1
        i0wWF0+5WtxuXMFm0br3CLvF4TftrBb/rm1kcRDyWDNvDaPH+xut7B6bVnWyeWxeUu9x8N0e
        Jo++LasYPT5vkgtgj+KySUnNySxLLdK3S+DKaNzay17wXbnid49eA+NG8S5GTg4JAROJszce
        MXUxcnEICexmlJh1bAojREJSYtrFo8xdjBxAtrDE4cPFEDVvGSU+bX3CAhIXFvCVeHXRHCQu
        InCOUaLv71l2kF5mgWlMEifWM0M0HGeU+Lr1AthQNgEtif0vbrCB2PwCihJXfzwGi/MK2Ekc
        W7KWFcRmEVCV+DXvJdggUYEIiUnXdrJA1AhKnJz5BMzmFLCXuNV9nw1imbrEn3mXmCFscYlb
        T+YzQdjyEs1bZzNPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQv
        XS85P3cTIziStTR3MF5eEn+IUYCDUYmH98QenVgh1sSy4srcQ4wSHMxKIry2X7VjhXhTEiur
        Uovy44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamAs3q0u9vXuht87Z8e7
        Bbj+n1Qg80jKQ1iYdfKZjf0tNWuOFtj+ZhJYNnO25+a1rzabZN85bRbV9/Dqn616Riv1wh3q
        M8Iqwxxv/qjcpGYx7buXRcepbzfmPilPv9117QBz7mr9jEiDw49WHJPzVgj4pfHbcNrBjyJd
        prHz1siGyIim52vudHqsxFKckWioxVxUnAgAwMSwueACAAA=
X-CMS-MailID: 20190716094644epcas1p2905f90d0067a302244b4cac39ca17cad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190715124434eucas1p273e2efaad8bc3904c6f76cc1671aeb6c
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124434eucas1p273e2efaad8bc3904c6f76cc1671aeb6c@eucas1p2.samsung.com>
        <20190715124417.4787-2-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Usually, when developing the clock controller driver,
define the same sequence between the definition sequence in dt-bibing
and clock driver. As I replied, if you squash patches, it is easy.

For example,
This series add clock id as following.
                                                                             
 569         MUX(CLK_MOUT_ACLK400_ISP, "mout_aclk400_isp", mout_group1_p,            
 570                         SRC_TOP0, 0, 2),                                        
 571         MUX(CLK_MOUT_ACLK400_MSCL, "mout_aclk400_mscl", mout_group1_p,          
 572                         SRC_TOP0, 4, 2),                                        
 573         MUX(CLK_MOUT_ACLK400_WCORE, "mout_aclk400_wcore", mout_group1_p,        
 574                         SRC_TOP0, 16, 2),                                       
 575         MUX(CLK_MOUT_ACLK100_NOC, "mout_aclk100_noc", mout_group1_p,            
 576                         SRC_TOP0, 20, 2),          

In case of this code, you can define the IDs as following sequentially:

#define CLK_MOUT_ACLK400_ISP ...
#define CLK_MOUT_ACLK400_MSCL ... 
#define CLK_MOUT_ACLK400_WCORE ...
#define CLK_MOUT_ACLK100_NOC ...


But, this series define the ID as following:
	#define CLK_MOUT_ACLK400_WCORE          662                                     
#define CLK_MOUT_SCLK_DPLL      663                                             
	#define CLK_MOUT_ACLK100_NOC    664                                             
#define CLK_MOUT_ACLK200_FSYS2  665                                             
#define CLK_MOUT_PCLK200_FSYS   666                                             
#define CLK_MOUT_ACLK200_FSYS   667                                             
	#define CLK_MOUT_ACLK400_ISP    668                                             
	#define CLK_MOUT_ACLK400_MSCL   669                                             
#define CLK_MOUT_SCLK_MPLL      700                                             
#define CLK_MOUT_ACLK266        701                                             
#define CLK_MOUT_UART0          702                                             
#define CLK_MOUT_UART1          703                                             
#define CLK_MOUT_UART2          704                                             
#define CLK_MOUT_UART3          7

On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
> There is a need of new IDs which will be used for modeling proper hierarchy
> in the Exynos54xx SoCs. Previous implementation rely on bootloader
> settings, which are not configuring properly some clocks.
> These IDs provide interface to set proper parents.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 27 +++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
> index 02d5ac469a3d..c37a28eeaf7e 100644
> --- a/include/dt-bindings/clock/exynos5420.h
> +++ b/include/dt-bindings/clock/exynos5420.h
> @@ -230,6 +230,30 @@
>  #define CLK_MOUT_USER_MAU_EPLL	659
>  #define CLK_MOUT_SCLK_SPLL	660
>  #define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
> +#define CLK_MOUT_ACLK400_WCORE		662
> +#define CLK_MOUT_SCLK_DPLL	663
> +#define CLK_MOUT_ACLK100_NOC	664
> +#define CLK_MOUT_ACLK200_FSYS2	665
> +#define CLK_MOUT_PCLK200_FSYS	666
> +#define CLK_MOUT_ACLK200_FSYS	667
> +#define CLK_MOUT_ACLK400_ISP	668
> +#define CLK_MOUT_ACLK400_MSCL	669
> +#define CLK_MOUT_SCLK_MPLL	700
> +#define CLK_MOUT_ACLK266	701
> +#define CLK_MOUT_UART0		702
> +#define CLK_MOUT_UART1		703
> +#define CLK_MOUT_UART2		704
> +#define CLK_MOUT_UART3		705
> +#define CLK_MOUT_SCLK_CPLL	706
> +#define CLK_MOUT_PWM		707
> +#define CLK_MOUT_ACLK266_G2D		708
> +#define CLK_MOUT_SW_ACLK400_WCORE	709
> +#define CLK_MOUT_SW_ACLK400_MSCL	710
> +#define CLK_MOUT_SW_ACLK400_ISP		711
> +#define CLK_MOUT_SW_ACLK266_ISP		712
> +#define CLK_MOUT_USER_ACLK266_ISP	713
> +#define CLK_MOUT_ACLK266_ISP	714
> +#define CLK_MOUT_MMC0		715
>  
>  /* divider clocks */
>  #define CLK_DOUT_PIXEL		768
> @@ -264,8 +288,9 @@
>  #define CLK_FF_DOUT_SPLL2	797
>  #define CLK_DOUT_PCLK_DREX0	798
>  #define CLK_DOUT_PCLK_DREX1	799
> +#define CLK_DOUT_ACLK266_ISP	800
>  
>  /* must be greater than maximal clock id */
> -#define CLK_NR_CLKS		800
> +#define CLK_NR_CLKS		801
>  
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
