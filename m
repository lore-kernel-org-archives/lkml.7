Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7472C32764
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 15:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C14A206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 15:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="XYkhfp2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgAAPPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 10:15:36 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:38667 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgAAPPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 10:15:36 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 63AF022FE5;
        Wed,  1 Jan 2020 16:15:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1577891732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/FBt0Zgi9W04iwgAW4q49Axs3gCKj+1g7HUQY1yOAzU=;
        b=XYkhfp2QUOPtI0N9L170Depb7z/b9NoxaxqrMe0XdUVJGYpoRQ5kzUBqnVgb1cWjwQdpM0
        wD4zO9D2UnU6Q8+jK8Cnh31vVQ/6HDpQazEcOyUMRvvhI8RbIKITUz+Dg1g3jSAsUt0V90
        GmJJXaW0d4PgGZK3MOgSIBddnssrdyQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Jan 2020 16:15:32 +0100
From:   Michael Walle <michael@walle.cc>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] clk: fsl-sai: new driver
In-Reply-To: <20191224080536.B0C99206CB@mail.kernel.org>
References: <20191209233305.18619-1-michael@walle.cc>
 <20191209233305.18619-2-michael@walle.cc>
 <20191224080536.B0C99206CB@mail.kernel.org>
Message-ID: <91275d33d6a7c9978a2c70545fde38cd@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 63AF022FE5
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.785];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stephen,

thanks for the review.

Am 2019-12-24 09:05, schrieb Stephen Boyd:
> Quoting Michael Walle (2019-12-09 15:33:05)
>> diff --git a/drivers/clk/clk-fsl-sai.c b/drivers/clk/clk-fsl-sai.c
>> new file mode 100644
>> index 000000000000..b92054d15ab1
>> --- /dev/null
>> +++ b/drivers/clk/clk-fsl-sai.c
>> @@ -0,0 +1,84 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Freescale SAI BCLK as a generic clock driver
>> + *
>> + * Copyright 2019 Kontron Europe GmbH
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/err.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/slab.h>
>> +
>> +#define I2S_CSR                0x00
>> +#define I2S_CR2                0x08
>> +#define CSR_BCE_BIT    28
>> +#define CR2_BCD                BIT(24)
>> +#define CR2_DIV_SHIFT  0
>> +#define CR2_DIV_WIDTH  8
>> +
>> +struct fsl_sai_clk {
>> +       struct clk_divider div;
>> +       struct clk_gate gate;
>> +       spinlock_t lock;
>> +};
>> +
>> +static void __init fsl_sai_clk_setup(struct device_node *node)
>> +{
>> +       const char *clk_name = node->name;
>> +       struct fsl_sai_clk *sai_clk;
>> +       unsigned int num_parents;
>> +       const char *parent_name;
>> +       void __iomem *base;
>> +       struct clk_hw *hw;
>> +
>> +       num_parents = of_clk_get_parent_count(node);
>> +       if (!num_parents) {
>> +               pr_err("%s: no parent found", clk_name);
>> +               return;
>> +       }
>> +
>> +       parent_name = of_clk_get_parent_name(node, 0);
> 
> Could this use the new way of specifying clk parents so that we don't
> have to query DT for parent names and just let the core framework do it
> whenever it needs to?

you mean specifying parent_data with .index = 0? Seems like 
clk_composite
does not support this. The parent can only be specified by supplying the
clock names.

I could add that in a separate patch. What do you think about the
following new functions, where a driver can use parent_data instead
of parent_names.

+struct clk *clk_register_composite_pdata(struct device *dev, const char 
*name,
+               const struct clk_parent_data *parent_data,
+               struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+               struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
+               struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+               unsigned long flags);

+struct clk_hw *clk_hw_register_composite_pdata(struct device *dev,
+               const char *name, const struct clk_parent_data 
*parent_data,
+               struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+               struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
+               struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+               unsigned long flags);


>> +
>> +       sai_clk = kzalloc(sizeof(*sai_clk), GFP_KERNEL);
>> +       if (!sai_clk)
>> +               return;
>> +
>> +       base = of_iomap(node, 0);
>> +       if (base == NULL) {
>> +               pr_err("%s: failed to map register space", clk_name);
>> +               goto err;
>> +       }
>> +
>> +       spin_lock_init(&sai_clk->lock);
>> +
>> +       sai_clk->gate.reg = base + I2S_CSR;
>> +       sai_clk->gate.bit_idx = CSR_BCE_BIT;
>> +       sai_clk->gate.lock = &sai_clk->lock;
>> +
>> +       sai_clk->div.reg = base + I2S_CR2;
>> +       sai_clk->div.shift = CR2_DIV_SHIFT;
>> +       sai_clk->div.width = CR2_DIV_WIDTH;
>> +       sai_clk->div.lock = &sai_clk->lock;
>> +
>> +       /* set clock direction, we are the BCLK master */
> 
> Should this configuration come from DT somehow?

No, we are always master, because as a slave, there would be no clock
output ;)

>> +       writel(CR2_BCD, base + I2S_CR2);
>> +
>> +       hw = clk_hw_register_composite(NULL, clk_name, &parent_name, 
>> 1,
>> +                                      NULL, NULL,
>> +                                      &sai_clk->div.hw, 
>> &clk_divider_ops,
>> +                                      &sai_clk->gate.hw, 
>> &clk_gate_ops,
>> +                                      CLK_SET_RATE_GATE);
>> +       if (IS_ERR(hw))
>> +               goto err;
>> +
>> +       of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
>> +
>> +       return;
>> +
>> +err:
>> +       kfree(sai_clk);
>> +}
>> +
>> +CLK_OF_DECLARE(fsl_sai_clk, "fsl,vf610-sai-clock", 
>> fsl_sai_clk_setup);
> 
> Is there a reason this can't be a platform device driver?

I don't think so, the user will be a sound codec for now. I'll convert 
it
to a platform device, in that case I could also use the devm_ variants.

-michael
