Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C396C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9452173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576085184;
	bh=6+GsgB2+SJxEeJX9z8+Ra3hd+E/oCT3XWF+00Tcl28Q=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=Ey3LJZJnNAlsOEEFdxzSX/yzF63ZsfdO2g7lKv2dVD7A0TQjgSM5sUvEtHMhe3xVw
	 8Ewd9xddMZAPrrJjmJefjmI0TdKT47TOeHg4p1A/NgJiS/IVI2IUp+FzOcC466qruV
	 c9bS8POQt5W1R65RqN6+HiG9vIP0feL/3jKs6n8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfLKR0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:26:23 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:54289 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbfLKR0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:26:22 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1if5kg-0007zE-BR; Wed, 11 Dec 2019 18:26:18 +0100
To:     Qianggui Song <qianggui.song@amlogic.com>
Subject: Re: [PATCH 2/4] irqchip/meson-gpio: rework meson irqchip driver to  support meson-A1 SoCs
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Dec 2019 17:26:18 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>
In-Reply-To: <2551e382-d373-dad8-7294-80f2a15c0ad4@amlogic.com>
References: <20191206121714.14579-1-qianggui.song@amlogic.com>
 <20191206121714.14579-3-qianggui.song@amlogic.com>
 <542e3e819e584d6e433d2c4276c3b379@www.loen.fr>
 <2551e382-d373-dad8-7294-80f2a15c0ad4@amlogic.com>
Message-ID: <0cbbb895b50a838fd1dfa9e59528367d@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: qianggui.song@amlogic.com, tglx@linutronix.de, jason@lakedaemon.net, khilman@baylibre.com, narmstrong@baylibre.com, jbrunet@baylibre.com, jianxin.pan@amlogic.com, xingyu.chen@amlogic.com, hanjie.lin@amlogic.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-10 02:08, Qianggui Song wrote:
> Hi, Marc
>      Thank you for your review
>
> On 2019/12/6 21:13, Marc Zyngier wrote:
>> On 2019-12-06 12:17, Qianggui Song wrote:
>>> Since Meson-A1 Socs register layout of gpio interrupt controller 
>>> have
>>> difference with previous chips, registers to decide irq line and
>>> offset
>>> of trigger method are all changed, the current driver should be
>>> modified.
>>>
>>> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
>>> ---
>>>  drivers/irqchip/irq-meson-gpio.c | 79
>>> ++++++++++++++++++++++++--------
>>>  1 file changed, 60 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-meson-gpio.c
>>> b/drivers/irqchip/irq-meson-gpio.c
>>> index 829084b568fa..1824ffc30de2 100644
>>> --- a/drivers/irqchip/irq-meson-gpio.c
>>> +++ b/drivers/irqchip/irq-meson-gpio.c
>>> @@ -30,44 +30,74 @@
>>>   * stuck at 0. Bits 8 to 15 are responsive and have the expected
>>>   * effect.
>>>   */
>>> -#define REG_EDGE_POL_EDGE(x)	BIT(x)
>>> -#define REG_EDGE_POL_LOW(x)	BIT(16 + (x))
>>> -#define REG_BOTH_EDGE(x)	BIT(8 + (x))
>>> -#define REG_EDGE_POL_MASK(x)    (	\
>>> -		REG_EDGE_POL_EDGE(x) |	\
>>> -		REG_EDGE_POL_LOW(x)  |	\
>>> -		REG_BOTH_EDGE(x))
>>> +#define REG_EDGE_POL_EDGE(params,
>>> x)	BIT((params)->edge_single_offset + (x))
>>> +#define REG_EDGE_POL_LOW(params, x)	BIT((params)->pol_low_offset +
>>> (x))
>>> +#define REG_BOTH_EDGE(params, x)	BIT((params)->edge_both_offset +
>>> (x))
>>> +#define REG_EDGE_POL_MASK(params, x)    (	\
>>> +		REG_EDGE_POL_EDGE(params, x) |	\
>>> +		REG_EDGE_POL_LOW(params, x)  |	\
>>> +		REG_BOTH_EDGE(params, x))
>>>  #define REG_PIN_SEL_SHIFT(x)	(((x) % 4) * 8)
>>>  #define REG_FILTER_SEL_SHIFT(x)	((x) * 4)
>>>
>>> +#define INIT_MESON8_COMMON_DATA					\
>>> +	.edge_single_offset = 0,				\
>>> +	.pol_low_offset = 16,					\
>>> +	.pin_sel_mask = 0xff,					\
>>> +	.ops = {						\
>>> +		.gpio_irq_sel_pin = meson8_gpio_irq_sel_pin,	\
>>> +	},
>>
>> Please place the #defines that operate on the various data 
>> structures
>> *after* the definition of the structures. It would greatly help
>> reading the changes.
>>
> OK, will place it below the definition of struct 
> meson_gpio_irq_params
> in the next patch.
>>> +
>>> +struct meson_gpio_irq_controller;
>>> +static void meson8_gpio_irq_sel_pin(struct 
>>> meson_gpio_irq_controller
>>> *ctl,
>>> +				    unsigned int channel, unsigned long hwirq);
>>> +struct irq_ctl_ops {
>>> +	void (*gpio_irq_sel_pin)(struct meson_gpio_irq_controller *ctl,
>>> +					 unsigned int channel,
>>> +					 unsigned long hwirq);
>>> +	void (*gpio_irq_init)(struct meson_gpio_irq_controller *ctl);
>>> +};
>>> +
>>>  struct meson_gpio_irq_params {
>>>  	unsigned int nr_hwirq;
>>>  	bool support_edge_both;
>>> +	unsigned int edge_both_offset;
>>> +	unsigned int edge_single_offset;
>>> +	unsigned int pol_low_offset;
>>> +	unsigned int pin_sel_mask;
>>> +	struct irq_ctl_ops ops;
>>>  };
>>>
>>>  static const struct meson_gpio_irq_params meson8_params = {
>>>  	.nr_hwirq = 134,
>>> +	INIT_MESON8_COMMON_DATA
>>>  };
>>>
>>>  static const struct meson_gpio_irq_params meson8b_params = {
>>>  	.nr_hwirq = 119,
>>> +	INIT_MESON8_COMMON_DATA
>>>  };
>>>
>>>  static const struct meson_gpio_irq_params gxbb_params = {
>>>  	.nr_hwirq = 133,
>>> +	INIT_MESON8_COMMON_DATA
>>>  };
>>>
>>>  static const struct meson_gpio_irq_params gxl_params = {
>>>  	.nr_hwirq = 110,
>>> +	INIT_MESON8_COMMON_DATA
>>>  };
>>>
>>>  static const struct meson_gpio_irq_params axg_params = {
>>>  	.nr_hwirq = 100,
>>> +	INIT_MESON8_COMMON_DATA
>>>  };
>>>
>>>  static const struct meson_gpio_irq_params sm1_params = {
>>>  	.nr_hwirq = 100,
>>>  	.support_edge_both = true,
>>> +	.edge_both_offset = 8,
>>> +	INIT_MESON8_COMMON_DATA
>>>  };
>>
>> OK, this isn't great. The least you could do is to make
>> your initializer parametric, so that it takes the nr_hwirq as
>> a parameter.
>>
>> Then, any additional member that overrides common behaviour
>> should come after the main initializer.
>>
>> Also, do you need 'support_edge_both'? Isn't a non-zero
>> 'edge_both_offset' enough to detect the feature?
>>
>
> Sorry, but I am not very clear that "make your initializer 
> parametric,
> so that it takes the nr_hwirq as a parameter". Is that
> initializer(initial function in .ops ? ) as a parameter of struct
> meson_gpio_irq_params ? If nr_hwirq as a parameter of init function 
> of
> .ops then will make lot of init function for each platform.
>
> How about move .ops from  macro like below:
> #define INIT_MESON8_COMMON_DATA					\
> 	.edge_single_offset = 0,				\
> 	.pol_low_offset = 16,					\
> 	.pin_sel_mask = 0xff,
>
> static const struct meson_gpio_irq_params sm1_params = {
>  	.nr_hwirq = 100,//main initializer
> 	.ops = {
>               .gpio_irq_sel_pin = meson8_gpio_irq_sel_pin,
>                /*in below to assign support_edge_both
>                 * edge_both_offset
>                 * call after main initializer to additional
>                 * member
>                 */
>               .gpio_irq_init = meson_sm1_irq_init,
> 	},
>   	INIT_MESON8_COMMON_DATA// m8 to sm1 are the same.
> };

No, what I'm suggesting is something like this:

diff --git a/drivers/irqchip/irq-meson-gpio.c 
b/drivers/irqchip/irq-meson-gpio.c
index 8478100706a6..27a3207a944d 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -43,24 +43,27 @@
  /* Below is used for Meson-A1 series like chips*/
  #define REG_PIN_A1_SEL	0x04

-#define INIT_MESON8_COMMON_DATA					\
-	.edge_single_offset = 0,				\
-	.pol_low_offset = 16,					\
-	.pin_sel_mask = 0xff,					\
-	.ops = {						\
-		.gpio_irq_sel_pin = meson8_gpio_irq_sel_pin,	\
-	},
-
-#define INIT_MESON_A1_COMMON_DATA				\
-	.support_edge_both = true,				\
-	.edge_both_offset = 16,					\
-	.edge_single_offset = 8,				\
-	.pol_low_offset = 0,					\
-	.pin_sel_mask = 0x7f,					\
-	.ops = {						\
-		.gpio_irq_sel_pin = meson_a1_gpio_irq_sel_pin,	\
-		.gpio_irq_init = meson_a1_gpio_irq_init,	\
-	},
+#define INIT_MESON_COMMON(irqs, init, sel)		\
+	.nr_hwirq = irqs,				\
+	.ops = {					\
+		.gpio_irq_sel_pin = sel,		\
+		.gpio_irq_init = init,			\
+	}
+
+#define INIT_MESON8_COMMON_DATA(irqs)			\
+	INIT_MESON_COMMON(irqs, NULL,			\
+			  meson8_gpio_irq_sel_pin),	\
+	.pol_low_offset = 16,				\
+	.pin_sel_mask = 0xff,
+
+#define INIT_MESON_A1_COMMON_DATA(irqs)			\
+	INIT_MESON_COMMON(irqs, meson_a1_gpio_irq_init,	\
+			  meson_a1_gpio_irq_sel_pin),	\
+	.support_edge_both = true,			\
+	.edge_both_offset = 16,				\
+	.edge_single_offset = 8,			\
+	.pol_low_offset = 0,				\
+	.pin_sel_mask = 0x7f,

  struct meson_gpio_irq_controller;
  static void meson8_gpio_irq_sel_pin(struct meson_gpio_irq_controller 
*ctl,
@@ -89,40 +92,33 @@ struct meson_gpio_irq_params {
  };

  static const struct meson_gpio_irq_params meson8_params = {
-	.nr_hwirq = 134,
-	INIT_MESON8_COMMON_DATA
+	INIT_MESON8_COMMON_DATA(134),
  };

  static const struct meson_gpio_irq_params meson8b_params = {
-	.nr_hwirq = 119,
-	INIT_MESON8_COMMON_DATA
+	INIT_MESON8_COMMON_DATA(119),
  };

  static const struct meson_gpio_irq_params gxbb_params = {
-	.nr_hwirq = 133,
-	INIT_MESON8_COMMON_DATA
+	INIT_MESON8_COMMON_DATA(133),
  };

  static const struct meson_gpio_irq_params gxl_params = {
-	.nr_hwirq = 110,
-	INIT_MESON8_COMMON_DATA
+	INIT_MESON8_COMMON_DATA(110),
  };

  static const struct meson_gpio_irq_params axg_params = {
-	.nr_hwirq = 100,
-	INIT_MESON8_COMMON_DATA
+	INIT_MESON8_COMMON_DATA(100),
  };

  static const struct meson_gpio_irq_params sm1_params = {
-	.nr_hwirq = 100,
+	INIT_MESON8_COMMON_DATA(100),
  	.support_edge_both = true,
  	.edge_both_offset = 8,
-	INIT_MESON8_COMMON_DATA
  };

  static const struct meson_gpio_irq_params a1_params = {
-	.nr_hwirq = 62,
-	INIT_MESON_A1_COMMON_DATA
+	INIT_MESON_A1_COMMON_DATA(62),
  };

  static const struct of_device_id meson_irq_gpio_matches[] = {


Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
