Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB408C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A0D222BD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uipUgxqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfKLO0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:26:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36286 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfKLO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:26:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id c22so3183693wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 06:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HwAdfhIitfcvpFjEunj/32j/tCIUn5eee0pERZjRVjE=;
        b=uipUgxqyeE0KHXL6ubhaAYxNl7gHKal9kFDPZKyC/mOcCSq/qqD4JI0HWLZCCL1D9L
         UoWifxltVooIF807CohBVKrrB4e8teUC8z4m5DcySXJPPcUV7Ioel38sWe2pBgqh8Sha
         w3eQSePVSSeLBhsFdb3L80gqQNgPUsxBZ3VS9Qn83lDTTQqu77datEQYFnGmdRg4Sm9J
         k3OgtpKUSu47ZFS+9l79UXYMEKpdDHNlb/nTlYUJEj/J5Ys8y8T4FztsP4l+5j3O3SSS
         P1AYwPTr5GZw/ZnYGnqhIqKXYvyYq5jThwVLL5tvv91hKaUS4s3gL9lZhyDk2map/Ho0
         RWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HwAdfhIitfcvpFjEunj/32j/tCIUn5eee0pERZjRVjE=;
        b=Lqtq/1Jf0anaW+9MDngQTJzFhrKaRWXucMu0h50HxhDiAV3yV+/LcttOLQDj5Bt/Fq
         jR96eHvXUKbdWfUDRMNOhGk5r+LjY3u8JqBs90QjT64aBwZL6ZvSrehnTTpm56JmzdUq
         m6i3SF1mbhcukKoZILoh7idzEqLl77O16uoziV0zigEYhGgbV1zqIUHnYePKOXHHVkCx
         axyXGTGQyhnqL4hzhBgt+swq0R2p4INMAGGPbbFKkIkEyx3w/dR9jZ/6rslvZh+7FvmC
         RQYY4EMmBGjXGwrp3ffYSVAzHUIDTKX0MVkkrunaPnQPOtu6f9JMoxHg4oW/ibCXQ4RQ
         gWOQ==
X-Gm-Message-State: APjAAAUzteVjhOPJ+P1wrDDqxryutYvxTyomcGn4PMP4bKX6P8X5jT28
        LvN505Ks9A3EaNOc94MvIkhgQw==
X-Google-Smtp-Source: APXvYqxckmcNBpy72Qpot+ikOCMpk6nDsafZH9hp9iZSZmb+C4cx7cr8Lnq9JsDuf1l4mrUm/lUcjw==
X-Received: by 2002:a7b:c08f:: with SMTP id r15mr4093427wmh.45.1573568800830;
        Tue, 12 Nov 2019 06:26:40 -0800 (PST)
Received: from [10.1.2.12] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j63sm4525489wmj.46.2019.11.12.06.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 06:26:40 -0800 (PST)
Subject: Re: [PATCH v2 1/5] drm/bridge/synopsys: dsi: move phy_ops callbacks
 around panel enablement
To:     Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        dri-devel@lists.freedesktop.org, a.hajda@samsung.com
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, philippe.cornu@st.com,
        yannick.fertre@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, christoph.muellner@theobroma-systems.com
References: <20191108000253.8560-1-heiko.stuebner@theobroma-systems.com>
 <20191108000253.8560-2-heiko.stuebner@theobroma-systems.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <4b311fe6-2105-c96c-f7d4-ac3535616690@baylibre.com>
Date:   Tue, 12 Nov 2019 15:26:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108000253.8560-2-heiko.stuebner@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2019 01:02, Heiko Stuebner wrote:
> If implementation-specific phy_ops need to be defined they probably
> should be enabled before trying to talk to the panel and disabled only
> after the panel was disabled.
> 
> Right now they are enabled last and disabled first, so might make it
> impossible to talk to some panels - example for this being the px30
> with an external Innosilicon dphy that needs the phy to be enabled
> to transfer commands to the panel.
> 
> So move the calls appropriately.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index 675442bfc1bd..49f5600a1dea 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -797,9 +797,6 @@ static void dw_mipi_dsi_bridge_post_disable(struct drm_bridge *bridge)
>  	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
>  	const struct dw_mipi_dsi_phy_ops *phy_ops = dsi->plat_data->phy_ops;
>  
> -	if (phy_ops->power_off)
> -		phy_ops->power_off(dsi->plat_data->priv_data);
> -
>  	/*
>  	 * Switch to command mode before panel-bridge post_disable &
>  	 * panel unprepare.
> @@ -816,6 +813,9 @@ static void dw_mipi_dsi_bridge_post_disable(struct drm_bridge *bridge)
>  	 */
>  	dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
>  
> +	if (phy_ops->power_off)
> +		phy_ops->power_off(dsi->plat_data->priv_data);
> +
>  	if (dsi->slave) {
>  		dw_mipi_dsi_disable(dsi->slave);
>  		clk_disable_unprepare(dsi->slave->pclk);
> @@ -882,6 +882,9 @@ static void dw_mipi_dsi_mode_set(struct dw_mipi_dsi *dsi,
>  
>  	/* Switch to cmd mode for panel-bridge pre_enable & panel prepare */
>  	dw_mipi_dsi_set_mode(dsi, 0);
> +
> +	if (phy_ops->power_on)
> +		phy_ops->power_on(dsi->plat_data->priv_data);
>  }
>  
>  static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
> @@ -898,15 +901,11 @@ static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  static void dw_mipi_dsi_bridge_enable(struct drm_bridge *bridge)
>  {
>  	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
> -	const struct dw_mipi_dsi_phy_ops *phy_ops = dsi->plat_data->phy_ops;
>  
>  	/* Switch to video mode for panel-bridge enable & panel enable */
>  	dw_mipi_dsi_set_mode(dsi, MIPI_DSI_MODE_VIDEO);
>  	if (dsi->slave)
>  		dw_mipi_dsi_set_mode(dsi->slave, MIPI_DSI_MODE_VIDEO);
> -
> -	if (phy_ops->power_on)
> -		phy_ops->power_on(dsi->plat_data->priv_data);
>  }
>  
>  static enum drm_mode_status
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
