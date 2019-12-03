Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD162C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 04:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9249F206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 04:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q6Zs69Ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfLCEwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 23:52:49 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:12015 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLCEwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 23:52:49 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191203045245epoutp03c174688fb815e4631f6b85453c6ab6ff~cw1r5R_IP1425114251epoutp03z
        for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2019 04:52:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191203045245epoutp03c174688fb815e4631f6b85453c6ab6ff~cw1r5R_IP1425114251epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575348765;
        bh=xmJU0vFcQ0KvSSiUfaN4Scg6dcjYCAueY7Rz3xbGdes=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Q6Zs69CtY/fHJw61+GF5Ofz7pqDmqTzT+ocfYlijQHfVJlHzkmA7bl21LViA+tfw8
         QEgPNav32VV4TvHZWntg67uqVgfRLGoIIRWr4dzmwaE/dDpLK28g7Gjwf0pOXSuT4L
         7epKc+L6BulVSZdqCt0NKscVP+x5A58llGuXFFhE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191203045244epcas1p3d26b5c662075923003846892953fc38a~cw1rQSe6-2749727497epcas1p3_;
        Tue,  3 Dec 2019 04:52:44 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47RqNV2sDLzMqYkk; Tue,  3 Dec
        2019 04:52:42 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.36.48019.A1AE5ED5; Tue,  3 Dec 2019 13:52:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191203045241epcas1p304f6496a75fe1a323bcdad5b4018f286~cw1od5o912749727497epcas1p3v;
        Tue,  3 Dec 2019 04:52:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191203045241epsmtrp2bda2424507eed869ae504ca6fc0852c5~cw1ocz90q3052430524epsmtrp2q;
        Tue,  3 Dec 2019 04:52:41 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-45-5de5ea1aef68
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.21.06569.91AE5ED5; Tue,  3 Dec 2019 13:52:41 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191203045241epsmtip229100121f225985f3095f125b11c10e8~cw1oOKq892451924519epsmtip2H;
        Tue,  3 Dec 2019 04:52:41 +0000 (GMT)
Subject: Re: [PATCH 22/30] drm/exynos: mic: Use drm_bridge_init()
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     nd <nd@arm.com>, Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <77306b25-e9b2-5b91-9d98-04e6d9e7299b@samsung.com>
Date:   Tue, 3 Dec 2019 13:54:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126131541.47393-23-mihail.atanassov@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmvq7Uq6exBufvClv0njvJZPF/20Rm
        iytf37NZvLh3kcWi//FrZovz5zewW5xtesNusenxNVaLy7vmsFnMOL+PyeLm5WMsFmeW9zBb
        zJj8ks2B12PNvDWMHnu/LWDx2LSqk81j+7cHrB73u48zeWxeUu/Rt2UVo8fnTXIBHFHZNhmp
        iSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAJysplCXmlAKF
        AhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjPmvHnL
        UrCCu2LP3ndMDYyrOLsYOTkkBEwkphxdxtbFyMUhJLCDUWLa9sWsEM4nRokdv46xQzjfGCXu
        bH/JCtPy8MMaqKq9jBJ3l/1kBkkICbxnlDjysxjEFhZwlJjx8w9Yg4hAmcS/s/OZQRqYBf4y
        S7y/uYIRJMEmoCoxccV9NhCbV8BO4uWLU2ANLAIqEpvvLwZq4OAQFYiQOP01EaJEUOLkzCcs
        IGFOAXuJJ5NrQcLMAuISt57MZ4Kw5SWat84GWyUhsIpd4uf0JqijXSQO/2hkgbCFJV4d38IO
        YUtJfH63lw3CLpd49u4Z2HwJgRqJb3MrIExjiYsrUkBMZgFNifW79CGKFSV2/p7LCLGVT+Ld
        1x5WiGpeiY42IYgSJYljF28wQtgSEheWTGSDKPGQmH+ucgKj4iwkX81C8sosJK/MQti7gJFl
        FaNYakFxbnpqsWGBCXJEb2IEp2Qtix2Me875HGIU4GBU4uHN+PUkVog1say4MvcQowQHs5II
        7zaJp7FCvCmJlVWpRfnxRaU5qcWHGE2BYT6RWUo0OR+YL/JK4g1NjYyNjS1MDM1MDQ2VxHk5
        flyMFRJITyxJzU5NLUgtgulj4uCUamBMYTklnGybrM7ec8EzznjXv+IAByM7Be29xhY99Y9W
        V6VvKdxwe1uwttukLfVn0oMWPrHo5+Py3WrFqVCn757YeulTxemPT6Zz31FjP/h45pej/x8L
        LVLfanf8582rN+8/MdBd/Svs/QuT1scLtkpdEjXL0v6r9XdHxlTDC/NyeRTsz1tsX/dciaU4
        I9FQi7moOBEAEbbVoN8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSvK7kq6exBlvbxSx6z51ksvi/bSKz
        xZWv79ksXty7yGLR//g1s8X58xvYLc42vWG32PT4GqvF5V1z2CxmnN/HZHHz8jEWizPLe5gt
        Zkx+yebA67Fm3hpGj73fFrB4bFrVyeax/dsDVo/73ceZPDYvqffo27KK0ePzJrkAjigum5TU
        nMyy1CJ9uwSujDlv3rIUrOCu2LP3HVMD4yrOLkZODgkBE4mHH9awdjFycQgJ7GaUeL/uD3sX
        IwdQQkJiy1YOCFNY4vDhYoiSt4wSHffns4D0Cgs4Ssz4+YcVxBYRKJPY0XyYGaSIWeA/s8Sx
        2Xuhhh5jlDh1dhIbSBWbgKrExBX3wWxeATuJly9OgXWzCKhIbL6/mBnEFhWIkHi+/QYjRI2g
        xMmZT1hAruAUsJd4MrkWJMwsoC7xZ94lZghbXOLWk/lMELa8RPPW2cwTGIVmIemehaRlFpKW
        WUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI5GLa0djCdOxB9iFOBgVOLh
        zfj1JFaINbGsuDL3EKMEB7OSCO82iaexQrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmk
        J5akZqemFqQWwWSZODilGhh5BBQVze5s7J+/hnlvg3vi3hiPU9WFSuq8/MoVrnofOK7rKNqe
        6bueN1/56t2iFv8TM9z+bfZh/b1oXibH7HTGGYHKBoZ6fe73er7G/7/14j7TaS8b9zXf6nvb
        bv1dsH/Zwl03XLRXeB5VL54bejEz8FfOzOdHkvUqe42cdsmmb6g/cbzx+Q4lluKMREMt5qLi
        RABpiFDBwgIAAA==
X-CMS-MailID: 20191203045241epcas1p304f6496a75fe1a323bcdad5b4018f286
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191126131754epcas5p250f5357a8a31292a83620680f68444cb
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
        <CGME20191126131754epcas5p250f5357a8a31292a83620680f68444cb@epcas5p2.samsung.com>
        <20191126131541.47393-23-mihail.atanassov@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


19. 11. 26. 오후 10:16에 Mihail Atanassov 이(가) 쓴 글:
> No functional change: no logic depends on driver_private being NULL, so
> it's safe to set it earlier in exynos_mic_probe.
Acked-by: Inki Dae <inki.dae@samsung.com>

And tested this patch on TM2 and TM2E boards.
Tested-by: Inki Dae <inki.dae@samsung.com>

Thanks,
Inki Dae

> 
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_mic.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
> index f41d75923557..caad348a5646 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
> @@ -309,10 +309,6 @@ static const struct drm_bridge_funcs mic_bridge_funcs = {
>  static int exynos_mic_bind(struct device *dev, struct device *master,
>  			   void *data)
>  {
> -	struct exynos_mic *mic = dev_get_drvdata(dev);
> -
> -	mic->bridge.driver_private = mic;
> -
>  	return 0;
>  }
>  
> @@ -422,9 +418,7 @@ static int exynos_mic_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, mic);
>  
> -	mic->bridge.funcs = &mic_bridge_funcs;
> -	mic->bridge.of_node = dev->of_node;
> -
> +	drm_bridge_init(&mic->bridge, dev, &mic_bridge_funcs, NULL, mic);
>  	drm_bridge_add(&mic->bridge);
>  
>  	pm_runtime_enable(dev);
> 
