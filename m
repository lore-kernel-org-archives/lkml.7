Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F53C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD09233FF
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kkcO1mDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfH3GwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:52:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34314 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfH3GwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:52:04 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190830065201euoutp017634ff2bf80046912a70b7e8b91f3734~-oLtQDBAN2754827548euoutp01_
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 06:52:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190830065201euoutp017634ff2bf80046912a70b7e8b91f3734~-oLtQDBAN2754827548euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1567147921;
        bh=9pSbaEQ3uaYxUFgj3JJo0TQLF03wGLIqv1Dnf//hfTE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kkcO1mDIkQ3ZlwduflTG9aC3gvaHbJdfV3VVv1vHdq6h6FSdI8bl0zL9R+2g342oi
         VOfkyV/Z15APbu0lerULgVGgLY3i50w2v6g7Ys99uvTTqQKBkiRv3IXC8H2YqyeMzh
         qfg35oLaIOk00+1ybbxqDvpBOppuvELL9NIzS9pE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190830065200eucas1p26db46f118f87207597717dde1df0ea7c~-oLsYzAQT1277112771eucas1p2u;
        Fri, 30 Aug 2019 06:52:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3D.21.04469.097C86D5; Fri, 30
        Aug 2019 07:52:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190830065159eucas1p2c7db5fa7dc620edecf210349fd9396f3~-oLrcYE5h1257512575eucas1p2S;
        Fri, 30 Aug 2019 06:51:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190830065159eusmtrp2d01b239b17a095b5d9969333ae4edfcc~-oLrODJm92637726377eusmtrp20;
        Fri, 30 Aug 2019 06:51:59 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-a2-5d68c7907162
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0D.DA.04117.F87C86D5; Fri, 30
        Aug 2019 07:51:59 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190830065158eusmtip19e40bba758fcb56e2ce52f8f902a74fc~-oLqhRHDA1732917329eusmtip1K;
        Fri, 30 Aug 2019 06:51:58 +0000 (GMT)
Subject: Re: [RFC][PATCH] drm: kirin: Fix dsi probe/attach logic
To:     Rob Clark <robdclark@gmail.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Matt Redfearn <matt.redfearn@thinci.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <ebdf3ff5-5a9b-718d-2832-f326138a5b2d@samsung.com>
Date:   Fri, 30 Aug 2019 08:51:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAF6AEGvborwLmjfC6_vgZ-ZbfvF3HEFFyb_NHSLRoYWF35bw+g@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUxTURTk9q1UC8+CcsSF2LhExTV+XFwQIibPRBL1R4MhUOGlIIumFRVX
        cK0ohiUuVKCoKEiMCshWFQmoLUEQyhIwEggQlCo2olVxqy1PIn8zc+acO5NclpB/p7zZ6Ph9
        gjpeGaugpWT5i9GmJWnGqNDlXRZvnNpUL8FtNiuN278NEfjlzyW4/kM7ic+l5zO41ZBNY0NP
        ngTXXtyJ317/TuDC0TKEux80IjxqyCVxqfUkifuGCqgAd97aeZrhryW1kHyVrpvh+3OKHVSb
        RfGmNLOEf9PxmOYrvvZSfM95o4TPv9xO8zWpmSR/LbOP4j+XzN4iC5GujRRio/cL6mX+4dKo
        5GLfvfc3HzQ9GmSSUBdOQa4scKsgs7uISUFSVs4VIrDWN0hE8gWBebCcEslnBLeHTqLxlTZt
        JRIHBQg6Wp+TIhlGUGbLYZwuDy4A3le8o5zYk9sEI9V3xkwEV0pCcdUT2jmguYXwu7RrDMs4
        f/hgqHGcZVmSmwcdA5ud8lRuB4z01lGiZQrUZw2QTuzKbQXdnTyJExOcD1QMZxMi9oLXA/qx
        DsDdYkH7qJkQYwdB9o1fpIg9wGJ8yIh4Jtir9BIRH4eewlOEuKx1tHlQ9W95DdQZWyhnOMIR
        +r5hmSgHgr3gHuOUgXODzuEpYgY3yCi/QoiyDLRn5KJ7DvQ0lv076AW3mm10GlLoJjTTTWij
        m9BG9//dPEQWIS8hQROnEjQr4oUDSzXKOE1CvGppxJ64EuT4jw1/jCOVyGbeVYs4Fikmy67W
        qELllHK/JjGuFgFLKDxluXxUqFwWqUw8JKj3hKkTYgVNLZrBkgov2WGX3p1yTqXcJ8QIwl5B
        PT6VsK7eSWhj3/ywcBfvxRnUm6wftsGIRI+XLunPDs71K1sZ3GdBJk/atpI5ugGfnT4QELLu
        mG+yi/+2u+7ZMtY+I4e3yLd/rJl1s+RQZfLXRJ8k6T2IDbuw2vfE0Yin1TEWrlnn9+PTpOBp
        ev8Qe+DucD+/V5cKtetbKfJIkanXFKTvN1sXKEhNlHLFIkKtUf4FCjXay4sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42I5/e/4Xd3+4xmxBhO+S1r0njvJZHHl63s2
        i6vfXzJbnPmta3HyzVUWi86JS9gtLu+aw2ax6/4CJotDfdEWzxf+YLZY8XMro8XdDWcZLX7u
        msdisfl9M4vFo5fLWR34Pd7faGX3mN1wkcVj56y77B6P524EcjtmsnqcmHCJyePOtT1sHtu/
        PWD1uN99nMljybSrbB4HeiezeMye/IjV4/MmuQDeKD2bovzSklSFjPziElulaEMLIz1DSws9
        IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mxo06Bet9Kk7sfsbewHjToouRk0NCwETiSscO
        xi5GLg4hgaWMEm/XvmeBSIhL7J7/lhnCFpb4c62LDaLoNaNE990drCAJYQEHidfbX4DZIgKe
        Ep/2rWQBKWIW2MoisbdhJzNExzVGiQv/f7GBVLEJaEr83XwTzOYVsJN4s+sA0G4ODhYBVYlr
        T3xAwqICERKHd8xihCgRlDg58wnYRZwCgRKzVi5gArGZBdQl/sy7xAxhy0tsfzsHyhaXuPVk
        PtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQITwrZjP7cA
        g+ld8CFGAQ5GJR5ei+3psUKsiWXFlbmHGCU4mJVEeOd5ZMQK8aYkVlalFuXHF5XmpBYfYjQF
        +m0is5Rocj4wWeWVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamA8
        7aNil6Ll8Hj2wflTfip6/RAQ1b0xPbHw877P0VMmnLhuwh0V0f/hdXNTVF/k1YWLw1pDeno3
        Fk2wuru7MKI1jHVh+qQUj+dbz2mu1SvqbmUNPWT4mlXb2MT52eXAPnahC4lzjl7+w3DqLZ/V
        bcXGZWHV045cl5ZbEGNTX3hxHqtlQ4Sig5QSS3FGoqEWc1FxIgDxookhHgMAAA==
X-CMS-MailID: 20190830065159eucas1p2c7db5fa7dc620edecf210349fd9396f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190829173938epcas3p1276089cb3d6f9813840d1bb6cac8b1da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190829173938epcas3p1276089cb3d6f9813840d1bb6cac8b1da
References: <20190829060550.62095-1-john.stultz@linaro.org>
        <CGME20190829173938epcas3p1276089cb3d6f9813840d1bb6cac8b1da@epcas3p1.samsung.com>
        <CAF6AEGvborwLmjfC6_vgZ-ZbfvF3HEFFyb_NHSLRoYWF35bw+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.2019 19:39, Rob Clark wrote:
> On Wed, Aug 28, 2019 at 11:06 PM John Stultz <john.stultz@linaro.org> wrote:
>> Since commit 83f35bc3a852 ("drm/bridge: adv7511: Attach to DSI
>> host at probe time") landed in -next the HiKey board would fail
>> to boot, looping:
> No, please revert 83f35bc3a852.. that is going in the *complete* wrong
> direction.  We actually should be moving panels to not require dsi
> host until attach time, similar to how bridges work, not the other way
> around.


Devices of panels and bridges controlled via DSI will not appear at all
if DSI host is not created.

So this is the only direction!!!


>
> The problem is that, when dealing with bootloader enabled display, we
> need to be really careful not to touch the hardware until the display
> driver knows the bridge/panel is present.  If the bridge/panel probes
> after the display driver, we could end up killing scanout
> (efifb/simplefb).. if the bridge/panel is missing some dependency and
> never probes, it is rather unpleasant to be stuck trying to debug what
> went wrong with no display.


It has nothing to do with touching hardware, you can always (I hope)
postpone it till all components are present.

But it is just requirement of device/driver model in Linux Kernel.


>
> Sorry I didn't notice that adv7511 patch before it landed, but the
> right thing to do now is to revert it.


The 1st version of the patch was posted at the end of April and final
version was queued 1st July, so it was quite long time for discussions
and tests.

Reverting it now seems quite late, especially if the patch does right
thing and there is already proper fix for one encoder (kirin), moreover
revert will break another platforms.

Of course it seems you have different opinion what is the right thing in
this case, so if you convince us that your approach is better one can
revert the patch.


Regards

Andrzej



>
> BR,
> -R
>
>>   adv7511 2-0039: failed to find dsi host
>>
>> messages over and over. Andrzej Hajda suggested this is due to a
>> circular dependency issue, and that the adv7511 change is
>> correcting the improper order used earlier.
>>
>> Unfortunately this means the DSI drivers that use adv7511 need
>> to also need to be updated to use the proper ordering to
>> continue to work.
>>
>> This patch tries to reorder the initialization to register the
>> dsi_host first, and then call component_add via dsi_host_attach,
>> instead of doing that at probe time.
>>
>> This seems to resolve the issue with the HiKey board.
>>
>> Cc: Andrzej Hajda <a.hajda@samsung.com>
>> Cc: Matt Redfearn <matt.redfearn@thinci.com>
>> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
>> Cc: Rongrong Zou <zourongrong@gmail.com>
>> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Cc: Jonas Karlman <jonas@kwiboo.se>
>> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: David Airlie <airlied@linux.ie>,
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Cc: Sam Ravnborg <sam@ravnborg.org>
>> Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
>> Fixes: 83f35bc3a852 ("drm/bridge: adv7511: Attach to DSI host at probe time")
>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>> ---
>> Note: I'm really not super familiar with the DSI code here,
>> and am mostly just trying to refactor the existing code in a
>> similar fashion to the suggested dw-mipi-dsi-rockchip.c
>> implementation. Careful review would be greatly appreciated!
>>
>> Also there is an outstanding regression on the db410c since it
>> similarly uses the adv7511 and probably needs a similar rework.
>> ---
>>  drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 111 ++++++++++---------
>>  1 file changed, 56 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
>> index 5bf8138941de..696cee1a1219 100644
>> --- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
>> +++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
>> @@ -79,6 +79,7 @@ struct dsi_hw_ctx {
>>  };
>>
>>  struct dw_dsi {
>> +       struct device *dev;
>>         struct drm_encoder encoder;
>>         struct drm_bridge *bridge;
>>         struct mipi_dsi_host host;
>> @@ -724,51 +725,6 @@ static int dw_drm_encoder_init(struct device *dev,
>>         return 0;
>>  }
>>
>> -static int dsi_host_attach(struct mipi_dsi_host *host,
>> -                          struct mipi_dsi_device *mdsi)
>> -{
>> -       struct dw_dsi *dsi = host_to_dsi(host);
>> -
>> -       if (mdsi->lanes < 1 || mdsi->lanes > 4) {
>> -               DRM_ERROR("dsi device params invalid\n");
>> -               return -EINVAL;
>> -       }
>> -
>> -       dsi->lanes = mdsi->lanes;
>> -       dsi->format = mdsi->format;
>> -       dsi->mode_flags = mdsi->mode_flags;
>> -
>> -       return 0;
>> -}
>> -
>> -static int dsi_host_detach(struct mipi_dsi_host *host,
>> -                          struct mipi_dsi_device *mdsi)
>> -{
>> -       /* do nothing */
>> -       return 0;
>> -}
>> -
>> -static const struct mipi_dsi_host_ops dsi_host_ops = {
>> -       .attach = dsi_host_attach,
>> -       .detach = dsi_host_detach,
>> -};
>> -
>> -static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
>> -{
>> -       struct mipi_dsi_host *host = &dsi->host;
>> -       int ret;
>> -
>> -       host->dev = dev;
>> -       host->ops = &dsi_host_ops;
>> -       ret = mipi_dsi_host_register(host);
>> -       if (ret) {
>> -               DRM_ERROR("failed to register dsi host\n");
>> -               return ret;
>> -       }
>> -
>> -       return 0;
>> -}
>> -
>>  static int dsi_bridge_init(struct drm_device *dev, struct dw_dsi *dsi)
>>  {
>>         struct drm_encoder *encoder = &dsi->encoder;
>> @@ -796,10 +752,6 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
>>         if (ret)
>>                 return ret;
>>
>> -       ret = dsi_host_init(dev, dsi);
>> -       if (ret)
>> -               return ret;
>> -
>>         ret = dsi_bridge_init(drm_dev, dsi);
>>         if (ret)
>>                 return ret;
>> @@ -817,13 +769,22 @@ static const struct component_ops dsi_ops = {
>>         .unbind = dsi_unbind,
>>  };
>>
>> -static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
>> +static int dsi_host_attach(struct mipi_dsi_host *host,
>> +                          struct mipi_dsi_device *mdsi)
>>  {
>> -       struct dsi_hw_ctx *ctx = dsi->ctx;
>> -       struct device_node *np = pdev->dev.of_node;
>> -       struct resource *res;
>> +       struct dw_dsi *dsi = host_to_dsi(host);
>> +       struct device_node *np = dsi->dev->of_node;
>>         int ret;
>>
>> +       if (mdsi->lanes < 1 || mdsi->lanes > 4) {
>> +               DRM_ERROR("dsi device params invalid\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       dsi->lanes = mdsi->lanes;
>> +       dsi->format = mdsi->format;
>> +       dsi->mode_flags = mdsi->mode_flags;
>> +
>>         /*
>>          * Get the endpoint node. In our case, dsi has one output port1
>>          * to which the external HDMI bridge is connected.
>> @@ -832,6 +793,42 @@ static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
>>         if (ret)
>>                 return ret;
>>
>> +       return component_add(dsi->dev, &dsi_ops);
>> +}
>> +
>> +static int dsi_host_detach(struct mipi_dsi_host *host,
>> +                          struct mipi_dsi_device *mdsi)
>> +{
>> +       /* do nothing */
>> +       return 0;
>> +}
>> +
>> +static const struct mipi_dsi_host_ops dsi_host_ops = {
>> +       .attach = dsi_host_attach,
>> +       .detach = dsi_host_detach,
>> +};
>> +
>> +static int dsi_host_init(struct device *dev, struct dw_dsi *dsi)
>> +{
>> +       struct mipi_dsi_host *host = &dsi->host;
>> +       int ret;
>> +
>> +       host->dev = dev;
>> +       host->ops = &dsi_host_ops;
>> +       ret = mipi_dsi_host_register(host);
>> +       if (ret) {
>> +               DRM_ERROR("failed to register dsi host\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int dsi_parse_dt(struct platform_device *pdev, struct dw_dsi *dsi)
>> +{
>> +       struct dsi_hw_ctx *ctx = dsi->ctx;
>> +       struct resource *res;
>> +
>>         ctx->pclk = devm_clk_get(&pdev->dev, "pclk");
>>         if (IS_ERR(ctx->pclk)) {
>>                 DRM_ERROR("failed to get pclk clock\n");
>> @@ -862,15 +859,19 @@ static int dsi_probe(struct platform_device *pdev)
>>         }
>>         dsi = &data->dsi;
>>         ctx = &data->ctx;
>> +       dsi->dev = &pdev->dev;
>>         dsi->ctx = ctx;
>>
>>         ret = dsi_parse_dt(pdev, dsi);
>>         if (ret)
>>                 return ret;
>>
>> -       platform_set_drvdata(pdev, data);
>> +       ret = dsi_host_init(&pdev->dev, dsi);
>> +       if (ret)
>> +               return ret;
>>
>> -       return component_add(&pdev->dev, &dsi_ops);
>> +       platform_set_drvdata(pdev, data);
>> +       return 0;
>>  }
>>
>>  static int dsi_remove(struct platform_device *pdev)
>> --
>> 2.17.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


