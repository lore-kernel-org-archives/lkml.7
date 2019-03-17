Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB68C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C652184C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552822012;
	bh=HSrT56cU8BsYxZKYsTXMNClA9He2xkCvH556nQsu/S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zdTStZByFM6b9Um8pVw4FGOXKbvpHqA/4YWxomfPOP/66Ewn+Dl85EsmOMLOB4w6L
	 GaSWsnXflbUR0rTyik1rZBNPUtSUIoD9NH7lsgDNPSXnBRrhY70R0MpGEdBD6p4i9j
	 HgyapwTfFPyq4I38zniWWm3WnX76DgyQaPWcg+ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfCQL0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfCQL0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:26:50 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F7DF21738;
        Sun, 17 Mar 2019 11:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552822009;
        bh=HSrT56cU8BsYxZKYsTXMNClA9He2xkCvH556nQsu/S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YpepTi+I53fm/7xFQ2p3bGo/38MuHPuWPktZUoHVREEPguF9pfIOSeB5ME5wXBocf
         uV6q6SKzUz2cT91PILt761IKnw0c4SF8pEEEQegnHsTOT+eS0P0M9O4f85jvfryj85
         2I6q1KHrMjIob9iFnnkrdXktZM2txhYBPRArA8jY=
Date:   Sun, 17 Mar 2019 12:26:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        jananis37@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH net] staging: rtl8188eu: use is_zero_ether_addr() instead
 of memcmp()
Message-ID: <20190317112647.GG4614@kroah.com>
References: <20190309032600.98732-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309032600.98732-1-maowenan@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 11:26:00AM +0800, Mao Wenan wrote:
> Using is_zero_ether_addr() instead of directly use
> memcmp() to determine if the ethernet address is all
> zeros.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_mlme.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> index 714f7a70ed64..beae367df93b 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> @@ -180,9 +180,8 @@ struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
>  {
>  	struct list_head *phead, *plist;
>  	struct wlan_network *pnetwork = NULL;
> -	u8 zero_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
>  
> -	if (!memcmp(zero_addr, addr, ETH_ALEN)) {
> +	if (is_zero_ether_addr(addr)) {

As Joe said, you have to prove that this is properly aligned before you
can call this function.  Please do so.

thanks,

greg k-h
