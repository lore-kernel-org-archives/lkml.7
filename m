Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10698C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BDA223BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gu/tmpuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbfGWPhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:37:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42375 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfGWPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:37:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190723153709euoutp0215a9bb5ebca2634d88faf7b5e625a72c~0E1WuOl-J0992109921euoutp02U
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:37:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190723153709euoutp0215a9bb5ebca2634d88faf7b5e625a72c~0E1WuOl-J0992109921euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563896229;
        bh=0+TsZ8zwQrMvUeWW/gzsV+tlOaK1iDbp8TpeojVf4Vk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gu/tmpuw2lFF5tap0jOIm2jEtPnysyn/fOggbbiTgUY0l0Rq3ToK8O0sivWaAYQyX
         6EJpqglfAy0+/chCQ79U5PGQ3r6aD+YxL0iZdBKTQ9On8btk73U8bKGj/0j0sJaqOL
         y6kig4FJTBrOi/NjM23e7LR2gaeUxoI9k6JWuiKg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190723153708eucas1p2d9faecbed408e947a960034ce5086c74~0E1WW4p102709827098eucas1p2E;
        Tue, 23 Jul 2019 15:37:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6B.36.04377.4A9273D5; Tue, 23
        Jul 2019 16:37:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723153708eucas1p218eb08397f9939db7a81478a5e51e79e~0E1VtUQno2709727097eucas1p2C;
        Tue, 23 Jul 2019 15:37:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723153707eusmtrp1105be7ebcedd5acc33c460afb36c6768~0E1VZ-eDG2308223082eusmtrp1g;
        Tue, 23 Jul 2019 15:37:07 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-a4-5d3729a43c11
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 15.E1.04140.3A9273D5; Tue, 23
        Jul 2019 16:37:07 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190723153707eusmtip140edcd8c0add74c5baa56194b6284bfc~0E1VFrwCM1278412784eusmtip1Y;
        Tue, 23 Jul 2019 15:37:07 +0000 (GMT)
Subject: Re: [PATCH v3 24/24] video: fbdev-MMP: Remove call to memset after
 dma_alloc_coherent
To:     Emil Velikov <emil.l.velikov@gmail.com>,
        Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <e66d213d-7a66-6c53-d453-6f4bbfa79c52@samsung.com>
Date:   Tue, 23 Jul 2019 17:37:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190715104049.GC20839@arch-x1c3>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djP87pLNM1jDW7cUbO48vU9m8Weq/eY
        LJadOslqcaLvA6vF5V1z2BxYPXbOusvucb/7OJPH501yAcxRXDYpqTmZZalF+nYJXBmru26y
        Fexmrdj/9B5rA+Nuli5GTg4JAROJ6xtmsHUxcnEICaxglLh7dQ0ThPOFUWL5m8dQmc+MEt//
        /ATKcIC1LD2dDxFfzihxtvMMK4TzllFifd8+JpC5wgIJEju2nASzRQTCJL7tnMQKYjMDxf+f
        3wkWZxOwkpjYvooRZCivgJ3EprN2IGEWAVWJc2v2MIPYogIREvePbQBr5RUQlDg58wnY2ZwC
        +hLvjy9mhBgpLnHryXwmCFteYvvbOcwg90gITGeXOPjwKNSfLhJnznxlhrCFJV4d38IOYctI
        nJ7cwwLRsI5R4m/HC6ju7UD/T/7HBlFlLXH4+EVWkEuZBTQl1u/Shwg7Siz/vJ8ZEip8Ejfe
        CkIcwScxadt0qDCvREebEES1msSGZRvYYNZ27VzJPIFRaRaS12YheWcWkndmIexdwMiyilE8
        tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzC1nP53/MsOxl1/kg4xCnAwKvHwVjCZxwqxJpYV
        V+YeYpTgYFYS4Q1sMIsV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1OzW1ILUI
        JsvEwSnVwKh0tmNpehWXhG5rrkrf6WNWkaKzzl3axHl+v97enTN4y192y9+XqbLkP7rbTE87
        XujGMp+Jfk2fTiQk1+0TF5OOYe7MO7f8e8qrGicLhvrsKy/mnl1XNyF5Sljn+RXMqWaB4Ud6
        3vg6HM40mH4nc9IvpXuyjA+n96yV/Rfcl7w2wG/h7R+TliqxFGckGmoxFxUnAgAzkNA3KQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7qLNc1jDY69NbS48vU9m8Weq/eY
        LJadOslqcaLvA6vF5V1z2BxYPXbOusvucb/7OJPH501yAcxRejZF+aUlqQoZ+cUltkrRhhZG
        eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmru26yFexmrdj/9B5rA+Nuli5GDg4J
        AROJpafzuxg5OYQEljJKXDwqBRGWkTi+vgwkLCEgLPHnWhdbFyMXUMlrRonjc16xgCSEBRIk
        dmw5yQRiiwiESbyfsRkszgwU37yykRmiYSujxPanv1lBEmwCVhIT21cxgizgFbCT2HTWDiTM
        IqAqcW7NHmYQW1QgQuLM+xVgc3gFBCVOznwCZnMK6Eu8P76YEWK+usSfeZeYIWxxiVtP5jNB
        2PIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmAc
        bTv2c8sOxq53wYcYBTgYlXh4K5jMY4VYE8uKK3MPMUpwMCuJ8AY2mMUK8aYkVlalFuXHF5Xm
        pBYfYjQFem4is5Rocj4wxvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQx
        cXBKNTCeORbtkHriXpOypLP4y3XF318lXWUSCeIqUNxhK/Imkiecb+aWV/UBLlNOf+s5bVna
        a68aeWJlwezYyTy6hTV2j++ZtLdLz5/G7Ppq76+sj09uh+0/lJsU2dx9f78Jf2Km53wDD4Od
        m7ZYFRV2i7tN3/1joXdy3iXZL6Hyu247z+metfP/5Y1KLMUZiYZazEXFiQBo5QxsuQIAAA==
X-CMS-MailID: 20190723153708eucas1p218eb08397f9939db7a81478a5e51e79e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715104058epcas1p2da7ed04b6c6d0d9e81c75e2b118d2dcb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715104058epcas1p2da7ed04b6c6d0d9e81c75e2b118d2dcb
References: <20190715032017.7311-1-huangfq.daxian@gmail.com>
        <CGME20190715104058epcas1p2da7ed04b6c6d0d9e81c75e2b118d2dcb@epcas1p2.samsung.com>
        <20190715104049.GC20839@arch-x1c3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/15/19 12:40 PM, Emil Velikov wrote:
> On 2019/07/15, Fuqian Huang wrote:
>> In commit 518a2f1925c3
>> ("dma-mapping: zero memory returned from dma_alloc_*"),
>> dma_alloc_coherent has already zeroed the memory.
>> So memset is not needed.
>>
>> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
>> ---
>> Changes in v3:
>>   - Use actual commit rather than the merge commit in the commit message
>>
>>  drivers/video/fbdev/mmp/fb/mmpfb.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
> 
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
