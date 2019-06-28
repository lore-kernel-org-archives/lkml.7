Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F3EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D7420645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZkaWLVUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfF1M6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:58:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58513 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1M6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:58:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190628125838euoutp023ff7696965fe6d5d061433d89bcf68a8~sXi0laFBb0793207932euoutp021
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:58:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190628125838euoutp023ff7696965fe6d5d061433d89bcf68a8~sXi0laFBb0793207932euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561726718;
        bh=+fXjqMD80dTEeznXW+urjzkEHk1O/732pqOUC3IDfkY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZkaWLVUL/EDXvoRU+nPTD+5uB4JPBVfqwGgNBXD662dRx11Kh6eZQk3XZAse4DO8E
         8dLELWVvCGbqSzbr7mzD6px75tuYqA64KoyUkuOyWvhUdWG4OI94vEbExQeN+c1AKC
         vacLiBG9VSo9sPkdgYgmskyWCT2TGCHyIUeH3FnQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190628125837eucas1p117ade18f8ad2f92ca5b5d444c1f33336~sXiz1d8Ax0757307573eucas1p1P;
        Fri, 28 Jun 2019 12:58:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 30.5A.04377.DFE061D5; Fri, 28
        Jun 2019 13:58:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190628125836eucas1p26db88c2fc26c7fdfbc9015a0c5252e1a~sXiy5cATZ1701517015eucas1p2P;
        Fri, 28 Jun 2019 12:58:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190628125836eusmtrp282053a9d728b660cbaafa6575e430aee~sXiyrSAiU0722007220eusmtrp2m;
        Fri, 28 Jun 2019 12:58:36 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-98-5d160efdb846
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C9.34.04140.CFE061D5; Fri, 28
        Jun 2019 13:58:36 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190628125836eusmtip27d2be573ba8b7c8512826cc4a44f92b2~sXiyJxH5i0729607296eusmtip2e;
        Fri, 28 Jun 2019 12:58:36 +0000 (GMT)
Subject: Re: [PATCH 01/12] backlight: gpio: allow to probe non-pdata devices
 from board files
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
Message-ID: <bec514d8-a005-5c10-7770-d6fcd541ded4@samsung.com>
Date:   Fri, 28 Jun 2019 14:58:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190625163434.13620-2-brgl@bgdev.pl>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+87ZOTuOJp9z6atdGVRU5OwGJ5OoMDgFZf0RpCG68jStbcqW
        ZVclcuUiK5PKZSp2MS10WGhTKVrNaRdDFBPNZrXAyqXorAztcjxK/vf73vd5eJ8HPoZUuKlQ
        JtlwgDcaNDoVLZNUN4w0Lx3zD4oLf9eygPVdfy5ha3uqafZlX7eULckMYtuG+2n2ji9fyn66
        /5Fg3cNOxOaNlhJs1cd2im3MGaDY1toCmn18zkask3P9HVlS7kZ7F8XZrd1Srqo8m+YGzzdR
        3Nv2eppzn3UR3P2bGZyro4bghqrmbJPFyiITeV3yQd6oXpsgS3p9y0ekmun0rnOjVCbKpizI
        jwG8ErJa+0iBFfgOgpF6nQXJ/rEPwaClUSIuhhD0tYVNGjqbPlGiqBTBo+91SHx4EXwtyScs
        iGECcTw4zGrBoMQLobjiHSFoSOwk4XPrXVpY0DgCLp4uRwLL8Vp44jk1HkmC50OXrWw80gy8
        E9wNNkrUBEBTvmc8kR9eAa/sDwmBSRwMnZ6iCZ4LNd4CUjgGOIsBxw2xG+AoKDHfo0UOhC+u
        B1KRZ8EfexEhGioQjJ3pnXDXICi99HvCsQaeuloooRqJF0FlrVocr4fON3VSYQzYHzq8AWII
        f8itvkKKYzmcMStE9QKw3bbRk2ct9jLyAlJZp1SzTqljnVLH+v9uMZKUo2A+zaTX8qblBv5Q
        mEmjN6UZtGF7UvRV6N+3e/Hb5XuIakd3OxBmkGq6vFgWFKegNAdNh/UOBAypUspDmpVxCnmi
        5vAR3pgSb0zT8SYHmslIVMHyo9N6dimwVnOA38/zqbxxckswfqGZaEflhwFlSERjfMyJTH3q
        htXHCzce2/d+3q+o06OXyZMDCf3DGRtio3d7vkWPBRZm5zuznUMGr3azetpQ3pX4gNUPml/+
        yaMcWauW6LzK3Nl30323gut/aq0/7OqYZw05m9JnNbRtPau8djXIKf/s2dITFrX9UG/C4NwX
        4bgjci+lt6okpiTNssWk0aT5C0HcfRJyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xe7p/+MRiDc5c07L4MvcUi8WuB9vY
        LM68uctusahBzOLK1/dsFiu+zGS3eLr5MZPF/a9HGS2m/FnOZLHp8TVWixN9H1gtLu+aw2ax
        v3cDkwOvx/sbrewei6/dZvXYOesuu8emVZ1sHp/6T7J63Lm2h83jfvdxJo/NS+o9jt/YzuTx
        eZNcAFeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
        Xsb5pV+YCtrYKm73/mFtYOxk7WLk5JAQMJG4dfIpkM3FISSwlFHi6bImti5GDqCEjMTx9WUQ
        NcISf651sUHUvGaU6J/zjxGkRlggXuJQmz5IjYiAusSCdfeYQGqYBY4zSyx8MYUNJCEksJ5R
        YtMSTxCbTcBKYmL7KkYQm1fATuLgkxawI1gEVCVub1jJDGKLCkRInHm/ggWiRlDi5MwnYDan
        gLHE2Z07mEBsZqBlf+ZdYoawxSVuPZkPFZeX2P52DvMERqFZSNpnIWmZhaRlFpKWBYwsqxhF
        UkuLc9Nzi430ihNzi0vz0vWS83M3MQKje9uxn1t2MHa9Cz7EKMDBqMTDu4BLLFaINbGsuDL3
        EKMEB7OSCK/kOZFYId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HJp68knhDU0NzC0tDc2Nz
        YzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MGldzvQSD45nTk++qz/W3jRc7Fi+Y08f9
        VMd/gb/FUaUtznyRJ9s/zm59oHDm8oG7H7LCl0/64in6Q3vPulP/+pTOBZyd/sx/boxD3eU+
        89PKUzynRMza8rmYy/vs7saKNZ0hfHzGKTHxXnOW7L2ksJGFbx7fdo7o1y+19R1NJ/L/cdif
        eilJiaU4I9FQi7moOBEAbTZJqwQDAAA=
X-CMS-MailID: 20190628125836eucas1p26db88c2fc26c7fdfbc9015a0c5252e1a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190625163457epcas3p2e246a27cb3ec0f0ffa48d32561ff3972
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190625163457epcas3p2e246a27cb3ec0f0ffa48d32561ff3972
References: <20190625163434.13620-1-brgl@bgdev.pl>
        <CGME20190625163457epcas3p2e246a27cb3ec0f0ffa48d32561ff3972@epcas3p2.samsung.com>
        <20190625163434.13620-2-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/19 6:34 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently we can only probe devices that either use device tree or pass
> platform data to probe(). Rename gpio_backlight_probe_dt() to
> gpio_backlight_probe_prop() and use generic device properties instead
> of OF specific helpers. Reverse the logic checking the presence of
> platform data in probe(). This way we can probe devices() registered
> from machine code that neither have a DT node nor use platform data.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
