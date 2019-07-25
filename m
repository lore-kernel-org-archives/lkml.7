Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF23217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564058733;
	bh=AW/J1bPuReTrZwkbmXMaygaa2ZUKlCuofWo3qYK9hik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sXkdEbhU+GD3UUnkUjORRYSYi5x7/7Zqny6r5Eq2zBbGR34VqKHsh3616aJgPbT9J
	 pJGacwILeUrwVlXo8cQZJ5xMtvGb7DgfN765/ly9qKI8Iv+r4rJzWZLxQrTMxVZt01
	 hn4RmzmkZXNGTQkHg1CnXd5NL9dUS5/R0bekJDaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389086AbfGYMpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388990AbfGYMpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:45:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3ED9217F4;
        Thu, 25 Jul 2019 12:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564058731;
        bh=AW/J1bPuReTrZwkbmXMaygaa2ZUKlCuofWo3qYK9hik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVEzKj5PqjX8zQVV/Z59oc36IyvBDb24WnBDuYsfO8d9lqhRmD3ngB3DpZmiEdGT7
         5ivDRPhyvD53EhGkWD1hUBmXvqR2fkJFe3raSPc1WODzgtCt11/VmehtWjAPZ9MQTL
         Z9WZ9aQrtc0v/V/qZDrbB2ZK2H4pVgVRWoTcuFbk=
Date:   Thu, 25 Jul 2019 14:45:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     devel@driverdev.osuosl.org, secalert@redhat.com, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>, emamd001@umn.edu,
        Nishka Dasgupta <nishkadg.linux@gmail.com>, smccaman@umn.edu,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] rtl8192_init_priv_variable: null check is missing for
 kzalloc
Message-ID: <20190725124528.GA21757@kroah.com>
References: <20190720202546.21111-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720202546.21111-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 03:25:44PM -0500, Navid Emamdoost wrote:
> Allocation for priv->pFirmware may fail, so a null check is necessary.
> priv->pFirmware is accessed at line 2743. I added the check and made
> appropriate changes to propagate the errno to the caller.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index fe1f279ca368..5fb24b13ce5b 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -2096,7 +2096,7 @@ static void rtl8192_SetWirelessMode(struct net_device *dev, u8 wireless_mode)
>  }
>  
>  /* init priv variables here. only non_zero value should be initialized here. */
> -static void rtl8192_init_priv_variable(struct net_device *dev)
> +static int rtl8192_init_priv_variable(struct net_device *dev)
>  {
>  	struct r8192_priv *priv = ieee80211_priv(dev);
>  	u8 i;
> @@ -2223,6 +2223,10 @@ static void rtl8192_init_priv_variable(struct net_device *dev)
>  
>  	priv->AcmControl = 0;
>  	priv->pFirmware = kzalloc(sizeof(rt_firmware), GFP_KERNEL);
> +	if (!priv->pFirmware) {
> +		return -ENOMEM;
> +	}
> +
>  
>  	/* rx related queue */
>  	skb_queue_head_init(&priv->rx_queue);
> @@ -2236,6 +2240,8 @@ static void rtl8192_init_priv_variable(struct net_device *dev)
>  	for (i = 0; i < MAX_QUEUE_SIZE; i++)
>  		skb_queue_head_init(&priv->ieee80211->skb_drv_aggQ[i]);
>  	priv->rf_set_chan = rtl8192_phy_SwChnl;
> +
> +	return 0;
>  }
>  
>  /* init lock here */
> @@ -2605,7 +2611,10 @@ static short rtl8192_init(struct net_device *dev)
>  		memcpy(priv->txqueue_to_outpipemap, queuetopipe, 9);
>  	}
>  #endif
> -	rtl8192_init_priv_variable(dev);
> +	err = rtl8192_init_priv_variable(dev);
> +	if (err) {
> +		return err;
> +	}

Always run checkpatch.pl on your patch before sending it so you do not
get grumpy emails telling you to run checkpatch.pl before sending your
patch :)


thanks,

greg k-h
