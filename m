Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B9DCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982FD20679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572690650;
	bh=sF4nfLxBOEZkHO9qQsfjmcuOOEgD4OvA99sJnz6xUY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KlCR7rY5MhmtID2J/AN2vk1KFmKZvRcevIIwYMLQ61OkA2LQmN+rPw0cwkHzVdfJY
	 fsJDerV1LPtS3HUbv6CdXeG6jIJSovYLqpXaX+c3JIbmjwmWDAkKuDxvQX7hGAMAC+
	 NWqOCHTZ8g7oyRvo00NzIFaHbhO/UV0iOy7Lb/4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfKBKat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfKBKat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:30:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 107F220862;
        Sat,  2 Nov 2019 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572690648;
        bh=sF4nfLxBOEZkHO9qQsfjmcuOOEgD4OvA99sJnz6xUY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vrpSJR+uOL5bqcduqgk2DWrD4pkHenJ+/jO01+H5uUmRIqzQSEqSlSUzp2uRfSG2n
         Tg50Q72ftJ56no0KxlKTTpoOhgiuolf8srWn9PaCktEHS1avnBFmaOjt2tO5YE7csA
         16VEhvvQ74pPg68t7fON5N11wk2MJgBhIp/IaGR8=
Date:   Sat, 2 Nov 2019 11:30:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jerome.pouiller@silabs.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: Fix a memory leak in 'wfx_upload_beacon'
Message-ID: <20191102103045.GA135025@kroah.com>
References: <20191101172151.14295-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101172151.14295-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 06:21:51PM +0100, Christophe JAILLET wrote:
> The current code is a no-op, because all it can do is 'dev_kfree_skb(NULL)'
> Revert the test to free skb, if not NULL.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is purely speculative.
> 
> The 'if  (...)' could also be removed completely if we refactor the code
> and return directly at the beginning of the function.
> Or the 'return -ENOMEM' should be 'err = -ENOMEM; goto done;' in order to
> avoid a mixup of goto and direct return.
> ---
>  drivers/staging/wfx/sta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
> index 688586e823c0..e14da8dce388 100644
> --- a/drivers/staging/wfx/sta.c
> +++ b/drivers/staging/wfx/sta.c
> @@ -906,7 +906,7 @@ static int wfx_upload_beacon(struct wfx_vif *wvif)
>  	wfx_fwd_probe_req(wvif, false);
>  
>  done:
> -	if (!skb)
> +	if (skb)
>  		dev_kfree_skb(skb);

Just remove the "if" check entirely, as dev_kfree_skb() can handle NULL
being passed to it.

thanks,

greg k-h
