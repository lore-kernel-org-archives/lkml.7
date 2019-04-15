Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1C9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3766120854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfDOVz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:55:56 -0400
Received: from stcim.de ([78.46.90.227]:43648 "EHLO stcim.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbfDOVzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:55:55 -0400
Received: from xdsl-89-0-59-235.nc.de ([89.0.59.235] helo=porty)
        by stcim with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <contact@stefanchrist.eu>)
        id 1hG9Zq-0000zf-IS; Mon, 15 Apr 2019 23:55:46 +0200
Date:   Mon, 15 Apr 2019 23:55:46 +0200
From:   Stefan Lengfeld <contact@stefanchrist.eu>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 01/12] i2c: remove use of in_atomic()
Message-ID: <20190415215546.xr7aftkahcu4ygak@porty>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403124019.8947-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403124019.8947-2-wsa+renesas@sang-engineering.com>
X-PGP-Key: https://stefanchrist.eu/personal/Stefan_Lengfeld_0xE44A23B289092311.asc
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Apr 03, 2019 at 02:40:08PM +0200, Wolfram Sang wrote:
> Commit cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
> added in_atomic() to the I2C core. However, the use of in_atomic()
> outside of core kernel code is discouraged and was already[1] when this
> code was added in early 2008. The above commit was a preparation for
> commit b7a3670131c7 ("i2c-pxa: Add polling transfer"). Its commit
> message says explicitly it was added "for cases where I2C transactions
> have to occur at times interrup[t]s are disabled". So, the intention was
> 'disabled interrupts'. This matches the use cases for atomic I2C
> transfers I have seen so far: very late communication (mostly to a PMIC)
> to powerdown or reboot the system. For those cases, interrupts are
> disabled then. It doesn't seem that in_atomic() adds value.
> 
> After a discussion with Peter Zijlstra[2], we came up with a better set
> of conditionals to match the use case.
> 
> The I2C core will soon gain an extra callback into bus drivers
> especially for atomic transfers to make them more generic. The code
> deciding which transfer to use (atomic/non-atomic) should mimic the
> behaviour which locking to use (trylock/lock). This is why we add a
> helper for it.
> 
> [1] https://lwn.net/Articles/274695/
> [2] http://patchwork.ozlabs.org/patch/1067437/
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested-by: Stefan Lengfeld <contact@stefanchrist.eu>

snipped

> diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
> index 37576f50fe20..9d8526415b26 100644
> --- a/drivers/i2c/i2c-core.h
> +++ b/drivers/i2c/i2c-core.h
> @@ -29,6 +29,16 @@ extern int		__i2c_first_dynamic_bus_num;
>  
>  int i2c_check_7bit_addr_validity_strict(unsigned short addr);
>  
> +/*
> + * We only allow atomic transfers for very late communication, e.g. to send
> + * the powerdown command to a PMIC. Atomic transfers are a corner case and not
> + * for generic use!
> + */
> +static inline bool i2c_in_atomic_xfer_mode(void)
> +{
> +	return system_state > SYSTEM_RUNNING && irqs_disabled();
> +}

I agree that this code is a lot better than the previous
'irqs_disabled() || in_atomic()'. It also makes clear that the atomic
I2C transfers is only meant for late shutdown I2C communcation.


After I read the article https://lwn.net/Articles/274695/ again I
nevertheless cannot really say whether the usage of 'irqs_disabled()' is
the theoretical correct approach. The article states explicitly that
only the caller can really decided whether the operation should be
atomic or not.

Recap from previous discussions:

But then you have to patch every call site to use either a new function
like 'i2c_transfer_atomic()' or the extend I2C message flags. And mostly
also supported this trough regmap and maybe other translation layers,
which seems unpractical, may breaking existing usages and maybe not
worth the hassle.

For me this patch seems good and I don't know better.

Kind regards,
Stefan
