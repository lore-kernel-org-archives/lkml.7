Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B15C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 12:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E13121655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 12:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgABMGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 07:06:52 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35291 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgABMGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 07:06:52 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1imzFN-0003cs-KI; Thu, 02 Jan 2020 13:06:37 +0100
Message-ID: <1cb30ea7ed8acabb02dc78f6f054be19d4b5b609.camel@pengutronix.de>
Subject: Re: [PATCH v5 3/8] mailbox: sun6i-msgbox: Add a new mailbox driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Date:   Thu, 02 Jan 2020 13:06:34 +0100
In-Reply-To: <20191215042455.51001-4-samuel@sholland.org>
References: <20191215042455.51001-1-samuel@sholland.org>
         <20191215042455.51001-4-samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-12-14 at 22:24 -0600, Samuel Holland wrote:
> Allwinner sun6i, sun8i, sun9i, and sun50i SoCs contain a hardware
> message box used for communication between the ARM CPUs and the ARISC
> management coprocessor. This mailbox contains 8 unidirectional
> 4-message FIFOs.
> 
> Add a driver for it, so it can be used for SCPI or other communication
> protocols.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/mailbox/Kconfig        |   9 +
>  drivers/mailbox/Makefile       |   2 +
>  drivers/mailbox/sun6i-msgbox.c | 332 +++++++++++++++++++++++++++++++++
>  3 files changed, 343 insertions(+)
>  create mode 100644 drivers/mailbox/sun6i-msgbox.c
> 
[...]
> diff --git a/drivers/mailbox/sun6i-msgbox.c b/drivers/mailbox/sun6i-msgbox.c
> new file mode 100644
> index 000000000000..7a41e732457c
> --- /dev/null
> +++ b/drivers/mailbox/sun6i-msgbox.c
> @@ -0,0 +1,332 @@
[...]
> +static int sun6i_msgbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mbox_chan *chans;
> +	struct reset_control *reset;
> +	struct resource *res;
> +	struct sun6i_msgbox *mbox;
> +	int i, ret;
> +
> +	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +	if (!mbox)
> +		return -ENOMEM;
> +
> +	chans = devm_kcalloc(dev, NUM_CHANS, sizeof(*chans), GFP_KERNEL);
> +	if (!chans)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < NUM_CHANS; ++i)
> +		chans[i].con_priv = mbox;
> +
> +	mbox->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(mbox->clk)) {
> +		ret = PTR_ERR(mbox->clk);
> +		dev_err(dev, "Failed to get clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(mbox->clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	reset = devm_reset_control_get(dev, NULL);

Please use devm_reset_control_get_exclusive() explicitly.

regards
Philipp

