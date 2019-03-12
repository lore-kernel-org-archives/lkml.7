Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FC8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEED820657
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QbxQz77T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfCLM1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:27:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45681 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLM1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:27:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id h99so1471295wrh.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vvg0MSJblpzxKFZiJBKUrB9yVh4oMAzNMDxux+emkOM=;
        b=QbxQz77TINAiYtAP0Foi5rUjGmFlGSJphnWE1JAYaY47Xog4rzZZCLCkiKn2OD9jRX
         iPSqw7LboWkbkwnuG8O7lot8Vmf5F0hAD7MePI02OFIPj7G/SRuEPQH9fjA1DQXWW0U3
         tAGI4Bd4MtNpY2OjVr4KMGmAxMuXMWD7uS2kmNEjrP3yLwNWzlcvJz3WHhrnb3f4HwNR
         fXpy9uR0h384VQeMcboyd8JS9ICxC1pTmwfezQO8aLineIfnZiWys/W88y2XD8+5d/nx
         ghLv449og03QIVLC6BY/lAx7riOzmxCAJaQzlarI1L8a2Zztyy8nhZd42BiGgHipCaR4
         8gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vvg0MSJblpzxKFZiJBKUrB9yVh4oMAzNMDxux+emkOM=;
        b=oYlBtW6RtQt1nSc5Jt4XxEad0Rj1L9DgA0eS56aizL2D8dck2OWb+gaKS2OtEg1Sn1
         ycqWWUTHcR2ak7lYUoSKIhofMTfYYWcMd2tOoZSbVTYSZnNMKD/8zogoaZG3aEE39z5h
         2d8WfDesx4wmM9r9MrgfpkSTahQruQqU/O45m26jDcR/z8NGc5UGbuqQgaROjpX5Nkwo
         GBMTCDjqN4V0soSfVS+GlNfrid7ccGrAez8+toVWS4+mizhmtyvqSDx31Ft4QSYMCayc
         6u4Trb6nhvDYBGg5YqShfo2yswr+8Tt68S9rcecjpyLWEC6NSZ7n2Lc+4DGmK2Jz6/6n
         8A6g==
X-Gm-Message-State: APjAAAWDmXYYB5K6UkI57Z+iV5g5dbLFF83jFLJoPh/XD/HfB8VaJRRk
        WduqfwdANWGwBEvGvcYsCBwaMw==
X-Google-Smtp-Source: APXvYqxQo/sWkzNQIDoHcb0MbfzNbzDxEr878iRRLRXE9CXGx9+JGC+MF3bqObR+cUUj7LGJrlaSmg==
X-Received: by 2002:adf:f78e:: with SMTP id q14mr26263871wrp.227.1552393633704;
        Tue, 12 Mar 2019 05:27:13 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o63sm2473251wmo.46.2019.03.12.05.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 05:27:12 -0700 (PDT)
Date:   Tue, 12 Mar 2019 12:27:11 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux@armlinux.org.uk, xuwei5@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, peter.griffin@linaro.org,
        guodong.xu@linaro.org, haojian.zhuang@linaro.org
Subject: Re: [PATCH 1/2] amba: Take device out of reset before reading pid
 and cid values
Message-ID: <20190312122711.b2ibipico2dgavl7@holly.lan>
References: <20190309015635.5401-1-manivannan.sadhasivam@linaro.org>
 <20190309015635.5401-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309015635.5401-2-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 07:26:34AM +0530, Manivannan Sadhasivam wrote:
> For the AMBA Primecell devices having the reset lines wired, it is
> necessary to take them out of reset before reading the pid and cid values.
> Earlier we were dependent on the bootloader to do this but a more cleaner
> approach would be to do it in the kernel itself. Hence, this commit
> deasserts the reset line just before reading the pid and cid values.
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/amba/bus.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 41b706403ef7..da8f1aac5315 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -21,6 +21,7 @@
>  #include <linux/limits.h>
>  #include <linux/clk/clk-conf.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  
>  #include <asm/irq.h>
>  
> @@ -352,6 +353,7 @@ static void amba_device_release(struct device *dev)
>  
>  static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>  {
> +	struct reset_control *rst;
>  	u32 size;
>  	void __iomem *tmp;
>  	int i, ret;
> @@ -388,6 +390,13 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>  	if (ret == 0) {
>  		u32 pid, cid;
>  
> +		/* De-assert the reset line to take the device out of reset */
> +		rst = reset_control_get_optional_exclusive(&dev->dev, NULL);
> +		if (IS_ERR(rst))
> +			return PTR_ERR(rst);

It is really correct to propagate an error if we cannot get exclusive
ownership of the reset line.

With drivers for vendor specific cells it is ok to "just know" that the
reset line is never shared but we cannot know this for generic cells and
we certainly can't know this for the bus.

I think it *might* be OK to propagate an error if you used
reset_control_get_optional_shared() instead because if that reports an
error than arguably we have either a mistake in the DT or a bug in the
driver we are sharing a reset with.


> +
> +		reset_control_deassert(rst);

Perhaps we might also need to explain why we can ignore -ENOTSUPP
here. Perhaps something like the following based on the comment
found in in reset_control_deassert():

		/*
		 * -ENOTSUPP means occurs when the reset controller
		 * does not implement .deassert(), in which case the
		 * the reset lines should be self-deasserting (and
		 * deasserted by default).
		 */
		WARN_ON(deassert did not return 0 or -ENOTSUPP);
> +
>  		/*
>  		 * Read pid and cid based on size of resource
>  		 * they are located at end of region

This looks like it will leak the control reference... shouldn't there
be a put after you have read the pid/cid?


Daniel.
