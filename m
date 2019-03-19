Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC20C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E21F20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Yzyo5GRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCSD7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:59:54 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41678 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSD7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:59:53 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190319035948epoutp01bd2930b8c4c993082e837951b57a27fd~NQChYqvrP0943409434epoutp01H
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 03:59:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190319035948epoutp01bd2930b8c4c993082e837951b57a27fd~NQChYqvrP0943409434epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552967988;
        bh=wfLqH87t3Tpi0uXp7spuAdI3pARMYbs/BOpTS36A1CQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Yzyo5GRf8OElPf1uidPttjom1UvKn9DuIHD7v5GaMMJZPum4mlXca0YKRs9Vv8/d2
         jXQoJGOP/cGtVgciKQ4OOxhYW9K/qtoDjuRAwlJ38BU7X+NZ0bOeNrskx93lYxx4wf
         HXTC0Vj0REmvYJw5N/sWnYjLmy5mdcsbUUopN/RA=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190319035945epcas1p233eaf821d2b52ec50db7609d6c6bd14c~NQCe7XIsU2636626366epcas1p2K;
        Tue, 19 Mar 2019 03:59:45 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.4C.04257.139609C5; Tue, 19 Mar 2019 12:59:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190319035945epcas1p42bab697412f09d7ce6a81e8f6e35afd7~NQCecEiw92915629156epcas1p4a;
        Tue, 19 Mar 2019 03:59:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190319035945epsmtrp1e84d61aa670d43483b5f4c22dbbd36bb~NQCebH0Pr1073810738epsmtrp1t;
        Tue, 19 Mar 2019 03:59:45 +0000 (GMT)
X-AuditID: b6c32a38-5cbff700000010a1-42-5c906931601b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.4C.03662.139609C5; Tue, 19 Mar 2019 12:59:45 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190319035945epsmtip27b268c05f92e9a72695d80da90730487~NQCeNz7_u0529105291epsmtip2Y;
        Tue, 19 Mar 2019 03:59:45 +0000 (GMT)
Subject: Re: [PATCH 2/6] drm/exynos: dsi: Use drm_bridge_detach
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <e7d55512-41be-b3a7-a23b-59fd6bfbcbc3@samsung.com>
Date:   Tue, 19 Mar 2019 12:59:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315130825.9005-3-jagan@amarulasolutions.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTZxTH8/S+tlnNXZH5BJPZ3IUPkiBcS92DCpLozN3GhybGZHEkcEMv
        baVv6y0MdIngJgrKbLPMCTrADR2DiqYqKFJxnYHgXLEbww0zQFEZ08jYsAlug932Ysa333l7
        zvmfJ4fGdAepFNrm9Ioep2BnSQ3e9e3ajHTO5ivIrP3agEY7IwSqjwyq0GKXH0PNN2Rz+NkM
        ieaCPhL9NhbF0ff7n1Co1t9Koa9810gUnBwh0I89J0n09/1+Cp2+E1Whiek+gG5WH8DRgdAN
        Ch3/ZJpE8+EhVV4Sf3Z2nOADTQHANwX28ufvdxB8KNaC873+QZI/caiB4IPttSTfHZsg+PHD
        Ayr+Qus+/uOL7YD/K/iqSburdLNVFMyiRy86i11mm9OSw769o3BroXFDJpfOZaPXWb1TcIg5
        7LZ8U/p2m10WyurLBXuZ7DIJksRm5G72uMq8ot7qkrw5rOg2293Z7nWS4JDKnJZ1xS7HRi4z
        c71RTiwqtT5uPo67H6orqk4FQBX4gq4DahoyWTB0c0pVBzS0jrkMYEdbPaYYfwI4+6SaUIwY
        gF9eiBAvSpraOpYCIQD7A/eW6mcA7L0zBeJZScwW2Dx0BMQDK5kJFfxlbiBRgjELKlgdHk1k
        kUwq9LeNk3WAprVMLvzh0s64G5fdC48bqDgnM+/AmYdX8ThrmZfhYMODBKvlBsNz8wnGmFVw
        9EGzSuE18MNLJxIiIDNLwfZIDFPm3gZ/nbyOK5wEfx+4SCmcAqeP1izx+/DR00d4fB7IfABj
        n1coaIDRNnMcMWYtPNeToXRaAZ8+O0IoGVp4qEanvMHC/ujPQGEIb7f6SYV52Hrq7tLeBgAc
        G7yK+YC+cZmwxmViGpeJafy/cwvA28EroltyWESJc2ct/+0gSBxBGroMeiP5YcDQgH1Jazp2
        tEBHCOVSpSMMII2xK7Vb3pRdWrNQuUf0uAo9ZXZRCgOjvHc/lpJc7JJPyukt5IzrDQYDyuI2
        GDmOXaU9l7e1QMdYBK9YKopu0fOiTkWrU6pA/rCh8t6x5wtU0R+Hh7JP0mOm69nP3YHVvTkl
        qd5NXbrP1LXp+7a/9lF50RslGluqpj4CyPCm5JLR3d+MnM77p2VizXTnlR235v2TfWeIM1N3
        rURN1W2N9taKjavfC3btt0R3gdy0xe4rIyOfFn3XXdHwb+fOd3tCP+2+tnhwT5/vrb0sLlkF
        Lg3zSMJ/uFPv4RoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRjHeXfOzs5Go9Nm+M7AwSCigZYR8X4IDfpy+mJJBF0MHXnyMjfX
        jtcEW4qlM92GX+bMTcNK1CTmldSETbwUaW6SaC5tc6ZZiGSS2W0Xgn37Pf//83veDy+JiVbx
        GDJbnc9o1YpcGSHA+5wyaVxCtjH1eItLjBa6priodmqSg/72mTBkGw2Ms983CbRtNxJo7cMM
        jt6Uf+GhalMrDz01viSQ3feOi9wvHhJozzvGQ4/nZjhoeX0EoFd3K3FUOTzKQ+b6dQLtOqY5
        Z8T0s60lLt1p7QS0tbOUfu7t4NLDO804PWSaJOjGqgYubW+vJuj+nWUuvVQzzqG7W+/QdT3t
        gP5mj70gvCo4ncHkZhcy2mOJ6YKsDZsZ1/j5xbqWTqADj0g94JOQOgmtbR1cPRCQImoQQL3z
        J6YHZKCAsKeXDKMYOp1seOUrgO0VbizoiqkkaJt+AIJFFOXlwE37ZyI4YJQOg9b5VSysjAPo
        GfCHFII6DE1tS0TwrJBKhK7eS8EYD8R/Nhp4QT5IXYaemTU8yELqAJxsWAkxP/Da7PZuiDHq
        CPxldWFhjoYLKzZOmKWworcRMwKRJUK3RCiWCMUSoTQDvB1IGA2rylSxCZoTaqYonlWo2AJ1
        ZvyNPJUdhH5fLh8AExNpDkCRQLZP2GY2pIq4ikK2ROUAkMRkUcKkc4FImKEouc1o89K0BbkM
        6wCHSFwWLZTmjV0RUZmKfEbJMBpG+7/lkPwYHVCKpE9usf1bRzWDcWU2X858kURuumf8VH7W
        /XtEnuSbGtWmTr/2ePmnmiSDTX5l90ZyWkp1lyXLgDn8N309NVG1+SXXJMvKufexBudb3v26
        Hy3u8znW/cUjpc0Xh0rTXByfLr2qv8wlGNcY5Cn+j0Pmvev1yeWLnkWbzOaV4WyWIkGOaVnF
        P30kI9L5AgAA
X-CMS-MailID: 20190319035945epcas1p42bab697412f09d7ce6a81e8f6e35afd7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190315130851epcas1p2412844a1a23d72e725ac6e2d23179fbd
References: <20190315130825.9005-1-jagan@amarulasolutions.com>
        <CGME20190315130851epcas1p2412844a1a23d72e725ac6e2d23179fbd@epcas1p2.samsung.com>
        <20190315130825.9005-3-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



19. 3. 15. 오후 10:08에 Jagan Teki 이(가) 쓴 글:
> drm_bridge_detach now available to use while detaching
> bridge, use this core wrapper instead of explicitly
> pointing the bridge funcs.
> 
> Cc: Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Acked-by: Inki Dae <inki.dae@samsung.com>

Thanks,
Inki Dae

> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index a4253dd55f86..5daf43d02768 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1583,8 +1583,7 @@ static int exynos_dsi_host_detach(struct mipi_dsi_host *host,
>  		dsi->connector.status = connector_status_disconnected;
>  		mutex_unlock(&drm->mode_config.mutex);
>  	} else {
> -		if (dsi->out_bridge->funcs->detach)
> -			dsi->out_bridge->funcs->detach(dsi->out_bridge);
> +		drm_bridge_detach(dsi->out_bridge);
>  		dsi->out_bridge = NULL;
>  	}
>  
> 
