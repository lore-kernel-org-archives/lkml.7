Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76277ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D7C2173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="2tdq2mgq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tQnr7GXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfJGMIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:08:35 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42405 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727467AbfJGMIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:08:35 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D421921B74;
        Mon,  7 Oct 2019 08:08:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 07 Oct 2019 08:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=j
        0BA7cW3BlyI/BnVP4//2CDS/zymIhVMHBQUSMqPWhA=; b=2tdq2mgq2K1eOhx8b
        i6OW7UjwuXnpW/dMThcZ0zG8FFgI+yH0djTC6n4OZV/QzewPZA2AWu1bYgzsU7VZ
        3JT4pmVihxmh4AplRMneRSJP2lp4LTmBTwAIGJnzk08y4pp3WOtumWexYDAI1bq5
        igPiboT6Un0vLPNVd0haezt34JOfEM6Wn/Pu2MKXWnbDjICDggnU6WVlY20PKSX2
        yahrX3Ji9mYR07bEHnylbJQasWGDrCSPhCHh7qc0s7EYRgfcptEeWxhsoxmLv5we
        +9k9YT7knHUnW2x9gzkv+6i8A2xYYppQUQdDHUK7Z0svs/7vyJQaHUSgVQEIKEbq
        GCgsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=j0BA7cW3BlyI/BnVP4//2CDS/zymIhVMHBQUSMqPW
        hA=; b=tQnr7GXwy8TROrHoOc5qffk+yD5hd2czOsNxxuiFccJz21XmVRRsSPt8n
        cEUKXcyKAMfybQ9lc4wYRCmKoTyDvTveHYpo4xEolvZ4ABzCr35uVuSDaS9L1asN
        hn6uc6hlhtRIoe3rODFlmzGq12/R9xEUq8ms6E8LKH4Eo+T/NUnFfAF7q1ve0GsT
        uM/vBmw4M9Jju1eP5cVQL3UMnV3YtY9O9c32ZAH9qRRrXqBgijxvJm9DI37D8Wa7
        +WyOnAIMAub4ikEiPvWweSBCfQgFOGU/6LhD/V7dAccnK8oMiSas/PTGZlqontRR
        +RljymTkn0m71FSP6qZZC0kJUFzmQ==
X-ME-Sender: <xms:wSqbXffhKneAAD3jRejaHmvsHckxJI1XnVXnkytvJMbIf6-4OKpdCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrheejgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:wSqbXWVj88odH4aydt5bAsQroJKWph-FZ627SiFYOwOkmnZ9P7fP3Q>
    <xmx:wSqbXZfVT_YMCtzLadrUzQnz4qWaLRncK-9oqdSAUpJtmzqErbWWjg>
    <xmx:wSqbXcA_y6XoBdWc0kO9vOk-8lEwKRAJF0gmVHcs6UkckpRE-RVpjA>
    <xmx:wSqbXW3iJ-SC3gmYGi3eZ69b8UEnPfSfF1CWWWtvdHvwMHPr3-f8NA>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F46FD60057;
        Mon,  7 Oct 2019 08:08:33 -0400 (EDT)
Subject: Re: [PATCH] bus: sunxi-rsb: Make interrupt handling more robust
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <sboyd@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20190824175013.28840-1-samuel@sholland.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <8d4415f3-c0d2-d351-2221-2e86bd0d6673@sholland.org>
Date:   Mon, 7 Oct 2019 07:08:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190824175013.28840-1-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 8/24/19 12:50 PM, Samuel Holland wrote:
> The RSB controller has two registers for controlling interrupt inputs:
> RSB_INTE, which has bits for each possible interrupt, and the global
> interrupt enable bit in RSB_CTRL.
> 
> Currently, we enable the bits in RSB_INTE before each transfer, but this
> is unnecessary because we never disable them. Move the initialization of
> RSB_INTE so it is done only once.
> 
> We also set the global interrupt enable bit before each transfer. Unlike
> other bits in RSB_CTRL, this bit is cleared by writing a zero. Thus, we
> clear the bit in the post-timeout cleanup code, so I note that in the
> comment.
> 
> However, if we do receive an interrupt, we do not clear the bit. Nor do
> we clear interrupt statuses before starting a transfer. Thus, if some
> other driver uses the RSB bus while Linux is suspended (as both Trusted
> Firmware and SCP firmware do to control the PMIC), we receive spurious
> interrupts upon resume. This causes false completion of a transfer, and
> the next transfer starts prematurely, causing a LOAD_BSY condition. The
> end result is that some transfers at resume fail with -EBUSY.
> 
> With this patch, all transfers reliably succeed during/after resume.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Ping? Any comments?

> ---
>  drivers/bus/sunxi-rsb.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index be79d6c6a4e4..b8043b58568a 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -274,7 +274,7 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>  	reinit_completion(&rsb->complete);
>  
>  	writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER,
> -	       rsb->regs + RSB_INTE);
> +	       rsb->regs + RSB_INTS);
>  	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
>  	       rsb->regs + RSB_CTRL);
>  
> @@ -282,7 +282,7 @@ static int _sunxi_rsb_run_xfer(struct sunxi_rsb *rsb)
>  					    msecs_to_jiffies(100))) {
>  		dev_dbg(rsb->dev, "RSB timeout\n");
>  
> -		/* abort the transfer */
> +		/* abort the transfer and disable interrupts */
>  		writel(RSB_CTRL_ABORT_TRANS, rsb->regs + RSB_CTRL);
>  
>  		/* clear any interrupt flags */
> @@ -480,6 +480,9 @@ static irqreturn_t sunxi_rsb_irq(int irq, void *dev_id)
>  	status = readl(rsb->regs + RSB_INTS);
>  	rsb->status = status;
>  
> +	/* Disable any further interrupts */
> +	writel(0, rsb->regs + RSB_CTRL);
> +
>  	/* Clear interrupts */
>  	status &= (RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR |
>  		   RSB_INTS_TRANS_OVER);
> @@ -718,6 +721,9 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
>  		goto err_reset_assert;
>  	}
>  
> +	writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER,
> +	       rsb->regs + RSB_INTE);
> +
>  	/* initialize all devices on the bus into RSB mode */
>  	ret = sunxi_rsb_init_device_mode(rsb);
>  	if (ret)
> 

