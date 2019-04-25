Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81F4C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB57217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="evU6cpvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfDYImM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:42:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56159 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYImL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:42:11 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190425084209euoutp0108c2e9440b1ac3524fb9d4585d26d0be~Yqwm-0bU61896818968euoutp01R
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 08:42:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190425084209euoutp0108c2e9440b1ac3524fb9d4585d26d0be~Yqwm-0bU61896818968euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556181729;
        bh=ZjCI3NmSxaFhdrKIfLCeZFz9kEclzb5vSajJKzfGv/I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=evU6cpvqDfTkex5KRxXkk62T/N7ZSBg2cnkUjQqhql3afnTIVIsQvykV5RQJP41ig
         zM9XvKzoAaE7eeeE9ybygyJ3BOeX0dC7EzE2/jzenJyUZyQuJBoGaqI5uvso2j4Y+2
         XcevpUHkTVt/K/97pEerRtmr139jFN7N4T83uDAg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190425084208eucas1p2b41768424a8f08cd9287a6154eb22f6b~YqwmWxBVE0747807478eucas1p2C;
        Thu, 25 Apr 2019 08:42:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AD.6A.04298.0E271CC5; Thu, 25
        Apr 2019 09:42:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190425084208eucas1p2b8cf6fe6a46bd3f32eeede394bff29ba~Yqwlq0hV90487404874eucas1p2N;
        Thu, 25 Apr 2019 08:42:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190425084207eusmtrp1a998f10584db661922eae8d20401eee1~YqwlcwRHI1252312523eusmtrp1-;
        Thu, 25 Apr 2019 08:42:07 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-a1-5cc172e0098a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DB.B5.04140.FD271CC5; Thu, 25
        Apr 2019 09:42:07 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190425084207eusmtip11983d63f7a55de04010afccb489d2d79~Yqwk_FtOM0283302833eusmtip1x;
        Thu, 25 Apr 2019 08:42:07 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge: dw-hdmi: fix SCDC configuration for
 ddc-i2c-bus
To:     Jonas Karlman <jonas@kwiboo.se>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <2f70a4cd-b6a1-c978-33a0-ebf33935398a@samsung.com>
Date:   Thu, 25 Apr 2019 10:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VE1PR03MB59031814B5BCAB2152923BDAAC210@VE1PR03MB5903.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+845247T2ec0fFEpGpUuKAu6HOhCQtGJICKiIo2adTJzau1o
        LQtalrIshxpdZqJGVlZWa01nkqTTnOIlzYqZ5MwsKhuLTE1ildsx8r/f+z3Pe3ngo0l5ryiM
        TkxJ4zQpKrVCLKWqmsafL+jX1Mct+l6hZHI7WggmU+8SMX+q8knm5YhbzPwZGBIxr8Y+k0zL
        11cUcza/TMJ01xSJGZshlnlrakdr/Fm3I0vCXtV1UWy3IZdga0dLKfaq3ihim/NeEKx1tF/E
        Os/ZCbYu9wLFWl8Xk+yweeZm/53Slfs4deIRThO9eo/0QL9bLzlkwNo2XTelQzdlOciPBrwE
        2tusRA6S0nJcjuDe51OTxQ8E5tF3pFAMI2h4Woz+tQzeuiYShFsI3o1lSoTChWDY6iG9rmC8
        BcyeLomXQ/BB+FTwGnlNJD5DQnX5fbFXEGMleB71+FiGV0OfvdHXQOG58N7U7hs0A+8AZ5NJ
        JHiCoMU4SHnZD++CvqpWXy+JZ4HVVUQKHApvBksI4dRxCVyvjhJ4LTwtvjgZIRi+2C0SgSOg
        9cJ5SuCT4Cw/48sMWI+g0vSYFIQV0GDvmjiCnlighAc10V4EHAPOx0oBA8HhChIuCISCqsuk
        8CwDfbZcmDEbnO2Vk/NC4UbniDgPKQqn5CqckqVwSpbC/2tLEXUHhXLpfHICxy9O4Y4u5FXJ
        fHpKwsK9qclmNPHlWn/bv1ejkRfxNoRppAiQ6eLr4uQi1RH+WLINAU0qQmSRS+vj5LJ9qmMZ
        nCZ1tyZdzfE2FE5TilDZ8Wn9sXKcoErjkjjuEKf5pxK0X5gO5Ym3t1galywIUGs7vkV2jBd0
        7pRamjbw+lUfa9V+Mb2bwiMj0h5m5Wccv1150hqceaU5aqBsa05JUviHdQOEbZt2+tzljS97
        bU7GfDi2s2m9xaVd40Gj2bS7wp1lMy7rsc501O/HhnUW8knSvJ+ny8YC0371bnx2YshhXHTp
        7hwFxR9QLZ5PanjVX8ZT1H1uAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xu7r3iw7GGLz6aGbRe+4kk0VTx1tW
        i//bJjJbXPn6ns3i/6PXrBZXv79ktjj55iqLRefEJewWl3fNYbM41BdtcXfDWUYHbo/3N1rZ
        PWY3XGTxuNzXy+Sx99sCFo/ZHTNZPU5MuMTksf3bA1aP+93HmTwO9E5m8dh+bR6zx+dNcgHc
        UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZD953
        sBf0CVScabjM0sC4jLeLkZNDQsBE4snyhaxdjFwcQgJLGSXO7FvDCpEQl9g9/y0zhC0s8eda
        FxtE0WtGib6uZ2wgCWGBIIlNfy+yg9giAlkSK7Y9YwIpYhZoYZbon7yMGaJjA6PEyevNYB1s
        ApoSfzffBLN5Bewk7h0/AtbNIqAq8XjDWbB1ogIREmfer2CBqBGUODnzCZjNKRArcW/babBe
        ZgF1iT/zLjFD2PIS29/OgbLFJW49mc80gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIj
        veLE3OLSvHS95PzcTYzA2N527OeWHYxd74IPMQpwMCrx8CpEHogRYk0sK67MPcQowcGsJMKr
        bnowRog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgWknryTe0NTQ3MLS0NzY3NjMQkmct0MA
        qEkgPbEkNTs1tSC1CKaPiYNTqoFx/jXZBxW/eew/z6183Lv5U8cUXiHxO/5+R84dbVb9VOT7
        Y5ZjmSfTqR2Puuzddov3+/zrcWUR+Pu7PtbxxzXO7dqHL198tv+QftWRpdkhMy9PPBKwaEWJ
        tM0unZ8vL7V22nzdxtmn82ZS1pTl+R+neXzQZRStObKvjPe7+d3uP4Y3U6P5jxZEK7EUZyQa
        ajEXFScCAPLUCyUDAwAA
X-CMS-MailID: 20190425084208eucas1p2b8cf6fe6a46bd3f32eeede394bff29ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190421082557epcas3p4cf620e148f998076130ded078b2f64be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190421082557epcas3p4cf620e148f998076130ded078b2f64be
References: <CGME20190421082557epcas3p4cf620e148f998076130ded078b2f64be@epcas3p4.samsung.com>
        <VE1PR03MB59031814B5BCAB2152923BDAAC210@VE1PR03MB5903.eurprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.2019 10:25, Jonas Karlman wrote:
> When ddc-i2c-bus property is used, a NULL pointer dereference is reported:
>
> [   31.041669] Unable to handle kernel NULL pointer dereference at virtual address 00000008
> [   31.041671] pgd = 4d3c16f6
> [   31.041673] [00000008] *pgd=00000000
> [   31.041678] Internal error: Oops: 5 [#1] SMP ARM
>
> [   31.041711] Hardware name: Rockchip (Device Tree)
> [   31.041718] PC is at i2c_transfer+0x8/0xe4
> [   31.041721] LR is at drm_scdc_read+0x54/0x84
> [   31.041723] pc : [<c073273c>]    lr : [<c05926c4>]    psr: 280f0013
> [   31.041725] sp : edffdad0  ip : 5ccb5511  fp : 00000058
> [   31.041727] r10: 00000780  r9 : edf91608  r8 : c11b0f48
> [   31.041728] r7 : 00000438  r6 : 00000000  r5 : 00000000  r4 : 00000000
> [   31.041730] r3 : edffdae7  r2 : 00000002  r1 : edffdaec  r0 : 00000000
>
> [   31.041908] [<c073273c>] (i2c_transfer) from [<c05926c4>] (drm_scdc_read+0x54/0x84)
> [   31.041913] [<c05926c4>] (drm_scdc_read) from [<c0592858>] (drm_scdc_set_scrambling+0x30/0xbc)
> [   31.041919] [<c0592858>] (drm_scdc_set_scrambling) from [<c05cc0f4>] (dw_hdmi_update_power+0x1440/0x1610)
> [   31.041926] [<c05cc0f4>] (dw_hdmi_update_power) from [<c05cc574>] (dw_hdmi_bridge_enable+0x2c/0x70)
> [   31.041932] [<c05cc574>] (dw_hdmi_bridge_enable) from [<c05aed48>] (drm_bridge_enable+0x24/0x34)
> [   31.041938] [<c05aed48>] (drm_bridge_enable) from [<c0591060>] (drm_atomic_helper_commit_modeset_enables+0x114/0x220)
> [   31.041943] [<c0591060>] (drm_atomic_helper_commit_modeset_enables) from [<c05c3fe0>] (rockchip_atomic_helper_commit_tail_rpm+0x28/0x64)
>
> hdmi->i2c may not be set when ddc-i2c-bus property is used in device tree.
> Fix this by using hdmi->ddc as the i2c adapter when calling drm_scdc_*().
> Also report that SCDC is not supported when there is no DDC bus.
>
> Fixes: 264fce6cc2c1 ("drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>


Pushed to drm-misc-fixes.

Regards

Andrzej

