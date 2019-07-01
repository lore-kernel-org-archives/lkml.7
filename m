Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AC1C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D91D206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HFYhfqJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfGAKgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:36:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46915 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAKgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:36:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190701103649euoutp020ac3d5c521041a01cc393366786df796~tQi2kKBCD2289722897euoutp02j
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2019 10:36:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190701103649euoutp020ac3d5c521041a01cc393366786df796~tQi2kKBCD2289722897euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561977409;
        bh=QlKaur9fP+7+/WrimQJNRX1Ptyxs2WCP18dZV/gz7rA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HFYhfqJc+uVdX+24IalJ169qlgiyElHnUJkcTNz7holdAcONUj3+x7+rTl3JPrXKt
         wPGJcOYag17GBAOoaEnr8rcoJ25XYGgmFFIFx8I1ZOHy+zuViyrJs8Th0g/zyq3zNV
         tbnGKEZ06+N3s7xDW8YNRlj+0jq99Y6/niXCF89E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190701103648eucas1p15baa282254e802ce482042f2047941f7~tQi17tvi50125501255eucas1p1r;
        Mon,  1 Jul 2019 10:36:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 75.68.04377.042E91D5; Mon,  1
        Jul 2019 11:36:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190701103648eucas1p1620cd2b7f6d5d820f60a77e606e0cb22~tQi1MDMnX0799407994eucas1p17;
        Mon,  1 Jul 2019 10:36:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190701103647eusmtrp1e83afefe3104da592061b05c5651e223~tQi097AUZ1778817788eusmtrp1X;
        Mon,  1 Jul 2019 10:36:47 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-81-5d19e240c2ac
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 55.65.04140.F32E91D5; Mon,  1
        Jul 2019 11:36:47 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701103647eusmtip19c40a629c7c8640fb38eca335b00c849~tQi0X_5xH2991829918eusmtip1V;
        Mon,  1 Jul 2019 10:36:47 +0000 (GMT)
Subject: Re: [PATCH v2] drm/bridge: adv7511: Attach to DSI host at probe
 time
To:     Matt Redfearn <matt.redfearn@thinci.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <a68a3c20-b3a0-7d0e-6a2e-28649bf9effc@samsung.com>
Date:   Mon, 1 Jul 2019 12:36:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627151740.2277-1-matt.redfearn@thinci.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRj1vfduXofT2yp8+qDayB/2aVF0QZOKwEuYRR9QmeTKy5Sc1eb8
        KmxIxrK2nILVtLnKUgprrNp0aNoql9UqXZZFOTP74WhlpYaSmds18t95zjnv857z8pK4yMub
        TaZnZrGKTGmGhC8grK0jL5au652VHO36LKa1z9swulDj49HjVj1Ovxr6xqc7f/XjdNuXToI+
        pa8Opt32Sj5t95gw2mY0Y7RDl0R/MLsQPWI3EuuEzLeuomCmQt1OMG6dFmOahk0E02D4MMFp
        LvCYxyUdGGMb7uExntNOjGnRlhFMRVkvj/lpmbc1dI8gNpXNSM9mFcvjUgRplsIi/PB7Ua6h
        VIerkTm8GJEkUKtgUAPFSECKqFoEr91eghsGERTp3Xxu+Ing8zvjhBISONFvqQvmhBoE4xcb
        edzgQ6Cteo77906ntoChNdzPz6AsGFSc7wiYcOoKBpcejfP9q/hUFIzdfhvAQioObuq+Y35M
        UAvhur06wM+kdoH7jh1xnmnQdqEvECOEWgujnt4Aj1PzwearxDkcAe/6qjAuqp6EHquEwxvh
        a6N2kp8OXuedYA7PhadlZyarHQdP7QncHxQoDYK75gacE2LggbOd52+GT4S+ZV/O0evhTXcz
        4h4yDLp807gIYVBqPYdztBA0J0WcWwwe193JhRFw9eUQvwRJDFOKGaaUMUwpY/h/rwkR11EE
        q1LKZaxyZSabs0wplStVmbJlBw7JLWjiBz794xysR/bf+x2IIpEkVKh+D8kinjRbmSd3ICBx
        yQxhc+2sZJEwVZqXzyoO7VOoMlilA80hCUmE8GhQT5KIkkmz2IMse5hV/FMxMmS2Ggk+1SFX
        7o3ubG/IE3GY7bRPxZj2pajHBiIfhO/fli/eefbIvYzCAueGchSkV21qwVUtpvjLMQk74ld3
        CQYWm6sXGI9tJ4SyNTHhvpnXoiQUHSm2r0+sqLmx+2P0j3bnw2f5TTnS2IZXm/VL2gv23q8b
        GKyPpEefJZZ38hP2bjBICGWadMUiXKGU/gXn8rdbfQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4XV37R5KxBu++6Fr0njvJZNHU8ZbV
        4v+2icwWV76+Z7O4+v0ls8XJN1dZLDonLmG3uLxrDpvFrvsLmCy2z9vAZHGoL9ri7oazjBY/
        d81jceD1eH+jld1jdsNFFo/Lfb1MHnu/LWDx2DnrLlCsYyarx4kJl5g8tn97wOpxv/s4k8eB
        3sksHrMnP2L1+LxJLoAnSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
        JTUnsyy1SN8uQS9jU1Mrc8EdoYpZk/qYGxg38HcxcnJICJhIvNy0lr2LkYtDSGApo8Tets9M
        EAlxid3z3zJD2MISf651sUEUvWaU+PJoKViRsICvxKfbuxhBEiICW5gkvm08ADaKWWAxk0Tz
        ut+sEC0TGCXmXu4Fm8UmoCnxd/NNNhCbV8BOYl3fR7BRLAIqEqt2LQGLiwpESPS1zYaqEZQ4
        OfMJC4jNKWAr8ev+I0YQm1lAXeLPvEvMELa8xPa3c6BscYlbT+YzTWAUmoWkfRaSlllIWmYh
        aVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMPa3Hfu5ZQdj17vgQ4wCHIxKPLwatyRi
        hVgTy4orcw8xSnAwK4nw7l8hGSvEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cC0lFcSb2hq
        aG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgbHk6InJyrK37rS4N045HW7X
        Z1h38yKTTKQCS5GS8n37BUuPPomY35F1V0M9Z58bw/WnV4/V7rvDtO+Eiqagso6im83Uz5IH
        Ox61ztj/1vZV5qb1z059qtRyZgkNaNqt4sgjk/L4UVzK7WpJ61XGhwL09y/4vbyt9FD/6m9u
        3RbnfjJZrNNqeaHEUpyRaKjFXFScCABhd1/WEwMAAA==
X-CMS-MailID: 20190701103648eucas1p1620cd2b7f6d5d820f60a77e606e0cb22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190627151810epcas2p14661fda980f479627c6beb501f52bfb2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190627151810epcas2p14661fda980f479627c6beb501f52bfb2
References: <CGME20190627151810epcas2p14661fda980f479627c6beb501f52bfb2@epcas2p1.samsung.com>
        <20190627151740.2277-1-matt.redfearn@thinci.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.2019 17:18, Matt Redfearn wrote:
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

Queued to drm-misc-next.


Regards

Andrzej

>
> ---
>
> Changes in v2:
> Cleanup if adv7533_attach_dsi fails.
>
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index e7ddd3e3db9..807827bd910 100644
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
> @@ -1222,8 +1219,17 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>  	drm_bridge_add(&adv7511->bridge);
>  
>  	adv7511_audio_init(dev, adv7511);
> +
> +	if (adv7511->type == ADV7533) {
> +		ret = adv7533_attach_dsi(adv7511);
> +		if (ret)
> +			goto err_remove_bridge;
> +	}
> +
>  	return 0;
>  
> +err_remove_bridge:
> +	drm_bridge_remove(&adv7511->bridge);
>  err_unregister_cec:
>  	i2c_unregister_device(adv7511->i2c_cec);
>  	if (adv7511->cec_clk)


