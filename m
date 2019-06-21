Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8FCC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641A421530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HbYw+pf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfFULGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:06:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39602 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfFULGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:06:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190621110649euoutp014f61c05fd9925aada8bdfec6dd9ac3ec~qMgMf5Zal2736927369euoutp01D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 11:06:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190621110649euoutp014f61c05fd9925aada8bdfec6dd9ac3ec~qMgMf5Zal2736927369euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561115209;
        bh=2caUkBUX34B65u2vHzuNj9T+cWmaNw+VM2Qj1PAYCqY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HbYw+pf9hEidKfU3aRd9WpCvjp3ILFWSLBdVPIq38S+0x5Tp5uMmm32u10o1iy52F
         p7thgR7e1w2JFRjHs4GPR7/u1l5Vasrx80D/9eBfqmnZdIKkkAQKKdXmR2Cb/ms/Mv
         qHN2fUqLQ/JLlfO4CX+NCQhXCEpMyiC6iNxC0H60=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190621110649eucas1p239c3781c1f4d8a0831ead85463f81612~qMgL8KEMK2565525655eucas1p2e;
        Fri, 21 Jun 2019 11:06:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4B.AA.04325.84ABC0D5; Fri, 21
        Jun 2019 12:06:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190621110647eucas1p2d7b803b54304d653e5755677d28e3117~qMgKxLsse2562325623eucas1p2X;
        Fri, 21 Jun 2019 11:06:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190621110647eusmtrp1f54c463b296dc6d604430407b0ca6664~qMgKjLIpA0123601236eusmtrp15;
        Fri, 21 Jun 2019 11:06:47 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-84-5d0cba48dbae
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C0.54.04140.74ABC0D5; Fri, 21
        Jun 2019 12:06:47 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190621110647eusmtip19ef13f2272bbabdbfec1cc8ae1f6259c~qMgKTb_L10104201042eusmtip1e;
        Fri, 21 Jun 2019 11:06:47 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: pvr2fb: fix build warning when compiling
 as module
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <b54d11f4-bc25-3e1a-1a7e-2c61555be39b@samsung.com>
Date:   Fri, 21 Jun 2019 13:06:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2376f0a7-2511-b52d-c0d1-9162382f8693@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7oeu3hiDXouWFpc+fqezeJE3wdW
        i8u75rBZbN17ld2BxaPxxg02j/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4MrYcnQzW8Eh5orn
        J++xNjD+Y+pi5OSQEDCRuL/kLJgtJLCCUeL/5CQI+wujxNRXJl2MXED2Z0aJHef2MMM0fDu/
        gg0isZxRYuW/T1DOW0aJNV8/soFUCQuES6x9vQKsg03ASmJi+ypGEFtEIEFixfQZYDazgLZE
        79v3YDW8AnYS845cBOtlEVCVuHjlJFhcVCBC4v6xDawQNYISJ2c+YQGxOQXsJY7e/Qs1R1zi
        1pP5TBC2vMT2t3OYQQ6SEGhnl2g43Ah1totE66bJUD8LS7w6voUdwpaROD25hwWiYR2jxN+O
        F1Dd2xkllk/+xwZRZS1x+PhFoDM4gFZoSqzfpQ8RdpT4+2UrC0hYQoBP4sZbQYgj+CQmbZvO
        DBHmlehoE4KoVpPYsGwDG8zarp0rmScwKs1C8tosJO/MQvLOLIS9CxhZVjGKp5YW56anFhvn
        pZbrFSfmFpfmpesl5+duYgQmlNP/jn/dwbjvT9IhRgEORiUe3gOzuGOFWBPLiitzDzFKcDAr
        ifDy5PDECvGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCUamDU
        bn7xP/76KyMJn21GqmdtVr55tWBtV3Pf0X3317GtaElPU7F+LTDr4fEjha7KtlddUoWn318p
        upI5n2n226Om/78oPTrQzR58pYVz6zz5wMab/bfE9AuOc/PtmtdTWOmctFY8x6phQsalp+yC
        T3YkcxfyTr2xYt39wgvRQk9WZab2rwlw1DJRYinOSDTUYi4qTgQAOG+QAiQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xu7ruu3hiDa5e0bK48vU9m8WJvg+s
        Fpd3zWGz2Lr3KrsDi0fjjRtsHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJex5ehmtoJDzBXPT95jbWD8x9TFyMkhIWAi8e38
        CjYQW0hgKaPEw9PsXYwcQHEZiePryyBKhCX+XOsCKuECKnnNKLHxxCEWkISwQLjE4aX/wHrZ
        BKwkJravYgSxRQQSJJ6+ng8WZxbQluh9+54ZYr6dROOijWB7eYHseUcugtWwCKhKXLxyEqxG
        VCBC4sz7FSwQNYISJ2c+AbM5Bewljt79ywgxU13iz7xLzBC2uMStJ/OZIGx5ie1v5zBPYBSa
        haR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwfrYd+7llB2PXu+BD
        jAIcjEo8vAdmcccKsSaWFVfmHmKU4GBWEuHlyeGJFeJNSaysSi3Kjy8qzUktPsRoCvTcRGYp
        0eR8YGznlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgnJ2VEb9u
        UpBkU8KXNbtnCrCkLtn6cX/5pi6H8qcpTGcXHl5rIxI7d5+6E9+5ZZIHWo8u2ju7N8SkRadt
        U8EGh7ify5qvzvmk9fWDZ9eTnc3aB+5KrvYU/1ilHN3uOKvlYlxw/12m3lc7D9dvfC6z9t4x
        Q/tNSsEyUxecy82amGz6/n2KZXLwaiWW4oxEQy3mouJEAM+4YUa1AgAA
X-CMS-MailID: 20190621110647eucas1p2d7b803b54304d653e5755677d28e3117
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190621110647eucas1p2d7b803b54304d653e5755677d28e3117
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190621110647eucas1p2d7b803b54304d653e5755677d28e3117
References: <2376f0a7-2511-b52d-c0d1-9162382f8693@samsung.com>
        <CGME20190621110647eucas1p2d7b803b54304d653e5755677d28e3117@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/19 12:43 PM, Bartlomiej Zolnierkiewicz wrote:
> Add missing #ifndef MODULE around pvr2_get_param_val().
> 
> Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
