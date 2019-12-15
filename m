Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A9BC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A669206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576434498;
	bh=FJoCcm3/m6bmGnsMRlppEMrCQYBjPw89R85uQ5q+42s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xmAvt1r1o/QI8C6jaVcwZmt8/bEoSYyKB1a71TrPC93t1JIgJDV6Gtb075MQzDspx
	 rgK/DA088jyWHvGn5ul7i68jHTOwYVyXbl9t4lJW6elThdKu6KOwYYLElEdWu25nNl
	 kbTeVPWfvT+K04A7SBxf8zmSH3buRocZPK8gF+T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfLOS2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 13:28:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfLOS2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 13:28:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB93206E0;
        Sun, 15 Dec 2019 18:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576434496;
        bh=FJoCcm3/m6bmGnsMRlppEMrCQYBjPw89R85uQ5q+42s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mu/uaV7tJ4lQeAsVtSTM+UXRFX2qogrSRvRYzofFP1KeMqKSFfzlwhC9inkJRc1Qk
         a/ccQJSFTKhlLnWTOsMX/KiNKgC7Srcu3O73oZeH0uZIqwmPTwqqUMID1n53KfKhnc
         PUduw/Yng/jpKXaIzMf32r7ZWDtwmLDcrOIZeuL4=
Date:   Sun, 15 Dec 2019 19:28:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     devel@driverdev.osuosl.org, Vandana BN <bnvandana@gmail.com>,
        Harsh Jain <harshjain32@gmail.com>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Subject: Re: [PATCH] staging: kpc2000: replace assertion with recovery code
Message-ID: <20191215182814.GA859066@kroah.com>
References: <20191215181243.31519-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215181243.31519-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 12:12:37PM -0600, Aditya Pakki wrote:
> In kpc_dma_transfer, if either priv or ldev is NULL, crashing the
> process is excessive and is not needed. Instead of asserting, by
> passing the error upstream, the error can be handled.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/staging/kpc2000/kpc_dma/fileops.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> index cb52bd9a6d2f..1c4633267cc1 100644
> --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> @@ -49,9 +49,11 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
>  	u64 dma_addr;
>  	u64 user_ctl;
>  
> -	BUG_ON(priv == NULL);
> +	if (!priv)
> +		return -EINVAL;

How can prive ever be NULL here?  Can you track back to all callers to
verify this?  If so, just remove the check.

thanks,

greg k-h
