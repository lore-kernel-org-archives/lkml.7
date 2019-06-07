Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B94AC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AF52089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vNS+Cswa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfFGGmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:42:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42417 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfFGGmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:42:14 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607064212euoutp015dbcf277181bfb1f1bb18b21c83c1c57~l13KKVBsT1080110801euoutp01j
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 06:42:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607064212euoutp015dbcf277181bfb1f1bb18b21c83c1c57~l13KKVBsT1080110801euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559889732;
        bh=3qxmw66B41o0ihEUJxKIfGNz16QqnTiQIV4yVoLj8P4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vNS+CswafpSV6iODjg7g7s0xdIcyzm4sp+nGwGHaJQRfGl1FMNs9eu+ZkIfWREaak
         y4+9euNlLiPOdlzrSvb5vqkrH2c49j4/xJ0UGp4dX8FIb4Opcyn/T67QS5cPyN+FUL
         TP7AgGUtjDs4naQprEMcJnc5SYIAYXdm5d03ndIs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190607064212eucas1p298d26982546a2b1b38d8b81a4cc1e17a~l13JW2ozf3057230572eucas1p2Q;
        Fri,  7 Jun 2019 06:42:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8A.6F.04377.3470AFC5; Fri,  7
        Jun 2019 07:42:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190607064211eucas1p174370d94ad4fc041efb6fd43c549b880~l13IkkNvt3212532125eucas1p1C;
        Fri,  7 Jun 2019 06:42:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607064210eusmtrp2b19e77c660c443d0cd64838fe0e35dd1~l13IU8uix0307003070eusmtrp21;
        Fri,  7 Jun 2019 06:42:10 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-ee-5cfa0743d466
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4B.BC.04146.2470AFC5; Fri,  7
        Jun 2019 07:42:10 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607064210eusmtip16216a1cef3c6d602454481abeb3ef8f8~l13Hsd0Xw1500215002eusmtip1T;
        Fri,  7 Jun 2019 06:42:10 +0000 (GMT)
Subject: Re: [PATCH v4 15/15] drm/bridge: tc358767: Replace magic number in
 tc_main_link_enable()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b20c99e3-fe15-6456-8b70-c2843bf07773@samsung.com>
Date:   Fri, 7 Jun 2019 08:42:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607044550.13361-16-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87rO7L9iDJ6/0rJo7rC1aDrUwGrx
        48phFouDe44zWVz5+p7N4sHcm0wWnROXsFtc3jWHzeLuvRMsFuvn32Jz4PJ4MPU/k8fOWXfZ
        PWZ3zGT1uN99nMmj/6+Bx/Eb25k8Pm+S8zg39SxTAEcUl01Kak5mWWqRvl0CV8aWyQEFc7kq
        Xk/4xtzAeIaji5GTQ0LARGLqhOvsXYxcHEICKxglel/3QDlfGCU6/z+Fcj4zSszevJgJpuXd
        89tQieWMEtN6T7BCOG8ZJRZePMQKUiUskCxx9P5mFhBbRCBA4lPTTjaQImaB00wS7btuM4Mk
        2AQ0Jf5uvskGYvMK2Ems236cEcRmEVCRaFwwFywuKhAhcf/YBlaIGkGJkzOfgA3lFLCXOPi0
        F6yGWUBeonnrbGYIW1zi1pP5TCDLJASusUssuveGFeJuF4l/9zYzQ9jCEq+Ob2GHsGUk/u+c
        D/VbvcT9FS3MEM0djBJbN+yEarCWOHz8ItAgDqANmhLrd+lDhB0lLm+7zQYSlhDgk7jxVhDi
        Bj6JSdumM0OEeSU62oQgqhUl7p/dCjVQXGLpha9sExiVZiH5bBaSb2Yh+WYWwt4FjCyrGMVT
        S4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxApPX6X/Hv+xg3PUn6RCjAAejEg+vA8PPGCHWxLLi
        ytxDjBIczEoivGUXfsQI8aYkVlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoE
        k2Xi4JRqYNz+55jWxNyqKvdHa6ZcEP6nf3fNbk9+tqNOwawn37G6GK8uu58ZHDDD543n0xLX
        x/5l1Z9CJvkYXzHft/HT7/v/XyhN//hln1l7Tv+t97NNFFX0p9ZptNrmZf6btltd1rFgSVzm
        KRYbP8m3C4q/VPzKm/ZXPilO9f9a1WNLV7w0nD1tDad0hawSS3FGoqEWc1FxIgAqGqOEWgMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7pO7L9iDP4dNLZo7rC1aDrUwGrx
        48phFouDe44zWVz5+p7N4sHcm0wWnROXsFtc3jWHzeLuvRMsFuvn32Jz4PJ4MPU/k8fOWXfZ
        PWZ3zGT1uN99nMmj/6+Bx/Eb25k8Pm+S8zg39SxTAEeUnk1RfmlJqkJGfnGJrVK0oYWRnqGl
        hZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaWyQEFc7kqXk/4xtzAeIaji5GTQ0LAROLd
        89vsXYxcHEICSxklGk4dZ4ZIiEvsnv8WyhaW+HOtiw3EFhJ4zSgxbZEQiC0skCxx9P5mFhBb
        RMBPomveASaQQcwCZ5kkfu/eCdVwjFHi1mEXEJtNQFPi7+abYHFeATuJdduPM4LYLAIqEo0L
        5oLFRQUiJM68X8ECUSMocXLmEzCbU8Be4uDTXrAaZgF1iT/zLjFD2PISzVtnQ9niEreezGea
        wCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgrG479nPzDsZL
        G4MPMQpwMCrx8Dow/IwRYk0sK67MPcQowcGsJMJbduFHjBBvSmJlVWpRfnxRaU5q8SFGU6Dn
        JjJLiSbnA9NIXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGRjb9
        1p/HpnPv29vJd6P26Y/yl5en18WF550MEFEXDX3k+K6jwf5P7TJ7E5VNC6vkD9ovWJZgO/0N
        Q31br7KGJYOXzCNfZveSitAzvMtv12yxPfP8yr5LrgUPLzhz2v7i/8pb+9c6efODdR/nX9IR
        TFTZGcU/TzFmleNlecPg2XfkYzQOy1bXK7EUZyQaajEXFScCADQ8mRrrAgAA
X-CMS-MailID: 20190607064211eucas1p174370d94ad4fc041efb6fd43c549b880
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607044651epcas1p3cccde08d3b4f4a414f84ef757973e804
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607044651epcas1p3cccde08d3b4f4a414f84ef757973e804
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
        <CGME20190607044651epcas1p3cccde08d3b4f4a414f84ef757973e804@epcas1p3.samsung.com>
        <20190607044550.13361-16-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.2019 06:45, Andrey Smirnov wrote:
> We don't need 8 byte array, DP_LINK_STATUS_SIZE (6) should be
> enough. This also gets rid of a magic number as a bonus.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 4a245144aa83..05c5fab011f8 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -874,7 +874,7 @@ static int tc_main_link_enable(struct tc_data *tc)
>  	u32 dp_phy_ctrl;
>  	u32 value;
>  	int ret;
> -	u8 tmp[8];
> +	u8 tmp[DP_LINK_STATUS_SIZE];
>  
>  	dev_dbg(tc->dev, "link enable\n");
>  


