Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F1DC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EE1233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="PcuOy/1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbfHVJOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:14:03 -0400
Received: from first.geanix.com ([116.203.34.67]:51054 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733031AbfHVJOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:14:02 -0400
Received: from [10.130.30.123] (unknown [89.221.170.34])
        by first.geanix.com (Postfix) with ESMTPSA id 5E7DA26C;
        Thu, 22 Aug 2019 09:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566465226; bh=asXzZBQBNt4GDuGVIHuNtW2Y0ft96E4G10anvfYUF/8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PcuOy/1n0ks2lfIy7rEPtHSNPB2ib/EcUFsL6j04f7IuVtitWCIrrbzy2RxBOk6pC
         T5y8EKSLj/pjQ8FgbkhZaj6hGRxI7rvSoM/QtZhuuuKViecd0e7vNqsRdY+hfhkutL
         1CzgKOitxDGY+xnWHfSElnGpvJjFTDgHZIdTRV8H8Ns86uXP8fpz6t7Nxk9pjJJ0zv
         H2CRY3EibutmIC7wN7clZe0YDPLOgXuGgvcngxyjGSSySP6f98r56hvBd4lKzH3Z6M
         lrUIbnWrVCGdp8fi+/9jqd1HrhXpDH6pxWd39w3/bU2FaD2zYpJgk04OsgbfbwZqfE
         uNps0ZMwytgBg==
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_can=3a_Delete_unnecessary_checks_before?=
 =?UTF-8?B?IHRoZSBtYWNybyBjYWxsIOKAnGRldl9rZnJlZV9za2LigJ0=?=
To:     Markus Elfring <Markus.Elfring@web.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Lukas Wunner <lukas@wunner.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weitao Hou <houweitaoo@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <27674907-fd2a-7f0c-84fd-d8b5124739a9@web.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <dc19a08f-eba9-ebd3-ef0a-3f99e06c9916@geanix.com>
Date:   Thu, 22 Aug 2019 11:13:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <27674907-fd2a-7f0c-84fd-d8b5124739a9@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/08/2019 21.30, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 21 Aug 2019 21:16:15 +0200
> 
> The dev_kfree_skb() function performs also input parameter validation.
> Thus the test around the shown calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/net/can/spi/hi311x.c  | 3 +--
>   drivers/net/can/spi/mcp251x.c | 3 +--
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
> index 03a711c3221b..7c7c7e78214c 100644
> --- a/drivers/net/can/spi/hi311x.c
> +++ b/drivers/net/can/spi/hi311x.c
> @@ -184,8 +184,7 @@ static void hi3110_clean(struct net_device *net)
> 
>   	if (priv->tx_skb || priv->tx_len)
>   		net->stats.tx_errors++;
> -	if (priv->tx_skb)
> -		dev_kfree_skb(priv->tx_skb);
> +	dev_kfree_skb(priv->tx_skb);
>   	if (priv->tx_len)
>   		can_free_echo_skb(priv->net, 0);
>   	priv->tx_skb = NULL;
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index 12358f06d194..1c496d2adb45 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -274,8 +274,7 @@ static void mcp251x_clean(struct net_device *net)
> 
>   	if (priv->tx_skb || priv->tx_len)
>   		net->stats.tx_errors++;
> -	if (priv->tx_skb)
> -		dev_kfree_skb(priv->tx_skb);
> +	dev_kfree_skb(priv->tx_skb);
>   	if (priv->tx_len)
>   		can_free_echo_skb(priv->net, 0);
>   	priv->tx_skb = NULL;
> --
> 2.23.0
> 

Good catch Markus :-)

/Sean
