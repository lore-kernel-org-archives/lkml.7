Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E49EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011BE23404
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="C/MonQxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfH2VGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:06:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33017 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfH2VGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:06:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id l26so4958791edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mjeDM1ef59jHGyITUEWKWasfOEJ0lhbfqjEvHa/i+Bc=;
        b=C/MonQxuUjA5OS8d5fmb1X7dzmJV0jA/mpbw81KMoaWWx12Ur45uzcUPiyItofO4v9
         ZMj31l1mLBk4UYgZWQMPClJjRLmg984pRbGnjiQ2wWDCUkxvF1I+1fH5h/d1GcxHtHf8
         ZKyevKI9p7RRxOkpxiOTHK345zHfkJgCWRVJQBRjgmZJZcKw2vovVBq5A9qJ0BqQUL79
         Snd5sFvGZgbt9oslfbZhqPuHOncfZMRCcoaP7tqTK6fqT2C3aC+u+W3lVp2ZZbyg6i3n
         4mCLRie4ILXwTkCGQ3pbUklEBecKmO/y5dmAQRUWaE/4l2A5XdbA2N5jxEeRaAtVz39f
         hKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mjeDM1ef59jHGyITUEWKWasfOEJ0lhbfqjEvHa/i+Bc=;
        b=iB24Dqo6DtUV3EBPkutxO4lDN+xtn3Zvo2lyplThByZjQ5Aklc40pHiQRaYRrLbHRk
         XS9uiTy1HC7g4O071SGW0GaBrPH2gx2AWLvc20bu7DqgxmLwdgzNGFZ7CUg2CFGWCEiD
         tDbNL6DEo078IlkXejifEl6fv/ZJKXXR8I9Pnwf5wvkEue52pFk/p8n01J4ooYabwh3R
         3kZ1ZnsmLJDcYwcP1W2Xo5EGSXOlfCZbDx89M7r+syvlJZVe0ASUuEDcLcmvJpRhENKl
         XQA1agNszR/z89uZLb0PkdLkauFrJh+KBdHu99LHlyG262nSxL/kf0ko3+xcc+LvWObT
         PNwg==
X-Gm-Message-State: APjAAAXxadIlFjNy6FKWnpwdDK6C/5da/IeCn5tTwBpqisqUz8y7oHHt
        rao2HswvaK3G2FTh94UbDB0tgw==
X-Google-Smtp-Source: APXvYqxkf3fLJCOCftLxVNmTyA/z4TI2hfVEFN6q2d+atf4OWedLQfzK96Qaw5gyDlRRT9vKcpKKUQ==
X-Received: by 2002:a05:6402:1344:: with SMTP id y4mr11932199edw.124.1567112762386;
        Thu, 29 Aug 2019 14:06:02 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id f6sm640076edv.30.2019.08.29.14.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 14:06:02 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:05:37 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 05/15] net: sgi: ioc3-eth: allocate space
 for desc rings only once
Message-ID: <20190829140537.68abfc9f@cakuba.netronome.com>
In-Reply-To: <20190829155014.9229-6-tbogendoerfer@suse.de>
References: <20190829155014.9229-1-tbogendoerfer@suse.de>
        <20190829155014.9229-6-tbogendoerfer@suse.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 17:50:03 +0200, Thomas Bogendoerfer wrote:
> Memory for descriptor rings are allocated/freed, when interface is
> brought up/down. Since the size of the rings is not changeable by
> hardware, we now allocate rings now during probe and free it, when
> device is removed.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/net/ethernet/sgi/ioc3-eth.c | 103 ++++++++++++++++++------------------
>  1 file changed, 51 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
> index ba18a53fbbe6..d9d94a55ac34 100644
> --- a/drivers/net/ethernet/sgi/ioc3-eth.c
> +++ b/drivers/net/ethernet/sgi/ioc3-eth.c
> @@ -803,25 +803,17 @@ static void ioc3_free_rings(struct ioc3_private *ip)
>  	struct sk_buff *skb;
>  	int rx_entry, n_entry;
>  
> -	if (ip->txr) {
> -		ioc3_clean_tx_ring(ip);
> -		free_pages((unsigned long)ip->txr, 2);
> -		ip->txr = NULL;
> -	}
> +	ioc3_clean_tx_ring(ip);
>  
> -	if (ip->rxr) {
> -		n_entry = ip->rx_ci;
> -		rx_entry = ip->rx_pi;
> +	n_entry = ip->rx_ci;
> +	rx_entry = ip->rx_pi;
>  
> -		while (n_entry != rx_entry) {
> -			skb = ip->rx_skbs[n_entry];
> -			if (skb)
> -				dev_kfree_skb_any(skb);
> +	while (n_entry != rx_entry) {
> +		skb = ip->rx_skbs[n_entry];
> +		if (skb)
> +			dev_kfree_skb_any(skb);

I think dev_kfree_skb_any() accepts NULL

>  
> -			n_entry = (n_entry + 1) & RX_RING_MASK;
> -		}
> -		free_page((unsigned long)ip->rxr);
> -		ip->rxr = NULL;
> +		n_entry = (n_entry + 1) & RX_RING_MASK;
>  	}
>  }
>  
> @@ -829,49 +821,34 @@ static void ioc3_alloc_rings(struct net_device *dev)
>  {
>  	struct ioc3_private *ip = netdev_priv(dev);
>  	struct ioc3_erxbuf *rxb;
> -	unsigned long *rxr;
>  	int i;
>  
> -	if (!ip->rxr) {
> -		/* Allocate and initialize rx ring.  4kb = 512 entries  */
> -		ip->rxr = (unsigned long *)get_zeroed_page(GFP_ATOMIC);
> -		rxr = ip->rxr;
> -		if (!rxr)
> -			pr_err("%s: get_zeroed_page() failed!\n", __func__);
> -
> -		/* Now the rx buffers.  The RX ring may be larger but
> -		 * we only allocate 16 buffers for now.  Need to tune
> -		 * this for performance and memory later.
> -		 */
> -		for (i = 0; i < RX_BUFFS; i++) {
> -			struct sk_buff *skb;
> +	/* Now the rx buffers.  The RX ring may be larger but
> +	 * we only allocate 16 buffers for now.  Need to tune
> +	 * this for performance and memory later.
> +	 */
> +	for (i = 0; i < RX_BUFFS; i++) {
> +		struct sk_buff *skb;
>  
> -			skb = ioc3_alloc_skb(RX_BUF_ALLOC_SIZE, GFP_ATOMIC);
> -			if (!skb) {
> -				show_free_areas(0, NULL);
> -				continue;
> -			}
> +		skb = ioc3_alloc_skb(RX_BUF_ALLOC_SIZE, GFP_ATOMIC);
> +		if (!skb) {
> +			show_free_areas(0, NULL);
> +			continue;
> +		}
>  
> -			ip->rx_skbs[i] = skb;
> +		ip->rx_skbs[i] = skb;
>  
> -			/* Because we reserve afterwards. */
> -			skb_put(skb, (1664 + RX_OFFSET));
> -			rxb = (struct ioc3_erxbuf *)skb->data;
> -			rxr[i] = cpu_to_be64(ioc3_map(rxb, 1));
> -			skb_reserve(skb, RX_OFFSET);
> -		}
> -		ip->rx_ci = 0;
> -		ip->rx_pi = RX_BUFFS;
> +		/* Because we reserve afterwards. */
> +		skb_put(skb, (1664 + RX_OFFSET));
> +		rxb = (struct ioc3_erxbuf *)skb->data;
> +		ip->rxr[i] = cpu_to_be64(ioc3_map(rxb, 1));
> +		skb_reserve(skb, RX_OFFSET);
>  	}
> +	ip->rx_ci = 0;
> +	ip->rx_pi = RX_BUFFS;
>  
> -	if (!ip->txr) {
> -		/* Allocate and initialize tx rings.  16kb = 128 bufs.  */
> -		ip->txr = (struct ioc3_etxd *)__get_free_pages(GFP_KERNEL, 2);
> -		if (!ip->txr)
> -			pr_err("%s: __get_free_pages() failed!\n", __func__);
> -		ip->tx_pi = 0;
> -		ip->tx_ci = 0;
> -	}
> +	ip->tx_pi = 0;
> +	ip->tx_ci = 0;
>  }
>  
>  static void ioc3_init_rings(struct net_device *dev)
> @@ -1239,6 +1216,23 @@ static int ioc3_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	timer_setup(&ip->ioc3_timer, ioc3_timer, 0);
>  
>  	ioc3_stop(ip);
> +
> +	/* Allocate and rx ring.  4kb = 512 entries  */
> +	ip->rxr = (unsigned long *)get_zeroed_page(GFP_ATOMIC);
> +	if (!ip->rxr) {
> +		pr_err("ioc3-eth: rx ring allocation failed\n");
> +		err = -ENOMEM;
> +		goto out_stop;
> +	}
> +
> +	/* Allocate tx rings.  16kb = 128 bufs.  */
> +	ip->txr = (struct ioc3_etxd *)__get_free_pages(GFP_KERNEL, 2);
> +	if (!ip->txr) {
> +		pr_err("ioc3-eth: tx ring allocation failed\n");
> +		err = -ENOMEM;
> +		goto out_stop;
> +	}

Please just use kcalloc()/kmalloc_array() here, and make sure the flags
are set to GFP_KERNEL whenever possible. Here and in ioc3_alloc_rings()
it looks like GFP_ATOMIC is unnecessary.
