Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19C1C742B3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF13206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XfKQX/WR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfGLKbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 06:31:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33616 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfGLKbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:31:08 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190712103107euoutp01fa1ab52c83760cf0fc8d585c1f13e531~wokAni8_X1918119181euoutp01M
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:31:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190712103107euoutp01fa1ab52c83760cf0fc8d585c1f13e531~wokAni8_X1918119181euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562927467;
        bh=L9nTEdffmmppnQXXzaoMqKQFM3A683O7RSLnY9V3vuQ=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=XfKQX/WR+lXEX+3t19ZRfwaN5MxGWrIbBfW3P0QNbli8+7JGl864GrqunNZjaX1O/
         dey+68RTjZRetOcHg3z+zX4nMd8RpVMEg5/lSctvqjSvpNLYqSN8zfPnOwWK5KutpS
         BEgdWxdlo5QDp6tYSSkHOg+VNkc3xDE6gd29Lxm0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190712103106eucas1p234a7723ba3e494ac099879c9d89a8efd~woj-lQhsn0791607916eucas1p2G;
        Fri, 12 Jul 2019 10:31:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FA.D1.04325.961682D5; Fri, 12
        Jul 2019 11:31:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190712103105eucas1p27d737c1a20ee65be2c8523f46bc9914e~woj_1Vi1x1832918329eucas1p2E;
        Fri, 12 Jul 2019 10:31:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190712103104eusmtrp21847deb6947e25f75ae89567012a4fad~woj_nE0vW1384213842eusmtrp2k;
        Fri, 12 Jul 2019 10:31:04 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-7e-5d28616992a3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 94.FB.04146.861682D5; Fri, 12
        Jul 2019 11:31:04 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190712103104eusmtip23ed1f1601b70625ec1883bddcaa62231~woj961cqx1128711287eusmtip2J;
        Fri, 12 Jul 2019 10:31:04 +0000 (GMT)
Subject: Re: [PATCH 1/3] drm/bridge: sii902x: fix missing reference to mclk
 clock
To:     Olivier Moysan <olivier.moysan@st.com>, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        benjamin.gaignard@st.com, alexandre.torgue@st.com,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, jsarha@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <5d87caa7-faac-4461-4184-aff5b8af04b5@samsung.com>
Date:   Fri, 12 Jul 2019 12:31:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <1562082426-14876-2-git-send-email-olivier.moysan@st.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRz3e97uKa49nayvWHRjZEhj9hgaZvbgD+RlpkVHj7S60+7pRaxp
        FHel9yV1rWvJqFW4U4lqhE56UdGrWWcdlqRNijY5d/ec6b/P9/P9fn7fz+e7H43LrlJedLgq
        mlerFJFyypWoaZ5+vSZcsTJ43dTkajatowVj71taEZuut5CstSYLZ/XPO0j27eQ4xfb8HMHZ
        lq89BJuq1ZCsNqtUwhqGe0n2zaNCik3ptSlu9XVhbFN6EJtTr6PY5Ibnkm3uXEVRBeLG+5Ml
        XMNUMcHpNPkkZyjXUtzLzG6Mq50yk9xQqgnjjKUXuSdpOQT3tNGf+/irAedM/bUYN2Hw3u92
        zHVLKB8ZHsur/QJCXM98vGYmojLpc8UjJVgi+kalIBcamA1wVXcdS0GutIy5g6DqRTMhFj8Q
        6ArfSMRiAkHJVK7kn+SS6QYlNm4jGB1OdOrHbMVMM2afms8chJdpGscSD6YXh7wxzo4pxhdm
        jAMOXsoEwGDSb9KOCWY5dA6WIjtewByB6WKtc8YdWvIthB27MLvga2G5wwXOLIHL1TpcxJ4w
        aNE7TABTRoO+rAoTre6E65dHnXg+fDE9cEZYDNY6vZO/CEN3knBRrEFQfa8OFxub4Zmpy+aO
        tm3whbuP/ER6O/waznLQwLhB/5i76MENsmvycJGWguaKTJz2gaH2aueDnnCrc9J5dw4GBg1k
        JvIpmJWyYFayglnJCv57KEZEOfLkYwRlGC+sV/FxawWFUohRha09dVZpQLbv2frHNPkQNf4+
        2YQYGsnnSfs3rQiWkYpYIV7ZhIDG5R7ScquNkoYq4s/z6rMn1DGRvNCEFtGE3FN6YY45SMaE
        KaL5CJ6P4tX/uhjt4pWIGka3K9vajCNWfeeTDOjrDN57oOtz8M09Nd/Hda++VO74sabkko85
        yfs0kuY2WjZu1W5KWLGw3bdWVX/Mo0JZWhm6O3A64hDEDZVZlaaQHUsPz9QHfVqZGhYVKLTu
        eRfiPZBgzL3ZnfF+btzJ8Ox9dXn+ZmPf0eiMhA8v0pcdjy96LCeEMwr/VbhaUPwFRmOOvpoD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42I5/e/4Pd2MRI1Yg5cHzC16z51kstj45DSj
        Rd/8J6wW/7dNZLaYf+Qcq8WVr+/ZLK5+f8lscfLNVRaL7s4OVovOiUvYLTY9vsZqcXnXHDaL
        rmtAHUuvX2SyONQXbTF5z2w2i9a9R9gdBD3WzFvD6PH+Riu7x95vC1g8ZnfMZPXYtKqTzePE
        hEtMHtu/PWD1uN99nMlj85J6jwO9k1k8Du4z9Hj6Yy+zx/Eb25k8Pm+SC+CL0rMpyi8tSVXI
        yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mt42vOApWACR8WCl4uY
        GhjfsXUxcnJICJhINB2fAWYLCSxllDh/WAYiLi6xe/5bZghbWOLPtS6gGi6gmteMEldOXQFL
        CAsES5zo7QBLiAhcY5b4tbOLBaLqKqPEvLvf2EGq2AQ0Jf5uvgm2glfATuJWyx9WEJtFQFXi
        wq0ljF2MHByiAmESR0/kQZQISpyc+YQFxOYUcJN4M2cV2BhmAXWJP/MuMUPY8hLNW2dD2eIS
        t57MZ5rAKDgLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmBS2Hbs
        5+YdjJc2Bh9iFOBgVOLhvWGpHivEmlhWXJl7iFGCg1lJhHfVf6AQb0piZVVqUX58UWlOavEh
        RlOg3yYyS4km5wMTVl5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6p
        BkadqPnrl1iePpf6bU1XR1PBhh095iv5vZSu8S9WuX/dMpPBS2Xzeq8yYT/XW1O77At1e9ZK
        iD06ePm4kvABhfLFpx+5FmlPWbvkrXhCbcUTk4RC/jWnckTv8/9uMzuSzXOq8kwbQ772OtXZ
        7PNLLx2bs6g2T+5SlP69+4VWWxTPBYXYJtruXqzEUpyRaKjFXFScCAAENZ72IAMAAA==
X-CMS-MailID: 20190712103105eucas1p27d737c1a20ee65be2c8523f46bc9914e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190702154805epcas2p2f95d733d2f0df9d311ab5ed37f452d34
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190702154805epcas2p2f95d733d2f0df9d311ab5ed37f452d34
References: <1562082426-14876-1-git-send-email-olivier.moysan@st.com>
        <CGME20190702154805epcas2p2f95d733d2f0df9d311ab5ed37f452d34@epcas2p2.samsung.com>
        <1562082426-14876-2-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.2019 17:47, Olivier Moysan wrote:
> Add devm_clk_get call to retrieve reference to master clock.
>
> Fixes: ff5781634c41 ("drm/bridge: sii902x: Implement HDMI audio support")
>
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index dd7aa466b280..36acc256e67e 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -750,6 +750,7 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
>  		sii902x->audio.i2s_fifo_sequence[i] |= audio_fifo_id[i] |
>  			i2s_lane_id[lanes[i]] |	SII902X_TPI_I2S_FIFO_ENABLE;
>  
> +	sii902x->audio.mclk = devm_clk_get(dev, "mclk");
>  	if (IS_ERR(sii902x->audio.mclk)) {
>  		dev_err(dev, "%s: No clock (audio mclk) found: %ld\n",
>  			__func__, PTR_ERR(sii902x->audio.mclk));

Acked-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

