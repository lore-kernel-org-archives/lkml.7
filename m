Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9573CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A038205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZbN5WId2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407862AbfFLHCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:02:14 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37037 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404851AbfFLHCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:02:14 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190612070212euoutp0297e2c067b46f500981691abe4e7ba87e~nYXDAtwDo2757827578euoutp02Z
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:02:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190612070212euoutp0297e2c067b46f500981691abe4e7ba87e~nYXDAtwDo2757827578euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560322932;
        bh=CzNp08rqtjUdtpSyrEtzVUY/SAEVmfbKxjuvR5Yj+bQ=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=ZbN5WId2X6++zBiesiBWi/5d4YCU9O3gTip6EHqr7gNkBvaXVvMTh/1dr5rLuSr5T
         EDpqZ6sSuy3od4pDEjeTuWXdJ8tVUCDK+S/iuPH9ka+/FkWWlSdpUWRTc0JTksQS/p
         5OHBSMR9oJkHs4L0Mdf3XXX77kVcX6RVLd3hmu/c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190612070211eucas1p290dbd703c3d9d40387004e84dbef065a~nYXCDpzPA1264012640eucas1p2V;
        Wed, 12 Jun 2019 07:02:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9C.FC.04325.373A00D5; Wed, 12
        Jun 2019 08:02:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190612070210eucas1p1c478fb74744a81095b654074651b5dd5~nYXBMLbMm2813128131eucas1p1K;
        Wed, 12 Jun 2019 07:02:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190612070210eusmtrp17641ccec4451dd6e634e189978a47937~nYXA9Sspi2934629346eusmtrp1K;
        Wed, 12 Jun 2019 07:02:10 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-0f-5d00a3737ff4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.D3.04140.273A00D5; Wed, 12
        Jun 2019 08:02:10 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190612070209eusmtip2695dd495424d2e34bf27f04da35fb7f6~nYXAVbKIy0779107791eusmtip2L;
        Wed, 12 Jun 2019 07:02:09 +0000 (GMT)
Subject: Re: [PATCH v1 2/2] drm/stm: dsi: add power on/off phy ops
To:     =?UTF-8?Q?Yannick_Fertr=c3=a9?= <yannick.fertre@st.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <91abfd99-1737-33bb-77aa-2bf1f076cebd@samsung.com>
Date:   Wed, 12 Jun 2019 09:02:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1558952499-15418-3-git-send-email-yannick.fertre@st.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURiFuZ2lA1ocC4ZfUdEmxKixuD2MG3GLGXxQEzVRlGiFCRLWdChu
        DzaiWKrIohFpCWhotRKNUmy1KghTQ4MsggLiCtG6xAZ9QKpEKzIZiLx995xz73/+5FKYMkDM
        oFIysjlthiZNRYbgzqbh9kV8VVDCYk91FFPQ3ixjarwtiDkhPCGZEWcxxnQNfR+l9z6CyS+2
        yBn7hx6CeX6/nGSMPV6CqQjcJBjr72+I6T/5hWBsww7EtHY34Mzp/FPkWpqt81/GWZfprZw1
        G8oI9k3PQ5K96+8n2L4zHhlbaznOWi52k2zA9Ahn7/ZUYGxj/RL24686jB20z96miA9ZncSl
        peRw2pjY/SEHA0+q5FlFoYc97qsyPRImGVEwBfRyqCs7TxpRCKWkbQgKBYtMNJT0DwSVt6Il
        YxCBwVgtG78x8MKGScY1BO+aenHpMIDA+SwXiakwej34CqvkohFOlxPQWP6TEA2Sng+B2pek
        yAo6FvS1LlxknI4G86tCucjT6F3ww2VHUmYqNJd5RzMUFUxvgpv6laKM0VGQ6zBjEkfAK2+l
        TJwF9BUKyn41klLVjWAt8BMSh8FXzx25xDOh5fxZXOLj0Gc7iUmXDQgct12YZKwCt6eTEAdj
        o6Vv3Y+R5HVQYLuAiTLQodA7MFXqEAolztIxWQGGPKWUngt9bY6xByPA2jE01oyFgfoarAjN
        NU1Y0jRhM9OEzUz/O1xGeDWK4HR8ejLHL8vgDql5TTqvy0hWJ2am29Hop2z56xm6h+r/HBAQ
        TSHVZEVD6cheJaHJ4Y+kCwgoTBWuWJoalKBUJGmOHOW0mfu0ujSOF1AkhasiFMeC+vco6WRN
        NpfKcVmcdtyVUcEz9Gi6jQ/v2M7kRCe1YVMcvU61a8Hn3Su215Xc+Zlr6zJ25VmrWgKtNwTB
        9nrniDPSgK3xb7YShksB+7MNk9YUs3HZ12Wfkn3nvgkJW5J06n03dmx1U4kV8U2oZtac0j73
        YPw9y9PH5+YFLA9OUCX+hebhed2dvnyHpSK3KK7E2a3C+YOaJQswLa/5BzT0cTCQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42I5/e/4Pd2ixQyxBnf/KFn0njvJZLHxyWlG
        i6ZDp9gs/m+byGxx5et7IOvRa1aLzolL2C02Pb7GanF51xw2i65rT1gt5v1dy2qx9Pc7RosH
        LS9YLVb83MpocebqARaL9s5WNgcBj73fFrB47Jx1l91jdsdMVo871/aweWz/9oDV4373cSaP
        zUvqPZZMu8rm8XfWfhaP7dfmMXsc3Gfo8fTHXmaPz5vkAnij9GyK8ktLUhUy8otLbJWiDS2M
        9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DL+nlrMXjCBr+L44WVMDYyHuLsYOTkk
        BEwk3l5fwdzFyMUhJLCUUeLx9nmsEAlxid3z3zJD2MISf651sUEUvWaUOH3zJgtIQljASeJ1
        /2J2kISIwAJWibarvYwQVVcZJeYfvAVWxSagKfF38002EJtXwE6iYfNOsDiLgKrE7Fv97CC2
        qECExOxdDSwQNYISJ2c+AbI5ODgF3CTWNliBhJkF1CX+zLvEDGHLSzRvnQ1li0vcejKfaQKj
        4Cwk3bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgUlg27GfW3Ywdr0L
        PsQowMGoxMN7YPr/GCHWxLLiytxDjBIczEoivEbZDLFCvCmJlVWpRfnxRaU5qcWHGE2BfpvI
        LCWanA9MUHkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhjzos7u
        +BT9tshr/m1prc5HXzij5PhecEjM3LzQ+4DNP3OeL/MnLdfVN6hguO0SGvX12IfqB/FKn5Qc
        4orZCs8JqmgVSuTfuNQzd51P2AP+t7EzYjW2aqVMq3KYFb2f58q+fb/S69V+bTl6hDcpN7Dc
        w/prdiPzVJt/Hz7dL5u/fvfK63YKF+2UWIozEg21mIuKEwHedbClGAMAAA==
X-CMS-MailID: 20190612070210eucas1p1c478fb74744a81095b654074651b5dd5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190527102223epcas1p2c69f1e7cf18cd08f7184b0e0b6cf5837
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190527102223epcas1p2c69f1e7cf18cd08f7184b0e0b6cf5837
References: <1558952499-15418-1-git-send-email-yannick.fertre@st.com>
        <CGME20190527102223epcas1p2c69f1e7cf18cd08f7184b0e0b6cf5837@epcas1p2.samsung.com>
        <1558952499-15418-3-git-send-email-yannick.fertre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.05.2019 12:21, Yannick Fertré wrote:
> These new physical operations are helpful to power_on/off the dsi
> wrapper. If the dsi wrapper is powered in video mode, the display
> controller (ltdc) register access will hang when DSI fifos are full.
>
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


 --
Regards
Andrzej


> ---
>  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> index 01db020..0ab32fe 100644
> --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> @@ -210,10 +210,27 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
>  	if (ret)
>  		DRM_DEBUG_DRIVER("!TIMEOUT! waiting PLL, let's continue\n");
>  
> +	return 0;
> +}
> +
> +static void dw_mipi_dsi_phy_power_on(void *priv_data)
> +{
> +	struct dw_mipi_dsi_stm *dsi = priv_data;
> +
> +	DRM_DEBUG_DRIVER("\n");
> +
>  	/* Enable the DSI wrapper */
>  	dsi_set(dsi, DSI_WCR, WCR_DSIEN);
> +}
>  
> -	return 0;
> +static void dw_mipi_dsi_phy_power_off(void *priv_data)
> +{
> +	struct dw_mipi_dsi_stm *dsi = priv_data;
> +
> +	DRM_DEBUG_DRIVER("\n");
> +
> +	/* Disable the DSI wrapper */
> +	dsi_clear(dsi, DSI_WCR, WCR_DSIEN);
>  }
>  
>  static int
> @@ -287,6 +304,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
>  
>  static const struct dw_mipi_dsi_phy_ops dw_mipi_dsi_stm_phy_ops = {
>  	.init = dw_mipi_dsi_phy_init,
> +	.power_on = dw_mipi_dsi_phy_power_on,
> +	.power_off = dw_mipi_dsi_phy_power_off,
>  	.get_lane_mbps = dw_mipi_dsi_get_lane_mbps,
>  };
>  


