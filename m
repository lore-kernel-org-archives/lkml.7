Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD9DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0B520856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RB0qBuuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfDAOAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:00:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35284 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfDAOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:00:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190401140038euoutp01dbbf95669d5196eec2db9496bd41f09c~RXn1SSPoG1358613586euoutp01D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 14:00:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190401140038euoutp01dbbf95669d5196eec2db9496bd41f09c~RXn1SSPoG1358613586euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554127238;
        bh=45qL0eZxmTLJzkX/c6hLJ88n/m0+Zh1r672xRua+0aU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RB0qBuuwiDo+bpXuTgM77ncbsQlzVvSHoUEkgaT+VZz82k++1sM8DxvE/ML0NOW0N
         xJWts+t30Y6FqE2+0V8dNe7lklgBF+8BTEFnzNs388tfOcuTTQ2iB+UAXOwI6sGZFu
         /+0Fb1lBFTSdi1brPP0PpMOpDP50zGFoCrWIL4Mc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190401140038eucas1p1bced3d931fce49fae6f63d5bae054c82~RXn0u9hWI0069600696eucas1p1S;
        Mon,  1 Apr 2019 14:00:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D2.9F.04377.58912AC5; Mon,  1
        Apr 2019 15:00:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190401140037eucas1p1ac8f4e4daec5c43104dc01ed253d391c~RXn0C9IwI1227312273eucas1p1N;
        Mon,  1 Apr 2019 14:00:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190401140037eusmtrp1480c11b286c43166498698a8f93bfa3c~RXnz0-PZP1776917769eusmtrp1O;
        Mon,  1 Apr 2019 14:00:37 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-d2-5ca219854388
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.3C.04146.48912AC5; Mon,  1
        Apr 2019 15:00:36 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190401140036eusmtip2745f4ea454e7afa08c5272779660d3fb~RXnzWjrsD2492124921eusmtip2d;
        Mon,  1 Apr 2019 14:00:36 +0000 (GMT)
Subject: Re: [PATCH] fbdev: list all pci memory bars as conflicting
 apertures
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <33cf37dc-8456-0316-0b48-fca7c92caa28@samsung.com>
Date:   Mon, 1 Apr 2019 16:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190314114500.8336-1-kraxel@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7qtkotiDH4cMbdY+PAus8WVr+/Z
        LJ7dOslscaLvA6vF5V1z2BxYPfZ+W8Dicb/7OJPH+31X2Tw+b5ILYInisklJzcksSy3St0vg
        ythwpoe54AxLxbMrM9gbGJ8ydzFyckgImEhc2HKXtYuRi0NIYAWjxNsTU5khnC+MEq+Xb2GC
        cD4zSpw+sRyu5UnLFajEckaJuxMmQrW8ZZRY33IaaBgHh7CAv8SSJTIgDSICqhIL/y0B28Es
        sI1R4tz8K4wgCTYBK4mJ7avAbF4BO4mOM3vYQWwWARWJt//fM4PMERWIkOg/ow5RIihxcuYT
        FhCbU8BMYv7kBWCtzAIGEkcWzWGFsOUltr+dA3VoP7tE074cCNtF4se3FUwQtrDEq+Nb2CFs
        GYnTk3tYQG6TEFjHKPG34wUzhLOdUWL55H9sEFXWEoePX2SFsB0lppwEeZ8DyOaTuPFWEGIx
        n8SkbdOZIcK8Eh1tQhDVahIblm1gg9nVtXMl1G0eEhNvrmSawKg4C8lrs5C8MwvJOwsYmVcx
        iqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJpTT/45/2cG460/SIUYBDkYlHl4O8UUxQqyJ
        ZcWVuYcYJTiYlUR4z/QviBHiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUg
        tQgmy8TBKdXAaHrp7Fv3Y/ODXiS/Kf7gkJjQHlu5plgwXLFpwtoIFzc5JoMnPxkzN72Qe/ik
        qU7RdMGS3U2h2g5f7HqWftsZWcC82umJ/wl3vosyQW2sfxW0Q89YvI34tLt1Ov+PWDc/Af2I
        WnWx3JnNenttdoeedjX7rlqu56576Qf3lLV8reIGG18u+79DiaU4I9FQi7moOBEApanZOiQD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7otkotiDKYes7RY+PAus8WVr+/Z
        LJ7dOslscaLvA6vF5V1z2BxYPfZ+W8Dicb/7OJPH+31X2Tw+b5ILYInSsynKLy1JVcjILy6x
        VYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy9hwpoe54AxLxbMrM9gbGJ8y
        dzFyckgImEg8abnC1MXIxSEksJRR4uqJb+xdjBxACRmJ4+vLIGqEJf5c62KDqHnNKDF3+St2
        kISwgK/EjvcT2UBsEQFViYX/lrBCFHUySlxf2gs2lVlgG5BzYTUjSBWbgJXExPZVYDavgJ1E
        x5k9YJNYBFQk3v5/D3aSqECExK2HHSwQNYISJ2c+AbM5Bcwk5k9eANbLLKAnseP6L1YIW15i
        +9s5zBMYBWchaZmFpGwWkrIFjMyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNl27Gfm3cw
        XtoYfIhRgINRiYc3QmhRjBBrYllxZe4hRgkOZiUR3jP9C2KEeFMSK6tSi/Lji0pzUosPMZoC
        PTGRWUo0OR8YxXkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhh1
        NiRZ1XBFW3qvDeP4ucR/wVd+xnc7Q3+yTNl+8Fw3H6fL6onfTd9sf1qlac3G96q66KJTS/rV
        mxnKF47zveXy6/wcsUBA9DePfVitl9YTyY7P5Tc+GrxUO7VP311Yb2+Jbes60aytNjafHcuY
        2OKS4llvmy9VW5HkscE854GiMtOiVe9OpCmxFGckGmoxFxUnAgB6JqsVqgIAAA==
X-CMS-MailID: 20190401140037eucas1p1ac8f4e4daec5c43104dc01ed253d391c
X-Msg-Generator: CA
X-RootMTR: 20190314114511epcas2p2a9669714177b00989bd3195300f7d3a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190314114511epcas2p2a9669714177b00989bd3195300f7d3a6
References: <CGME20190314114511epcas2p2a9669714177b00989bd3195300f7d3a6@epcas2p2.samsung.com>
        <20190314114500.8336-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/14/2019 12:45 PM, Gerd Hoffmann wrote:
> Simply add all pci memory bars to struct apertures_struct in
> remove_conflicting_pci_framebuffers(), without depending on the
> res_id parameter.
> 
> The plan is to drop the res_id parameter later on.  For now keep the
> parameter, use it for sanity-checking and warn on inconsistencies.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
