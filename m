Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE38C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9CD20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555318989;
	bh=o94C3pRsnUp1q4hbRWMvpQZolUpciNHeJyzwWsLxD9Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=1s2x24kmF76+zsuRJvtBJZlYuCgaf3TPi31yTzChWUR2oBr9CrzmHfUqY/WHJE++v
	 bdf6jQC1HRucFDgocqt6or3rNgAgBshM8jbMK2CjDV+2rcx95kKvP/zUqf2CLFgSIg
	 0lxSzWRy2PWXmF0UmxXTVdFcsxRH7uexmmduhBG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDOJDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfDOJDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:03:07 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEFF620833;
        Mon, 15 Apr 2019 09:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555318987;
        bh=o94C3pRsnUp1q4hbRWMvpQZolUpciNHeJyzwWsLxD9Y=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=hlvbgAIJyMUOrwF9thr72g15mb+hjsXdfSfaSbPdjpQYtN2kqgMDu7Z1HLE59EOQS
         E8n7engiowIpBXBZ10/gi3wHwqGT5BGrh1ikgTm32TgcxXKTQICWfOGLEXmVqi4tab
         G7uw2vay8H88ChrAC7FT8bm6j377DjKRo23o9BQg=
Date:   Mon, 15 Apr 2019 11:03:03 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Mao Wenan <maowenan@huawei.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>
Subject: Re: [PATCH] HID: fix compiling error in u2fzero_probe()
In-Reply-To: <20190413134459.76045-1-maowenan@huawei.com>
Message-ID: <nycvar.YFH.7.76.1904151102250.9803@cbobk.fhfr.pm>
References: <20190413134459.76045-1-maowenan@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2019, Mao Wenan wrote:

> There is one compiling error in u2fzero_probe()->u2fzero_init_hwrng(),
> this is because HW_RANDOM is not set.
> 
> drivers/hid/hid-u2fzero.o: In function `u2fzero_probe':
> hid-u2fzero.c:(.text+0xc70): undefined reference to `devm_hwrng_register'
> 
> Fixes: 42337b9d4d958("HID: add driver for U2F Zero built-in LED and RNG")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 4dc1035..76d8206 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1017,6 +1017,7 @@ config HID_U2FZERO
>  	tristate "U2F Zero LED and RNG support"
>  	depends on USB_HID
>  	depends on LEDS_CLASS
> +	depends on HW_RANDOM

[ CCing Andrej ]

This was supposed to be sent by Andrej (together with other fixes), but 
you beat him to it. Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

