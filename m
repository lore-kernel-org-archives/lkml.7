Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB14C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323B020836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576008804;
	bh=d4m8RyRaIFUsp+FGIuHS5xArnuXnFWtjuRqLlW6epXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XceNZJm1JrWIizeD9HUy9bY/sRHIdSePU9NKzparIfin9DLe4wXWubkX9BqpKrtHK
	 cBEQDmTX/BY6yjPfrg3h8D8sL6RgxcidChbxFyIalts5jk8difewCIlmC6A2QLSA35
	 Wj0LNF94IVarT+aSH7iQUg9Q8mI6eMEuNFRvVZpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfLJUNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfLJUNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:13:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9C12073D;
        Tue, 10 Dec 2019 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576008801;
        bh=d4m8RyRaIFUsp+FGIuHS5xArnuXnFWtjuRqLlW6epXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ST5a1CQfF4T91g4YqgT4Ml6JvNveb21sGDz3FR5d14k/48JJD2aaB7EtAn+llseFs
         OmKmK1gVUedf/IKGPiNgjppSGz5p8RakeFLUGskgfMDXkdX3Ax7n968tHPsbS75Iut
         cV8YEVwq8mIWsobGt3NbGMqb8kjyltyIYOc/efig=
Date:   Tue, 10 Dec 2019 21:13:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Joe Perches <joe@perches.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] staging: hp100: add back CONFIG_NET dependency
Message-ID: <20191210201318.GA4070187@kroah.com>
References: <20191210200110.994059-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210200110.994059-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:00:52PM +0100, Arnd Bergmann wrote:
> The move to staging lost an important dependency:
> 
> ERROR: "eth_validate_addr" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "eth_mac_addr" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "alloc_etherdev_mqs" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "register_netdev" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "__skb_pad" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "consume_skb" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "dev_trans_start" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "__dev_kfree_skb_any" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "netif_rx" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "eth_type_trans" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "skb_trim" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "skb_put" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "__netdev_alloc_skb" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "free_netdev" [drivers/staging/hp/hp100.ko] undefined!
> ERROR: "unregister_netdev" [drivers/staging/hp/hp100.ko] undefined!
> 
> Add it back explicitly.
> 
> Fixes: 52340b82cf1a ("hp100: Move 100BaseVG AnyLAN driver to staging")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/hp/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/hp/Kconfig b/drivers/staging/hp/Kconfig
> index fb395cfe6b92..9566d4ab5ce5 100644
> --- a/drivers/staging/hp/Kconfig
> +++ b/drivers/staging/hp/Kconfig
> @@ -6,6 +6,7 @@
>  config NET_VENDOR_HP
>  	bool "HP devices"
>  	default y
> +	depends on NET
>  	depends on ISA || EISA || PCI
>  	---help---
>  	  If you have a network (Ethernet) card belonging to this class, say Y.

Heh, I just queued up this same patch a few hours ago :)

greg k-h
