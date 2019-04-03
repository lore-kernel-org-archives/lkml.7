Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08810C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54C320700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDCPIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:08:30 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37209 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfDCPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:08:29 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 05D041C0003;
        Wed,  3 Apr 2019 15:08:25 +0000 (UTC)
Date:   Wed, 3 Apr 2019 17:08:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: pcf2127: add battery-low INTn generation
Message-ID: <20190403150824.GO22216@piout.net>
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
 <1554303165-24813-2-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554303165-24813-2-git-send-email-f.suligoi@asem.it>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 16:52:45+0200, Flavio Suligoi wrote:
> The pcf2127 has an automatic battery-low detection function.
> 
> In case of battery-low event, an interrupt generation through
> the pin INTn (active low) can be enabled, setting the flag BLIE
> in the register Control_3.
> 
> This function is activated by the "battery-low-hw-alarm" DT property.
> 
> Example of use for an NXP i.MX7D board:
> 
> &i2c3 {
> 	clock-frequency = <100000>;
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pinctrl_i2c3>;
> 	status = "okay";
> 
> 	pcf2127@51 {
> 		compatible = "nxp,pcf2127";
> 		reg = <0x51>;
> 		battery-low-hw-alarm;
> 		status = "okay";
> 	};
> };
> 

So I'm curious, how do you then use that signal? I have a (not yet sent)
series adding alarm support for the pcf2127. The issue having BLIE is
that then this will prevent the alarm to work properly.

So my guess is that you have nINT connected to an LED or something that
the user can see?

> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  drivers/rtc/rtc-pcf2127.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 7cb786d..e3805c8 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -228,6 +228,10 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>  			const char *name, bool has_nvmem)
>  {
>  	struct pcf2127 *pcf2127;
> +	struct device_node *np;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	unsigned char buf[2];
> +	int err;
>  	int ret = 0;
>  
>  	dev_dbg(dev, "%s\n", __func__);
> @@ -245,6 +249,35 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>  	if (IS_ERR(pcf2127->rtc))
>  		return PTR_ERR(pcf2127->rtc);
>  
> +	/*
> +	 * The pcf2127 has an automatic battery-low detection function.
> +	 *
> +	 * In case of battery-low event, an interrupt generation through
> +	 * the pin INTn (active low) can be enabled, setting the flag BLIE
> +	 * in the register Control_3.
> +	 */
> +	np = of_node_get(dev->of_node);
> +	if (!np) {
> +		dev_err(dev, "failed to find the RTC pcf2127 node\n");
> +		return -ENOENT;
> +	}
> +	if (of_get_property(np, "battery-low-hw-alarm", NULL)) {
> +		dev_info(dev, "enable battery-low hw alarm on INTn pin\n");
> +
> +		/*
> +		 * Set BLIE bit in register Control_3 (override is possible
> +		 * because this register is fully zero after reset)
> +		 */
> +		buf[0] = PCF2127_REG_CTRL3;
> +		buf[1] = 0x01;
> +		/* write register's data */
> +		err = i2c_master_send(client, buf, 2);

This has to use regmap_update_bits because this also has to work on spi.
(I don't know where you get the client pointer from anyway).

> +		if (err != 2) {
> +			dev_err(dev, "%s: err=%d", __func__, err);
> +			return -EIO;
> +		}
> +	}
> +
>  	if (has_nvmem) {
>  		struct nvmem_config nvmem_cfg = {
>  			.priv = pcf2127,
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
