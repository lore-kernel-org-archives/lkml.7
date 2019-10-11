Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B41EECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C950F2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FkciRwiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfJKHd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 03:33:58 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47230 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:33:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191011073356euoutp0199af82cd4996db7ff3bf637ade81d207~Mh2Sz4Si13246132461euoutp01X
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:33:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191011073356euoutp0199af82cd4996db7ff3bf637ade81d207~Mh2Sz4Si13246132461euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570779236;
        bh=0cRp63auWCMeQJ0hBCZd2uWeAtjJbMYTxVjcpcdjMRs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FkciRwiuU4wRzf9qxvWF8EMo05i0be65xgB1zeHW/Zy01elllAEzAevEDcwGgwhA7
         XLUfPvguAfSUkU+DcRxK1vjQLlSG6VQ8GPkCJg0J49LnrHQl+V5ZnDWwTF6KChfHAx
         UJBUpp7wFlM431P2M3e/0pr7+zsItTOlLlgesQoY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191011073356eucas1p29466f4daa169253abfc64700e8ace83f~Mh2SiP1jS2249122491eucas1p2z;
        Fri, 11 Oct 2019 07:33:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BD.92.04469.46030AD5; Fri, 11
        Oct 2019 08:33:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191011073355eucas1p1b0986792eed078f66c9711b844c5e48b~Mh2SLH-tD2821628216eucas1p1V;
        Fri, 11 Oct 2019 07:33:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191011073355eusmtrp17151d3307fceb5f0072a8cfd149aa988~Mh2SKV3DD0118301183eusmtrp1C;
        Fri, 11 Oct 2019 07:33:55 +0000 (GMT)
X-AuditID: cbfec7f2-569ff70000001175-6c-5da03064d2d0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 71.DE.04166.36030AD5; Fri, 11
        Oct 2019 08:33:55 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191011073355eusmtip1237d7101a2ecb708f649650105fb8614~Mh2Rm0jpK0683006830eusmtip1O;
        Fri, 11 Oct 2019 07:33:55 +0000 (GMT)
Subject: Re: [PATCH v2] drm: bridge: adv7511: Enable SPDIF DAI
To:     Bogdan Togorean <bogdan.togorean@analog.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, allison@lohutok.net, tglx@linutronix.de,
        rfontana@redhat.com, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b3ab3f90-6657-a58b-e022-c23d0e412d27@samsung.com>
Date:   Fri, 11 Oct 2019 09:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191007100641.25599-1-bogdan.togorean@analog.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju23d2dlxbns1qHxZFq34YlQpBBxMpuh36Fd0oReqUJxOdyo6X
        7EJRGjrb8JK3aWmWpmVo3pWU0kjFHJWOdJFTdEVrZmazG2rbziT/Pe/7PM/3Pg98BJRbhN5E
        RHQcq45mopS4GGt8+duwJcyvJNTvb5WM0hp6BFRl9xxGXUu5Ban5xkxIDdgnccr48zOkemxG
        jErLvC+i+luLcKpDF0I9HauGVF1tDtwpoa3GXfTkYIqIbpspwejC1AIh3Z3xVkB/NRhEdNPM
        iJA2p3cJ6CnbuIiebDfi9DNtNkZP1645KAkWB4axUREJrNo36JT4XFX5KIy9ITv/XKPDrwKr
        VAM8CERuQ7deaDENEBNysgKg6pwinB9+AJSX3ORmph3DtzbBguVu2wDkiQcAFVc9d6smABod
        aIROlRcZhDJ1LS7HcvIwsk9lu0TQKbL0TrgInPRBs3VDuBNLHYac1nsujJEbUe6wRagBBLGC
        PI567QwvkaGegnHMiT3IneiXKdMlh+RadL2hEPJYgUzjxQLnLUSmEei28bo79h6kmW8HPPZC
        1q56EY9Xo97smxiPryBzRTLkzakANdS0QJ7YgTq73rgCQUfo6lZffr0LmVI6oXONyGVocELG
        Z1iGshrz3GspSr0h59XrkLmvwf2gApW9tuMZQKlf1Ey/qI1+URv9/7slAHsIFGw8pwpnOf9o
        NnErx6i4+OjwrWdiVLXA8fl657q+NwP729MdgCSAUiLNX1scKhcyCVySqgMgAiqXS0v1RaFy
        aRiTdIFVx5xUx0exXAdYRWBKhfTikpEQORnOxLGRLBvLqhdYAeHhfRXg+3+ceLz33W8/GGwb
        zo8aMq9f2v/ZJJa1z3AbAx71zfpXXrQeOQxRgGrln9JhW6AgYUXNt7HIfQrPYxZa9zEx/ax+
        83v7ZMQTQ9aBL20hPpakDXe+x+7WZ6w5WnZo7pOkXru9EGuS+F76UJ4bp/NhL3e+qvnb7NnU
        3T4V6Ls9NFiJcecY/01QzTH/ADiF8PF4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xu7rJBgtiDZaeNrfoPXeSyWLliX8s
        Fk2tU5gt/m+byGxx5et7Nour318yW5x8c5XFonPiEnaLy7vmsFkc6ou22PN4PbPF5k1TmR14
        PF5ddfR4f6OV3WPvtwUsHrM7ZrJ6nJhwicnj3blz7B7bvz1g9bjffZzJ4+ObJ+we7/ddZfM4
        0DuZxePzJrkAnig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jDXLHjIXtAlWHOzqY2tgfMXbxcjJISFgIrFw7xVmEFtIYCmjxIaZMRBxcYnd898y
        Q9jCEn+udbF1MXIB1bxmlHgyaxFYQljATmJi304mEFtEIFji498b7CBFzAJvGSUeHWllguiY
        zChx4dBcNpAqNgFNib+bb4LZvEDdU3ctBrNZBFQlpt17ygpiiwpESDzffoMRokZQ4uTMJywg
        NqeAg8SPWxPB6pkF1CX+zLvEDGHLSzRvnQ1li0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZV
        jCKppcW56bnFhnrFibnFpXnpesn5uZsYgbG+7djPzTsYL20MPsQowMGoxMP7QXF+rBBrYllx
        Ze4hRgkOZiUR3kWz5sQK8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wDeWVxBuaGppbWBqa
        G5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamDs7VLo6FI8W/uXIVH19dsDUstn7lWM
        tuRUueT/tobhwr4ej7WT9p+qfW/0Uj44ivO33/rVASfznk+/lfG2f+eLK+dX9Sbnbpju2Plv
        S5LZ1n2ej6tr+VjMvp9nmz2p23d70zH7fQbPn79fzJLJHbFt/Ubu7xrZc3zc5gb5e0dEuEg/
        Pr7nhfw2JZbijERDLeai4kQAxHwoKgsDAAA=
X-CMS-MailID: 20191011073355eucas1p1b0986792eed078f66c9711b844c5e48b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191007100945epcas2p15319b2e323c67b9ed8a5a4f56f5f7e7a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191007100945epcas2p15319b2e323c67b9ed8a5a4f56f5f7e7a
References: <CGME20191007100945epcas2p15319b2e323c67b9ed8a5a4f56f5f7e7a@epcas2p1.samsung.com>
        <20191007100641.25599-1-bogdan.togorean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.10.2019 12:06, Bogdan Togorean wrote:
> ADV7511 support I2S or SPDIF as audio input interfaces. This commit
> enable support for SPDIF.
>
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


Let's wait few days with queuing, with hope somebody will test it.


 --
Regards
Andrzej


> ---
>
> Changes in v2:
> - add forgotten break statement
>
>  drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> index a428185be2c1..1e9b128d229b 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> @@ -119,6 +119,9 @@ int adv7511_hdmi_hw_params(struct device *dev, void *data,
>  		audio_source = ADV7511_AUDIO_SOURCE_I2S;
>  		i2s_format = ADV7511_I2S_FORMAT_LEFT_J;
>  		break;
> +	case HDMI_SPDIF:
> +		audio_source = ADV7511_AUDIO_SOURCE_SPDIF;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -175,11 +178,21 @@ static int audio_startup(struct device *dev, void *data)
>  	/* use Audio infoframe updated info */
>  	regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(1),
>  				BIT(5), 0);
> +	/* enable SPDIF receiver */
> +	if (adv7511->audio_source == ADV7511_AUDIO_SOURCE_SPDIF)
> +		regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG,
> +				   BIT(7), BIT(7));
> +
>  	return 0;
>  }
>  
>  static void audio_shutdown(struct device *dev, void *data)
>  {
> +	struct adv7511 *adv7511 = dev_get_drvdata(dev);
> +
> +	if (adv7511->audio_source == ADV7511_AUDIO_SOURCE_SPDIF)
> +		regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG,
> +				   BIT(7), 0);
>  }
>  
>  static int adv7511_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
> @@ -213,6 +226,7 @@ static const struct hdmi_codec_pdata codec_data = {
>  	.ops = &adv7511_codec_ops,
>  	.max_i2s_channels = 2,
>  	.i2s = 1,
> +	.spdif = 1,
>  };
>  
>  int adv7511_audio_init(struct device *dev, struct adv7511 *adv7511)


