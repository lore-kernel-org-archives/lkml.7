Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12313C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B7F2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QTlE11rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDPFzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 01:55:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37586 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfDPFzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 01:55:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190416055537euoutp02c75f1ac7d819810db073ad64d7cac20c~V3rok81zb0394803948euoutp02c
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:55:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190416055537euoutp02c75f1ac7d819810db073ad64d7cac20c~V3rok81zb0394803948euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555394137;
        bh=b7hY9Z4yNISntomPMw2//37eIahx2gdihHbn/58KJrA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QTlE11rH5g+xjhyjncu8bwLfNhLZPZPlJJoJ/4D1fpNx4IAJgSl8AcyYrwvFr2DSn
         nKScwnBECdJkgoiUuw/5MfDGgQlxWHYV/v29jht7aR+5YAygHIh2z0IwH9CzNcDPCz
         bzS2vuqKqotJLiv6U62ZLBj9knd32BuMUqG6fPpc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190416055536eucas1p1e0c69cb5ccca9bdaad5bf4ce1b411a79~V3rn53pBi0077300773eucas1p1o;
        Tue, 16 Apr 2019 05:55:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.C3.04377.85E65BC5; Tue, 16
        Apr 2019 06:55:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190416055535eucas1p14da3316309de64b825c4bc81afef3484~V3rnDDS9f0573705737eucas1p1O;
        Tue, 16 Apr 2019 05:55:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190416055535eusmtrp176e7e243af3e1bd75becd4370372711a~V3rmulweT2260922609eusmtrp1I;
        Tue, 16 Apr 2019 05:55:35 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-53-5cb56e58bbd0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.18.04140.75E65BC5; Tue, 16
        Apr 2019 06:55:35 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190416055534eusmtip1336dda4ac9ce7d0703ccd44ec7c60090~V3rmLGHw-1597215972eusmtip1h;
        Tue, 16 Apr 2019 05:55:34 +0000 (GMT)
Subject: Re: [PATCH v5 1/2] drm/bridge: sil_sii8620: make remote control
 optional.
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Inki Dae <inki.dae@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <dd5189a2-8422-5e3c-1c79-d68680117deb@samsung.com>
Date:   Tue, 16 Apr 2019 07:56:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415232444.GB13033@innovation.ch>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtd1+7mpPrVPZVUnQjwqC0ErlgSELU/SuKCiwtW3nRUJdtaplJ
        PnosK1GTymkaaaTT0OacafTQkWtpbwsf6ARNx8gsdYWg1rar5H/nd75zvvMd+NG4zEqupE8q
        UwSVUpHIUp6EsWPm/aZIZVN08LsOP+5Gzm2MM923Ia7bMUFxbxxzFJdbWU9xRdYCgrtaWCXh
        eid/k9zn1jKKs42t4myD4xj3+vctbIcXP6Wzk3yLdkDCl2pKSL74KvDlln38i7t1Et56zYzx
        +QYd4p8NGgh+Sr+av3PFSO5dfthze6yQeDJNUAWFH/OMzxnOliT/CDj7604+lYW65HnIgwYm
        BB7X5CMXljHVCBpyA/KQpxNPIxj7bCbFxxSCuukyfNFxrbhrYfAQwaP8flx8jCOomXyCuVS+
        zAEYe2YhXNiPCQN9YbfbgTOvcejtK3aLKCYQ5hp7KReWMuGgq7G4DyGY9VD+x+GO82ciwdrR
        QIoaH7CUjLiXejDbQFc+4vbizBrIbSrFRSyHvpEKzBUGzIwEPlX8JMW7d8JoswkTsS/YzQaJ
        iAOg8+Z1QsQXwFp9ERfNGgRNDS0LpcPAZP7oXEQ7EwKhvjVIpCOgtrIMuWhgvKFn3Ee8wRuK
        jLdxkZaC5rJMVK8F69umhYVyePDBQRUgVrukmXZJG+2SNtr/ufcQoUNyIVWdFCeotyqFM5vV
        iiR1qjJu84lTSXrk/Had8+bpJ6h19ng7YmjEeknp64ZoGalIU6cntSOgcdZPGhHrpKSxivRz
        gupUjCo1UVC3o1U0wcqlGcuGomRMnCJFSBCEZEG1OMVoj5VZKONQsDEU0+1vzQkd6OnnUN3Q
        bH3p0K5Z/fFhfxJavuc9X8sSbS9v8M/t2ZqnQVWZp4ejZqpD/mbWloQmHI0/2PXH96tNU0ls
        Ot9mf+X4otdcipmcMJqUy8qaR3fHNH6L23Bkj3VsndJQX2uJmjf5b2SbS1BBgkfg3xUXs7ze
        hbOEOl6xZSOuUiv+Ad104lNyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xu7rheVtjDP5OFLbobZrOZHF40QtG
        iytf37NZnPr6l82iefF6NotJ9yewWHROXMJucfPTN1aLy7vmsFm8eC5t8eLeWyaLE9+mMTnw
        eHxe9YrVY+esu+wesztmsnpM6ZTwmHcy0GP/3DXsHve7jzN59G1Zxeix994WFo/Pm+Q8ZrRv
        Yw3gjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL
        aHrcyF7wTqbi44w+tgbGM+JdjJwcEgImEt1TzrB2MXJxCAksZZR4+m8WG0RCXGL3/LfMELaw
        xJ9rXWwQRa8ZJd5M3scCkhAWCJF4vvckmC0iYC2xaeIVsEnMAueYJZZM2wU1djaTxJH1GxhB
        qtgENCX+br4JtoJXwE5i1cqTYHEWAVWJed+/gq0TFYiQOPN+BQtEjaDEyZlPwGxOAWOJVfOe
        gPUyC6hL/Jl3iRnClpdo3jobyhaXuPVkPtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nz
        i430ihNzi0vz0vWS83M3MQIjfNuxn1t2MHa9Cz7EKMDBqMTDm9C3JUaINbGsuDL3EKMEB7OS
        CK9jClCINyWxsiq1KD++qDQntfgQoynQcxOZpUST84HJJ68k3tDU0NzC0tDc2NzYzEJJnPe8
        QWWUkEB6YklqdmpqQWoRTB8TB6dUA+OBB2ems1wMTfvvEpYa3F7q4JlYFRzsL+Asz6TqOWtG
        Ef9Dzs3l+2fkiau/uSptul3ktMq9lkvWH+YUGNeUV68u107YFyrRbLOpJTpV/PxXuZOxRtWH
        BMr9XgedEi58OtHziL7kl9UnVGTT7cvd9zGnaMyyvbI5xfJExsPP3GevvM0xWr70khJLcUai
        oRZzUXEiAJ15MFYGAwAA
X-CMS-MailID: 20190416055535eucas1p14da3316309de64b825c4bc81afef3484
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190415082007epcas2p431304d9b3a9ddb13ff6b7384d7b583ac
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190415082007epcas2p431304d9b3a9ddb13ff6b7384d7b583ac
References: <20190415081300.24831-1-ronald@innovation.ch>
        <CGME20190415082007epcas2p431304d9b3a9ddb13ff6b7384d7b583ac@epcas2p4.samsung.com>
        <20190415081300.24831-2-ronald@innovation.ch>
        <76cf3079-f190-bed4-7a00-149d7fa0a650@samsung.com>
        <20190415232444.GB13033@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.2019 01:24, Life is hard, and then you die wrote:
>   Hi Andrzej,
>
> On Mon, Apr 15, 2019 at 10:58:09AM +0200, Andrzej Hajda wrote:
>> On 15.04.2019 10:12, Ronald Tschalär wrote:
>>> commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
>>> of RC_CORE) changed the driver to select both RC_CORE and INPUT.
>>> However, this causes problems with other drivers, in particular an input
>>> driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
>>> commit):
>>>
>>>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>>>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>>>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>>>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>>>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>>>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>>>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>>>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>>>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
>>>
>>> According to the docs and general consensus, select should only be used
>>> for non user-visible symbols, but both RC_CORE and INPUT are
>>> user-visible. Furthermore almost all other references to INPUT
>>> throughout the kernel config are depends, not selects. For this reason
>>> the first part of this change reverts commit d6abe6df706c.
>>>
>>> In order to address the original reason for commit d6abe6df706c, namely
>>> that not all boards use the remote controller functionality and hence
>>> should not need have to deal with RC_CORE, the second part of this
>>> change now makes the remote control support in the driver optional and
>>> contingent on RC_CORE being defined. And with this the hard dependency
>>> on INPUT also goes away as that is only needed if RC_CORE is defined
>>> (which in turn already depends on INPUT).
>>>
>>> CC: Inki Dae <inki.dae@samsung.com>
>>> CC: Andrzej Hajda <a.hajda@samsung.com>
>>> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
>>
>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Thanks for your reviews!
>
>> If there are no objections I will take it to drm-misc tomorrow.
> This brings us back to the discussion started in response to the first
> version of my patch (see
> https://lore.kernel.org/lkml/20190124082423.23139-1-ronald@innovation.ch/T/#m24f45fecd987a787a9554c8088f463fd10de2b00).
> To recap: the problem is that the applespi patch depends on this patch
> here, as make-config will break as described above otherwise. So if
> this patch is submitted through drm-misc, then it's unclear to me how
> to ensure that the two patches make it upstream in proper order,
> unless the applespi patch is also upstreamed through drm-misc, or the
> Kconfig for applespi is (temporarily) modified to not trigger the
> config error and another patch is later submitted to fix the Kconfig
> again (which seems somewhat ugly to me). Assuming that consensus is to
> merge both patches through one tree, then it would seem that because
> this patch here is relatively small that maybe it could be merged
> through the input tree along with the applespi patch?


Oh, I have forgot. Please take it then via input tree.


Regards

Andrzej



>
>
>   Cheers,
>
>   Ronald
>
>
>

