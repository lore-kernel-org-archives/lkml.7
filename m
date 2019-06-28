Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32278C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31AE208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FMI3ixGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfF1M7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:59:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58670 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1M7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:59:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190628125910euoutp0229a8ce1ba455845efd4e2685703e3f0c~sXjShZJzz0793007930euoutp02J
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:59:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190628125910euoutp0229a8ce1ba455845efd4e2685703e3f0c~sXjShZJzz0793007930euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561726750;
        bh=8Hd3VfBJL+xbiJrjQF90ePIZxnBEv9M00xB5/OAyKPM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FMI3ixGUI4k6ZAc1G+bgJMwhHYv20vjSnzYHzs92j8SSQ3JyQVEbpd/cBJ8jS0xti
         2YEwFH6azYkpaqoDsuXfZSGsjWfWLA3/9KdDiEGAa9mijDRPNevB0qTnidcyVJ4lJM
         IilhMVjZmVbdX6tM4Rry90VASWPCZ9rmKPZM4dus=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190628125910eucas1p202669bfbbad1a9ea55c66706559f1029~sXjR2wB1i1911519115eucas1p2u;
        Fri, 28 Jun 2019 12:59:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 90.6A.04377.D1F061D5; Fri, 28
        Jun 2019 13:59:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190628125909eucas1p272b6e6e36732ce575b70772b67ae7c6c~sXjRBheKx2972129721eucas1p2v;
        Fri, 28 Jun 2019 12:59:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190628125909eusmtrp2b41c12b64b7e42d74f7267a2c892ddd1~sXjQzVFZ20722007220eusmtrp2h;
        Fri, 28 Jun 2019 12:59:09 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-e9-5d160f1dc589
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E9.44.04140.C1F061D5; Fri, 28
        Jun 2019 13:59:08 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190628125908eusmtip1476c57280886b316413bd8d2c64e41ee~sXjQN785u0811308113eusmtip1c;
        Fri, 28 Jun 2019 12:59:08 +0000 (GMT)
Subject: Re: [PATCH 02/12] backlight: gpio: use a helper variable for
 &pdev->dev
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        David Lechner <david@lechnology.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <f6095658-8d23-c30e-7d50-b1555e9dd3e5@samsung.com>
Date:   Fri, 28 Jun 2019 14:59:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190625163434.13620-3-brgl@bgdev.pl>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUhTURztvq89V9PnNHfVPmBkYpFaRjzMpKLy/VFhghCK5KzX1Pxqz4/M
        P9LIaRMrKyuH5jRJW6RrC81pBRu5zFRCMbPMgUYf5EzngsCP3J6S/53fPed3zj2XS6JiK+5H
        pmRks4oMWZqUEGKtXX/7dmz08EkIfemg6dmatxhttLYS9LtfowK6vtCHHnRMEXTTbJWA/moY
        R+gxx2tA355rRGj9+BBOv7n2G6cHjNUE/apch+wXMVPDxQLmwdAnnGlXjwoYvfYqwcxc78aZ
        z0OdBDNWZkEYQ8MlxjLchjB2/aZoYZww4gyblpLLKkIiE4XJjpoRkGVGL7zQ+RaCeUQF3EhI
        7YbK5o8CFRCSYqoJwMYPNowfZgGc/qZD+MEOYGW/CqyslE/bcZ5oBLDUurismgRQea8Odaq8
        qBhYfvW+K8SbCoSa5i8uEUq9RuGPgceEkyCocFhRonXZiqhI2PL0O+7EGBUAtU/sLqP11Ek4
        1qXDeY0n7K6awJzYjQqDDUMzrgCUksCRidplvBm2TVajzjBIFZGw2Dy4RJBLwyFouryFr+AF
        f1qeCXi8AS621yK8vhnA+dLvy8ttS89xa4HgVXuh2fIedxqhVBBsMYbwxweg7Z4J4/3d4fCk
        J38Hd3iz9S7KH4tgqVLMq7dC3UMdsRKran+E3gBS9apm6lVt1KvaqP/nagCmBRI2h0uXs9yu
        DDYvmJOlczkZ8uDTmel6sPTvehYss8+BcS7JBCgSSNeJNEKfBDEuy+Xy000AkqjUW+Tb550g
        Fp2R5V9kFZmnFDlpLGcC/iQmlYgK1ljjxZRcls2eY9ksVrHCIqSbXyEos3gwlePmo1IDqUmd
        /3HEfaJEknVl41o2NKy2q9r2JzqG23A4bmAsJjHPwxbUzQaeL+g5uG9P7qU7vfGGw2ZJfES4
        0qzSOYo0oL+io0m+3f/28U51naQhFdTfNCZVvYzVaKMCOM0JJZJacWTbMX3s2Y66XnVU/4GQ
        4EMWTCzFuGTZzm2ogpP9A1lGc0xzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xu7oy/GKxBlu/W1t8mXuKxWLXg21s
        Fmfe3GW3WNQgZnHl63s2ixVfZrJbPN38mMni/tejjBZT/ixnstj0+BqrxYm+D6wWl3fNYbPY
        37uByYHX4/2NVnaPxddus3rsnHWX3WPTqk42j0/9J1k97lzbw+Zxv/s4k8fmJfUex29sZ/L4
        vEkugCtKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5B
        L+Pr3FuMBYeZK/ZukGxg/MvUxcjJISFgItH78TNrFyMXh5DAUkaJjj+vGbsYOYASMhLH15dB
        1AhL/LnWxQZR85pRYtPHlWDNwgJBEr2d88BsEQF1iQXr7jGBFDELHGeWWPhiClTHekaJ5m1/
        WUCq2ASsJCa2r2IEsXkF7CTWb3zBCmKzCKhKrFr7mRnEFhWIkDjzfgULRI2gxMmZT8BsTgFj
        iSXXPoFtYwba9mfeJWYIW1zi1pP5UHF5ie1v5zBPYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0
        ODc9t9hIrzgxt7g0L10vOT93EyMwvrcd+7llB2PXu+BDjAIcjEo8vAu4xGKFWBPLiitzDzFK
        cDArifBKnhOJFeJNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YOrJK4k3NDU0t7A0NDc2Nzaz
        UBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAKDSj0/hlUG7WJFmH4hO3F6yyqpP7USy1vErx
        ePmO12pfLqfOdF3ImaMstOFfo6m10TqJDbM93rz7JLxY8oLxHz6Py4XMXb8Wssufc3qnqvvN
        lktD9NuKJ4za+0JZGQKkvkzzS1m8zOA73/4sz/igmg0xeRlsU4Q2ML/d+fd2+IH9Qi+yf/k4
        KLEUZyQaajEXFScCADLzI24FAwAA
X-CMS-MailID: 20190628125909eucas1p272b6e6e36732ce575b70772b67ae7c6c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190625163459epcas1p39631966dbd7acbbbb1f905b18e41a2d7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190625163459epcas1p39631966dbd7acbbbb1f905b18e41a2d7
References: <20190625163434.13620-1-brgl@bgdev.pl>
        <CGME20190625163459epcas1p39631966dbd7acbbbb1f905b18e41a2d7@epcas1p3.samsung.com>
        <20190625163434.13620-3-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/19 6:34 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Instead of dereferencing pdev each time, use a helper variable for
> the associated device pointer.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
