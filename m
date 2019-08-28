Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A39CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1652339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="QubqZWHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfH1XDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 19:03:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45768 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfH1XDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 19:03:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id x19so1765144eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=819swzQKe98LdzJrxDCxiGarxJHyCdbjjXG7zzq6Gf4=;
        b=QubqZWHDcswIDRZ8UX5aJXD/sm3fEumW25hWHLvukFM819Yknc/uzen5kBObQFjrdN
         XmFszcsJ+GPcabhUnQT1QZN/w+PEpinIsaoZaVN3ECc0kcf60/vQ8pnlJD8N6G5S45ds
         U4nOHX9dKdLgiNdKat17I/2K1IKRnkemIE5FRUhHjwIWSZvpT49XEePRucm0LPPssiP/
         eNrQgiMr4oO3n1I2TRi1W8epuOB/BSo2TQ4NXTwQ9tMoyIUsSMYyQOtgjCD4HdSNHI45
         Q1uGRcf12BioBGyMHqAyd0jv/HvOl73jHciadrnImwkS3urwM1/v69qBrZiTpCMpl7ns
         7hHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=819swzQKe98LdzJrxDCxiGarxJHyCdbjjXG7zzq6Gf4=;
        b=ThKWyBjQCVWJYbU3KmQxgE0/ZExAuHZLzYZMDvq52lmSsbmt1x7aZxmuyIzo/hzhsj
         90Yd+WrMGqbZxF16N4DAOqGODDCn3bs46LojwvRsiV0JAh/kmMVZ5r+XLdO1r/w6ZrdZ
         QeE1+3KS4xF6FVsN+T9yC4osW0XjtWjOyYXTc3XnrfutMLT/xAVeYInLuKrCKa2y7TRV
         JKQKZg2z8txVC5P/YPxJZc5sb3XnyxbPRQHnjvqcbIYcs5F3mmZen7T2E9ivJlDjXsLa
         /C2IAS5BfvZqgmJpyM7EulietVHvrK79nfPtcHjRHkoxZ7vACUMqBXdFsbdV0fOXxlN3
         jmKQ==
X-Gm-Message-State: APjAAAWMs3XQssMLn8sAlhoK+tOeAQZZ39nWbRtNjeg3AVtJZ6DNMKVQ
        /xOzfeuKn60JnbiLomUVDKF/7A==
X-Google-Smtp-Source: APXvYqwBNeZBsZAb2QiHZ3ka+pGiYcIhUqd3Va0L+/ypOzKgUthP1oIon5KcXep4ANSKBdqvf6IDlg==
X-Received: by 2002:a50:9116:: with SMTP id e22mr6723578eda.161.1567033388739;
        Wed, 28 Aug 2019 16:03:08 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id f6sm96846edn.63.2019.08.28.16.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 16:03:08 -0700 (PDT)
Date:   Wed, 28 Aug 2019 16:02:46 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next 06/15] net: sgi: ioc3-eth: get rid of
 ioc3_clean_rx_ring()
Message-ID: <20190828160246.7b211f8a@cakuba.netronome.com>
In-Reply-To: <20190828140315.17048-7-tbogendoerfer@suse.de>
References: <20190828140315.17048-1-tbogendoerfer@suse.de>
        <20190828140315.17048-7-tbogendoerfer@suse.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 16:03:05 +0200, Thomas Bogendoerfer wrote:
> Clean rx ring is just called once after a new ring is allocated, which
> is per definition clean. So there is not need for this function.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/net/ethernet/sgi/ioc3-eth.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
> index 6ca560d4ab79..39631e067b71 100644
> --- a/drivers/net/ethernet/sgi/ioc3-eth.c
> +++ b/drivers/net/ethernet/sgi/ioc3-eth.c
> @@ -761,26 +761,6 @@ static void ioc3_mii_start(struct ioc3_private *ip)
>  	add_timer(&ip->ioc3_timer);
>  }
>  
> -static inline void ioc3_clean_rx_ring(struct ioc3_private *ip)
> -{
> -	struct ioc3_erxbuf *rxb;
> -	struct sk_buff *skb;
> -	int i;
> -
> -	for (i = ip->rx_ci; i & 15; i++) {
> -		ip->rx_skbs[ip->rx_pi] = ip->rx_skbs[ip->rx_ci];
> -		ip->rxr[ip->rx_pi++] = ip->rxr[ip->rx_ci++];
> -	}
> -	ip->rx_pi &= RX_RING_MASK;
> -	ip->rx_ci &= RX_RING_MASK;
> -
> -	for (i = ip->rx_ci; i != ip->rx_pi; i = (i + 1) & RX_RING_MASK) {
> -		skb = ip->rx_skbs[i];
> -		rxb = (struct ioc3_erxbuf *)(skb->data - RX_OFFSET);
> -		rxb->w0 = 0;

There's gotta be some purpose to setting this w0 word to zero no?
ioc3_rx() uses that to see if the descriptor is done, and dutifully
clears it after..

> -	}
> -}
> -
>  static inline void ioc3_clean_tx_ring(struct ioc3_private *ip)
>  {
>  	struct sk_buff *skb;
> @@ -860,7 +840,6 @@ static void ioc3_init_rings(struct net_device *dev)
>  	ioc3_free_rings(ip);
>  	ioc3_alloc_rings(dev);
>  
> -	ioc3_clean_rx_ring(ip);
>  	ioc3_clean_tx_ring(ip);
>  
>  	/* Now the rx ring base, consume & produce registers.  */

