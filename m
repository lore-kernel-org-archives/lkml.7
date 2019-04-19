Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366C8C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA37204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698834;
	bh=h3gcGpiGPtefheJf96gt7F+FQkOHoNChboFIJMOtF60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E9q7saNzboLd/xUhTathr1a+zxb37krLQdu2wzwqtslD/n5RI1BRC4cjVKbKHiYdo
	 iuoQUYkt6kAuQhALgz+d+2CbYcwCjpeUhvHBLXybbgMim5aHKVgdrs/vOeQI3fLS8D
	 NUdvdqhfWrYEp7E2b2Sw0Sa4+P4vIesX2BaCpOe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfDSSdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbfDSS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ACB621903;
        Fri, 19 Apr 2019 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555672860;
        bh=h3gcGpiGPtefheJf96gt7F+FQkOHoNChboFIJMOtF60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXwRrlDP489Vvntan/RU8yP8FCWNLSAnCt32CnDERPevJz4ocKVGeOQa3Ql0X++X6
         OCtp9Mbp9nyHzokygin1RrfBs1S04fSevGbHx3kIiuiaewhUSSpAxl43TWE1HCBOha
         4iX9ZHR0iVmtuE08AG6I96zw25KDmnUFBjsm5pZA=
Date:   Fri, 19 Apr 2019 13:20:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bhanusree Pola <bhanusreemahesh@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: rtl8723bs: Avoid typedefs for structure
Message-ID: <20190419112057.GA14886@kroah.com>
References: <1555672376-20268-1-git-send-email-bhanusreemahesh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555672376-20268-1-git-send-email-bhanusreemahesh@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 04:42:56PM +0530, Bhanusree Pola wrote:
> Avoid typedefs for structure types to maintain kernel coding style.
> Remove typedefs for _ODM_Phy_Dbg_Info and _ODM_Mac_Status_Info_.
> This part is done by the following semantic patch:
> 
> <smpl>
> @r1@
> identifier i;
> type t;
> @@
> typedef struct i {
> ...
> }t;
> 
> @r2@
> type r1.t;
> identifier v;
> @@
> t v;
> 
> @script:python match@
> i << r1.i;
> x;
> @@
> coccinelle.x = i;
> 
> @r4@
> identifier match.x;
> type r1.t;
> @@
> - typedef struct x
> + struct x
> { ... }
> - t
> ;
> 
> @r5@
> type r1.t;
> identifier r2.v, match.x;
> @@
> - t v;
> + struct x v;
> </smpl>
> 
> Change Structure name _ODM_Phy_Dbg_Info and _ODM_Mac_Status_Info_ to maintain Linux kernel Coding Style.
> Replace occurences of ODM_PHY_DBG_INFO_T to odm_phy_dbg_info and ODM_MAC_INFO to odm_mac_status_info.
> 
> Signed-off-by: Bhanusree Pola <bhanusreemahesh@gmail.com>
> ---
> v2:
>  Changed the occurence of (ODM_MAC_INFO *) to (struct odm_mac_status_info *) in the commented code
> 
>  drivers/staging/rtl8723bs/hal/odm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
> index 7de5161..9db9f17 100644
> --- a/drivers/staging/rtl8723bs/hal/odm.c
> +++ b/drivers/staging/rtl8723bs/hal/odm.c
> @@ -691,7 +691,7 @@ void ODM_CmnInfoHook(PDM_ODM_T pDM_Odm, ODM_CMNINFO_E CmnInfo, void *pValue)
>  	/* break; */
>  
>  	/* case ODM_CMNINFO_MAC_STATUS: */
> -	/* pDM_Odm->pMacInfo = (ODM_MAC_INFO *)pValue; */
> +	/* pDM_Odm->pMacInfo = (struct odm_mac_status_info *)pValue; */
>  	/* break; */
>  	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
>  	default:

This patch doesn't really do anything at all, right?

Are you sure you included the correct patch?

thanks,

greg k-h
