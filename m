Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFA1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15D32070B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfH1RKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:10:23 -0400
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:49214 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726315AbfH1RKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:10:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 958B2100E86C8;
        Wed, 28 Aug 2019 17:10:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: use06_2004d02ba580f
X-Filterd-Recvd-Size: 4000
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 28 Aug 2019 17:10:19 +0000 (UTC)
Message-ID: <d0fd02c3634d187dcfe5487917099bc1905e3789.camel@perches.com>
Subject: Re: [PATCH net-next 03/15] net: sgi: ioc3-eth: remove checkpatch
 errors/warning
From:   Joe Perches <joe@perches.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Date:   Wed, 28 Aug 2019 10:10:18 -0700
In-Reply-To: <20190828140315.17048-4-tbogendoerfer@suse.de>
References: <20190828140315.17048-1-tbogendoerfer@suse.de>
         <20190828140315.17048-4-tbogendoerfer@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 16:03 +0200, Thomas Bogendoerfer wrote:
> Before massaging the driver further fix oddities found by checkpatch like
> - wrong indention
> - comment formatting
> - use of printk instead or netdev_xxx/pr_xxx

trivial notes:

Please try to make the code better rather than merely
shutting up checkpatch.

> diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
[]
> @@ -209,8 +201,7 @@ static inline void nic_write_bit(u32 __iomem *mcr, int bit)
>  	nic_wait(mcr);
>  }
>  
> -/*
> - * Read a byte from an iButton device
> +/* Read a byte from an iButton device
>   */

These comment styles would be simpler on a single line

/* Read a byte from an iButton device */

>  static u32 nic_read_byte(u32 __iomem *mcr)
>  {
> @@ -223,8 +214,7 @@ static u32 nic_read_byte(u32 __iomem *mcr)
>  	return result;
>  }
>  
> -/*
> - * Write a byte to an iButton device
> +/* Write a byte to an iButton device
>   */

/* Write a byte to an iButton device */

etc...

[]
> @@ -323,16 +315,15 @@ static int nic_init(u32 __iomem *mcr)
>  		break;
>  	}
>  
> -	printk("Found %s NIC", type);
> +	pr_info("Found %s NIC", type);
>  	if (type != unknown)
> -		printk (" registration number %pM, CRC %02x", serial, crc);
> -	printk(".\n");
> +		pr_cont(" registration number %pM, CRC %02x", serial, crc);
> +	pr_cont(".\n");

This code would be more sensible as

	if (type != unknown)
		pr_info("Found %s NIC registration number %pM, CRC %02x\n",
			type, serial, crc);
	else
		pr_info("Found %s NIC\n", type); 

Though I don't know if registration number is actually a MAC
address or something else.  If it's just a 6 byte identifier
that uses colon separation it should probably use "%6phC"
instead of "%pM"

[] 

> @@ -645,22 +636,21 @@ static inline void ioc3_tx(struct net_device *dev)
>  static void ioc3_error(struct net_device *dev, u32 eisr)
>  {
>  	struct ioc3_private *ip = netdev_priv(dev);
> -	unsigned char *iface = dev->name;
>  
>  	spin_lock(&ip->ioc3_lock);
>  
>  	if (eisr & EISR_RXOFLO)
> -		printk(KERN_ERR "%s: RX overflow.\n", iface);
> +		netdev_err(dev, "RX overflow.\n");
>  	if (eisr & EISR_RXBUFOFLO)
> -		printk(KERN_ERR "%s: RX buffer overflow.\n", iface);
> +		netdev_err(dev, "RX buffer overflow.\n");
>  	if (eisr & EISR_RXMEMERR)
> -		printk(KERN_ERR "%s: RX PCI error.\n", iface);
> +		netdev_err(dev, "RX PCI error.\n");
>  	if (eisr & EISR_RXPARERR)
> -		printk(KERN_ERR "%s: RX SSRAM parity error.\n", iface);
> +		netdev_err(dev, "RX SSRAM parity error.\n");
>  	if (eisr & EISR_TXBUFUFLO)
> -		printk(KERN_ERR "%s: TX buffer underflow.\n", iface);
> +		netdev_err(dev, "TX buffer underflow.\n");
>  	if (eisr & EISR_TXMEMERR)
> -		printk(KERN_ERR "%s: TX PCI error.\n", iface);
> +		netdev_err(dev, "TX PCI error.\n");

All of these should probably be ratelimited() output.


