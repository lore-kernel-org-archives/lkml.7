Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23595C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB87212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Swz68RIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfFGMa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:30:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40676 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbfFGMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:30:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607123057euoutp012ff98c8e57ae73f80e9cbc10a7f9e612~l6npTXqpg0173801738euoutp01M
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 12:30:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607123057euoutp012ff98c8e57ae73f80e9cbc10a7f9e612~l6npTXqpg0173801738euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559910657;
        bh=jVgHTVhAOSFZU12CT5tL8EynrAm4MZd6GB6AuG5JpIc=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Swz68RILKBUAMUy5LyK8FL6VvsrlvPjzi7jIbYc9vO46gRJju2LfwKS8wegWdzp8v
         JE3aZoMVV9658nEQJTgq7964GhDoqaf3dz4WxOVlA/DgYZTBMUYjLaAdGdDG00+t0R
         luKvL71B++/fVZcagR5TWRwniITSNo6eMMu8nzwo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607123056eucas1p144917f52f689fb73cbdfaefd321a8d1b~l6nospfFT0621306213eucas1p1x;
        Fri,  7 Jun 2019 12:30:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2F.62.04325.FF85AFC5; Fri,  7
        Jun 2019 13:30:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607123055eucas1p2c00e55a61972be0d0da49249a7e15e26~l6nng3vVI0519005190eucas1p23;
        Fri,  7 Jun 2019 12:30:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607123054eusmtrp220d447702e348eb9cc2d576e0b20ca94~l6nnRXeXL0884308843eusmtrp2t;
        Fri,  7 Jun 2019 12:30:54 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-95-5cfa58ff7619
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7D.A2.04140.EF85AFC5; Fri,  7
        Jun 2019 13:30:54 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190607123054eusmtip241e14def18d6884c28839bc180af4070~l6nnDYEWY2165521655eusmtip2C;
        Fri,  7 Jun 2019 12:30:54 +0000 (GMT)
Subject: Re: [PATCH v2] video: fbdev: gbefb: add COMPILE_TEST support
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <e1537488-d30e-3680-36d0-3a848b79f370@samsung.com>
Date:   Fri, 7 Jun 2019 14:30:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8bcfd5b8-347b-89e4-5faf-8569a3d00115@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzned3/Eb9iDNYes7C48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApigum5TUnMyy1CJ9uwSujBv/5zIV3GKueLt3O3MDYzNzFyMn
        h4SAicT7Zd2sXYxcHEICKxgldvxezQThfGGUmLnrBjtIlZDAZ0aJe/tEYTp+LvvPDBFfzihx
        prMEouEto8Sdj6vAGoQFXCVaF01mArHZBKwkJravYgSxRQQSJFZMnwFm8wrYSSz984sVxGYR
        UJE4cvQVWFxUIELi/rENrBA1ghInZz5hAbE5Bewlfm95zwZiMwuIS9x6Mp8JwpaX2P52DjPI
        ERIC79kkHv5uhPrNReLDhR2MELawxKvjW9ghbBmJ/zvnM0E0rGOU+NvxAqp7O6PE8sn/2CCq
        rCUOH78IdAYH0ApNifW79CHCjhLr5n5kAQlLCPBJ3HgrCHEEn8SkbdOZIcK8Eh1tQhDVahIb
        lm1gg1nbtXMl1GkeEvevHGeewKg4C8mbs5C8NgvJa7MQbljAyLKKUTy1tDg3PbXYOC+1XK84
        Mbe4NC9dLzk/dxMjMHmc/nf86w7GfX+SDjEKcDAq8fB6sP+MEWJNLCuuzD3EKMHBrCTCW3bh
        R4wQb0piZVVqUX58UWlOavEhRmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYOTqkGxqL94S7O
        vxncTKfblLw9Jfk4yoBPeHoG947/AQ/2ZGaxzEit/6cryPmn0zdjyf1Yf4br/Ocsmvfw5vx+
        /dL8a0TofKmzLdln2j0aNdUudgR4qWWqtXbffJbIkP03y6Q0P5Wx1eETjxqXikXPjarXLHs1
        Z+huLZbX2eZUp6atfHBdhQuXa6gSS3FGoqEWc1FxIgDBtGNpGgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42I5/e/4Pd1/Eb9iDE4tMra48vU9m8WJvg+s
        Fpd3zWFzYPa4332cyePzJrkApig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
        JX07m5TUnMyy1CJ9uwS9jBv/5zIV3GKueLt3O3MDYzNzFyMnh4SAicTPZf+BbC4OIYGljBLP
        714FcjiAEjISx9eXQdQIS/y51sUGUfOaUeLHxhlsIAlhAVeJ1kWTmUBsNgEriYntqxhBbBGB
        BImnr+eD1QgJ2EnsaT0CtowXyF765xcriM0ioCJx5OgrsHpRgQiJM+9XsEDUCEqcnPkEzOYU
        sJf4veU92BxmAXWJP/MuMUPY4hK3nsxngrDlJba/ncM8gVFwFpL2WUhaZiFpmYWkZQEjyypG
        kdTS4tz03GIjveLE3OLSvHS95PzcTYzAqNh27OeWHYxd74IPMQpwMCrx8M5g+hkjxJpYVlyZ
        e4hRgoNZSYS37MKPGCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OB0ZsXkm8oamhuYWlobmx
        ubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGRsVvawU5k9VbTpSsczBhc1A4csi2yfH5
        4qVzXjcsyN9rfzRh6q7/m+V3XvqpJFNt7CN4+7yJ256IE56zfvc/WXLvEdN/j97JRX5+1z98
        ntv/+H526OFJXvs31z9p7prxZLl+K9tek+1/xAoN0nb0JZRx5R827DN3/WV7VTbugeThxyb6
        yvMM3JVYijMSDbWYi4oTATiQp2OgAgAA
X-CMS-MailID: 20190607123055eucas1p2c00e55a61972be0d0da49249a7e15e26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607123055eucas1p2c00e55a61972be0d0da49249a7e15e26
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607123055eucas1p2c00e55a61972be0d0da49249a7e15e26
References: <8bcfd5b8-347b-89e4-5faf-8569a3d00115@samsung.com>
        <CGME20190607123055eucas1p2c00e55a61972be0d0da49249a7e15e26@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/21/19 1:51 PM, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to gbefb driver for better compile
> testing coverage.
> 
> While at it convert bogus udelay() calls to mdelay() (needed to
> build driver on ARM) and remove dead x86 specific code.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I queued the patch for v5.3.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
