Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22A5C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B349F2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o4emtk3Z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iYkxWwIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfDHVqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:46:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42294 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbfDHVqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:46:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EBAC60F3D; Mon,  8 Apr 2019 21:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554759975;
        bh=TPCGwo78+ase5tPdZdsTulWASwuTRNiDoLiOYVnG67U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o4emtk3ZUyDJ8VOeDtLFOBbP3rP8XX/VJ262q35ArC0Or8/HCNOk2BoEf0LL2BGmV
         ziNYKAohdelK0ZMnrcg1cAQuDpVtWLQU7kRr/JN6E6IkB7i2Ioveq3ufC/s4jiSPm1
         8i4zc4ZusAykw/00iwFr0gyCWZ4kISnEgg+eSocw=
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC6CA60303;
        Mon,  8 Apr 2019 21:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554759973;
        bh=TPCGwo78+ase5tPdZdsTulWASwuTRNiDoLiOYVnG67U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iYkxWwIzkv2NKNrU+1/Cf1Ti4g1V+BkfJ/2DaCl5uu42FKRk+Rfme71cNZBA07Sao
         1EEJ9UswBV2H95qRKIJA6NxNvu6VIQeznZbIgnE744i6ILjKDPgLhij6CcuH86MJaE
         dtsZYcfyFnpPb45R9z+VitTs/slm2ZuNH9QLBQYY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC6CA60303
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 3/7] clk: Add of_clk_hw_register() API for early clk
 drivers
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
References: <20190404215344.6330-1-sboyd@kernel.org>
 <20190404215344.6330-4-sboyd@kernel.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <f989942c-89fc-76cf-af1b-2ac352d6e60c@codeaurora.org>
Date:   Mon, 8 Apr 2019 15:46:11 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190404215344.6330-4-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/2019 3:53 PM, Stephen Boyd wrote:
> In some circumstances drivers register clks early and don't have access
> to a struct device because the device model isn't initialized yet. Add
> an API to let drivers register clks associated with a struct device_node
> so that these drivers can participate in getting parent clks through DT.

NACK.  This patch broke boot for me.  I had to pull the below from JTAG. 
  What do you need to debug this?

[    0.000000] Unable to handle kernel read from unreadable memory at 
virtual address 0000000000000280
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x96000004
[    0.000000]   Exception class = DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004
[    0.000000]   CM = 0, WnR = 0
[    0.000000] [0000000000000280] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 96000004 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.1.0-rc1+ #453
[    0.000000] Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP 
(DT)
[    0.000000] pstate: 60400085 (nZCv daIf +PAN -UAO)
[    0.000000] pc : clk_hw_register+0x24/0x40
[    0.000000] lr : clk_hw_register_fixed_rate_with_accuracy+0xac/0x100
[    0.000000] sp : ffff0000117d3df0
[    0.000000] x29: ffff0000117d3df0 x28: ffff8000fdc7cd28
[    0.000000] x27: dead000000000100 x26: dead000000000200
[    0.000000] x25: 0000000000000001 x24: ffff7dfffe80047c
[    0.000000] x23: 000000000124f800 x22: 0000000000000000
[    0.000000] x21: 0000000000000000 x20: ffff8000f9524c00
[    0.000000] x19: 0000000000000000 x18: ffffffffffffffff
[    0.000000] x17: 0000000000000000 x16: 0000000000000000
[    0.000000] x15: ffff0000117dc708 x14: ffffffffffffffff
[    0.000000] x13: 0000000000000020 x12: 0101010101010101
[    0.000000] x11: 7f7f7f7f7f7f7f7f x10: 02fefeff01fefeff
[    0.000000] x9 : 0000000000000000 x8 : ffff8000f9524c80
[    0.000000] x7 : 0000000000000000 x6 : 000000000000003f
[    0.000000] x5 : 0000000000000040 x4 : 0000000000000000
[    0.000000] x3 : 0000000000000000 x2 : ffff8000f9524c00
[    0.000000] x1 : ffff8000f9524c00 x0 : 0000000000000000
[    0.000000] Process swapper/0 (pid: 0, stack limit = 0x(____ptrval____))
[    0.000000] Call trace:
[    0.000000]  clk_hw_register+0x24/0x40
[    0.000000]  clk_hw_register_fixed_rate_with_accuracy+0xac/0x100
[    0.000000]  _of_fixed_clk_setup+0xa8/0x120
[    0.000000]  of_fixed_clk_setup+0x20/0x2c
[    0.000000]  of_clk_init+0x19c/0x254
[    0.000000]  time_init+0x18/0x4c
[    0.000000]  start_kernel+0x394/0x524
[    0.000000] Code: aa1e03e0 d503201f aa1403e2 aa1303e0 (f9414261)
[    0.000000] ---[ end trace 5d02af5e3cbab7bf ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill 
the idle task! ]---

> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>   drivers/clk/clk.c            | 26 +++++++++++++++++++++++---
>   include/linux/clk-provider.h |  1 +
>   2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d27775a73e67..4971e9651ca5 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -45,6 +45,7 @@ struct clk_core {
>   	struct clk_hw		*hw;
>   	struct module		*owner;
>   	struct device		*dev;
> +	struct device_node	*of_node;
>   	struct clk_core		*parent;
>   	const char		**parent_names;
>   	struct clk_core		**parents;
> @@ -3313,7 +3314,8 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
>   	return clk;
>   }
>   
> -static struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
> +static struct clk *
> +__clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
>   {
>   	int i, ret;
>   	struct clk_core *core;
> @@ -3339,6 +3341,7 @@ static struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
>   	if (dev && pm_runtime_enabled(dev))
>   		core->rpm_enabled = true;
>   	core->dev = dev;
> +	core->of_node = np;
>   	if (dev && dev->driver)
>   		core->owner = dev->driver->owner;
>   	core->hw = hw;
> @@ -3429,7 +3432,7 @@ static struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
>    */
>   struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>   {
> -	return __clk_register(dev, hw);
> +	return __clk_register(dev, dev->of_node, hw);
>   }
>   EXPORT_SYMBOL_GPL(clk_register);
>   
> @@ -3445,10 +3448,27 @@ EXPORT_SYMBOL_GPL(clk_register);
>    */
>   int clk_hw_register(struct device *dev, struct clk_hw *hw)
>   {
> -	return PTR_ERR_OR_ZERO(__clk_register(dev, hw));
> +	return PTR_ERR_OR_ZERO(__clk_register(dev, dev->of_node, hw));
>   }
>   EXPORT_SYMBOL_GPL(clk_hw_register);
>   
> +/*
> + * of_clk_hw_register - register a clk_hw and return an error code
> + * @node: device_node of device that is registering this clock
> + * @hw: link to hardware-specific clock data
> + *
> + * of_clk_hw_register() is the primary interface for populating the clock tree
> + * with new clock nodes when a struct device is not available, but a struct
> + * device_node is. It returns an integer equal to zero indicating success or
> + * less than zero indicating failure. Drivers must test for an error code after
> + * calling of_clk_hw_register().
> + */
> +int of_clk_hw_register(struct device_node *node, struct clk_hw *hw)
> +{
> +	return PTR_ERR_OR_ZERO(__clk_register(NULL, node, hw));
> +}
> +EXPORT_SYMBOL_GPL(of_clk_hw_register);
> +
>   /* Free memory allocated for a clock. */
>   static void __clk_release(struct kref *ref)
>   {
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index b7cf80a71293..7d2d97e15b76 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -773,6 +773,7 @@ struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
>   
>   int __must_check clk_hw_register(struct device *dev, struct clk_hw *hw);
>   int __must_check devm_clk_hw_register(struct device *dev, struct clk_hw *hw);
> +int __must_check of_clk_hw_register(struct device_node *node, struct clk_hw *hw);
>   
>   void clk_unregister(struct clk *clk);
>   void devm_clk_unregister(struct device *dev, struct clk *clk);
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
