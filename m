Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1246EC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A9E2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556779225;
	bh=VKRnFzqwCQEQEJ4Whj1x0Xu91tlu8JsLCBySle3yAbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WGfDvfvYpg4Ku9GbmaVg0gkxX8+PATAOoEyg0Nqqm9btY65OoRVGo3sE+kWUWKNWs
	 QTjlQcxjBQA+RWoTXM5PgTE1AHlKdht5UpD0/5eak4o0i2CfQc2houMUdlAXS2GB4G
	 OEH+d1jt1/3asixBQnnpULCfUCoTR5b0izJYwPPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfEBGkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 02:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfEBGkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 02:40:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ABF1208C4;
        Thu,  2 May 2019 06:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556779223;
        bh=VKRnFzqwCQEQEJ4Whj1x0Xu91tlu8JsLCBySle3yAbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8p1ZpJppNoJp7O4j75gUhtvC7VqfqcrSud4+QxpZ5Av0V6CcEwfq2CqR/sfp+a5r
         UXy7GLtsv0jhdmm0qAE/Kasgsaz4tTh4ayHBl14I4g9WPIPEk6IOBap7JOL2RH1Y1L
         l+05oYWOcBVWK9MorrgwN1u+pGDHMuSXGRmIncRg=
Date:   Thu, 2 May 2019 08:40:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sdasari@fb.com
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
Message-ID: <20190502064021.GA14911@kroah.com>
References: <20190501223836.1670096-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501223836.1670096-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 03:38:36PM -0700, Vijay Khemka wrote:
> Corrected some of return values with appropriate meanings.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
> index 332210e06e98..97ae341109d5 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -68,7 +68,6 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>  		unsigned long param)
>  {
>  	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
> -	struct device *dev = file->private_data;
>  	void __user *p = (void __user *)param;
>  	struct aspeed_lpc_ctrl_mapping map;
>  	u32 addr;

This change is not reflected in your changelog text :(

Please fix up, or break this up into multiple patches.

greg k-h
