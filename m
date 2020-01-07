Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F212C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1572072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Y41Q3XD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgAGUoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:44:23 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39648 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgAGUoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:44:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so675329qko.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 12:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=aKiD0yl/utmWGZaoed1gH+OXHhJjpm2ChFJUcYMOQxI=;
        b=Y41Q3XD2a5iov+A2KLdw2GHrEdUxtVlLLS8VWZjLQwJvyyg7xkRduDJmtGdRj2IYey
         9HmLfncNoD+gD0eT48uT29jfG8XNwRv7loHWE9MJEIeQqiq2kbZ+Hs/cRBLj1IHzZ6no
         aGXyjDnws8HHqPUTlPrs+rRP6ZnprDV4zk0wNfYwBMF7yl1reNPFFUK3nf3i8DWVp5DL
         JaMrLfBc6z86Hp6X2XUaelQiGPjl215W924+k98+VOJgEOEWRwS7hcCVcUMTJjT+QLdi
         S8tztTeVCsnqyGk2/lL8dczPd3tQ3gaL2ex5gEkQ0WANUSArxkM1l8Sg9dNZuxhg911r
         D/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=aKiD0yl/utmWGZaoed1gH+OXHhJjpm2ChFJUcYMOQxI=;
        b=I/kY5wT80jKvYz1NkLQpJTdSMlb1q52CjnRzqSJjewjb3oUi7G3WeVB65PbJABWZ9A
         N6NpVzmeGcxtBohlsGYBzKEQJy5frAIFtmxJ8uqUPXRmjF263Y17SYVixg96/vx8H3DN
         K+SSyspODl4jrlL/KaVbyuY4SBoWHsFewKRiS5+ZuQaJwBmWJzbYcj0Ymxl8Y29iTQTB
         O70IqkJ+ESpoojoQf/M4R5jy23k6QXta+qgTDSKmEPYcCzskq5s8x46sNCMSCeZ8SZGv
         RYgtlp+LqDhTRjdnOUNO46B2BfcuP10SDAQE/ZfoAq4JtG5gRbzfqYX/V2gJs5nrSMBJ
         0pFQ==
X-Gm-Message-State: APjAAAW8C3tGQqvHqv6rrobNEqnScJ/PmI75XeC0z9B6aTu3PPTvmSxR
        5eJ0RPW3hsz2KvA0IEPRWdybkg==
X-Google-Smtp-Source: APXvYqw10njFuD2i83yGtttPLUy+OQw/6rh20Q9UHP1ZUmHjW02T1W8/PcKdKOLg8lsZNARk1fDeTg==
X-Received: by 2002:a37:e109:: with SMTP id c9mr1124597qkm.366.1578429862045;
        Tue, 07 Jan 2020 12:44:22 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i4sm357765qki.45.2020.01.07.12.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 12:44:21 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:44:17 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Simon Horman <simon.horman@netronome.com>,
        John Hurley <john.hurley@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netronome: fix ipv6 link error
Message-ID: <20200107124417.5239a6cf@cakuba.netronome.com>
In-Reply-To: <20200107200659.3538375-1-arnd@arndb.de>
References: <20200107200659.3538375-1-arnd@arndb.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jan 2020 21:06:40 +0100, Arnd Bergmann wrote:
> When the driver is built-in but ipv6 is a module, the flower
> support produces a link error:
> 
> drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.o: In function `nfp_tunnel_keep_alive_v6':
> tunnel_conf.c:(.text+0x2aa8): undefined reference to `nd_tbl'

Damn, I guess the v2 of that patch set did not solve _all_ v6 linking
issues :/ Thanks for the patch.

> Add a Kconfig dependency to avoid that configuration.
> 
> Fixes: 9ea9bfa12240 ("nfp: flower: support ipv6 tunnel keep-alive messages from fw")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/netronome/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/netronome/Kconfig b/drivers/net/ethernet/netronome/Kconfig
> index bac5be4d4f43..dcb02ce28460 100644
> --- a/drivers/net/ethernet/netronome/Kconfig
> +++ b/drivers/net/ethernet/netronome/Kconfig
> @@ -31,6 +31,7 @@ config NFP_APP_FLOWER
>  	bool "NFP4000/NFP6000 TC Flower offload support"
>  	depends on NFP
>  	depends on NET_SWITCHDEV
> +	depends on IPV6 != m || NFP =m

Could we perhaps do the more standard:

	depends on IPV6 || IPV6=n

The whitespace around = and != seems a little random as is..

>  	default y
>  	---help---
>  	  Enable driver support for TC Flower offload on NFP4000 and NFP6000.

