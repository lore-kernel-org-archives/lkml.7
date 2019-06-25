Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2838C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD02B204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M/Abjt7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbfFYKy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:54:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57752 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfFYKy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:54:26 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190625105424euoutp014f5b47749408d8e407840cd0439ab1fa~ra6fRmlh92448124481euoutp01j
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:54:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190625105424euoutp014f5b47749408d8e407840cd0439ab1fa~ra6fRmlh92448124481euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561460064;
        bh=R2A3RFHa8CFk8Ye6kdA1TIoqIG8QcKLFEzHo0ffgjPE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=M/Abjt7FzIoz2QXxtduPFBX6sxjwzrJnVR5HSYMKA2hPwwo+sGLXLPE6vB0kOfAlV
         SPwm/49ER1tnxL4pJuQgNCqg7RJcVsub9i+RcEHnegtdmBMmWd0W0TvtZZ/N/o9F6c
         o46q17noTtb2mCiTmUml2EIGi5aq7J7EZhMKUEC0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190625105423eucas1p122dbc580064b4f1295cdf59127a8336d~ra6egbcMn2315623156eucas1p1l;
        Tue, 25 Jun 2019 10:54:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BA.0E.04298.F5DF11D5; Tue, 25
        Jun 2019 11:54:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190625105422eucas1p20d6b3c7d7a126f42ed2bf50edc5d8e27~ra6dnn23C2324523245eucas1p2p;
        Tue, 25 Jun 2019 10:54:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190625105422eusmtrp2d04ca419ae199f5024586e6d392b3375~ra6dZh8sN3072330723eusmtrp2M;
        Tue, 25 Jun 2019 10:54:22 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-f0-5d11fd5f783a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4C.92.04146.E5DF11D5; Tue, 25
        Jun 2019 11:54:22 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190625105421eusmtip11845686facffb1722de0b1b9665e6a35~ra6c5zGNE0279502795eusmtip1e;
        Tue, 25 Jun 2019 10:54:21 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge: adv7511: Attach to DSI host at probe time
To:     Matt Redfearn <matt.redfearn@thinci.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <3951d606-6bbd-8465-4a02-1e23964a548b@samsung.com>
Date:   Tue, 25 Jun 2019 12:54:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190424132233.26435-1-matt.redfearn@thinci.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O2dnOy6nn1Pxw0prEqaVlwg6IzGLfhyCcBRFFmbHPHmfsjlv
        SUpILU3RLC9z5MJEkfKaOk2LTFriJXXZDWUiUmGIpc6oUNt2lPz3vM/zvJcHXhIXfyA8yDh5
        KquQM4kSvpDX8fr32wORq84Rgc+XtlGFIwMYdUM9T1CNJQ8xar2jBKfemRf41OL7AkDdLnkk
        oIzdWj71pKaCT3WbdBjV+aAZo6aah0GoA12VO8ajjUWFGN27ouPRXZopAV2lriTozpVpgjYV
        GDC6qnSGoJdaPWX2F4TB0WxiXBqrCAi5LIytmhgHKY3ijDyDBssFaqd8YE8ieAi9meoX5AMh
        KYb1AC1X6PlcsQxQ0Y/KjWIJoD6TVrDZ0vTtJ2bFYlgH0N81f840D9DA4ymeVXCBJ9Fo24LN
        5AqLALpTetZqwqEeRwO9DTaBD33RatsnvhWLYAiaGNICK+bBPejPlyGbxw2eR8tdrYDzOKOB
        ylnbAnuL/1mDwcbj0At1zmtxDrujz7PVmHUZgmYB0vWsEfmAtBQn0E3TLi6BC5ozPN1IswOt
        d1VjHM5Bpvo8nOtVA9Te3IVzwhH0yjBmm4Nbjm7qDuDoY+hFzYyAG++IPs47cyc4orsd5ThH
        i5D6pphz70am4faNge6odtTMLwYSzZZgmi1hNFvCaP7v1QFeA3BnVcqkGFYZJGfT/ZVMklIl
        j/G/kpzUCizvNrhmWNQD83hUH4AkkDiIdP0wQkwwacrMpD6ASFziKqplLJQomsnMYhXJkQpV
        IqvsA9tJnsRddM1u+qIYxjCpbALLprCKTRUj7T1yQcK09OXC98OhtyZh3b1V+ZBZqJJ5hev9
        gr3vS1zKyzxXwuOlp87szchuDY+o3/eVyAlLD0738TYWH124vjbiUZ0VVSbrjSOdEstDs3Ky
        RlMGe+188u3OGQOHJHijjMnu8Z1UHTwNL/0KW3RQH09w3DkXL2652uImJaKl0rri/RKeMpYJ
        8sMVSuYfZzacCGoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7pxfwVjDfZ1Clr0njvJZNHU8ZbV
        Yt3EhUwW/7dNZLa48vU9m8Wna92MFp0Tl7BbXN41h81i7eIZbBa77i9gstg+bwOTxd0NZxkd
        eDxmN1xk8bjc18vksffbAhaPnbPusnvM7pjJ6rH92wNWj/vdx5k8Zk9+xOrxeZNcAGeUnk1R
        fmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbsq5cYC9YJ
        VbQcn8XUwNjB38XIySEhYCKx/sVHpi5GLg4hgaWMEhPbjjBDJMQlds9/C2ULS/y51sUGUfSa
        UWLfp29MIAlhAS+JC5vfg3WLCPQxSnyefIkdxGEW2MUssbHhNytIlZDAREaJ+1fUQGw2AU2J
        v5tvsoHYvAJ2ElfPzGEEsVkEVCV+PTsDNlVUIEJi9q4GFogaQYmTM5+A2ZxA9btXHQerZxZQ
        l/gz7xIzhC0vsf3tHChbXOLWk/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy021CtO
        zC0uzUvXS87P3cQIjOltx35u3sF4aWPwIUYBDkYlHt4FRwRihVgTy4orcw8xSnAwK4nwLk0E
        CvGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MN3klcQbmhqaW1gamhubG5tZKInzdggcjBES
        SE8sSc1OTS1ILYLpY+LglGpglPPexz1Hj80jObT9spaCyaYK/WehyQm1jTyXdn94928rT+os
        bgmla4HfdqVGdmYfXxqvmxNSoKqt4fr9dffRnxv3lm1+mLuH8Zdch9akiLVnni2VPqx+ZtNV
        uypvn+oL685ud6/rVVqRYS115/00/1v20rL2LrLpCgn2bwQfdodOv7vRcZG9EktxRqKhFnNR
        cSIAEJHvw/8CAAA=
X-CMS-MailID: 20190625105422eucas1p20d6b3c7d7a126f42ed2bf50edc5d8e27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190424132254epcas1p4157791b8ce30297340d7053f59bc7f10
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190424132254epcas1p4157791b8ce30297340d7053f59bc7f10
References: <CGME20190424132254epcas1p4157791b8ce30297340d7053f59bc7f10@epcas1p4.samsung.com>
        <20190424132233.26435-1-matt.redfearn@thinci.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.2019 15:22, Matt Redfearn wrote:
> In contrast to all of the DSI panel drivers in drivers/gpu/drm/panel
> which attach to the DSI host via mipi_dsi_attach() at probe time, the
> ADV7533 bridge device does not. Instead it defers this to the point that
> the upstream device connects to its bridge via drm_bridge_attach().
> The generic Synopsys MIPI DSI host driver does not register it's own
> drm_bridge until the MIPI DSI has attached. But it does not call
> drm_bridge_attach() on the downstream device until the upstream device
> has attached. This leads to a chicken and the egg failure and the DRM
> pipeline does not complete.
> Since all other mipi_dsi_device drivers call mipi_dsi_attach() in
> probe(), make the adv7533 mipi_dsi_device do the same. This ensures that
> the Synopsys MIPI DSI host registers it's bridge such that it is
> available for the upstream device to connect to.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>
>
> ---
>
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index e7ddd3e3db9..ea36ac3a3de 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -874,9 +874,6 @@ static int adv7511_bridge_attach(struct drm_bridge *bridge)
>  				 &adv7511_connector_helper_funcs);
>  	drm_connector_attach_encoder(&adv->connector, bridge->encoder);
>  
> -	if (adv->type == ADV7533)
> -		ret = adv7533_attach_dsi(adv);
> -
>  	if (adv->i2c_main->irq)
>  		regmap_write(adv->regmap, ADV7511_REG_INT_ENABLE(0),
>  			     ADV7511_INT0_HPD);
> @@ -1222,7 +1219,11 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>  	drm_bridge_add(&adv7511->bridge);
>  
>  	adv7511_audio_init(dev, adv7511);
> -	return 0;
> +
> +	if (adv7511->type == ADV7533)
> +		return adv7533_attach_dsi(adv7511);
> +	else
> +		return 0;


It seems that on failure of adv7533_attach_dsi cleanup is not performed.

Beside this change looks OK, but it would be good to test it on
platforms with adv7533.


Regards

Andrzej


>  
>  err_unregister_cec:
>  	i2c_unregister_device(adv7511->i2c_cec);


