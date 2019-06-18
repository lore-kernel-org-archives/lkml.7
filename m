Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBFBC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAE820823
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560841175;
	bh=5ecne3rCtVqpWXP+h0ZrAWJGGu531cJx7E9w2U9xOz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EE47hvvGN5s3JUheHanyPDHvQ6uhXmZuMbdcd5Z86uws7aCJ3yAyazuRCnICzWKkN
	 qKP8wM9XBiUVrIj0FBuCOjOtGN9lQndcAgu6mgvH8FWVdG978P5VYPYe7MxnVaMult
	 Sgf2dx/QVF/CGIy0dgyrUfUvYGHR1kcC6CkwbQk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfFRG7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfFRG7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:59:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9FE20673;
        Tue, 18 Jun 2019 06:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560841172;
        bh=5ecne3rCtVqpWXP+h0ZrAWJGGu531cJx7E9w2U9xOz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nW10Hu++sUQrj/S3YQTKUNgZJgfWeNCSb95YUyAw0/gQlWPavg1CfR91PTbv60Cgy
         HaE+ZOhu3Vdc25N0ZC7bJvT20lGMLHaT0eu850YiT8QH35rZ9nlejaP2LGHkgtFCY2
         gJl1cK8K4kK5wU7MDBxhKaP6wHa8fVWD4MoeEFCI=
Date:   Tue, 18 Jun 2019 08:59:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Jeeeun Evans <jeeeunevans@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Omer Efrat <omer.efrat@tandemg.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Puranjay Mohan <puranjay12@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: Make use rtw_zmalloc
Message-ID: <20190618065930.GB15358@kroah.com>
References: <20190616051619.GA15036@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616051619.GA15036@hari-Inspiron-1545>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 10:46:19AM +0530, Hariprasad Kelam wrote:
> rtw_malloc with memset can be replaced with rtw_zmalloc.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 9bc6856..aa7cc50 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -1078,12 +1078,10 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
>  	DBG_871X("pairwise =%d\n", pairwise);
>  
>  	param_len = sizeof(struct ieee_param) + params->key_len;
> -	param = rtw_malloc(param_len);
> +	param = rtw_zmalloc(param_len);


No, please call the "real" kernel function instead.

thanks,

greg k-h
