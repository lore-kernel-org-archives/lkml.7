Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9701C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31B320840
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560077975;
	bh=cSnrY0iwjVJXZwlEA+2n8J0j0S3Bx09YY45oP76Myok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yUqB8zWtG2m5MR1vAEDTkz702Y2Ou+54KifOPRtWuBBkD+jMprlaB/x6hWh56b/Z6
	 2Ttj79KrSQaZXrgnypJKBwVNjmTSfsY86bscP+DAZSGiWxJhiepuxSHj/vivajNDzR
	 Sn6sqi7KP/YFOu0LdvDFNcnIUlFgiB01A1CJtqlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfFIK7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 06:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbfFIK7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 06:59:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EAB02083D;
        Sun,  9 Jun 2019 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560077974;
        bh=cSnrY0iwjVJXZwlEA+2n8J0j0S3Bx09YY45oP76Myok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCJF76xSiUB32mel7TvguvVDFQqBgoIcn2OFACK2R2d0l4IIjNsxL6nGAj7hPDzgb
         Y+SGYsTo6jAbm6PI/tOljchkwivb0T3coyV6q86U/c97BodWtH+mzuFIADssf8sQ3+
         7k3NvE84Vc9sFPeUEw37b1ZKKFwPBRyyUPO630Ss=
Date:   Sun, 9 Jun 2019 12:59:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Valerio Genovese <valerio.click@gmail.com>
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: isdn: hysdn: fix symbol 'hysdn_proc_entry' was
 not declared.
Message-ID: <20190609105931.GB30671@kroah.com>
References: <20190605135349.6840-1-valerio.click@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605135349.6840-1-valerio.click@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 03:53:49PM +0200, Valerio Genovese wrote:
> This was reported by sparse:
> drivers/staging/isdn/hysdn/hysdn_procconf.c:352:23: warning: symbol 'hysdn_proc_entry' was not declared. Should it be static?
> 
> Signed-off-by: Valerio Genovese <valerio.click@gmail.com>
> ---
>  drivers/staging/isdn/hysdn/hysdn_defs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/isdn/hysdn/hysdn_defs.h b/drivers/staging/isdn/hysdn/hysdn_defs.h
> index cdac46a21692..a651686b1787 100644
> --- a/drivers/staging/isdn/hysdn/hysdn_defs.h
> +++ b/drivers/staging/isdn/hysdn/hysdn_defs.h
> @@ -221,7 +221,7 @@ typedef struct hycapictrl_info hycapictrl_info;
>  /* exported vars */
>  /*****************/
>  extern hysdn_card *card_root;	/* pointer to first card */
> -
> +extern struct proc_dir_entry *hysdn_proc_entry; /* hysdn subdir in /proc/net

I can not take drivers/staging/isdn patches until 5.3-rc1.

thanks,

greg k-h
