Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8916EC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7C121734
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g21nJ5dP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfGWPfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:35:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50882 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387672AbfGWPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:35:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190723153508euoutp017555c068d76c73a91184e098c8eb07f0~0EzmCnY9F1160911609euoutp01p
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:35:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190723153508euoutp017555c068d76c73a91184e098c8eb07f0~0EzmCnY9F1160911609euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563896108;
        bh=3524MG5ykI7x6NMGcwx0EKgHUZ9KtyeSNKu7ggZci18=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=g21nJ5dPzOpMuc3DMpwdNuHOSFeWhYHFmFbDgbvVZODf1/pXFXK/GfufzUVJvC78/
         FbB8QcDPHC/D5nw+yopTMRHL6mHYZ4i/L7nssvWb7B/cRfsuoj/Q24LEjLJDsGSu8W
         TmFcKmZsDT2CkWBGMfnLfvfkM3nHj8QJ0aSSn2hM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190723153507eucas1p1d113b6a5d1fbfbe7740887de7f218a6f~0EzlEUweA1181411814eucas1p1E;
        Tue, 23 Jul 2019 15:35:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 64.84.04298.A29273D5; Tue, 23
        Jul 2019 16:35:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723153506eucas1p2f9344c53f8b25fb9d89a1f0ee5dddae0~0EzkYliZO0645406454eucas1p20;
        Tue, 23 Jul 2019 15:35:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190723153506eusmtrp2994761be7e7e6d9a011678c88f89e277~0EzkKhiqr0483104831eusmtrp2Q;
        Tue, 23 Jul 2019 15:35:06 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-77-5d37292a17cc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A3.B1.04140.A29273D5; Tue, 23
        Jul 2019 16:35:06 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190723153505eusmtip1bfa1c18450b588d77194751d9bb262dd~0EzjowehC1210512105eusmtip1U;
        Tue, 23 Jul 2019 15:35:05 +0000 (GMT)
Subject: Re: [PATCH] fbmem: remove redundant assignment to err
To:     Colin King <colin.king@canonical.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <72586381-9cf1-a401-b9bd-5705ebbaf937@samsung.com>
Date:   Tue, 23 Jul 2019 17:35:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190624223724.13629-1-colin.king@canonical.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djPc7pamuaxBh+3W1v8Xt3LZrHw4V1m
        iytf37NZbL0lbXGi7wOrxeVdc9gc2DxmNfSyeez9toDF4373cSaPz5vkAliiuGxSUnMyy1KL
        9O0SuDKuLb/OVPCQuWLFb50GxnbmLkZODgkBE4ntz3eydjFycQgJrGCU+HiilRHC+cIo0f9m
        BRNIlZDAZ0aJR18EYTpmLDzLDlG0nFHi6fvbUB1vGSU2fDrGAlIlLGAn8ev4DCCbg0NEQFPi
        /LkikBpmgdWMEqs+TwOrYROwkpjYvooRxOYFqj/0ej47iM0ioCox8d85sLioQITE/WMbWCFq
        BCVOznwC1ssJVP/15GQwm1lAXOLWk/lMELa8xPa3c6B+W8QucfWpI4TtItHyaA4ThC0s8er4
        FnYIW0bi/06QXi4gex2jxN+OF8wQznZGieWT/7FBVFlLHD5+kRXkG2agb9bv0ocIO0oceQ4y
        iAPI5pO48VYQ4gY+iUnbpjNDhHklOtqEIKrVJDYs28AGs7Zr50rmCYxKs5B8NgvJN7OQfDML
        Ye8CRpZVjOKppcW56anFhnmp5XrFibnFpXnpesn5uZsYganm9L/jn3Ywfr2UdIhRgINRiYe3
        gsk8Vog1say4MvcQowQHs5IIb2CDWawQb0piZVVqUX58UWlOavEhRmkOFiVx3mqGB9FCAumJ
        JanZqakFqUUwWSYOTqkGxiVLbi/bdDXzfvvUQLcUcYMVLpUrE0Nn/N27tzJG4K72zE0tk9cV
        LuGr6C7PcLF49/WTbUVas+X1CJf2K/HnBS7nhzguPCN1/v5nqxcbjFTun7v35uDplSu1Kl+E
        ZSuarF/vH1KWah4j/OWGTdu53a4TC4s31h5bePuIULTUZM6vn112WmRwtSmxFGckGmoxFxUn
        AgBK1RwOMQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7pamuaxBq9OCFj8Xt3LZrHw4V1m
        iytf37NZbL0lbXGi7wOrxeVdc9gc2DxmNfSyeez9toDF4373cSaPz5vkAlii9GyK8ktLUhUy
        8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKuLb/OVPCQuWLFb50G
        xnbmLkZODgkBE4kZC8+yg9hCAksZJU79zepi5ACKy0gcX18GUSIs8edaF1sXIxdQyWtGiXkf
        vzOCJIQF7CR+HZ/BAlIvIqApcf5cEUgNs8BqRolP8/ewQDRMZJR4NWUVK0gDm4CVxMT2VWDN
        vEDNh17PB1vMIqAqMfHfObC4qECExJn3K1ggagQlTs58AmZzAtV/PTkZzGYWUJf4M+8SM4Qt
        LnHryXwmCFteYvvbOcwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dL
        zs/dxAiMrW3Hfm7Zwdj1LvgQowAHoxIPbwWTeawQa2JZcWXuIUYJDmYlEd7ABrNYId6UxMqq
        1KL8+KLSnNTiQ4ymQM9NZJYSTc4Hxn1eSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU
        1ILUIpg+Jg5OqQbGpr6Vsz5PrBCVnTzRrypBVF97YtViZuZqzbhDDZG17oGvfl5RXsQs/fzA
        4qPqEq+VBNQ3XK6QyVF+tPWsyMH95noJt07JmeTUWcZp+5z03md9pGVbbOLKe7fvnF3gkSe2
        q9nAquDpPSaewKutnd4tZlWGU/a921l3cFXhrmMzlpyaNtNEzC5WiaU4I9FQi7moOBEALFwa
        O8MCAAA=
X-CMS-MailID: 20190723153506eucas1p2f9344c53f8b25fb9d89a1f0ee5dddae0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190624223730epcas2p4d2b1ad1200c11a472ba327ee39ede08b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190624223730epcas2p4d2b1ad1200c11a472ba327ee39ede08b
References: <CGME20190624223730epcas2p4d2b1ad1200c11a472ba327ee39ede08b@epcas2p4.samsung.com>
        <20190624223724.13629-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/25/19 12:37 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable err is initialized to a value that is never read and it
> is re-assigned later.  The initialization is redundant and can
> be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch queued for v5.4, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
