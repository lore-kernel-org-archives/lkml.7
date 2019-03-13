Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EBBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3510F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552500019;
	bh=iyw5aTKEkQKgz7UBxN+cWeL+tRN+7WqJP1sI9zGtmF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vf1rWFBDylqrXb0KqLp86UQ5yYPDZL+ouhHlTlLu+gLE+p2p9GRPQTlRlthbtr085
	 6DFjZPeyYkXI5PQW3hn9jX+hzDRXxbxSTaRGtxMrCH2kb3eosdxGWBP7nAuKQRFeqi
	 yxhO//dade5jFAks3ExVVSxl0nuElXiq3blifvnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfCMSAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMSAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:00:17 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99F4320854;
        Wed, 13 Mar 2019 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552500016;
        bh=iyw5aTKEkQKgz7UBxN+cWeL+tRN+7WqJP1sI9zGtmF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nx3KlfC/JlitpBl0/m8vla27u4MEo7wDvX6UdpF269uptJR1+13CZkPi57dp/EZVg
         HB9CCAow4CQppjrjN48GiSPiTMP7HpV+lGG3NoyEALa0fTjliuR4R0v3nX9Dk1PBRU
         Glipi0aj/DVIOx9pkCv2pHPYLIuXGW/32UNXiS0s=
Date:   Wed, 13 Mar 2019 11:00:16 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     devel@driverdev.osuosl.org, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: rtl8188eu: Fix potential NULL pointer
 dereference
Message-ID: <20190313180016.GB27267@kroah.com>
References: <20190313171132.23052-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313171132.23052-1-pakki001@umn.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:11:30PM -0500, Aditya Pakki wrote:
> hwxmits is allocated via kcalloc and not checked for failure before its
> dereference. The patch fixes this problem similar to rtl8723bs.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/staging/rtl8188eu/core/rtw_xmit.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> index 1723a47a96b4..a557ed37923a 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> @@ -1512,6 +1512,10 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
>  
>  	pxmitpriv->hwxmits = kcalloc(pxmitpriv->hwxmit_entry,
>  				     sizeof(struct hw_xmit), GFP_KERNEL);
> +	if (!pxmitpriv->hwxmits) {
> +		DBG_88E("alloc hwxmits fail!...\n");

You never need to print a message for a memory allocation failure, that
happens by the function that tried to allocate the memory.

> +		return;

Shouldn't you return an error?

thanks,

greg k-h
