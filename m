Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BABC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337B22173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LSk4JaiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbfHWQKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:10:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41489 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388997AbfHWQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:10:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so5808935pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=brEz57KSv9M0lzRju932ZTp5uWTNGJMBeYQNt57q3B8=;
        b=LSk4JaiG3kNahJym5ph4p7/DJszhGCxXYsNz9CSryZBvZSEWdvgKnM9o/iYlhJpnhY
         CIxBe/BWxYQDTnOwVGPWaxb7855aVGTWS2LKsP+jgxko4VMfvsyEeaWp11bI5zR40AxO
         SmqZ1nUYR4g85pD5hbkGczt5q5VVEQvWbckzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=brEz57KSv9M0lzRju932ZTp5uWTNGJMBeYQNt57q3B8=;
        b=uCgCpEEp1EPP6uQY8Um89CSaH+Hgpb35QC9u5j+6NVCHzBEkthMeHK+mPmZSkLT2w6
         nl+wszEOmsJcaQLwmaZZyqY4rAPGwRsqvZ55peaHZSQq156jk7/L4r+CpTc5kdOWvxMc
         a1emGQPlmJ7DQbbf/BsTZBiJBAyArXmoVOrLw1+2m9YKVE2lZnn+D5iRgdq6wslST09q
         UNVb+DxJEYcfB99Ibf7CLrmhxniAdG2DX7GPoSCX/lb11PSdUaS26GUvhhOX4FycdqpO
         n5lY78Ijo4T8sjTLatSN5KWbBufkNgZDAQUTMEgm9hqyWmURgl0z2bygKAnCqDmwFKlL
         W5/A==
X-Gm-Message-State: APjAAAVLEu/PcLsEC+K2ZMelxEMg3kFWXdzz0yLsWwwJTETlxD5jZAQB
        KoJMXvd1MegO7r62tKUD5XuAd59rt3LIGbbozkeVOPxWjG3y6GA1CVnhi7CGwDlZYMMHy9kxVrC
        +Wq5JrYxJ55DvqFS7dDMI0NuSHNYIiYFLkdpCn0kQnZpaNH993puY4oKE6HnPffUTakksXYF/iY
        2vZ8UJkQ==
X-Google-Smtp-Source: APXvYqxiP2ekIBBxAiFgPENCMVwHMGc68Z6hyNSBFfdXPSdkPG9bT4Of774IUlvHarZSaUjmecbKzA==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr3626425ply.309.1566576609501;
        Fri, 23 Aug 2019 09:10:09 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a142sm3342737pfd.147.2019.08.23.09.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 09:10:08 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_ethernet=3a_Delete_unnecessary_checks_b?=
 =?UTF-8?Q?efore_the_macro_call_=e2=80=9cdev=5fkfree=5fskb=e2=80=9d?=
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        intel-wired-lan@lists.osuosl.org,
        bcm-kernel-feedback-list@broadcom.com,
        UNGLinuxDriver@microchip.com,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Doug Berger <opendmb@gmail.com>,
        Douglas Miller <dougmill@linux.ibm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <af1ae1cf-4a01-5e3a-edc2-058668487137@web.de>
 <4ab7f2a5-f472-f462-9d4c-7c8d5237c44e@wanadoo.fr>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <c90f0649-0dc0-df9a-21e6-ae6566ca5935@broadcom.com>
Date:   Fri, 23 Aug 2019 09:10:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4ab7f2a5-f472-f462-9d4c-7c8d5237c44e@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-08-23 7:08 a.m., Christophe JAILLET wrote:
> Hi,
>
> in this patch, there is one piece that looked better before. (see below)
>
> Removing the 'if (skb)' is fine, but concatening everything in one 
> statement just to save 2 variables and a few LOC is of no use, IMHO, 
> and the code is less readable.
Agreed.
>
> just my 2c.
>
>
> CJ
>
>
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index d3a0b614dbfa..8b19ddcdafaa 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -2515,19 +2515,14 @@ static int bcmgenet_dma_teardown(struct 
> bcmgenet_priv *priv)
>  static void bcmgenet_fini_dma(struct bcmgenet_priv *priv)
>  {
>      struct netdev_queue *txq;
> -    struct sk_buff *skb;
> -    struct enet_cb *cb;
>      int i;
>
>      bcmgenet_fini_rx_napi(priv);
>      bcmgenet_fini_tx_napi(priv);
>
> -    for (i = 0; i < priv->num_tx_bds; i++) {
> -        cb = priv->tx_cbs + i;
> -        skb = bcmgenet_free_tx_cb(&priv->pdev->dev, cb);
> -        if (skb)
> -            dev_kfree_skb(skb);
> -    }
> +    for (i = 0; i < priv->num_tx_bds; i++)
> + dev_kfree_skb(bcmgenet_free_tx_cb(&priv->pdev->dev,
> +                          priv->tx_cbs + i));
>
>      for (i = 0; i < priv->hw_params->tx_queues; i++) {
>          txq = netdev_get_tx_queue(priv->dev, priv->tx_rings[i].queue);
