Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B53FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEC524672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576775532;
	bh=gtRIXUIO8/7p8WMoeBwntSQJkt2SzKky6CLRodXmKco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ClAIyO5Qbn5fz45YB7NmIun4auIryiKl9IKzk3R6xA7o9ZM1p9BzWHxE0h9fD0Hu
	 e9PHvdec7G1K2bE+GaO9AEVo7AqUCVyi6MUMqZ9tFqFECokgUzy140o7Ib9hDrJ7ob
	 RdUZECc2u5aO2P/cGXHUmdf8Y17BuCtm7LJUiTwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfLSRML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSRMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:12:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8EB124672;
        Thu, 19 Dec 2019 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576775530;
        bh=gtRIXUIO8/7p8WMoeBwntSQJkt2SzKky6CLRodXmKco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZ/oxQq5nLw+CSDUMlkxklbz3JHLaEkUHdpKHH7Q4vgtrdToI/9uAHR1RfS8fsYuR
         PNPoPTNKD3o3voZrF/JEkSlbdtVqIPltcCDCBgs0+U+G1c/VT60vBuB1+OD09VyQEx
         PXkisJoXixfwO3vNrNxiWnHA0oFmAdLBjFIWAovc=
Date:   Thu, 19 Dec 2019 18:11:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Bharath Vedartham <linux.bhar@gmail.com>,
        Vandana BN <bnvandana@gmail.com>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Harsh Jain <harshjain32@gmail.com>,
        Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v2] staging: kpc2000: remove unnecessary assertion on priv
Message-ID: <20191219171141.GA2068060@kroah.com>
References: <20191217225830.4018-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217225830.4018-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 04:58:24PM -0600, Aditya Pakki wrote:
> In kpc_dma_transfer(), the assertion that priv is NULL is never
> satisfied. The two callers of the function, dereference the priv
> pointer before the call is executed. This patch removes the
> unnecessary BUG_ON call.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
> v1: Replace the recovery code by removing the assertion, as suggested
> by Greg Kroah-Hartman.
> ---
>  drivers/staging/kpc2000/kpc_dma/fileops.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> index cb52bd9a6d2f..61d762535823 100644
> --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> @@ -49,7 +49,6 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
>  	u64 dma_addr;
>  	u64 user_ctl;
>  
> -	BUG_ON(priv == NULL);
>  	ldev = priv->ldev;
>  	BUG_ON(ldev == NULL);

ldev is also obviously never NULL so you can remove that at the same
time.

thanks,

greg k-h
