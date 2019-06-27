Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5599C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88662208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="I6vSO2VN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dD+Jzon7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfF0QoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:44:21 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:36091 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbfF0QoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:44:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id AA8634DA;
        Thu, 27 Jun 2019 12:44:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 27 Jun 2019 12:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=rDFUjydPbLgsHZHBEgoxvpKuMK6
        XbRLR5IiACkCmvT4=; b=I6vSO2VNuWrji3LYrrKcLmA3Q16/Y9vYiMp0qg0Mj77
        9Fswf/GESw2QATxuYhgU6oCyeuTyu5Rk+1UfNEHnpkAZvufipskhyjlaYHB5LbiV
        6gkNkkYSrJ60fbIjq4PYNONXcRsxKT+n7WCOYW3UHpgfp+Gb+PqwPMpgIuADysVl
        U6WPAB5CS60jXFWoCp2W2FnSdgime72a3nfYaWtPLgnv/JQ0eie8luIW8SGxmUqt
        qNhRKd2dkaCPqXwGGdH787SSEqW80UZKaWybROp6o4HY/gOI6smT6igm42wdZ3g4
        kw6DEHA+m1znV0ednrwwCbpxow+ZzcHKBytAmpN+ItQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rDFUjy
        dPbLgsHZHBEgoxvpKuMK6XbRLR5IiACkCmvT4=; b=dD+Jzon7HcqaRUKKnkcOM4
        YQRPum6RVEfVcDAAWl0cP+tzyFjoNvnJvkmjHd2Dmb6uBd6ZVlD9ydpM9ikJ/tqM
        xH2zE50xMaliPVN+/YJcswyH6eQsI7ijUWVaduvqeErNDfu89t+G0ueDNhy3r/r4
        hrwvo/x3+ndHySevhQsMz8Z7fcsZBrK1YdcRA0ENWruQb2ot76qkuw/KVMjxcSL1
        UIiVTuV2tzDrsReKysASZxKdhYtn0J0XWF53WoOvlbPANg/Oyn0ezbiRQbZhPQRT
        DBZEX9I7hC/bobjuWOKbinSXnYTfxWK0nfiCoA0lKyH8BcuCUsqbX7MADUuAKmtg
        ==
X-ME-Sender: <xms:YPIUXbYz4uVGFicZm3E9vkxFiL3Rnb1y33-oei5-NMQC0Ry8t_jSwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudekgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekledrvddthedrudefie
    drvddvieenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    necuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:YPIUXaH2RT0o7koS1e1MTdG5EPWVoCCfhzUYeD48Qp5tJzbj9EMmYg>
    <xmx:YPIUXT5baNsKQ6c7ZrAWhcCbG3NQ8Wxn441MKOqoNeSh_xvW4THzww>
    <xmx:YPIUXb5JOEZTj6f6GhQWmppFXc6zeguxWnlUBcaVv11m1nJkay0Dyw>
    <xmx:YvIUXfUlsC41Jaz8cDTMImQFCmkzxexJJ-a15g7no7P8OQEtze1zHFaB5L4>
Received: from localhost (unknown [89.205.136.226])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9ED34380083;
        Thu, 27 Jun 2019 12:44:15 -0400 (EDT)
Date:   Fri, 28 Jun 2019 00:44:05 +0800
From:   Greg KH <greg@kroah.com>
To:     Lukas Schneider <lukas.s.schneider@fau.de>
Cc:     leobras.c@gmail.com, digholebhagyashri@gmail.com,
        bhanusreemahesh@gmail.com, daniel.vetter@ffwll.ch,
        der_wolf_@web.de, payal.s.kshirsagar.98@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jannik Moritz <jannik.moritz@fau.de>, linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH] fbtft: Cleanup line over 80 character warnings
Message-ID: <20190627164405.GB9692@kroah.com>
References: <20190627121240.31584-1-lukas.s.schneider@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627121240.31584-1-lukas.s.schneider@fau.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 02:12:40PM +0200, Lukas Schneider wrote:
> Cleanup the line over 80 character warnings, reported by checkpatch
> 
> Signed-off-by: Lukas Schneider <lukas.s.schneider@fau.de>
> Signed-off-by: Jannik Moritz <jannik.moritz@fau.de>
> Cc: <linux-kernel@i4.cs.fau.de>
> ---
>  drivers/staging/fbtft/fbtft-sysfs.c |  3 ++-
>  drivers/staging/fbtft/fbtft.h       | 26 ++++++++++++++++++++++----
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
> index 2a5c630dab87..78d2b81ea2e7 100644
> --- a/drivers/staging/fbtft/fbtft-sysfs.c
> +++ b/drivers/staging/fbtft/fbtft-sysfs.c
> @@ -68,7 +68,8 @@ int fbtft_gamma_parse_str(struct fbtft_par *par, u32 *curves,
>  			ret = get_next_ulong(&curve_p, &val, " ", 16);
>  			if (ret)
>  				goto out;
> -			curves[curve_counter * par->gamma.num_values + value_counter] = val;
> +			curves[curve_counter * par->gamma.num_values
> +				+ value_counter] = val;

Ick, that's horrible to read now, right?

>  			value_counter++;
>  		}
>  		if (value_counter != par->gamma.num_values) {
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
> index 9b6bdb62093d..cddbfd4ffa10 100644
> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -348,9 +348,25 @@ module_exit(fbtft_driver_module_exit);
>  
>  /* shorthand debug levels */
>  #define DEBUG_LEVEL_1	DEBUG_REQUEST_GPIOS
> -#define DEBUG_LEVEL_2	(DEBUG_LEVEL_1 | DEBUG_DRIVER_INIT_FUNCTIONS | DEBUG_TIME_FIRST_UPDATE)
> -#define DEBUG_LEVEL_3	(DEBUG_LEVEL_2 | DEBUG_RESET | DEBUG_INIT_DISPLAY | DEBUG_BLANK | DEBUG_REQUEST_GPIOS | DEBUG_FREE_GPIOS | DEBUG_VERIFY_GPIOS | DEBUG_BACKLIGHT | DEBUG_SYSFS)
> -#define DEBUG_LEVEL_4	(DEBUG_LEVEL_2 | DEBUG_FB_READ | DEBUG_FB_WRITE | DEBUG_FB_FILLRECT | DEBUG_FB_COPYAREA | DEBUG_FB_IMAGEBLIT | DEBUG_FB_BLANK)
> +#define DEBUG_LEVEL_2	(DEBUG_LEVEL_1 |		\
> +			 DEBUG_DRIVER_INIT_FUNCTIONS |	\
> +			 DEBUG_TIME_FIRST_UPDATE)
> +#define DEBUG_LEVEL_3	(DEBUG_LEVEL_2 |		\
> +			 DEBUG_RESET |			\
> +			 DEBUG_INIT_DISPLAY |		\
> +			 DEBUG_BLANK |			\
> +			 DEBUG_REQUEST_GPIOS |		\
> +			 DEBUG_FREE_GPIOS |		\
> +			 DEBUG_VERIFY_GPIOS |		\
> +			 DEBUG_BACKLIGHT |		\
> +			 DEBUG_SYSFS)
> +#define DEBUG_LEVEL_4	(DEBUG_LEVEL_2 |		\
> +			 DEBUG_FB_READ |		\
> +			 DEBUG_FB_WRITE |		\
> +			 DEBUG_FB_FILLRECT |		\
> +			 DEBUG_FB_COPYAREA |		\
> +			 DEBUG_FB_IMAGEBLIT |		\
> +			 DEBUG_FB_BLANK)
>  #define DEBUG_LEVEL_5	(DEBUG_LEVEL_3 | DEBUG_UPDATE_DISPLAY)
>  #define DEBUG_LEVEL_6	(DEBUG_LEVEL_4 | DEBUG_LEVEL_5)
>  #define DEBUG_LEVEL_7	0xFFFFFFFF

All of these special debug "levels" need to go away now that the drivers
are working, and just use the in-kernel debugging macros instead.

thanks,

greg k-h
