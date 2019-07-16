Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E575C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4589920659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EUYjhMJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfGPJK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:10:28 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:22876 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbfGPJK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:10:27 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190716091025epoutp0328d684174569c44f24c5904b50e233ff~x2CsL2ghl0476704767epoutp03E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:10:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190716091025epoutp0328d684174569c44f24c5904b50e233ff~x2CsL2ghl0476704767epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563268225;
        bh=P4u5h85CFzOB9l4bM0VuyGV6wejNo+c68JCtJ/yWYn0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EUYjhMJw564H5OeNj+YfIPF1e4OZLpuY/6Gm57bQjniI5ceUcJ3RPAtGF0uJ33rjs
         52eLLhAP8YQu6rsNtIXCYVXDh8J/LWuixoRuj+bV9y1xWDfiS56n//2yRzBWcBk8Z2
         uolK4wB41Q1GBfdDEYfTrvd24zEPZklZFKRLbwRs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190716091024epcas1p2c7ba029d12e0577ee127fb8474c81887~x2Crnmc0x1582915829epcas1p2s;
        Tue, 16 Jul 2019 09:10:24 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45nvkN3VBNzMqYkd; Tue, 16 Jul
        2019 09:10:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.85.04066.C749D2D5; Tue, 16 Jul 2019 18:10:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190716091019epcas1p3b3d7a6a80b958ec361e4f21f0baa65bd~x2CnafxxN0663706637epcas1p32;
        Tue, 16 Jul 2019 09:10:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716091019epsmtrp1e7487c448d28a6b99e4169f88cae82c9~x2CnZc0C52476524765epsmtrp1o;
        Tue, 16 Jul 2019 09:10:19 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-77-5d2d947c79f1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.D4.03706.B749D2D5; Tue, 16 Jul 2019 18:10:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716091019epsmtip2d1ac0b25c7a2b174b117498e68f3c51f~x2Cm5kB5d2306223062epsmtip2-;
        Tue, 16 Jul 2019 09:10:19 +0000 (GMT)
Subject: Re: [PATCH v1 03/50] clk: samsung: change parent of
 dout_aclk400_wcore in Exynos5420
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
Message-ID: <6d3361b5-9e1f-eb1a-aaa9-3ca15ed5ad1d@samsung.com>
Date:   Tue, 16 Jul 2019 18:13:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715124417.4787-4-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmvm7NFN1Yg13vpS1urTvHarFxxnpW
        i/lHgKz+x6+ZLc6f38BucbbpDbvFrQYZi02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfdYun1
        i0wWF0+5WtxuXMFm0br3CLvF4TftrBb/rm1kcRDyWDNvDaPH+xut7B6bVnWyeWxeUu9x8N0e
        Jo++LasYPT5vkgtgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
        cvEJ0HXLzAF6QkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66X
        nJ9rZWhgYGQKVJiQnfH9+HGmggWcFYcPJjQwPmDvYuTkkBAwkXh45TdrFyMXh5DADkaJxj8X
        GSGcT4wS+/a3QGW+MUo877wN1/J443l2iMReRon//48ygySEBN4zSnw7xwJiCwvES/z+Ng2s
        QUTgHKNEx1NpEJtZYBqTxKx5oiA2m4CWxP4XN9hAbH4BRYmrPx4zgti8AnYSG57uB5vDIqAq
        MfXxFrD5ogIREqeOzGOBqBGUODnzCZjNKWAv0dzRzQoxX1zi1pP5TBC2vETz1tnMIIdKCBxj
        l/ixdTIzxAcuEleOtELZwhKvjm+B+kxK4mV/G5RdLbHy5BE2iOYORokt+y+wQiSMJfYvnQy0
        gQNog6bE+l36EGFFiZ2/5zJCLOaTePe1hxWkREKAV6KjTQiiRFni8oO7TBC2pMTi9k62CYxK
        s5C8MwvJC7OQvDALYdkCRpZVjGKpBcW56anFhgXGyJG9iRGcvrXMdzBuOOdziFGAg1GJh/fE
        Hp1YIdbEsuLK3EOMEhzMSiK8tl+1Y4V4UxIrq1KL8uOLSnNSiw8xmgJDeyKzlGhyPjC35JXE
        G5oaGRsbW5gYmpkaGiqJ8877oxkrJJCeWJKanZpakFoE08fEwSnVwMgvx5UwRdpmUda3PfMk
        A+fe37zb6EuR2PW/eWKBxRNSPy3ItLsySWFS3V5pjWs2049tqJ2oumRVYv65HWl+yW2pp+Q/
        nGFJOLp4tvyelJf8k39erDohxaFkFqn2c6lHt/+6rTx93yW5OvsTDDw5NQ7mGbjM0um0V9+X
        8Dljpr38YQeLfWGr65VYijMSDbWYi4oTAbZNqaH1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCSvG71FN1Yg9X39CxurTvHarFxxnpW
        i/lHgKz+x6+ZLc6f38BucbbpDbvFrQYZi02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfdYun1
        i0wWF0+5WtxuXMFm0br3CLvF4TftrBb/rm1kcRDyWDNvDaPH+xut7B6bVnWyeWxeUu9x8N0e
        Jo++LasYPT5vkgtgj+KySUnNySxLLdK3S+DK+H78OFPBAs6KwwcTGhgfsHcxcnJICJhIPN54
        Hsjm4hAS2M0o8aR1JwtEQlJi2sWjzF2MHEC2sMThw8UQNW8ZJVrPXmMGqREWiJf4/W0aWLOI
        wDlGib6/Z8GmMgtMY5I4sZ4ZouM4o8Tz5w/BEmwCWhL7X9xgA7H5BRQlrv54zAhi8wrYSWx4
        uh9sM4uAqsTUx1vANogKREhMugZxEa+AoMTJmU/AbE4Be4nmjm5WiGXqEn/mXWKGsMUlbj2Z
        zwRhy0s0b53NPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS9
        5PzcTYzgWNbS3MF4eUn8IUYBDkYlHt4Te3RihVgTy4orcw8xSnAwK4nw2n7VjhXiTUmsrEot
        yo8vKs1JLT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qBMb9B9U/wm2AxiYNbTyfN
        EagKromu23X+0b/tu27MYHxW90I2oNMjMre1kfuYdzDHlUXhO3s8Q+XPHWlvPmJ/5pH1VreZ
        1/NStfMcJ1SI9is+P6tUUaGSlPT30/vZmvOeih39dsbAPDM5xKvHJneOrkr2LIHuSXkKCrON
        uP/M26e8/oBPQ+ZBJZbijERDLeai4kQA/nCKoOECAAA=
X-CMS-MailID: 20190716091019epcas1p3b3d7a6a80b958ec361e4f21f0baa65bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190715124436eucas1p28a581bc25f6dae52a5b9b1af26d26368
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124436eucas1p28a581bc25f6dae52a5b9b1af26d26368@eucas1p2.samsung.com>
        <20190715124417.4787-4-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 7. 15. 오후 9:43, Lukasz Luba wrote:
> Change parent of dout_aclk400_wcore to mout_aclk400_wcore which reflects
> topology described in the RM.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index d353870e7fda..361ee53fc9fc 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -577,7 +577,7 @@ static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
>  
>  static const struct samsung_div_clock exynos5420_div_clks[] __initconst = {
>  	DIV(CLK_DOUT_ACLK400_WCORE, "dout_aclk400_wcore",
> -			"mout_aclk400_wcore_bpll", DIV_TOP0, 16, 3),
> +			"mout_aclk400_wcore", DIV_TOP0, 16, 3),
>  };
>  
>  static const struct samsung_gate_clock exynos5420_gate_clks[] __initconst = {
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

If possible, you better to send it to stable mailing list
with Fixes information.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
