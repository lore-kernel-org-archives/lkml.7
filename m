Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3772EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1CD20645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lpN08RJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfF1M77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:59:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58927 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfF1M77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:59:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190628125958euoutp0240bf3f39d93a57232b2c39e34db10f52~sXj_tn05i0935709357euoutp02N
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:59:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190628125958euoutp0240bf3f39d93a57232b2c39e34db10f52~sXj_tn05i0935709357euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561726798;
        bh=OUDwoCQGsl9WTT2taNQCoc/tSY0rgy7kUD5RRoWSEP0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lpN08RJkHhMm8gvjKXXe9mEQuSVd64G/vr7yuIEOkO2FKNFG3Me+yhCRXRdGKhotQ
         Ujbhs4dqHWw1B/8QV3lnvIf42GAtkBsOrGVmACOat4v8YMzvGPauVIVUe3D7VtIrph
         8EsB5CLs63fuTJt+m8+b3/Xo1ofFLhde1+tJjT5E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190628125957eucas1p27033429a12c8ea16f19ec34e72e83a78~sXj_FgENY0785107851eucas1p2N;
        Fri, 28 Jun 2019 12:59:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D9.B5.04298.D4F061D5; Fri, 28
        Jun 2019 13:59:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190628125956eucas1p11973850c636bc43d0208f4c4bab19d30~sXj9UJ0Yy2289622896eucas1p1i;
        Fri, 28 Jun 2019 12:59:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190628125956eusmtrp22d896bdd5128a321cc2e8677b1963048~sXj9F7-uJ0792407924eusmtrp2b;
        Fri, 28 Jun 2019 12:59:56 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-98-5d160f4d2074
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1C.7B.04146.C4F061D5; Fri, 28
        Jun 2019 13:59:56 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190628125956eusmtip10a728d1d09434b2484bc6b3dffc3dd51~sXj8gz6aU0865708657eusmtip1N;
        Fri, 28 Jun 2019 12:59:55 +0000 (GMT)
Subject: Re: [PATCH 03/12] backlight: gpio: pull the non-pdata device
 probing code into probe()
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
Message-ID: <cb6b2f51-f1cb-74f9-2638-fa7becd0b2c4@samsung.com>
Date:   Fri, 28 Jun 2019 14:59:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190625163434.13620-4-brgl@bgdev.pl>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe8/ZOTuOtk5z6WNG5UC7QKXUh9NNEqQOkaRBoJXayoNZ3tpJ
        ywwyzLSFaSnIRqF4d4mNmZqmXWY5tUhyKXbRjTKyyDJvFWnl2VHy2/+5/N/n+T28FK50EEup
        mPhTnDZeE6smZZL6tl9d64IWuYX7frF6MuM3OyVMk6OeZJ596ZcyxWluzMuJbyRTOa6XMh9q
        32OMfeIJYvKnKjDG/L6XYNqvjhCMrekGyTzINmE75Oy3vgwpW9L7hmAbDf1S1my8TLKjOR0E
        +7a3mWTtV6wYW1t6nrX2NWDsmHl5sOyAbFsUFxuTzGk3+B+WHSuxjGKJJZIzF6uaURrqwHXI
        hQJ6E7wxv5XqkIxS0pUIRqwWXAzGEVTWF2JiMIag89mlmQrltOS3+Ir5CgTl3VOEGAwjmMyr
        w4QmV1oDRT1bhBEqehUU1Qw4H8LpJzh8st0ihQJJb4FrmUYkaDntDzk/fjt3ktDeUOQwEoJe
        QoeCvc1EiD2LoUM/KBG0C70RurImnV6cdofXg8Kmgl4BDcM3nAhAZ1DQZyghRdBAyLZVS0Xt
        Cp+td2b1MvjbKGICXYNgOmto1t2AoCLvz6x7K7RaXxACGk6vgdtNG8R0AOQP6UjxLAroG14s
        LqGA6/UFs9eSQ9YlpdjtA6ZyEzk3VtdYhecitWEemmEejmEejuH/3CIkMSJ3LomPi+Z4v3ju
        9HpeE8cnxUevP5oQZ0Yz/+7pH+voXTTRfcSCaAqpF8p/LnQLVxKaZD4lzoKAwtUqucdzVbhS
        HqVJOctpEyK1SbEcb0GelETtLk9d4DiopKM1p7gTHJfIaeeqGOWyNA2FeTwKUhXqUlM2Zger
        Qne0bg+u1bfYWturTWXp9wfM9t0N8sLS74qBi157e3zLQnayx6e8jPty39n6BzffK3B8PPRw
        KDij30c7EbF/ejxCEZlx4bQ+U+X5caUi5HOq7+C5ukA+X7UrOexk6avH6VOuD/Wr96TbiwOa
        7d5R9q+VWQq1hD+m8VuLa3nNPzn1rkxzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xu7o+/GKxBpOmKFp8mXuKxWLXg21s
        Fmfe3GW3WNQgZnHl63s2ixVfZrJbPN38mMni/tejjBZT/ixnstj0+BqrxYm+D6wWl3fNYbPY
        37uByYHX4/2NVnaPxddus3rsnHWX3WPTqk42j0/9J1k97lzbw+Zxv/s4k8fmJfUex29sZ/L4
        vEkugCtKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5B
        L2PxoU9MBYtZKlpW7mFsYDzJ3MXIwSEhYCIxZa9BFyMXh5DAUkaJRy+3M0LEZSSOry/rYuQE
        MoUl/lzrYgOxhQReM0p0HRUBsYUFEiV6Xr5kAbFFBNQlFqy7xwQyh1ngOLPEwhdT2CCGrmeU
        uDNtJTNIFZuAlcTE9lWMIDavgJ1E//ffYHEWAVWJBQ9WsYLYogIREmfer2CBqBGUODnzCZjN
        KWAscb7jG1gvM9C2P/MuMUPY4hK3nsxngrDlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypG
        kdTS4tz03GJDveLE3OLSvHS95PzcTYzA6N527OfmHYyXNgYfYhTgYFTi4V3AJRYrxJpYVlyZ
        e4hRgoNZSYRX8pxIrBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnAxNPXkm8oamhuYWlobmx
        ubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGRkeTzFUPuMrW9ur5/1jbX5FaulttboNI
        sOWh5fa/5z99JaRxI+l+AWeweHWQ0kfTDTeNWEWu35a/Wr+n0Nu9xy42p/PUzoYFO+TMXj/q
        SrvEw8LEmHC0u/RsW9BOw8X9O1kXHWU27WVbNfX11NVxOcn//MV2XrnRHvoktS1E37JPOy07
        cLu1EktxRqKhFnNRcSIAL20C+QQDAAA=
X-CMS-MailID: 20190628125956eucas1p11973850c636bc43d0208f4c4bab19d30
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190625163459epcas3p1331f76cb55291f41c5a4c3e37e0713fe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190625163459epcas3p1331f76cb55291f41c5a4c3e37e0713fe
References: <20190625163434.13620-1-brgl@bgdev.pl>
        <CGME20190625163459epcas3p1331f76cb55291f41c5a4c3e37e0713fe@epcas3p1.samsung.com>
        <20190625163434.13620-4-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/19 6:34 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> There's no good reason to have the generic probing code in a separate
> routine. This function is short and is inlined by the compiler anyway.
> Move it into probe under the pdata-specific part.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
