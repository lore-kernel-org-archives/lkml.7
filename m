Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346EBC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130EC21743
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfFSNZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:25:52 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:59484 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfFSNZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:25:52 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 9B5C520023;
        Wed, 19 Jun 2019 15:25:47 +0200 (CEST)
Date:   Wed, 19 Jun 2019 15:25:46 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v2 2/2] drm/panel: Add support for Raydium RM67191 panel
 driver
Message-ID: <20190619132546.GB31903@ravnborg.org>
References: <1560864646-1468-1-git-send-email-robert.chiras@nxp.com>
 <1560864646-1468-3-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560864646-1468-3-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=8AirrxEcAAAA:8
        a=7gkXJVJtAAAA:8 a=Ec1C81j2VkJbqId89Q8A:9 a=CjuIK1q_8ugA:10
        a=ST-jHhOKWsTCqRlWije3:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 04:30:46PM +0300, Robert Chiras wrote:
> This patch adds Raydium RM67191 TFT LCD panel driver (MIPI-DSI
> protocol).
> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Please include in the changelog a list of what was updated - like this:

v2:
- added kconif symbol sorted (sam)
- another nitpick (foo)
- etc

In general try to namme who gave feedback to give them some credit.

Who is maintainer for this onwards?

> ---
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-raydium-rm67191.c | 709 ++++++++++++++++++++++++++
>  3 files changed, 719 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-raydium-rm67191.c
> 
> +static int rad_panel_prepare(struct drm_panel *panel)
> +{
> +	struct rad_panel *rad = to_rad_panel(panel);
> +
> +	if (rad->prepared)
> +		return 0;
> +
> +	if (rad->reset) {
> +		gpiod_set_value_cansleep(rad->reset, 1);
> +		usleep_range(3000, 5000);
> +		gpiod_set_value_cansleep(rad->reset, 0);

So writing a 0 will release reset.
> +		usleep_range(18000, 20000);
> +	}
> +
> +	rad->prepared = true;
> +
> +	return 0;
> +}
> +
> +static int rad_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct rad_panel *rad = to_rad_panel(panel);
> +
> +	if (!rad->prepared)
> +		return 0;
> +
> +	if (rad->reset) {
> +		gpiod_set_value_cansleep(rad->reset, 1);
> +		usleep_range(15000, 17000);
> +		gpiod_set_value_cansleep(rad->reset, 0);
Looks strange that reset is released in unprepare.
I would expect it to stay reset to minimize power etc.

> +
> +	ret = drm_display_info_set_bus_formats(&connector->display_info,
> +					       rad_bus_formats,
> +					       ARRAY_SIZE(rad_bus_formats));

Other drivers has this as the last stement in their enable function.
I did not check why, but maybe something to invest a few minutes into.
Be different only if there is a reason to do so.

> +	if (ret)
> +		return ret;
> +
> +	drm_mode_probed_add(panel->connector, mode);
> +
> +	return 1;
> +}
> +
> +
> +#ifdef CONFIG_PM
> +static int rad_panel_suspend(struct device *dev)
> +{
> +	struct rad_panel *rad = dev_get_drvdata(dev);
> +
> +	if (!rad->reset)
> +		return 0;
> +
> +	devm_gpiod_put(dev, rad->reset);
> +	rad->reset = NULL;
> +
> +	return 0;
> +}
> +
> +static int rad_panel_resume(struct device *dev)
> +{
> +	struct rad_panel *rad = dev_get_drvdata(dev);
> +
> +	if (rad->reset)
> +		return 0;
> +
> +	rad->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(rad->reset))
> +		rad->reset = NULL;
> +
> +	return PTR_ERR_OR_ZERO(rad->reset);
> +}
> +
> +#endif

Use __maybe_unused for the tw functions above.
And loose the ifdef...

> +
> +static const struct dev_pm_ops rad_pm_ops = {
> +	SET_RUNTIME_PM_OPS(rad_panel_suspend, rad_panel_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(rad_panel_suspend, rad_panel_resume)
> +};
> +
> +static const struct of_device_id rad_of_match[] = {
> +	{ .compatible = "raydium,rm67191", },
> +	{ }
We often, but not always, write this as { /* sentinal */ },

> +};
> +MODULE_DEVICE_TABLE(of, rad_of_match);
> +
> +static struct mipi_dsi_driver rad_panel_driver = {
> +	.driver = {
> +		.name = "panel-raydium-rm67191",
> +		.of_match_table = rad_of_match,
> +		.pm	= &rad_pm_ops,
> +	},
> +	.probe = rad_panel_probe,
> +	.remove = rad_panel_remove,
> +	.shutdown = rad_panel_shutdown,
> +};
> +module_mipi_dsi_driver(rad_panel_driver);
> +
> +MODULE_AUTHOR("Robert Chiras <robert.chiras@nxp.com>");
> +MODULE_DESCRIPTION("DRM Driver for Raydium RM67191 MIPI DSI panel");
> +MODULE_LICENSE("GPL v2");

With the above trivialities considered/fixed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
