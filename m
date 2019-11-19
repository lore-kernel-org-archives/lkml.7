Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0832C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748F12230C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574150346;
	bh=Ld566us/253H4UlC/U9J6/5di2INvcC40kur0c0jF1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xNKrhoZZixcU9PYVvWsyQpHASKyUZF/q/2HK23kqjUZGE9ZG+BvrTlSmPG44cUJvA
	 S7m3LRLFPt5gsPp5SEGdc1J5S/cTuV9zEAFYzSIJtRxIH0u5AutJ/JdXADP4NM3k2v
	 eXthpjLoVVB3wdaCshXvpgPQlxA3yOLJ2Ibtn8D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfKSH7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 02:59:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfKSH7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:59:03 -0500
Received: from localhost (unknown [89.205.134.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF19822312;
        Tue, 19 Nov 2019 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574150342;
        bh=Ld566us/253H4UlC/U9J6/5di2INvcC40kur0c0jF1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zPYSBYy8xvhgn0yPWzrvPImskm4fnvhCIg585Y5wEaE89cA+XBqwinRXsqZp3kl5z
         kuZpPqvc0qXjERxs58j0Teu5ZsV1hG8A5bf27Yr4maB3LOIuDnwy8GPVvKk4dSd4uy
         z2pNo35jmNeuL1zSZSTqMMyL6zeGQLv9dcV4f2qM=
Date:   Tue, 19 Nov 2019 08:58:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rui_feng@realsil.com.cn
Cc:     arnd@arndb.de, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: rtsx: Fix impossible condition
Message-ID: <20191119075859.GC1858193@kroah.com>
References: <1574148825-2797-1-git-send-email-rui_feng@realsil.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574148825-2797-1-git-send-email-rui_feng@realsil.com.cn>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 03:33:45PM +0800, rui_feng@realsil.com.cn wrote:
> From: Rui Feng <rui_feng@realsil.com.cn>
> 
> A u8 can only go up to 255, condition n > 396 is
> impossible, so change u8 to u16.
> 
> Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
> ---
>  drivers/misc/cardreader/rts5261.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
> index 32dcec2..8dba0bf 100644
> --- a/drivers/misc/cardreader/rts5261.c
> +++ b/drivers/misc/cardreader/rts5261.c
> @@ -628,7 +628,8 @@ int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
>  		u8 ssc_depth, bool initial_mode, bool double_clk, bool vpclk)
>  {
>  	int err, clk;
> -	u8 n, clk_divider, mcu_cnt, div;
> +	u16 n;
> +	u8 clk_divider, mcu_cnt, div;
>  	static const u8 depth[] = {
>  		[RTSX_SSC_DEPTH_4M] = RTS5261_SSC_DEPTH_4M,
>  		[RTSX_SSC_DEPTH_2M] = RTS5261_SSC_DEPTH_2M,
> @@ -661,9 +662,9 @@ int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
>  		return 0;
>  
>  	if (pcr->ops->conv_clk_and_div_n)
> -		n = (u8)pcr->ops->conv_clk_and_div_n(clk, CLK_TO_DIV_N);
> +		n = (u16)pcr->ops->conv_clk_and_div_n(clk, CLK_TO_DIV_N);
>  	else
> -		n = (u8)(clk - 4);
> +		n = (u16)(clk - 4);

Why is the cast now needed?  Same for everywhere else.

thanks,

greg k-h
