Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B011C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0C92238C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559250767;
	bh=8ogzh1kXxnB4e4k6xpIqU2Y6rtedLnLHRgwK4C8BkxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0VuGpGTribaWInlycqzuZWs2ViUl1fo/puwOAoqr1OZPFcXZjFySTVN3iLtcsfyLH
	 3mG+2fQ+PB+jQ+4RguhZo9FnIdAFLriA+iYVj8gtFMdTxUuXh/A7BmcIt1pVcECrlp
	 zTv6vPLANEVD3jhK6fkjZmVMEMsReKWOhg1/fhTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfE3VMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfE3VMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:12:45 -0400
Received: from localhost (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE53621985;
        Thu, 30 May 2019 21:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559250765;
        bh=8ogzh1kXxnB4e4k6xpIqU2Y6rtedLnLHRgwK4C8BkxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y+4fRKmJ9QXOZWZLpA/DAp88qHyQyRLnoGL/6/Dme0ree+A+GQ/SE7E5acG8x6hLz
         dV0Cf3jLUqaAQ/GpVK8kfEk0EixWb7d9Y0YZs4F52VX8IUzFN+XNGSmDdkD8TifKsA
         3ypNkO2Oz4EdiXRAtsp+XS30uh5NuIAVr+H6z1eQ=
Date:   Thu, 30 May 2019 14:12:44 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        himadri18.07@gmail.com, daniela.mormocea@gmail.com,
        straube.linux@gmail.com, vatsalanarang@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Remove unnecessary variable in
 rtl8712_recv.c
Message-ID: <20190530211244.GA24020@kroah.com>
References: <20190529132031.6493-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529132031.6493-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 06:50:31PM +0530, Nishka Dasgupta wrote:
> Remove unnecessary variable last_evm in rtl8712_recv.c and use its value
> directly.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl8712_recv.c | 5 ++---
>  drivers/staging/rtl8712/rtl871x_cmd.c  | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
> index 82ddc0c3ecd4..f6f7cd5fd0f2 100644
> --- a/drivers/staging/rtl8712/rtl8712_recv.c
> +++ b/drivers/staging/rtl8712/rtl8712_recv.c
> @@ -885,7 +885,7 @@ static void query_rx_phy_status(struct _adapter *padapter,
>  static void process_link_qual(struct _adapter *padapter,
>  			      union recv_frame *prframe)
>  {
> -	u32	last_evm = 0, tmpVal;
> +	u32	tmpVal;
>  	struct rx_pkt_attrib *pattrib;
>  	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
>  
> @@ -898,8 +898,7 @@ static void process_link_qual(struct _adapter *padapter,
>  		 */
>  		if (sqd->total_num++ >= PHY_LINKQUALITY_SLID_WIN_MAX) {
>  			sqd->total_num = PHY_LINKQUALITY_SLID_WIN_MAX;
> -			last_evm = sqd->elements[sqd->index];
> -			sqd->total_val -= last_evm;
> +			sqd->total_val -= sqd->elements[sqd->index];

Nope, original code is easier to understand :(

>  		}
>  		sqd->total_val += pattrib->signal_qual;
>  		sqd->elements[sqd->index++] = pattrib->signal_qual;
> diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
> index 05a78ac24987..7c437ee9e022 100644
> --- a/drivers/staging/rtl8712/rtl871x_cmd.c
> +++ b/drivers/staging/rtl8712/rtl871x_cmd.c
> @@ -880,7 +880,7 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter,
>  		}
>  		r8712_indicate_connect(padapter);
>  	} else {
> -		pwlan = _r8712_alloc_network(pmlmepriv);
> +		pwlan = r8712_alloc_network(pmlmepriv);

what does this change have to do with your changelog?

confused,

greg k-h
