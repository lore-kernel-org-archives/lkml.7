Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB775C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822AB2082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q9EShU1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfDALwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:52:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57969 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfDALwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:52:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190401115253euoutp02708938ef0bad3a225f11e86624aaf9a6~RV4SRGWdX0974409744euoutp02c
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 11:52:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190401115253euoutp02708938ef0bad3a225f11e86624aaf9a6~RV4SRGWdX0974409744euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554119573;
        bh=RNtK5s/1+hT9FQhdeQ9u9XOvN1y9ajSb03GLGKTVeTk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Q9EShU1/Pg+USk/TGQTRQiqrEhmgdFt8sIzZBfcn/GvbenLnKyLV6N2ikuFQCkuUd
         ulTYcG084MH0AsODiOTIuziu4Hf4Eqe0YRhTBWg2oWQ4BZV5PIL4gHUtJ8PkPpJst9
         JU+5rFPBsFQaLsQ+Y158fK2tpts49gefKV0eRr7Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190401115252eucas1p270173d4bd60792a8c7567dabbd3c60d7~RV4RombgO0352203522eucas1p2l;
        Mon,  1 Apr 2019 11:52:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 40.2A.04377.49BF1AC5; Mon,  1
        Apr 2019 12:52:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190401115251eucas1p212ba1a09a84efa0e03a2b45b62480949~RV4Q8D8MZ0352203522eucas1p2i;
        Mon,  1 Apr 2019 11:52:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190401115251eusmtrp25dcc13466ac33f4fcb6ddfd837f1ab93~RV4Q7fUF-1360413604eusmtrp2N;
        Mon,  1 Apr 2019 11:52:51 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-f6-5ca1fb94b2d8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 62.E7.04140.39BF1AC5; Mon,  1
        Apr 2019 12:52:51 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190401115251eusmtip1e75c88a7369d7c1a9a232e89ae8a1e7f~RV4QjVhSI1638216382eusmtip1d;
        Mon,  1 Apr 2019 11:52:51 +0000 (GMT)
Subject: Re: [PATCH] video/macfb: Remove redundant code
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <6fa80c4d-1f20-deb0-e254-74f0147f4a81@samsung.com>
Date:   Mon, 1 Apr 2019 13:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUN1SGHd-BbEWY9xwc5jkybLQ_xbLaE0-jzskorso6brw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7pTfi+MMfgyW9jiytf3bBYTe5ey
        WDy7tZfJ4kTfB1aLy7vmsFksf7KW2YHN49DhDkaP+93HmTxOtn5j8Xh28CGrx+dNcgGsUVw2
        Kak5mWWpRfp2CVwZtxfvYyy4y1bx5tgPtgbGO6xdjJwcEgImEp2bPrJ3MXJxCAmsYJT41Dud
        CSQhJPCFUWLfMSGIxGdGiT2PDjLDdBxf0cIKkVjOKPF921tGiI63jBLnb1uA2MIC5hITVnSz
        gdgiAhESZ56vYwFpYBa4zyjxd+Z5dpAEm4CVxMT2VWDNvAJ2Ehe+7wbbwCKgIvFoYztQAweH
        KFBz/xl1iBJBiZMzn7CA2JwCgRKHb0wAe4FZQF5i+9s5zCDzJQQWsUvcWdoN9ZuLxNy999kh
        bGGJV8e3QNkyEv93zmeCaFgHdFDHC6ju7YwSyyf/Y4OospY4fPwiK8gVzAKaEut36UOEHSWm
        T3jDCBKWEOCTuPFWEOIIPolJ26YzQ4R5JTrahCCq1SQ2LNvABrO2a+dKaCB6SLw5eYhpAqPi
        LCSvzULyziyEvQsYmVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJpjT/45/2cG460/S
        IUYBDkYlHt4KpoUxQqyJZcWVuYcYJTiYlUR4z/QviBHiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        W83wIFpIID2xJDU7NbUgtQgmy8TBKdXA2H2tSu5AfJT8E93pH1jdGwxNfLgaUrSdsg+oCTiF
        XWBRFLF6U6+lenjm7rvd17KufTObsaA039iybP6hy8eWHGvbt27p9I3T/c0O1c07+GdnvfKD
        gg3LH8x04v207caK4kdnbHlvPH299ejkvaeNVlt48Xj0J6jxb9VQbgm8/nqF/xejpwUqNkos
        xRmJhlrMRcWJAIQdVWEsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xu7qTfy+MMTjXp2dx5et7NouJvUtZ
        LJ7d2stkcaLvA6vF5V1z2CyWP1nL7MDmcehwB6PH/e7jTB4nW7+xeDw7+JDV4/MmuQDWKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M24v3MRbc
        Zat4c+wHWwPjHdYuRk4OCQETieMrWsBsIYGljBIz16h2MXIAxWUkjq8vgygRlvhzrYuti5EL
        qOQ1o8SnH/vYQRLCAuYSE1Z0s4HYIgIREs+XNzJBFP1mlNiw8gYjiMMscJ9R4s3BnywgVWwC
        VhIT21cxgti8AnYSF77vZgaxWQRUJB5tbAerEQWadOthBwtEjaDEyZlPwGxOgUCJwzcmgF3K
        LKAu8WfeJWYIW15i+9s5zBMYBWchaZmFpGwWkrIFjMyrGEVSS4tz03OLjfSKE3OLS/PS9ZLz
        czcxAmNn27GfW3Ywdr0LPsQowMGoxMNbwbQwRog1say4MvcQowQHs5II75n+BTFCvCmJlVWp
        RfnxRaU5qcWHGE2BnpjILCWanA+M67ySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2amp
        BalFMH1MHJxSDYwTcn8ft7/Ra/yW87OE0p44QUHtkHSxpmaf/6KeycmVe/l+MFfO2Rv+p/ra
        1izdC+eW2Ej3FnvMvPdZ6eXz9ZaxIVPF9iseFLgzKaAnnDlTP3jj6qxp14xUvis8vxu13NLq
        osa811YLmRfv4brb32j4OOKNerTqUcMpyjE+4p97RQ9PLrpeqqDEUpyRaKjFXFScCABIfjTQ
        swIAAA==
X-CMS-MailID: 20190401115251eucas1p212ba1a09a84efa0e03a2b45b62480949
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190215082549epcas4p1d0901964a98383cefc42cab0dfeee178
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215082549epcas4p1d0901964a98383cefc42cab0dfeee178
References: <86a3eca8946cbeb648ddbe3ff67b983ece7498d8.1550182390.git.fthain@telegraphics.com.au>
        <CGME20190215082549epcas4p1d0901964a98383cefc42cab0dfeee178@epcas4p1.samsung.com>
        <CAMuHMdUN1SGHd-BbEWY9xwc5jkybLQ_xbLaE0-jzskorso6brw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/15/2019 09:25 AM, Geert Uytterhoeven wrote:
> On Fri, Feb 15, 2019 at 3:19 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>> The value of info->var.bits_per_pixel get checked in macfb_setcolreg().
>> Remove additional checks as they are redundant.
>>
>> macfb_defined.activate gets initialized to FB_ACTIVATE_NOW by the struct
>> initializer. Remove redundant assignments.
>>
>> macfb_defined.bits_per_pixel, .width and .height all get assigned
>> unconditionally. Remove redundant initializers.
>>
>> Cc: linux-m68k@lists.linux-m68k.org
>> Tested-by: Stan Johnson <userm57@yahoo.com>
>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
