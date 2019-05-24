Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ACBC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E78F2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558680872;
	bh=6yxF1DtxCQR03wlZSHaFbiN7xZqIfFk2Sf23Qua7HVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DhS9jsvuPY8K8Oae988VnhcJKkg/nMMA1uuhCfgr82H9ujYFCyjomXZAn18cvHpm0
	 whamKLubAta4EdYtRIqWxbY9FvEs4qg7LyzZFmcoLFAbAQ7K3ZGJgzTkBCYjLH1mrT
	 Y+AFqrcUbsydhFG72X9c+gS4IakSJ9GlwpixaoL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbfEXGyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 02:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388460AbfEXGyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:54:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74A712175B;
        Fri, 24 May 2019 06:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558680869;
        bh=6yxF1DtxCQR03wlZSHaFbiN7xZqIfFk2Sf23Qua7HVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1iEFCXphs7fp5rMUlTY41GxWM8ORExSmofvbS+cVmeAPQqqWe1MBg44+/ygUdtAuo
         Qtj4yin9EuUdQzWNYIFOILGMqkoA023RDARfaYfhmz4DxVcEnhoEAuKmckA+DpwhyQ
         K3tG8sohWZcXnvaJxzwRsRiDnyimrA4dAoImhX8Q=
Date:   Fri, 24 May 2019 08:54:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     colin.king@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: gdm724x: Remove variable
Message-ID: <20190524065427.GB3600@kroah.com>
References: <20190524060026.3763-1-nishkadg.linux@gmail.com>
 <20190524060026.3763-2-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524060026.3763-2-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:30:26AM +0530, Nishka Dasgupta wrote:
> The return variable is used only twice (in two different branches), and
> both times it is assigned the same constant value. These can therefore
> be merged into the same assignment, placed at the point that both
> these branches (and no other) go to. The return variable itself can be
> removed.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_usb.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Your subject line needs a lot of work.

How about:
	staging: gdm724x: remove unneeded variable in init_usb()



> 
> diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> index d023f83f9097..8145ae2afba7 100644
> --- a/drivers/staging/gdm724x/gdm_usb.c
> +++ b/drivers/staging/gdm724x/gdm_usb.c
> @@ -295,7 +295,6 @@ static void release_usb(struct lte_udev *udev)
>  
>  static int init_usb(struct lte_udev *udev)
>  {
> -	int ret = 0;
>  	int i;
>  	struct tx_cxt *tx = &udev->tx;
>  	struct rx_cxt *rx = &udev->rx;
> @@ -326,7 +325,6 @@ static int init_usb(struct lte_udev *udev)
>  	for (i = 0; i < MAX_NUM_SDU_BUF; i++) {
>  		t_sdu = alloc_tx_sdu_struct();
>  		if (!t_sdu) {
> -			ret = -ENOMEM;
>  			goto fail;
>  		}
>  
> @@ -337,7 +335,6 @@ static int init_usb(struct lte_udev *udev)
>  	for (i = 0; i < MAX_RX_SUBMIT_COUNT * 2; i++) {
>  		r = alloc_rx_struct();
>  		if (!r) {
> -			ret = -ENOMEM;
>  			goto fail;
>  		}
>  
> @@ -349,7 +346,7 @@ static int init_usb(struct lte_udev *udev)
>  	return 0;
>  fail:
>  	release_usb(udev);
> -	return ret;
> +	return -ENOMEM;
>  }

Again, you are getting _really_ close to the "churn for churn sake".
Maybe this is needed, but it's really a fine line...

thanks,

greg k-h
