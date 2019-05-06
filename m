Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A138C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B93D20675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R34w94dC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfEFNsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:48:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38265 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFNsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:48:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190506134829euoutp01ef6024f2e09fb1ecbbb23587e31d8506~cHCNxyFzi0737707377euoutp01u
        for <linux-kernel@vger.kernel.org>; Mon,  6 May 2019 13:48:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190506134829euoutp01ef6024f2e09fb1ecbbb23587e31d8506~cHCNxyFzi0737707377euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557150509;
        bh=60fYSlOZnGJ4TCsi1XwZigJGh2/4lZX1nrhDiHd5Q8E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=R34w94dCefCkobnpZ0JPsVpDE1kxJGcZhmzc3GO5DNUmytvnrpoiABEWlWxKIXPjO
         4E/9pk0IDtTzkUAmvZ1Gd6fle0eVBwJcDHpVfYZJpYnuAPLbKjft+78o475tx+VYFI
         QvzoLbgJuw97QTEoRA34v4BXdGFGN/yLVsmb6JQI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190506134828eucas1p21825be7143621fa1e463d5030a6715c5~cHCMyagnt2977829778eucas1p2-;
        Mon,  6 May 2019 13:48:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 28.A9.04377.C2B30DC5; Mon,  6
        May 2019 14:48:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190506134827eucas1p1e0e74c89f1f108ec49fe2aff4a1599a9~cHCL812sU1366013660eucas1p1B;
        Mon,  6 May 2019 13:48:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506134827eusmtrp2016f729c5cf21c4bc8ae74db55bcacd4~cHCLuxtCR2051320513eusmtrp2P;
        Mon,  6 May 2019 13:48:27 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-0b-5cd03b2c6ccf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.A3.04146.B2B30DC5; Mon,  6
        May 2019 14:48:27 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506134827eusmtip1b7db9a753493da336348be0c11be1472~cHCLVx0aZ1565315653eusmtip1b;
        Mon,  6 May 2019 13:48:27 +0000 (GMT)
Subject: Re: [PATCH next 25/25] video: fbdev: Use dev_get_drvdata()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michal Januszewski <spock@gentoo.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <9a9ec193-912e-393b-53b9-bc01e342f7c5@samsung.com>
Date:   Mon, 6 May 2019 15:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190423075020.173734-26-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURTHuzuzs7PS6rgqnsxemxaEqZXBoCZpfRjqS30IohSddNRFXW3H
        RxaWUpStkVqStZlaUNqKomv4gszH4iqKZqtZ4CNIxVLJWkVEW2ucFfz2P/f8/vd/z+GSmLJW
        6kGqNamcVsMmqggHvKFrpf+wT9DHcH9DvTs9tPSLoPO/z2L0wECtjO5+uCClLS0lBD1VfJMu
        +m3G6BzrBKLfj1vRSTljWZ7DmGb9mIy5Y5qXMkbDfYKZyDNLmO7iZZyxGnefk11yCI7hEtXp
        nNYvJMoh3qjPk6Z04NdsI6t4NprDdIgkgQoAw5q3DjmQSqoSwcrzYUIsFhHUjRnshRXB6MgY
        0iH5hiOnuwgXGxUIrEU6JBbzCBZK1wmBcqFOwdzneiRkuFI+8LIzTWAwqlIC7a0ruMAQVCAU
        3jNs3KqgQqDQNCYReJzygskqmSDdqIuQ33dQJJyh59kkLhzLqTAYqjovHGOUP5helUhFvQca
        50swIQmoLhmsLg1g4ptPQ3v+bULULvDT/E4mak9Yby6TiIYaBH9zZ+zuRgQVj212RxB0mgel
        og6FupF6qbg7R/gy7ywmO8KjhmL7ShWQe1cp0geg9k0tsZmla35rRxiwfFAUoH36LZPpt4yj
        3zJOOcIMyJ1L45PiOP6ohsvw5dkkPk0T5xudnGRE//9Rr8282IRa1q50IIpEqu2Kcq+BcKWU
        TeczkzoQkJjKVcFO94crFTFs5nVOmxypTUvk+A60k8RV7oob275dVlJxbCqXwHEpnHazKyHl
        HtkoPiLZZozd+7prZseUPEI9NKyhQ9WOP8osF0aORxc9qX+x60+102hwWeX+QfdjtrzIyKiI
        tl7G2yksws2vtDnAUG36eiZL+8B460SG88Tzp7k1PeOxgYttas+MxFCn5ZLGWd671dREebWQ
        VudP/YarOu/RgoYEC3uWzOpdnm7pU+F8PHvkEKbl2X/wOaFxQwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7ra1hdiDBqOyFlc+fqezaL/8Wtm
        i/PnN7BbnOj7wGpxedccNoun0+sspnw8zmzR+Pk+o8Xee58ZHTg9Ln9/w+yxc9Zddo+WI29Z
        PTat6mTzuN99nMnjxPTvLB6fN8kFsEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
        WhmZKunb2aSk5mSWpRbp2yXoZWya1c1acIil4t/13ywNjG+Yuxg5OSQETCQaT0xh6WLk4hAS
        WMoocebtA9YuRg6ghIzE8fVlEDXCEn+udbFB1LxmlHh/fzUrSEJYwFnizbXNjCD1IgI6EgsP
        l0LUnGGU+LTsOjOIwyywikli1e4bbCANbAJWEhPbVzGC2LwCdhITj9xlAmlmEVCReLKaHSQs
        KhAhcethBwtEiaDEyZlPWEBKOAWcJK6sDgQJMwvoSey4/osVwpaX2P52DvMERsFZSDpmISmb
        haRsASPzKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMA423bs5+YdjJc2Bh9iFOBgVOLh9VA6
        HyPEmlhWXJl7iFGCg1lJhDfx2bkYId6UxMqq1KL8+KLSnNTiQ4ymQC9MZJYSTc4HpoC8knhD
        U0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MufyCE793ut3vY0+5utVn
        x7JbnEs3BHvu2rur4L39u0vsspks78vX82z/+uv9Fd1bLAnbpcNO1FxVyf94Z3Mwo3eknqq0
        l4XRvb8zo5dUyO+8f/HKjg9b8k75/r1aKZZj7LqCm1nbpPXGkZvHHx9pX3lpcmp7woQlO9OX
        u4v2/npvsW8ZX6qMlBJLcUaioRZzUXEiALA8F0XJAgAA
X-CMS-MailID: 20190506134827eucas1p1e0e74c89f1f108ec49fe2aff4a1599a9
X-Msg-Generator: CA
X-RootMTR: 20190423074034epcas4p1f2aeab4d4e304358f2c8917af6ce23ca
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190423074034epcas4p1f2aeab4d4e304358f2c8917af6ce23ca
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
        <CGME20190423074034epcas4p1f2aeab4d4e304358f2c8917af6ce23ca@epcas4p1.samsung.com>
        <20190423075020.173734-26-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/23/2019 09:50 AM, Kefeng Wang wrote:
> Using dev_get_drvdata directly.
> 
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Michal Januszewski <spock@gentoo.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Patch queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
