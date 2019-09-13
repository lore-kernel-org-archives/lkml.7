Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F19C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5D7207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CNjme5Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbfIMIZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:25:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57813 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfIMIZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:25:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190913082510euoutp01c89da4f061cc94a52791f1ab9f7410bf~D8fBoDF7y0641206412euoutp01C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 08:25:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190913082510euoutp01c89da4f061cc94a52791f1ab9f7410bf~D8fBoDF7y0641206412euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568363110;
        bh=Y+70eoeOySg6zv/t1zkRpHQ8LjxlLH2L7D/4kmCRFa8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CNjme5Ku5yGrjU2AyD0qJqPvMTspzrEg3CnMtlLkd6GVqfzQdtmYf23FG2miUo593
         V8rLr2TCOJA81GetljTg+6VzUhSe2i/EMPbf6BjmXsH/+32Zw9JkkZJRbq0gA7kFHz
         prKBBWYiFDPr25aoMvYQwLFbxf9ebkOTFapksspo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190913082509eucas1p25aefda01ff4af9b0fd4b9d23d2e98a0e~D8fAtmFO-2693226932eucas1p2r;
        Fri, 13 Sep 2019 08:25:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 44.38.04469.4625B7D5; Fri, 13
        Sep 2019 09:25:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190913082508eucas1p1fe8f4a4dd962539e0831da3950f6f017~D8e-77knv1656016560eucas1p1P;
        Fri, 13 Sep 2019 08:25:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190913082508eusmtrp1bfa0be12c15e864cffef846e714258d9~D8e-6r_LY1187411874eusmtrp12;
        Fri, 13 Sep 2019 08:25:08 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-6e-5d7b52641f5f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3F.91.04117.4625B7D5; Fri, 13
        Sep 2019 09:25:08 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190913082507eusmtip1a5e208f4d2fdc951fa14515d85d2978e~D8e-Wv34X0164301643eusmtip1V;
        Fri, 13 Sep 2019 08:25:07 +0000 (GMT)
Subject: Re: [PATCH] Revert
 "drm/bridge: adv7511: Attach to DSI host at probe time"
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Matt Redfearn <matt.redfearn@thinci.com>,
        Rob Clark <robdclark@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <5b277456-2508-981c-7909-dde5f38f8ef6@samsung.com>
Date:   Fri, 13 Sep 2019 10:25:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829180836.14453-1-robdclark@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe/bcO6/WtesyPGpUDnqz1DQ/XEskKeIGfYggkMRq5W1Kvu6q
        ZUIuSJuaY2VZm/kSGVoEhe9OemFSU6yVpqaGTbK0LDN8q1lWzjvJb7/znOd/zv8Ph8KyMdKL
        ik1I4VUJiji51IWoe2az+EUfyIjaOvg8mM23tErYv3WXMNs5NSZlu358xmzr1y6CzblU7sS+
        Nt6QskZrmYQ1aSPZbtsgZodv/sRspa0WsdVVV/FOmhvryXLiitTtBPdwuozgGg39c6VGT3It
        ug4J981iceLqpwdIzppnlnDlhV1S7kl+AcEVFbwnuYmq1fvpQy6h0XxcbBqvCgg76hLT80dH
        Jk26nS5/PCJRo07XXORMARMMhX0XyFzkQsmYSgTDnz5hsZhEMPmsAInFBILSbKPTgkTX+8Uh
        qUDwVqt3SEYR6FsHsP3XCuYgvKzRSezszuyGlo5f8wrMGDFc+V4itTekzCaYre6dY4qimTCY
        nZnfQDDr4Lf2/fyclUwEjA80k3amGTdo1X8g7OzMhEBn9Z15xswaqB+9gUX2gL4PpRL7LmD0
        FHRbrpOi7d0wNFjsiLACRsw1Dl4FbQUXCZEzwVp5HotiDYLaB41YbOyAZnM7aTeK50zfNwbY
        EZhwuD6cLKIr9Iy6iRZc4XLdNSw+06DJlokzfMD6otYxzwNuv5qS6pDcsCiYYVEYw6Iwhv9r
        yxBxF3nwqUK8khcCE/hT/oIiXkhNUPofT4yvQnNn2PbHPN6ApjqOmRBDIfkymt1yJkpGKtKE
        9HgTAgrL3el9X9OjZHS0Iv0Mr0o8okqN4wUT8qYIuQedsWQgUsYoFSn8SZ5P4lULXQnl7KVG
        ruoHkfqSj6acZG+z8oTzroZwQ1a257ZOQ9HnN5lThSGr1xbLD556pHmleipV52ws3fzOz0d7
        c79hz/JN3yzVynsREVUKyluzwWdPPdedmZIS7h8UYw39e6sifCzI5t1/fL1n21Lt5hjf2JLS
        phbhbOG5XA2/d+Lw2tiZoYqmvO02OSHEKAJ9sUpQ/ANF+ZDDggMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42I5/e/4Xd2UoOpYg793+Sx6z51ksvi/bSKz
        xZWv79ksrn5/yWxx8s1VFovOiUvYLS7vmsNmsev+AiaLQ33RFtd+Pma2eL7wB7PFip9bGS02
        b5rK7MDr8f5GK7vH7IaLLB57vy1g8dg56y6Q2zGT1ePEhEtMHu/OnWP32P7tAavH/e7jTB5L
        pl1l8zjQO5nFY/bkR6wenzfJBfBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GXc+DeBteCLYMWS/a+YGhiv8HUxcnJICJhITLj5mhXEFhJYyiix
        f2o2RFxcYvf8t8wQtrDEn2tdbF2MXEA1rxkl/nzfyNLFyMEhLBAqMaGXC6RGRMBF4sSl36wg
        NcwCe5glHr24CdXQAzT06VKwSWwCmhJ/N4MkODh4Bewk/v5iBwmzCKhK/Ol7BFYiKhAhcXjH
        LEYQm1dAUOLkzCcsIDangKXElc0rwWxmAXWJP/MuMUPY8hLb386BssUlbj2ZzzSBUWgWkvZZ
        SFpmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMDo33bs55YdjF3vgg8xCnAw
        KvHwWuhUxQqxJpYVV+YeYpTgYFYS4fV5UxkrxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnA
        xJRXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoGxpyd174655S9P
        6XAtOClV2lnzadvCgwcyfbboKYUWfPA+uunc+kk9YSzHfoRs2jDvPb+9iQw/g4vE5cVWq9f4
        Fk6tevO57PGh9tfzW+6di7YLMEjQCrKdbzAz6f/029lXD8jf3cLvWbXtju0E38DVLOHJJ8xi
        2DyZt8byi2zMyOpWTawVn3BYiaU4I9FQi7moOBEAcSHrSxQDAAA=
X-CMS-MailID: 20190913082508eucas1p1fe8f4a4dd962539e0831da3950f6f017
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190829181055epcas3p3ee33cfe662517555ff0c1ce456757e7c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190829181055epcas3p3ee33cfe662517555ff0c1ce456757e7c
References: <CGME20190829181055epcas3p3ee33cfe662517555ff0c1ce456757e7c@epcas3p3.samsung.com>
        <20190829180836.14453-1-robdclark@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.2019 20:08, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> This reverts commit 83f35bc3a852f1c3892c7474998c5cec707c7ba3.
>
> This commit the wrong direction, we should really be changing panel
> framework to attach dsi host after probe, rather than introducing
> the same probe-order problem that panels already have to bridges.
>
> The reason is, that in order to deal with devices where display is
> enabled by bootloader and efifb/simplefb is used until the real
> driver probes, we need to be careful to not touch the hardware
> until we have all the pieces probed and ready to go, otherwise you
> will kill the working display, leaving yourself (at least, in the
> case of real consumer devices that do not have a debug UART) with
> no good way to debug what went wrong.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>


Applied to drm-misc-next-fixes, with changed commit message - I hope it
is OK for you.


Regards

Andrzej


> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 98bccace8c1c..f6d2681f6927 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -874,6 +874,9 @@ static int adv7511_bridge_attach(struct drm_bridge *bridge)
>  				 &adv7511_connector_helper_funcs);
>  	drm_connector_attach_encoder(&adv->connector, bridge->encoder);
>  
> +	if (adv->type == ADV7533)
> +		ret = adv7533_attach_dsi(adv);
> +
>  	if (adv->i2c_main->irq)
>  		regmap_write(adv->regmap, ADV7511_REG_INT_ENABLE(0),
>  			     ADV7511_INT0_HPD);
> @@ -1219,17 +1222,8 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>  	drm_bridge_add(&adv7511->bridge);
>  
>  	adv7511_audio_init(dev, adv7511);
> -
> -	if (adv7511->type == ADV7533) {
> -		ret = adv7533_attach_dsi(adv7511);
> -		if (ret)
> -			goto err_remove_bridge;
> -	}
> -
>  	return 0;
>  
> -err_remove_bridge:
> -	drm_bridge_remove(&adv7511->bridge);
>  err_unregister_cec:
>  	i2c_unregister_device(adv7511->i2c_cec);
>  	if (adv7511->cec_clk)


