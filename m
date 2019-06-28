Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D402C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B7920645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PqbXjhZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfF1NGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:06:09 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33226 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfF1NGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:06:08 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190628130607euoutp02af9736026a7d97e898e8e70458ad8a87~sXpWTwEEB1358613586euoutp02Q
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 13:06:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190628130607euoutp02af9736026a7d97e898e8e70458ad8a87~sXpWTwEEB1358613586euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561727167;
        bh=LNtMGok1x3cjZg39LfQejzodC8B1D/r3TRp6k46vC1Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PqbXjhZBV0ES/q2SAFhj5bo1RwnGEeRCfgkfdqg4ZvG5li/g4aWD8qS+U4LgyR5BR
         5Hl8UUrpntuN8yJV1JWXEU4UdDhhHUgN8hW3XppSAVOLFXLDCeLvQkQCjxZMdOwaJB
         B67zO17m8xHkxwQ+mNH0XP1sHosWu33vQm75iCf4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190628130606eucas1p2dcc7beeaf924327bf9d0a7f4c9c90138~sXpViTct90578905789eucas1p2J;
        Fri, 28 Jun 2019 13:06:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 24.6B.04377.EB0161D5; Fri, 28
        Jun 2019 14:06:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190628130605eucas1p1fd85f471fd86a6914ea887604efca6b4~sXpU5tKWO0890808908eucas1p1b;
        Fri, 28 Jun 2019 13:06:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190628130605eusmtrp1262afc22988935ca9709960c4a14470b~sXpUmdApT2189221892eusmtrp1D;
        Fri, 28 Jun 2019 13:06:05 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-fe-5d1610be0f8c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3A.55.04140.DB0161D5; Fri, 28
        Jun 2019 14:06:05 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190628130604eusmtip257086c7bb5aa31f0e0ef95b53c86ea90~sXpUETlEF1247912479eusmtip2s;
        Fri, 28 Jun 2019 13:06:04 +0000 (GMT)
Subject: Re: [PATCH 12/12] fbdev: da8xx: use resource management for dma
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
Message-ID: <84ef4c04-430d-0545-ff81-567f366fe035@samsung.com>
Date:   Fri, 28 Jun 2019 15:06:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190625163434.13620-13-brgl@bgdev.pl>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURT1zdahYXBaEC51i40LbizGj4kLwYSP+dEY0ShCxSoTILJoCygq
        oSooFnfcaDSiEtYEajEUGlmEQEWBgCgBBKmIUQlEgWLUIEoZiPyd++4595yTPBqX20gFHRUb
        L2hi1dFKSkqUNfxqWV/Fuqt873xnOPv9lwRnsZVRXNNQr4R7pHPn3ox/o7h8e5aE+1T6EeP6
        xusRd3MiD+NMHztI7sWV7yTXbrlHcdWXjVgAw3/rTJPwjzvekXyFoVfCmwovUvzo1UaS7+l4
        RvF9GVaML81J4a2dZowfMy3ZKd0v3RIuREclChof/4PSyIbPduroI/yEoTREhz5geuREA7sR
        fp3NQXokpeVsPgLDjzFCHOwIRobNpDiMIah4bUOzEn21bYaVh6D/4ciMfhhBS/cA4WC5sjx0
        3uqbVrixqyC7+D3mIOFsPQ5f24sox4JiN8H1C4XTJIb1B9vYV4kDE+wKKKrpnj60gN0HfQ1G
        UuTIoDFLNHCaimHMPDONcdYDugceYCJeCubhe7jDDNgzNLxoLpupGgifUg2EiF1h0PpUIuJF
        8CrzEiEKihH8Sf8yozYjyMucpETWZqiztk3FoKcsVkOJxccBgd0GuRnHROgCncMyMYML3Ci7
        g4vPDKSfl4s3VoIx10jNuuorCvBrSGmY08wwp41hThvDf9tsRBQiDyFBGxMhaDfECse9teoY
        bUJshPfhuBgTmvp3ryat9nJkmThUi1gaKZ2ZbKm7Sk6qE7VJMbUIaFzpxni2uKnkTLg66aSg
        iQvTJEQL2lq0kCaUHsypebYQORuhjheOCMJRQTO7xWgnhQ65nW72XbtYx/SGoT1e5t1FWdvL
        XW6Pyo5Z3iYPpRYu0z2g0WvPwORKv+S2nvDg0NbxoP5KRU/53Upyx+LPXXrFLs+gGplH3TLT
        tabg1Byvh7InSa2Jvn8rnzceWD4/YOvv/tCQn0NVqgtBewtU67pKU4Y+dAVdjbp+rtF5MK2E
        72lREtpItd8aXKNV/wNKnIshcwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xe7p7BcRiDWYcl7b4MvcUi8WuB9vY
        LM68uctusahBzOLK1/dsFiu+zGS3eLr5MZPF/a9HGS2m/FnOZLHp8TVWixN9H1gtLu+aw2ax
        v3cDkwOvx/sbrewei6/dZvXYOesuu8emVZ1sHp/6T7J63Lm2h83jfvdxJo/NS+o9jt/YzuTx
        eZNcAFeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
        Xsax51/YChYxV8zaHN3A+JCpi5GTQ0LARKJr/wMWEFtIYCmjxNwNoV2MHEBxGYnj68sgSoQl
        /lzrYuti5AIqec0ocXzSSjaQhLCAh8SNqfcZQWwRAXWJBevuMYEUMQscZ5ZY+GIKVMcGRomX
        Wy+DbWMTsJKY2L4KrINXwE7iweeX7CA2i4CqxOoDt8CuEBWIkDjzfgULRI2gxMmZT8BsTqBL
        N0xuBLOZgbb9mXeJGcIWl7j1ZD4ThC0vsf3tHOYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW
        56bnFhvpFSfmFpfmpesl5+duYgRG97ZjP7fsYOx6F3yIUYCDUYmHdwGXWKwQa2JZcWXuIUYJ
        DmYlEV7JcyKxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTDx5JfGGpobmFpaG5sbmxmYW
        SuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYz3kvurpw4tywY0YTjN7mOxz0Lkvft8YvyFvz
        ietxra/fYrYwR91X5b1xx/rM/yoLgXUmW3XYbk/lkrjKId3jXpTLFDT7OP/3UuXbfAl3ZZtn
        9bpmRr/8nDq19NjE29LzuB2szy0UUmvtds0w2skhxXu4Y+JfG2XZ7U675qaLmf/bO9mmLfaD
        EktxRqKhFnNRcSIALXftgQQDAAA=
X-CMS-MailID: 20190628130605eucas1p1fd85f471fd86a6914ea887604efca6b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190625163514epcas3p3b094a54f96c59c38b94ce56b6fc08f63
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190625163514epcas3p3b094a54f96c59c38b94ce56b6fc08f63
References: <20190625163434.13620-1-brgl@bgdev.pl>
        <CGME20190625163514epcas3p3b094a54f96c59c38b94ce56b6fc08f63@epcas3p3.samsung.com>
        <20190625163434.13620-13-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/19 6:34 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Use managed variants of dma alloc functions in the da8xx fbdev driver.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
