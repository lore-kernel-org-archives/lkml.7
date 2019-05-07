Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327F1C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E5A205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="o/r9IVM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfEGR2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:28:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37293 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfEGR2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:28:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so8022882qtp.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=EXaJJYnOhCMm1Ies7w0+ULwlGJK0FIFIMnFExUlBqmk=;
        b=o/r9IVM5MhwMiJDJ9GVBWFCxkF0ebVK49NOcXyK3oMxdQdwXCejyZcGgqxxZbluDRm
         TkLtTH/eX9lZ8Hmmjn3AjqvEtJOSVkbfEWlTF8X+cx3Ci0C6l/baZ/3IDmdJYLkq9Gxl
         qNfjNfWyviSVQuJ5NI/NVbGyZcbmMWcmfOPDmg1bZcSh/1hDkQy+VnbtYiIy9KVel14o
         Bh1AvI5Q4EXXWRlncz5nllTS/shUOyYW9YzFHkr3z+BRlktQFpIiru9Klc6AWvRe0uSa
         0LWCXqSSHhiYrQQYtkK2F7v0nNk19iYZYDgbfam9iurl9vHv5dReP0Nx7sQLTqdLcpQS
         XQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EXaJJYnOhCMm1Ies7w0+ULwlGJK0FIFIMnFExUlBqmk=;
        b=KJiLIWWonpQFikWAtgrgOPMzNmnZQ5rB2LOwjmgiMZ40Of0jT4GUJ378+dviUfnAeZ
         Kp+C9IY7lpJPAFUOvsIUFOSMuBEEwfS6H/xj1j63zYo+O909yideIjgLwqN51Eg/4MOb
         cHdBxYaK8CPQSGTPaSmsExdiCzFwb4ngcWdAQLd5EQhoyGMYkPnAHyDAAeVOWrmNofwT
         22FuRkGkTxKhGWFOB6T23AbSoHdsVfC4+QYsdT1+XYaDlM/d3IkH88lZ2TcJEaveJcBC
         EDrK2r2StMqrHC9OlthmlMivwfGsDE3JkeTX/VI77fRkv8dPKoT8Z8nwswc5TVR5MHrU
         tz6w==
X-Gm-Message-State: APjAAAVmGwzwavEYoGsA6UCu+biKww7kC5/DztI1CqIf8bWdgFztrBUP
        0x7DzDJRKkNR8V7q3lmsg3PTYg==
X-Google-Smtp-Source: APXvYqyIrBg1/Odexc0u9Gyx6vUUNEENb9y4VJBTuXlyJ+UvZiEnf2cIcBUNxrZ//Bz917WhUaM9ew==
X-Received: by 2002:ac8:2565:: with SMTP id 34mr28459068qtn.37.1557250092551;
        Tue, 07 May 2019 10:28:12 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id p6sm7274766qkc.13.2019.05.07.10.28.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 10:28:12 -0700 (PDT)
Date:   Tue, 7 May 2019 10:28:03 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: mvpp2: cls: Add missing NETIF_F_NTUPLE flag
Message-ID: <20190507102803.09fcb56c@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20190507123635.17782-1-maxime.chevallier@bootlin.com>
References: <20190507123635.17782-1-maxime.chevallier@bootlin.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 May 2019 14:36:35 +0200, Maxime Chevallier wrote:
> Now that the mvpp2 driver supports classification offloading, we must
> add the NETIF_F_NTUPLE to the features list.
> 
> Fixes: 90b509b39ac9 ("net: mvpp2: cls: Add Classification offload support")
> Reported-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> Hello David,
> 
> This patch applies on top of a commit 90b509b39ac9, which is in net-next
> but hasn't made it to -net yet.
> 
> Thanks,
> 
> Maxime
> 
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 25fbed2b8d94..1f164c893936 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -5040,8 +5040,10 @@ static int mvpp2_port_probe(struct platform_device *pdev,
>  	dev->hw_features |= features | NETIF_F_RXCSUM | NETIF_F_GRO |
>  			    NETIF_F_HW_VLAN_CTAG_FILTER;
>  
> -	if (mvpp22_rss_is_supported())
> +	if (mvpp22_rss_is_supported()) {
>  		dev->hw_features |= NETIF_F_RXHASH;
> +		dev->features |= NETIF_F_NTUPLE;

Hm, why not in hw_features?

> +	}
>  
>  	if (port->pool_long->id == MVPP2_BM_JUMBO && port->id != 0) {
>  		dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);

