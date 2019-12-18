Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8DDC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C662206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLRSsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:48:18 -0500
Received: from foss.arm.com ([217.140.110.172]:57250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfLRSsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:48:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8288D1FB;
        Wed, 18 Dec 2019 10:48:16 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D5B93F67D;
        Wed, 18 Dec 2019 10:48:14 -0800 (PST)
Date:   Wed, 18 Dec 2019 18:48:09 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 8/8] firmware: arm_scpi: Support unidirectional
 mailbox channels
Message-ID: <20191218184809.GA14599@bogus>
References: <20191215042455.51001-1-samuel@sholland.org>
 <20191215042455.51001-9-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215042455.51001-9-samuel@sholland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 10:24:55PM -0600, Samuel Holland wrote:
> Some mailbox controllers have only unidirectional channels, so we need a
> pair of them for each SCPI channel. If a mbox-names property is present,
> look for "rx" and "tx" mbox channels; otherwise, the existing behavior
> is preserved, and a single mbox channel is used for each SCPI channel.
>

I need to look at the bindings again, but I think you must update it.

> Note that since the mailbox framework only supports a single phandle
> with each name (mbox_request_channel_byname always returns the first
> one), this new mode only supports a single SCPI channel.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/firmware/arm_scpi.c | 58 +++++++++++++++++++++++++++++--------
>  1 file changed, 46 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index a80c331c3a6e..36ff9dd8d0fa 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c
> @@ -231,7 +231,8 @@ struct scpi_xfer {
>
>  struct scpi_chan {
>  	struct mbox_client cl;
> -	struct mbox_chan *chan;
> +	struct mbox_chan *rx_chan;
> +	struct mbox_chan *tx_chan;
>  	void __iomem *tx_payload;
>  	void __iomem *rx_payload;
>  	struct list_head rx_pending;
> @@ -505,7 +506,7 @@ static int scpi_send_message(u8 idx, void *tx_buf, unsigned int tx_len,
>  	msg->rx_len = rx_len;
>  	reinit_completion(&msg->done);
>
> -	ret = mbox_send_message(scpi_chan->chan, msg);
> +	ret = mbox_send_message(scpi_chan->tx_chan, msg);
>  	if (ret < 0 || !rx_buf)
>  		goto out;
>
> @@ -854,8 +855,13 @@ static void scpi_free_channels(void *data)
>  	struct scpi_drvinfo *info = data;
>  	int i;
>
> -	for (i = 0; i < info->num_chans; i++)
> -		mbox_free_channel(info->channels[i].chan);
> +	for (i = 0; i < info->num_chans; i++) {
> +		struct scpi_chan *pchan = &info->channels[i];
> +
> +		if (pchan->tx_chan != pchan->rx_chan)
> +			mbox_free_channel(pchan->tx_chan);
> +		mbox_free_channel(pchan->rx_chan);

I think mbox_free_channel handles !chan->cl, so just do unconditionally.

> +	}
>  }
>
>  static int scpi_remove(struct platform_device *pdev)
> @@ -903,6 +909,7 @@ static int scpi_probe(struct platform_device *pdev)
>  	struct resource res;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> +	bool use_mbox_names = false;
>
>  	scpi_info = devm_kzalloc(dev, sizeof(*scpi_info), GFP_KERNEL);
>  	if (!scpi_info)
> @@ -916,6 +923,14 @@ static int scpi_probe(struct platform_device *pdev)
>  		dev_err(dev, "no mboxes property in '%pOF'\n", np);
>  		return -ENODEV;
>  	}
> +	if (of_get_property(dev->of_node, "mbox-names", NULL)) {

So, for this platform, this is required and must fail if it is not found.
But instead your check here is optional and may end up populating 2
scpi channels instead of one. I would suggest to make it required and
fail for it based on some compatible, otherwise you are not checking
correctly.

Something like:
        if (of_match_device(blah_blah_of_match, &pdev->dev)) {
                use_mbox_names = true;
		count = 1;
	}


> +		use_mbox_names = true;
> +		if (count != 2) {
> +			dev_err(dev, "need exactly 2 mboxes with mbox-names\n");
> +			return -ENODEV;
> +		}
> +		count /= 2;
> +	}

Ah, OK then you must update the binding as it's different usage of mailbox. 

General query, not related to this patch: If you are in process of
implementing the firmware, I suggest to move to SCMI protocol than this
one if not too late. This specification is deprecated and no longer
updated while SCMI is actively developed and maintained. However it has
slightly different notion of tx and rx and the way the specification
commands which messages are synchronous and which can be async/delayed.

--
Regards,
Sudeep
