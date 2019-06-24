Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC0BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76810208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HpQk+AtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbfFXNkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:40:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34069 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfFXNkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:40:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190624134028euoutp02ad1aed1165d7cbb26adc48cadeb500fa~rJiMgwlFi0938009380euoutp02f
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:40:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190624134028euoutp02ad1aed1165d7cbb26adc48cadeb500fa~rJiMgwlFi0938009380euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561383628;
        bh=IpOffWBEcsmvOjWrflqytuSG0fGuguzvr6XW+DeI5A8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HpQk+AtLWrzJ/oWiI0RFRKLGIjA5/P3BJqBl8ipdW95YO0tJI07MVDSxNJ1JRC2JX
         wHQew5kdZiS/cFjQ+MIcjBoGUWjfVFkiJiK1cVQBLglqXayQ1chVfv4RYcEXU7jcQF
         vgceMg6w/hUVSlcG1neXOUx3x9TSlvaYmlQlF57c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190624134027eucas1p18adcffc00b518214506747be8d733370~rJiL6Ri2u1012610126eucas1p1n;
        Mon, 24 Jun 2019 13:40:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E5.8A.04325.BC2D01D5; Mon, 24
        Jun 2019 14:40:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190624134026eucas1p216d1f0f0b345f4afb1726cd75e05899a~rJiLK33542401124011eucas1p2J;
        Mon, 24 Jun 2019 13:40:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190624134026eusmtrp1d58682998059deffd4c1ee948029228f~rJiK8sxti3152831528eusmtrp1T;
        Mon, 24 Jun 2019 13:40:26 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-2a-5d10d2cb37dd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BC.05.04140.AC2D01D5; Mon, 24
        Jun 2019 14:40:26 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190624134025eusmtip1b9789649ed48a042dc558d30915240bc~rJiKTlzaG0889508895eusmtip1M;
        Mon, 24 Jun 2019 13:40:25 +0000 (GMT)
Subject: Re: [PATCH 1/4] drm/bridge: dw-hdmi: Add Dynamic Range and
 Mastering InfoFrame support
To:     Jonas Karlman <jonas@kwiboo.se>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>
Cc:     "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "wens@csie.org" <wens@csie.org>,
        "hjc@rock-chips.com" <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <a832e26c-811b-7e75-abe9-7c2cdeeb72fb@samsung.com>
Date:   Mon, 24 Jun 2019 15:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <VI1PR03MB4206B9AF66443E35946BD000AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRj13b3brqvJ69J80DIaCGmURv64UEll0P1R5K+yzPRWF4t01qb2
        IZKi2TIrK6G81ibadH2AZmppH8qMViwzNT+LZmKZlo3SKWbLvF4l/533nPM8zznwUoSqS+pL
        HdYkcVoNG6+WKciaFxNvVtlacXRI7i8l/c7pkNFTfd+k9M0raXT7+CBBv/reTtITZ6sk9LnL
        t+R0W90NGd07WI9oy8UoesLSLKHLs4I3LmQcXWfkjOFeKlPRd1fKFOoLpMzLvFYJYz9vlTAu
        vp5kGi5cJZmHHQaCGan0j1DsUaw/yMUfTuG0wWGxikMX28bkR4ujT9gap8h01LM1B7lTgEPB
        WG6W5SAFpcJmBO9LHYQgqPAogt/8ClEYQfBxNJ+cm3DV2mYnyhAYDGek4mMYQebnPrngWoRZ
        MPe3yATshTVgdBlmeALnkXB7bJuAZTgQXA+6ZzxKHAaPR+wzmMQB8GjQKhGwN46E0dpKJHo8
        4VVB/0wKdxwNz+1ZhLhzGWRWF85iH+jpN0qEQIB/yuHpHatUjL0FjDXtMhEvgiFrlVzES8B2
        NXe22mmwm4WlwrAeQXVFLSEK66DR2jK9iJq+EAjldcEivQn0rgyJQAP2gK5hTzGDB1ypuUaI
        tBL02SrRvRzsTdWzC33A9NYpy0Nqfl4zfl4bfl4b/v/dIkTeQT5csi4hjtOt1XDHV+vYBF2y
        Jm71gcSESjT932x/rc5H6Nmf/RaEKaReqCx6jqNVUjZFdzLBgoAi1F5KEztNKQ+yJ09x2sQY
        bXI8p7MgP4pU+yhT3XqjVDiOTeKOcNxRTjunSih333SEA5ZrF2RkNxWYXvPGjqndjakrx8Z/
        HPPb3PnWYXMOFN03dY+Fx5b611kiVbebQ9c40kqUcYGXokI61RFl+p1PPrHh2n1BqebOpSvN
        vHMH4dbOE18HSm3fTJE5bah48vqGvi8e3i559YdJ4+L4n/kxLV0lDe6+Ay+aNm2v2rV3SE3q
        DrFrggitjv0HcObuImsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7qnLgnEGkzdL2Fx5et7Nov/j16z
        WsydVGtx9ftLZouTb66yWPxs38Jk0TlxCbvF5V1z2CwevNzPaHGoL9ri56HzTBbrW/QdeDze
        32hl95i3ptpjw6PVrB6zO2ayepyYcInJ4373cSaPv7P2s3gc6J3M4rH92jxmj8+b5AK4ovRs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy+i5/Yy9Y
        FFtx+vB/lgbGW+5djJwcEgImEn93nmbrYuTiEBJYyijxcvlddoiEuMTu+W+ZIWxhiT/XuqCK
        XjNKHJzaBVYkLJAose3GOrAiEYE8iVm354AVMQtMYJHYt/cJVEczk8Se99tYQarYBDQl/m6+
        yQZi8wrYSez+fB/MZhFQldjx8jgTiC0qECExe1cDC0SNoMTJmU/AbE6BWIkj91vAtjELqEv8
        mXcJypaXaN46G8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL
        89L1kvNzNzECo3rbsZ9bdjB2vQs+xCjAwajEw7vgiECsEGtiWXFl7iFGCQ5mJRHepYlAId6U
        xMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HJpy8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6Ykl
        qdmpqQWpRTB9TBycUg2MJcWXrolcPpTWbFp44P7a/89Tyu+0513/Kjm9cbd8KmO8Ym+y0vTQ
        m8v4ZrqUdc3qdDiV6J204uRZvp111j1LXqmqZV+s3xd7IuBwrOtkR6dJjzT/JF59Mzmk5Jd4
        TVrbqp+sE/MvSN//tlv99hqn+YzX5gjbWTbvnBnvv2rF+z8LCkN8gzXylViKMxINtZiLihMB
        yoq4+AADAAA=
X-CMS-MailID: 20190624134026eucas1p216d1f0f0b345f4afb1726cd75e05899a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190526211953epcas3p1bd805a9edcfe8349cd234c92f538340d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190526211953epcas3p1bd805a9edcfe8349cd234c92f538340d
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
        <CGME20190526211953epcas3p1bd805a9edcfe8349cd234c92f538340d@epcas3p1.samsung.com>
        <VI1PR03MB4206B9AF66443E35946BD000AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.05.2019 23:19, Jonas Karlman wrote:
> Add support for configuring Dynamic Range and Mastering InfoFrame from
> the hdr_output_metadata connector property.
>
> This patch adds a drm_infoframe flag to dw_hdmi_plat_data that platform drivers
> use to signal when Dynamic Range and Mastering infoframes is supported.
> This flag is needed because Amlogic GXBB and GXL report same DW-HDMI version,
> and only GXL support DRM InfoFrame.
>
> These changes were based on work done by Zheng Yang <zhengyang@rock-chips.com>
> to support DRM InfoFrame on the Rockchip 4.4 BSP kernel at [1] and [2]
>
> [1] https://github.com/rockchip-linux/kernel/tree/develop-4.4
> [2] https://github.com/rockchip-linux/kernel/commit/d1943fde81ff41d7cca87f4a42f03992e90bddd5
>
> Cc: Zheng Yang <zhengyang@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 109 ++++++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  37 ++++++++
>  include/drm/bridge/dw_hdmi.h              |   1 +
>  3 files changed, 147 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 284ce59be8f8..801bbbd732fd 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -24,6 +24,7 @@
>  
>  #include <drm/drm_of.h>
>  #include <drm/drmP.h>
> +#include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_encoder_slave.h>
> @@ -1592,6 +1593,78 @@ static void hdmi_config_vendor_specific_infoframe(struct dw_hdmi *hdmi,
>  			HDMI_FC_DATAUTO0_VSD_MASK);
>  }
>  
> +#define HDR_LSB(n) ((n) & 0xff)
> +#define HDR_MSB(n) (((n) & 0xff00) >> 8)
> +
> +static void hdmi_config_drm_infoframe(struct dw_hdmi *hdmi)
> +{
> +	const struct drm_connector_state *conn_state = hdmi->connector.state;
> +	struct hdmi_drm_infoframe frame;
> +	int ret;
> +
> +	if (hdmi->version < 0x200a || !hdmi->plat_data->drm_infoframe)


Why do we need this double check? Here and in dw_hdmi_bridge_attach.

Wouldn't be enough to test drm_infoframe?


> +		return;
> +
> +	hdmi_modb(hdmi, HDMI_FC_PACKET_TX_EN_DRM_DISABLE,
> +		  HDMI_FC_PACKET_TX_EN_DRM_MASK, HDMI_FC_PACKET_TX_EN);
> +
> +	ret = drm_hdmi_infoframe_set_hdr_metadata(&frame, conn_state);
> +	if (ret < 0)
> +		return;
> +
> +	ret = hdmi_drm_infoframe_check(&frame);
> +	if (WARN_ON(ret))
> +		return;
> +
> +	hdmi_writeb(hdmi, frame.version, HDMI_FC_DRM_HB0);
> +	hdmi_writeb(hdmi, frame.length, HDMI_FC_DRM_HB1);
> +	hdmi_writeb(hdmi, frame.eotf, HDMI_FC_DRM_PB0);
> +	hdmi_writeb(hdmi, frame.metadata_type, HDMI_FC_DRM_PB1);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.display_primaries[0].x),
> +		    HDMI_FC_DRM_PB2);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.display_primaries[0].x),
> +		    HDMI_FC_DRM_PB3);


Adding two-byte version hdmi_writew would allow to remove multiple lines
here, but since register names and their relative location reflects
structure of raw frame you should be able to replace this
long/boring/error-prone sequence of writes with something like:

len = hdmi_infoframe_pack(frame, buf, len);

if (len < 0)

    ...

for (i = 0; i < len; ++i)

    hdmi_writeb(hdmi, buf[i], HDMI_FC_DRM_HB0 + i);


... or something similar.


> +	hdmi_writeb(hdmi, HDR_LSB(frame.display_primaries[0].y),
> +		    HDMI_FC_DRM_PB4);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.display_primaries[0].y),
> +		    HDMI_FC_DRM_PB5);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.display_primaries[1].x),
> +		    HDMI_FC_DRM_PB6);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.display_primaries[1].x),
> +		    HDMI_FC_DRM_PB7);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.display_primaries[1].y),
> +		    HDMI_FC_DRM_PB8);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.display_primaries[1].y),
> +		    HDMI_FC_DRM_PB9);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.display_primaries[2].x),
> +		    HDMI_FC_DRM_PB10);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.display_primaries[2].x),
> +		    HDMI_FC_DRM_PB11);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.display_primaries[2].y),
> +		    HDMI_FC_DRM_PB12);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.display_primaries[2].y),
> +		    HDMI_FC_DRM_PB13);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.white_point.x), HDMI_FC_DRM_PB14);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.white_point.x), HDMI_FC_DRM_PB15);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.white_point.y), HDMI_FC_DRM_PB16);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.white_point.y), HDMI_FC_DRM_PB17);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.max_display_mastering_luminance),
> +		    HDMI_FC_DRM_PB18);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.max_display_mastering_luminance),
> +		    HDMI_FC_DRM_PB19);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.min_display_mastering_luminance),
> +		    HDMI_FC_DRM_PB20);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.min_display_mastering_luminance),
> +		    HDMI_FC_DRM_PB21);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.max_cll), HDMI_FC_DRM_PB22);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.max_cll), HDMI_FC_DRM_PB23);
> +	hdmi_writeb(hdmi, HDR_LSB(frame.max_fall), HDMI_FC_DRM_PB24);
> +	hdmi_writeb(hdmi, HDR_MSB(frame.max_fall), HDMI_FC_DRM_PB25);
> +	hdmi_writeb(hdmi, 1, HDMI_FC_DRM_UP);
> +	hdmi_modb(hdmi, HDMI_FC_PACKET_TX_EN_DRM_ENABLE,
> +		  HDMI_FC_PACKET_TX_EN_DRM_MASK, HDMI_FC_PACKET_TX_EN);
> +}
> +
>  static void hdmi_av_composer(struct dw_hdmi *hdmi,
>  			     const struct drm_display_mode *mode)
>  {
> @@ -1963,6 +2036,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
>  		/* HDMI Initialization Step F - Configure AVI InfoFrame */
>  		hdmi_config_AVI(hdmi, mode);
>  		hdmi_config_vendor_specific_infoframe(hdmi, mode);
> +		hdmi_config_drm_infoframe(hdmi);
>  	} else {
>  		dev_dbg(hdmi->dev, "%s DVI mode\n", __func__);
>  	}
> @@ -2139,6 +2213,36 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>  	return ret;
>  }
>  
> +static bool blob_equal(const struct drm_property_blob *a,
> +		       const struct drm_property_blob *b)


Quite generic function, but since there are no other users(?) it can
stay here.


> +{
> +	if (a && b)
> +		return a->length == b->length &&
> +			!memcmp(a->data, b->data, a->length);
> +
> +	return !a == !b;


Ugly code (but it is probably matter of taste), maybe sth like this:

    if (!a || !b)

        return a != b;

    if (a->length != b->length)

        return false;

    return !memcmp(a->data, b->data, a->length);


> +}
> +
> +static int dw_hdmi_connector_atomic_check(struct drm_connector *conn,
> +	struct drm_connector_state *new_state)
> +{
> +	struct drm_connector_state *old_state =
> +		drm_atomic_get_old_connector_state(new_state->state, conn);
> +	struct drm_crtc_state *crtc_state;
> +
> +	if (!new_state->crtc)
> +		return 0;
> +
> +	crtc_state = drm_atomic_get_new_crtc_state(new_state->state,
> +						   new_state->crtc);
> +
> +	if (!blob_equal(new_state->hdr_output_metadata,
> +			old_state->hdr_output_metadata))
> +		crtc_state->mode_changed = true;
> +
> +	return 0;
> +}
> +
>  static void dw_hdmi_connector_force(struct drm_connector *connector)
>  {
>  	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
> @@ -2163,6 +2267,7 @@ static const struct drm_connector_funcs dw_hdmi_connector_funcs = {
>  
>  static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs = {
>  	.get_modes = dw_hdmi_connector_get_modes,
> +	.atomic_check = dw_hdmi_connector_atomic_check,
>  };
>  
>  static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
> @@ -2179,6 +2284,10 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
>  	drm_connector_init(bridge->dev, connector, &dw_hdmi_connector_funcs,
>  			   DRM_MODE_CONNECTOR_HDMIA);
>  
> +	if (hdmi->version >= 0x200a && hdmi->plat_data->drm_infoframe)
> +		drm_object_attach_property(&connector->base,
> +			connector->dev->mode_config.hdr_output_metadata_property, 0);
> +
>  	drm_connector_attach_encoder(connector, encoder);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> index 3f3c616eba97..d4efbec14f68 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
> @@ -256,6 +256,7 @@
>  #define HDMI_FC_POL2                            0x10DB
>  #define HDMI_FC_PRCONF                          0x10E0
>  #define HDMI_FC_SCRAMBLER_CTRL                  0x10E1
> +#define HDMI_FC_PACKET_TX_EN                    0x10E3
>  
>  #define HDMI_FC_GMD_STAT                        0x1100
>  #define HDMI_FC_GMD_EN                          0x1101
> @@ -291,6 +292,37 @@
>  #define HDMI_FC_GMD_PB26                        0x111F
>  #define HDMI_FC_GMD_PB27                        0x1120
>  
> +#define HDMI_FC_DRM_UP                          0x1167
> +#define HDMI_FC_DRM_HB0                         0x1168
> +#define HDMI_FC_DRM_HB1                         0x1169
> +#define HDMI_FC_DRM_PB0                         0x116A
> +#define HDMI_FC_DRM_PB1                         0x116B
> +#define HDMI_FC_DRM_PB2                         0x116C
> +#define HDMI_FC_DRM_PB3                         0x116D
> +#define HDMI_FC_DRM_PB4                         0x116E
> +#define HDMI_FC_DRM_PB5                         0x116F
> +#define HDMI_FC_DRM_PB6                         0x1170
> +#define HDMI_FC_DRM_PB7                         0x1171
> +#define HDMI_FC_DRM_PB8                         0x1172
> +#define HDMI_FC_DRM_PB9                         0x1173
> +#define HDMI_FC_DRM_PB10                        0x1174
> +#define HDMI_FC_DRM_PB11                        0x1175
> +#define HDMI_FC_DRM_PB12                        0x1176
> +#define HDMI_FC_DRM_PB13                        0x1177
> +#define HDMI_FC_DRM_PB14                        0x1178
> +#define HDMI_FC_DRM_PB15                        0x1179
> +#define HDMI_FC_DRM_PB16                        0x117A
> +#define HDMI_FC_DRM_PB17                        0x117B
> +#define HDMI_FC_DRM_PB18                        0x117C
> +#define HDMI_FC_DRM_PB19                        0x117D
> +#define HDMI_FC_DRM_PB20                        0x117E
> +#define HDMI_FC_DRM_PB21                        0x117F
> +#define HDMI_FC_DRM_PB22                        0x1180
> +#define HDMI_FC_DRM_PB23                        0x1181
> +#define HDMI_FC_DRM_PB24                        0x1182
> +#define HDMI_FC_DRM_PB25                        0x1183
> +#define HDMI_FC_DRM_PB26                        0x1184
> +
>  #define HDMI_FC_DBGFORCE                        0x1200
>  #define HDMI_FC_DBGAUD0CH0                      0x1201
>  #define HDMI_FC_DBGAUD1CH0                      0x1202
> @@ -746,6 +778,11 @@ enum {
>  	HDMI_FC_PRCONF_OUTPUT_PR_FACTOR_MASK = 0x0F,
>  	HDMI_FC_PRCONF_OUTPUT_PR_FACTOR_OFFSET = 0,
>  
> +/* FC_PACKET_TX_EN field values */
> +	HDMI_FC_PACKET_TX_EN_DRM_MASK = 0x80,
> +	HDMI_FC_PACKET_TX_EN_DRM_ENABLE = 0x80,
> +	HDMI_FC_PACKET_TX_EN_DRM_DISABLE = 0x00,
> +
>  /* FC_AVICONF0-FC_AVICONF3 field values */
>  	HDMI_FC_AVICONF0_PIX_FMT_MASK = 0x03,
>  	HDMI_FC_AVICONF0_PIX_FMT_RGB = 0x00,
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 0f0e82638fbe..04d1ec60f218 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -131,6 +131,7 @@ struct dw_hdmi_plat_data {
>  	unsigned long input_bus_format;
>  	unsigned long input_bus_encoding;
>  	bool ycbcr_420_allowed;
> +	bool drm_infoframe;


maybe sth less confusing, for example: use_drm_infoframe?


Regards

Andrzej



>  
>  	/* Vendor PHY support */
>  	const struct dw_hdmi_phy_ops *phy_ops;


