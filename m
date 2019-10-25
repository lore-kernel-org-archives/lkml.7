Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7130CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E6D21D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571971722;
	bh=1Ij1pOvkr5r3H3JLSktCJH50P9PNHxYON1Jh5oSWjVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kREywX6iLYPLa2Yhy2+Qxvt8J5a/yZ/xVuHenLEsGs6iSpTDB7DgvB3uk6+2cS8o0
	 nOm4Wy7jVE6eiNpWTDlV9/Aml4q/J/wC6HxE3lJnjeZM/03hLgn8AY7hRr8EbrUHYm
	 faHH4BfRZjjf7CONqFWq4+SR4DQBZ/SNrl/vQcCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390878AbfJYCsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 22:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbfJYCsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:48:41 -0400
Received: from localhost (unknown [38.98.37.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5A5621D71;
        Fri, 25 Oct 2019 02:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571971718;
        bh=1Ij1pOvkr5r3H3JLSktCJH50P9PNHxYON1Jh5oSWjVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NklGzeBx2JEUtwUrovi1KXGzUm9YB7RW1oRImgcmP42MJ+vuOKtlZi1mr5voXD0/V
         KgauZ7anOiIqaCiFO4JV5YxhjLI3RhjA+zAiHyVdH4hzeHWhAEaLdrEw1wH/PZMHSJ
         qcLqpdbdVS/eu7R2ZQEmPNaszar+L96sAcPZncuw=
Date:   Thu, 24 Oct 2019 22:42:16 -0400
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove an redundant null check
 before kfree()
Message-ID: <20191025024216.GB331827@kroah.com>
References: <1571211506-19005-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571211506-19005-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:38:26PM +0800, zhong jiang wrote:
> kfree() has taken null pointer into account. hence it is safe to remove
> the unnecessary check.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_xmit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index 7011c2a..4597f4f 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -2210,8 +2210,7 @@ void rtw_free_hwxmits(struct adapter *padapter)
>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
>  
>  	hwxmits = pxmitpriv->hwxmits;
> -	if (hwxmits)
> -		kfree(hwxmits);
> +	kfree(hwxmits);
>  }
>  
>  void rtw_init_hwxmits(struct hw_xmit *phwxmit, sint entry)
> -- 
> 1.7.12.4
> 

Patch does not apply to my tree :(
