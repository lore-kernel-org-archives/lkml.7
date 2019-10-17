Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DEEECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B304E2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391704AbfJQB3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:29:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:49928 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbfJQB3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:29:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x9H1Sgc9000334;
        Wed, 16 Oct 2019 20:28:42 -0500
Message-ID: <3a1176067b745fddfc625bbd142a41913ee3e3a1.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] ftgmac100: Disable HW checksum generation on AST2500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Vijay Khemka <vijaykhemka@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        joel@jms.id.au, linux-aspeed@lists.ozlabs.org, sdasari@fb.com
Date:   Thu, 17 Oct 2019 12:28:41 +1100
In-Reply-To: <20191011213027.2110008-1-vijaykhemka@fb.com>
References: <20191011213027.2110008-1-vijaykhemka@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 14:30 -0700, Vijay Khemka wrote:
> HW checksum generation is not working for AST2500, specially with
> IPV6
> over NCSI. All TCP packets with IPv6 get dropped. By disabling this
> it works perfectly fine with IPV6. As it works for IPV4 so enabled
> hw checksum back for IPV4.
> 
> Verified with IPV6 enabled and can do ssh.

So while this probably works, I don't think this is the right
approach, at least according to the comments in skbuff.h

The driver should have handled unsupported csum via SW fallback
already in ftgmac100_prep_tx_csum()

Can you check why this didn't work for you ?

Cheers,
Ben.

> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
> Changes since v1:
>  Enabled IPV4 hw checksum generation as it works for IPV4.
> 
>  drivers/net/ethernet/faraday/ftgmac100.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> b/drivers/net/ethernet/faraday/ftgmac100.c
> index 030fed65393e..0255a28d2958 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1842,8 +1842,19 @@ static int ftgmac100_probe(struct
> platform_device *pdev)
>  	/* AST2400  doesn't have working HW checksum generation */
>  	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac")))
>  		netdev->hw_features &= ~NETIF_F_HW_CSUM;
> +
> +	/* AST2500 doesn't have working HW checksum generation for IPV6
> +	 * but it works for IPV4, so disabling hw checksum and enabling
> +	 * it for only IPV4.
> +	 */
> +	if (np && (of_device_is_compatible(np, "aspeed,ast2500-mac")))
> {
> +		netdev->hw_features &= ~NETIF_F_HW_CSUM;
> +		netdev->hw_features |= NETIF_F_IP_CSUM;
> +	}
> +
>  	if (np && of_get_property(np, "no-hw-checksum", NULL))
> -		netdev->hw_features &= ~(NETIF_F_HW_CSUM |
> NETIF_F_RXCSUM);
> +		netdev->hw_features &= ~(NETIF_F_HW_CSUM |
> NETIF_F_RXCSUM
> +					 | NETIF_F_IP_CSUM);
>  	netdev->features |= netdev->hw_features;
>  
>  	/* register network device */

