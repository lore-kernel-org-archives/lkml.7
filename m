Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1633BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE7E218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbfB1PvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:51:05 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:49851 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfB1PvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:51:05 -0500
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 2B76F240012;
        Thu, 28 Feb 2019 15:50:59 +0000 (UTC)
Date:   Thu, 28 Feb 2019 16:50:59 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Yan Markman <ymarkman@marvell.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: Re: [EXT] [PATCH net-next 07/15] net: mvpp2: fix the computation of
 the RXQs
Message-ID: <20190228155059.GH4359@kwain>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
 <20190228132128.30154-8-antoine.tenart@bootlin.com>
 <DM5PR18MB21347E7CD5D39D016810C62DD6750@DM5PR18MB2134.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR18MB21347E7CD5D39D016810C62DD6750@DM5PR18MB2134.namprd18.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yan,

On Thu, Feb 28, 2019 at 03:40:50PM +0000, Yan Markman wrote:
> 
> Regarding the MVPP2_DEFAULT_RXQ
> Seems the current variant is flexible, permitting easy customize the
> configuration according to customer's needs.
> 
> Regarding the Queue in probe():
> Looking into old code there where no2 queue-modes but 3:
> enum mv_pp2_queue_distribution_mode {
> 	MVPP2_QDIST_SINGLE_MODE,
> 	MVPP2_QDIST_MULTI_MODE,
> 	MVPP2_SINGLE_RESOURCE_MODE
> };
> The current   if(MVPP2_QDIST_MULTI_MODE)else is correct also for the
> MVPP2_SINGLE_RESOURCE_MODE, but new/patched isn't.

There are only 2 modes supported in the upstream kernel:
MVPP2_QDIST_SINGLE_MODE and MVPP2_QDIST_MULTI_MODE. The third one you
mentioned is only supported in out-of-tree kernels.

Therefore patches sent to the upstream kernel do not take in into
account, as it is not supported.

> Since this patch doesn't change any functionality (right now) but
> reduces the flexibility I do not see real reason to apply it.

This patch do not break the upstream support of PPv2 and does improve
two thing:

- It limits the total number of RXQs being allocated, to ensure the
  number of RXQs being used do not exceed the number of available RXQ
  (which would make the driver to fail).
- It does fix PPv2.1 support, which was broken.

I do think the patch will benefit the upstream PPv2 support.

Thanks,
Antoine

> The patch fixes the computation of RXQs being used by the PPv2 driver,
> which is set depending on the PPv2 engine version and the
> queue mode used. There are three cases:
> 
> - PPv2.1: 1 RXQ per CPU.
> - PPV2.2 with MVPP2_QDIST_MULTI_MODE: 1 RXQ per CPU.
> - PPv2.2 with MVPP2_QDIST_SINGLE_MODE: 1 RXQ is shared between the CPUs.
> 
> The PPv2 engine supports a maximum of 32 queues per port. This patch
> adds a check so that we do not overstep this maximum.
> 
> It appeared the calculation was broken for PPv2.1 engines since
> f8c6ba8424b0, as PPv2.1 ports ended up with a single RXQ while they
> needed 4. This patch fixes it.
> 
> Fixes: f8c6ba8424b0 ("net: mvpp2: use only one rx queue per port per CPU")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  4 ++--
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 23 ++++++++++++-------
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> index 17ff330cce5f..687e011de5ef 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> @@ -549,8 +549,8 @@
>  #define MVPP2_MAX_TSO_SEGS		300
>  #define MVPP2_MAX_SKB_DESCS		(MVPP2_MAX_TSO_SEGS * 2 + MAX_SKB_FRAGS)
>  
> -/* Default number of RXQs in use */
> -#define MVPP2_DEFAULT_RXQ		1
> +/* Max number of RXQs per port */
> +#define MVPP2_PORT_MAX_RXQ		32
>  
>  /* Max number of Rx descriptors */
>  #define MVPP2_MAX_RXD_MAX		1024
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 24cee6cbe309..9c6200a59910 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -4062,8 +4062,8 @@ static int mvpp2_multi_queue_vectors_init(struct mvpp2_port *port,
>  			snprintf(irqname, sizeof(irqname), "hif%d", i);
>  
>  		if (queue_mode == MVPP2_QDIST_MULTI_MODE) {
> -			v->first_rxq = i * MVPP2_DEFAULT_RXQ;
> -			v->nrxqs = MVPP2_DEFAULT_RXQ;
> +			v->first_rxq = i;
> +			v->nrxqs = 1;
>  		} else if (queue_mode == MVPP2_QDIST_SINGLE_MODE &&
>  			   i == (port->nqvecs - 1)) {
>  			v->first_rxq = 0;
> @@ -4156,8 +4156,7 @@ static int mvpp2_port_init(struct mvpp2_port *port)
>  	    MVPP2_MAX_PORTS * priv->max_port_rxqs)
>  		return -EINVAL;
>  
> -	if (port->nrxqs % MVPP2_DEFAULT_RXQ ||
> -	    port->nrxqs > priv->max_port_rxqs || port->ntxqs > MVPP2_MAX_TXQ)
> +	if (port->nrxqs > priv->max_port_rxqs || port->ntxqs > MVPP2_MAX_TXQ)
>  		return -EINVAL;
>  
>  	/* Disable port */
> @@ -4778,10 +4777,18 @@ static int mvpp2_port_probe(struct platform_device *pdev,
>  	}
>  
>  	ntxqs = MVPP2_MAX_TXQ;
> -	if (priv->hw_version == MVPP22 && queue_mode == MVPP2_QDIST_MULTI_MODE)
> -		nrxqs = MVPP2_DEFAULT_RXQ * num_possible_cpus();
> -	else
> -		nrxqs = MVPP2_DEFAULT_RXQ;
> +	if (priv->hw_version == MVPP22 && queue_mode == MVPP2_QDIST_SINGLE_MODE) {
> +		nrxqs = 1;
> +	} else {
> +		/* According to the PPv2.2 datasheet and our experiments on
> +		 * PPv2.1, RX queues have an allocation granularity of 4 (when
> +		 * more than a single one on PPv2.2).
> +		 * Round up to nearest multiple of 4.
> +		 */
> +		nrxqs = (num_possible_cpus() + 3) & ~0x3;
> +		if (nrxqs > MVPP2_PORT_MAX_RXQ)
> +			nrxqs = MVPP2_PORT_MAX_RXQ;
> +	}
>  
>  	dev = alloc_etherdev_mqs(sizeof(*port), ntxqs, nrxqs);
>  	if (!dev)
> --
> 2.20.1
> 

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
