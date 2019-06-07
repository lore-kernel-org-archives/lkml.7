Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAAFC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B542D208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t0CBwA4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfFGGK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:10:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35286 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfFGGK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:10:57 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190607061055euoutp01d59da50263a5ddc739b4d37468a0c76b~l1b1y4cdS2879028790euoutp01o
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 06:10:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190607061055euoutp01d59da50263a5ddc739b4d37468a0c76b~l1b1y4cdS2879028790euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559887855;
        bh=+uR4qgy3oYGxG+0KpS+F/2Aej6rAjh5RXeKhbh9N708=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=t0CBwA4DqmDAGphyKeL4lji26zHP4IZJ54cNVOhqVx0LJsUN/pohoqo/Njd/lL0DT
         00e9Q08Agn7X09NNvLABtLfaTlt+X4QNj/s7ycdjUcmjtoL3X6h1Be0DnG0WefeHee
         956TRaMdMyswH1PRgJqIwCi+Ihp3Q8OAOeDGqxFg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607061054eucas1p131b508aac74138e2cbf72f6431562bdd~l1b0yNpKW0324403244eucas1p1J;
        Fri,  7 Jun 2019 06:10:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 45.35.04325.EEFF9FC5; Fri,  7
        Jun 2019 07:10:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607061053eucas1p230b6bcfdf9fc1c35f966dda20a76fdd5~l1bzwq0f30856808568eucas1p2U;
        Fri,  7 Jun 2019 06:10:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607061053eusmtrp23fac0fbb5cffd1e0022737b402e1a61a~l1bzg2FxW1706517065eusmtrp2L;
        Fri,  7 Jun 2019 06:10:53 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-79-5cf9ffee5131
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FF.A5.04140.DEFF9FC5; Fri,  7
        Jun 2019 07:10:53 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607061052eusmtip19fc68647439cbb0ce77d31ed7cd81e83~l1by4bHMK2554825548eusmtip1a;
        Fri,  7 Jun 2019 06:10:52 +0000 (GMT)
Subject: Re: [PATCH v4 09/15] drm/bridge: tc358767: Use reported AUX
 transfer size
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
Message-ID: <136db777-5d62-642b-a359-b06ade4518b8@samsung.com>
Date:   Fri, 7 Jun 2019 08:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607044550.13361-10-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjtvfdu9zo3u27ansyKhhQFmX0Ql7Iv8cf9JRJBZgO76kVXOmXz
        swKHRi4ttQ8Nt0JXhqGlZmpOREhpM8RSjHILNyn/JNgkkzKcy+0a+e+c85zzvs95eSlcbhdF
        UBptHq/TclkqsYTosS292/vdt6SO8ZZJmTLjMaZ00CBifn8YIpjX/XaM+bDoETPTDx0Yc+N2
        E8lM9D0QM1OuYYJpb3CKT0rY6VofxlpNUyRrNtaLWHelHWOrvTGsffIVxi50bmPf1Y5iiVSy
        JDadz9IU8Lp9xy9IMj1dFiy3fkvRJ88bwoDmwitQEAX0ITDecmIVSELJ6acIPi7UIIH8RHC3
        7ppIIAurk5dtq4QKRMa79wp6M4IXFi8pkDkEjWU25D9XQZ+B9iaP2I/D6ET4UWoV+004PYJB
        ed9n3D8Q07vB+9IRMMno4zDfUxfQCToKHrfMBvRwOgnctg6R4AmFt/UzhB8H0SdgZNpO+jFO
        b4eybjMuYCU4ZxoChYB2kWCeGkdC03jo/zqBC1gBs/YuUsCR4LP6A35cAu6n13AhbETQ3WFd
        CxyFIft4oD++unV73z5BPgW2XjMpPEsITM6FCjuEwJ2e+7ggy8B4XS64d4B7tHvtQCU8GVsU
        1yCVaV0z07o2pnVtTP/vbUREC1Ly+frsDF5/UMsXRuu5bH2+NiM6LSe7E61+r5EV+2IvGlhO
        HUQ0hVRSGUsuqeUirkBfnD2IgMJVYbKCsd9quSydK77M63JSdPlZvH4QbaEIlVJ2ZcP0eTmd
        weXxl3g+l9f9m2JUUIQBPRuNmt/quiBKXjYcLipUJ1OFF92lpybLta3nGixcyKabp9ss96qW
        lZ5WxXBLcO6ugfmqkpNfLDsfzSp8jkgplK+44rlf5e0JBnKzN9Yh3fgtLniHSJrSdCShMcnZ
        33L1wI2aP6nVZ9OcPzUhvvAc1/vqhqoIDWGpVEzENRueqwh9Jrd/D67Tc38BjrvOFVoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7pv//+MMVj+ks2iucPWoulQA6vF
        jyuHWSwO7jnOZHHl63s2iwdzbzJZdE5cwm5xedccNou7906wWKyff4vNgcvjwdT/TB47Z91l
        95jdMZPV4373cSaP/r8GHsdvbGfy+LxJzuPc1LNMARxRejZF+aUlqQoZ+cUltkrRhhZGeoaW
        FnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnvtyxkKpgpXXH9/VGWBsa3ol2MHBwSAiYS
        F7fqdjFycQgJLGWUuPDmCGsXIydQXFxi9/y3zBC2sMSfa11sEEWvGSV29UwESwgLhEgcOtLD
        AmKLCPhJdM07wARSxCxwlkni9+6dUB3HGCVmLP4G1sEmoCnxd/NNNhCbV8BO4sO2aWBxFgEV
        icWrXoHFRQUiJM68X8ECUSMocXLmEzCbU8Be4vSD4+wgNrOAusSfeZeYIWx5ieats6FscYlb
        T+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMF63Hfu5
        ZQdj17vgQ4wCHIxKPLwzmH7GCLEmlhVX5h5ilOBgVhLhLbvwI0aINyWxsiq1KD++qDQntfgQ
        oynQcxOZpUST84GpJK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dU
        A2Og2b0wH3k7ryuNW/MN1rN+Wt7/5t2W+qa397Knq8iXqH51vmE4d9FNoeo7ymcYSneqZfDb
        7lt3ZNl6zX+NyqXLDl6wcv7mumbZ03uPBSWWa3M4sK/5UCmcUf9rWZ2ey7PHlhcy+Q/u3e76
        oCh0LavojgkC1rLffipun/2qOu95q+2zdfGBFcVKLMUZiYZazEXFiQBN/buq7QIAAA==
X-CMS-MailID: 20190607061053eucas1p230b6bcfdf9fc1c35f966dda20a76fdd5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607044641epcas1p429ad931d59b2c1c083f41c29d86d1a12
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607044641epcas1p429ad931d59b2c1c083f41c29d86d1a12
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
        <CGME20190607044641epcas1p429ad931d59b2c1c083f41c29d86d1a12@epcas1p4.samsung.com>
        <20190607044550.13361-10-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.2019 06:45, Andrey Smirnov wrote:
> Don't assume that requested data transfer size is the same as amount
> of data that was transferred. Change the code to get that information
> from DP0_AUXSTATUS instead.
>
> Since the check for AUX_BUSY in tc_aux_get_status() is pointless (it
> will always called after tc_aux_wait_busy()) and there's only one user
> of it, inline its code into tc_aux_transfer() instead of trying to
> accommodate the change above.
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
>  drivers/gpu/drm/bridge/tc358767.c | 40 ++++++++++---------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 8b53dc8908d3..7d0fbb12195b 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -152,10 +152,10 @@
>  #define DP0_AUXWDATA(i)		(0x066c + (i) * 4)
>  #define DP0_AUXRDATA(i)		(0x067c + (i) * 4)
>  #define DP0_AUXSTATUS		0x068c
> -#define AUX_STATUS_MASK			0xf0
> -#define AUX_STATUS_SHIFT		4
> -#define AUX_TIMEOUT			BIT(1)
> -#define AUX_BUSY			BIT(0)
> +#define AUX_BYTES		GENMASK(15, 8)
> +#define AUX_STATUS		GENMASK(7, 4)
> +#define AUX_TIMEOUT		BIT(1)
> +#define AUX_BUSY		BIT(0)
>  #define DP0_AUXI2CADR		0x0698
>  
>  /* Link Training */
> @@ -298,29 +298,6 @@ static int tc_aux_wait_busy(struct tc_data *tc, unsigned int timeout_ms)
>  			       1000, 1000 * timeout_ms);
>  }
>  
> -static int tc_aux_get_status(struct tc_data *tc, u8 *reply)
> -{
> -	int ret;
> -	u32 value;
> -
> -	ret = regmap_read(tc->regmap, DP0_AUXSTATUS, &value);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (value & AUX_BUSY) {
> -		dev_err(tc->dev, "aux busy!\n");
> -		return -EBUSY;
> -	}
> -
> -	if (value & AUX_TIMEOUT) {
> -		dev_err(tc->dev, "aux access timeout!\n");
> -		return -ETIMEDOUT;
> -	}
> -
> -	*reply = (value & AUX_STATUS_MASK) >> AUX_STATUS_SHIFT;
> -	return 0;
> -}
> -
>  static int tc_aux_write_data(struct tc_data *tc, const void *data,
>  			     size_t size)
>  {
> @@ -356,6 +333,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  	struct tc_data *tc = aux_to_tc(aux);
>  	size_t size = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg->size);
>  	u8 request = msg->request & ~DP_AUX_I2C_MOT;
> +	u32 auxstatus;
>  	int ret;
>  
>  	if (size == 0)
> @@ -393,10 +371,16 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
>  	if (ret)
>  		return ret;
>  
> -	ret = tc_aux_get_status(tc, &msg->reply);
> +	ret = regmap_read(tc->regmap, DP0_AUXSTATUS, &auxstatus);
>  	if (ret)
>  		return ret;
>  
> +	if (auxstatus & AUX_TIMEOUT)
> +		return -ETIMEDOUT;
> +
> +	size = FIELD_GET(AUX_BYTES, auxstatus);
> +	msg->reply = FIELD_GET(AUX_STATUS, auxstatus);
> +
>  	switch (request) {
>  	case DP_AUX_NATIVE_READ:
>  	case DP_AUX_I2C_READ:


