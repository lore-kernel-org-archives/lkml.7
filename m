Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4566C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 06:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937CD206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 06:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKPGpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 01:45:52 -0500
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:48953 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbfKPGpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 01:45:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 9DED6181D3417;
        Sat, 16 Nov 2019 06:45:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wall56_6cf4312ecd835
X-Filterd-Recvd-Size: 2631
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sat, 16 Nov 2019 06:45:48 +0000 (UTC)
Message-ID: <3fd995ebb9ec87b202942fa1f000755c2d3cc4cb.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8192u: fix indentation issue
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Nov 2019 22:45:29 -0800
In-Reply-To: <20191114095430.132120-1-colin.king@canonical.com>
References: <20191114095430.132120-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-14 at 09:54 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a block of statements that are indented
> too deeply, remove the extraneous tabs.
[]
> diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
[]
> @@ -169,19 +169,20 @@ static void cmdpkt_beacontimerinterrupt_819xusb(struct net_device *dev)
>  {
>  	struct r8192_priv *priv = ieee80211_priv(dev);
>  	u16 tx_rate;
> -		/* 87B have to S/W beacon for DTM encryption_cmn. */
> -		if (priv->ieee80211->current_network.mode == IEEE_A ||
> -		    priv->ieee80211->current_network.mode == IEEE_N_5G ||
> -		    (priv->ieee80211->current_network.mode == IEEE_N_24G &&
> -		     (!priv->ieee80211->pHTInfo->bCurSuppCCK))) {
> -			tx_rate = 60;
> -			DMESG("send beacon frame  tx rate is 6Mbpm\n");
> -		} else {
> -			tx_rate = 10;
> -			DMESG("send beacon frame  tx rate is 1Mbpm\n");
> -		}
>  
> -		rtl819xusb_beacon_tx(dev, tx_rate); /* HW Beacon */
> +	/* 87B have to S/W beacon for DTM encryption_cmn. */
> +	if (priv->ieee80211->current_network.mode == IEEE_A ||
> +	    priv->ieee80211->current_network.mode == IEEE_N_5G ||
> +	    (priv->ieee80211->current_network.mode == IEEE_N_24G &&
> +	     (!priv->ieee80211->pHTInfo->bCurSuppCCK))) {
> +		tx_rate = 60;
> +		DMESG("send beacon frame  tx rate is 6Mbpm\n");
> +	} else {
> +		tx_rate = 10;
> +		DMESG("send beacon frame  tx rate is 1Mbpm\n");
> +	}
> +
> +	rtl819xusb_beacon_tx(dev, tx_rate); /* HW Beacon */

This function might as well be deleted instead as
rtl819xusb_beacon_tx is a noop function in
drivers/staging/rtl8192u/r8192U_core.c

void rtl819xusb_beacon_tx(struct net_device *dev, u16  tx_rate)
{
}


