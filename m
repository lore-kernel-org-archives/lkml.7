Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD96DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B19204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RtQjCBce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfHSOEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:04:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34309 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfHSOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:04:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190819140409euoutp01a44ad77b15b7650680c532e40fd5c436~8V_3Arsbc1730517305euoutp01Y
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:04:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190819140409euoutp01a44ad77b15b7650680c532e40fd5c436~8V_3Arsbc1730517305euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566223449;
        bh=IVGVScXvON25oAq1ZXeeLkXi4ylwf9qGe3dfQULgQ2I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RtQjCBceG9CWPNsiEsdUGcOhjMQ4u5ZkoLudtB0y+z92gBWgaIopdhhUCs+vXzMM7
         QYXNTbN/FrNsW0vTQbhCGTDAYfTfihA4PapxbRv12D909BVblh5AmIxk9YCUp+vFCn
         QbAoz3aTdvkuoFckA3CVDoBzlRw4hYZiF6Zx9JQ0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190819140408eucas1p14658360375590d19b1408d95715d7d88~8V_2e72dd0604506045eucas1p18;
        Mon, 19 Aug 2019 14:04:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 17.24.04374.85CAA5D5; Mon, 19
        Aug 2019 15:04:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190819140407eucas1p2b07b9917af8a5610b99568e2ae17b362~8V_1yy3Dd0246202462eucas1p2E;
        Mon, 19 Aug 2019 14:04:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190819140407eusmtrp2c784d48eeed6011d8b8af17bbb042294~8V_1kDeJC3145831458eusmtrp2i;
        Mon, 19 Aug 2019 14:04:07 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-e2-5d5aac58de80
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.15.04117.75CAA5D5; Mon, 19
        Aug 2019 15:04:07 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190819140407eusmtip1b1360e1158bdbf1d2b1ab5376a56e06f~8V_1NvHfZ0843608436eusmtip1E;
        Mon, 19 Aug 2019 14:04:07 +0000 (GMT)
Subject: Re: [PATCH v2] video: fbdev: Mark expected switch fall-through
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gustavo@embeddedor.com
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <270684a4-ce22-ebb8-73a8-c004674c8f5d@samsung.com>
Date:   Mon, 19 Aug 2019 16:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190730152530.3055-1-anders.roxell@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87oRa6JiDRo/cVvcmvKbyeLK1/ds
        Flv3qFqc6PvAanF51xw2B1aPdQdVPe5c28Pmcb/7OJPH501yASxRXDYpqTmZZalF+nYJXBnz
        V21gLFjDWfH0/ne2BsYf7F2MnBwSAiYSx660M3UxcnEICaxglNjQNYMZwvnCKNH36QwLhPOZ
        UWLz3o0sMC1/75yHalnOKDH32klmkISQwFtGiZPHeUBsYQF3ibOrJoLtEBHQkZj7+jxYDbNA
        hcTso5sYQWw2ASuJie2rwGxeATuJWZdms4HYLAKqEsf2HwWLiwpESNw/toEVokZQ4uTMJ2BH
        cArYSrz68ZwNYqa4xK0n85kgbHmJ5q2zwV6QEJjHLnHy4SdmiKtdJC7samSDsIUlXh3fAg0A
        GYn/O+czQTSsY5T42/ECqns7o8Tyyf+gOqwlDh+/CHQGB9AKTYn1u/Qhwo4SP/c9YwQJSwjw
        Sdx4KwhxBJ/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZSF6bheSdWUjemYWwdwEj
        yypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAFHP63/GvOxj3/Uk6xCjAwajEw+sxLSpW
        iDWxrLgy9xCjBAezkghvxRygEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2amp
        BalFMFkmDk6pBsbSqd6vZlq+StNmdDj2y2uul/H1r2c+pP767RniVltkPuGR1FqZy48Lt/2c
        csNLYab/14B5x/rnHpu35Ejckpr7E20O1+78m+UnaRBrd32G3Qmu3Pdb+7JcM917mBYv1rn9
        jXdO5XrNHbPe7n/HclvwrWGQydEPpUnJalfZp9l8nXBji9mWylOFSizFGYmGWsxFxYkA6cZO
        Wy0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xu7rha6JiDdpPSlrcmvKbyeLK1/ds
        Flv3qFqc6PvAanF51xw2B1aPdQdVPe5c28Pmcb/7OJPH501yASxRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnzV21gLFjDWfH0/ne2BsYf7F2M
        nBwSAiYSf++cZ+pi5OIQEljKKPFk+jS2LkYOoISMxPH1ZRA1whJ/rnWxQdS8ZpQ4+3cnE0hC
        WMBd4uyqiWCDRAR0JOa+Ps8MYjMLVEgcf9/NCmILCUxglFh1ygTEZhOwkpjYvooRxOYVsJOY
        dWk2G4jNIqAqcWz/UbC4qECExJn3K1ggagQlTs58AmZzCthKvPrxnA1ivrrEn3mXoHaJS9x6
        Mp8JwpaXaN46m3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmb
        GIERte3Yzy07GLveBR9iFOBgVOLh9ZgWFSvEmlhWXJl7iFGCg1lJhLdiDlCINyWxsiq1KD++
        qDQntfgQoynQcxOZpUST84HRnlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUI
        po+Jg1OqgfHIJNbpr1T/hC9vnVGYUPDi8YtVf5e43QpLXXk3fOc63/OKt/K3zZpwJfri7B9+
        P5jsNtzkZpmwN6cgW/7Di4vazpNt77Pfs8yuV4neZ60TVJHQJpxTI2TW+kpp7sKTdrPy/Ji5
        sjUmLlaZeOfyw58hh3ifRQq//O+yne3GJc41ue8lNH7sePNDiaU4I9FQi7moOBEAN5yYSr4C
        AAA=
X-CMS-MailID: 20190819140407eucas1p2b07b9917af8a5610b99568e2ae17b362
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190730152542epcas2p46c9b1c2e97c0b33df072e4fa1328f8d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190730152542epcas2p46c9b1c2e97c0b33df072e4fa1328f8d0
References: <CGME20190730152542epcas2p46c9b1c2e97c0b33df072e4fa1328f8d0@epcas2p4.samsung.com>
        <20190730152530.3055-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/30/19 5:25 PM, Anders Roxell wrote:
> Now that -Wimplicit-fallthrough is passed to GCC by default, the
> following warnings shows up:
> 
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_lcdc_channel_fb_init’:
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:2086:22: warning: this statement may fall
>  through [-Wimplicit-fallthrough=]
>    info->fix.ypanstep = 2;
>    ~~~~~~~~~~~~~~~~~~~^~~
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:2087:2: note: here
>   case V4L2_PIX_FMT_NV16:
>   ^~~~
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_lcdc_overlay_fb_init’:
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:1596:22: warning: this statement may fall
>  through [-Wimplicit-fallthrough=]
>    info->fix.ypanstep = 2;
>    ~~~~~~~~~~~~~~~~~~~^~~
> ../drivers/video/fbdev/sh_mobile_lcdcfb.c:1597:2: note: here
>   case V4L2_PIX_FMT_NV16:
>   ^~~~
> 
> Rework to address a warnings due to the enablement of
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
