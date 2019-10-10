Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01077C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28352190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570698250;
	bh=H6RTQHkgnOqK1Pnifhj8f8xAqA61MNagEhmL/2b5I/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l1+aOrJiWb+aEooDySWPU03tSAxqWwoJXpczrUPrUObjioK5MnW5Q0O8dbH9NgBZP
	 OgNTbz1FDlEoKD7mcQhbRKJS1tZoDlTYO1JLVxneeiNQnRQaS2t986rhACUR26FLSm
	 BDI2QS2O3kxf097WhuoitC5f0Q+94QY6nxDkowCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbfJJJEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387524AbfJJJEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:04:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7112067B;
        Thu, 10 Oct 2019 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570698248;
        bh=H6RTQHkgnOqK1Pnifhj8f8xAqA61MNagEhmL/2b5I/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKYaTGr+/60LAks4D8ZWDzkm2fvx44gz7TM+BndY0b2zBkB9V5ZopH6LwWInWB1YW
         JrQIxwsgr0cIg8zGV16AXp9JIENSPJCnvHeiPWaeuVuJIVhISJnaMhViNWy46Xg68j
         g+vhTcKDCy5oWCuSxcc42LhSizxSpHC064IkV/OA=
Date:   Thu, 10 Oct 2019 11:04:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] staging: sm750fb: Potential uninitialized field in "pll"
Message-ID: <20191010090406.GA466733@kroah.com>
References: <20191010043809.27594-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010043809.27594-1-yzhai003@ucr.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 09:38:08PM -0700, Yizhuo wrote:
> Inside function set_chip_clock(), struct pll is supposed to be
> initialized in sm750_calc_pll_value(), if condition
> "diff < mini_diff" in sm750_calc_pll_value() cannot be fulfilled,
> then some field of pll will not be initialized but used in
> function sm750_format_pll_reg(), which is potentially unsafe.
> 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/staging/sm750fb/ddk750_chip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index 5a317cc98a4b..31b3cf9c2d8b 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -55,7 +55,7 @@ static unsigned int get_mxclk_freq(void)
>   */
>  static void set_chip_clock(unsigned int frequency)
>  {
> -	struct pll_value pll;
> +	struct pll_value pll = {};
>  	unsigned int actual_mx_clk;
>  
>  	/* Cheok_0509: For SM750LE, the chip clock is fixed. Nothing to set. */

This doesn't apply to my tree at all.  Please rebase it against the
staging-next branch of staging.git and resend.

thanks,

greg k-h
