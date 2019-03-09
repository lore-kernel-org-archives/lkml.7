Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD9C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8638E20836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPX6agXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfCIOWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:22:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55792 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfCIOWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:22:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id q187so356910wme.5;
        Sat, 09 Mar 2019 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iJ7GVdFMJfD8adgjPNS/jtJI5VRP32URLIKXbn+1+xk=;
        b=aPX6agXXsAP+BbmV31OmamXKwzTHjikmD8qvmHdL+QYnCB6WC+ocdYOlDQ+pzWIxKG
         kCUaSU/lt7ij3s2p7ZS6j6lHR29EJjEgECJ/vzJo9ESZ2wGQ4gfkalSQcA1E7pM5LiPo
         7TdfUHZFWbyiHBtuwImAKMNaFQh5EVJRbkQsGkCrmPa5Wv3k1Scq8NXxaKNVHnIjz8Ks
         W+vc2/Y7afsAeztaWl6Gty1l2kekRoQV5mmaJ17Fp/MdD8qdWJmTfW+VEIceq4REHChN
         WxSmptyzEhIgjBZzSlrJIXqTx0Ny+Z4Xb2/YFBgWXWF/2PixizmbprWjv2tXaOpLq+nx
         lyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iJ7GVdFMJfD8adgjPNS/jtJI5VRP32URLIKXbn+1+xk=;
        b=jnXly0OunTFMeEUAccfzB3MU5RxeoO96kfov4GCVNW5eaRc4iYAjqVGAMVadeGFaXF
         CLH6fBHEWNy3E2Q97hOno6jVBMZw+Bid+ekrd7E2nTd9rAASH+eL6r1D/FvzqGWxG8jo
         OU28RcHq7q1RULAO1Ve3nyavGIiEo6L6ePasBMUCCHq94JnNpkgA9oIyg1yrefDEFy6y
         ysqybrTb8yum/0JXX47jPk0f5TVbkaqXaBtmuFnvlQa8PizneuPQOYBw0vAj/uqABlzY
         pAz7FxfxukPraHCScgmew9nLyG0kvCD0macqbumdZ4VpxrmnbcvdNCX4tgySJZfE37QA
         L1xA==
X-Gm-Message-State: APjAAAU2M6w+JsrgLM0uDYarrKVYFJoqTKaNEK86cTaEApVmMhFGcSU4
        UMabVMtUx4iI0b4AzWRyKcI039x9cxc=
X-Google-Smtp-Source: APXvYqy+2wqlDbVp8k3Iud2wYmBxOCBwCKgtQox8ivsYJtOB5BLu1Xn+bnd+Lx4A/XMz75AtOQNFMg==
X-Received: by 2002:a1c:7ed0:: with SMTP id z199mr11679355wmc.89.1552141322032;
        Sat, 09 Mar 2019 06:22:02 -0800 (PST)
Received: from ?IPv6:2003:ee:f27:ae00:bc3a:186e:8458:23ed? (p200300EE0F27AE00BC3A186E845823ED.dip0.t-ipconnect.de. [2003:ee:f27:ae00:bc3a:186e:8458:23ed])
        by smtp.googlemail.com with ESMTPSA id g15sm634222wrw.78.2019.03.09.06.22.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 06:22:01 -0800 (PST)
Subject: Re: [PATCH] net: can: Increase tx queue length
To:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
From:   Andre Naujoks <nautsch2@gmail.com>
Message-ID: <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com>
Date:   Sat, 9 Mar 2019 15:22:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/19 3:07 PM, Appana Durga Kedareswara rao wrote:
> While stress testing the CAN interface on xilinx axi can
> in loopback mode getting message "write: no buffer space available"
> Increasing device tx queue length resolved the above mentioned issue.

No need to patch the kernel:

$ ip link set <dev-name> txqueuelen 500

does the same thing.

> 
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
> --> Network devices default tx_queue_len is 1000 but for socket
> can device it is 10 any reason for it?? 
>  
>  drivers/net/can/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index c05e4d5..32bd5be 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -642,7 +642,7 @@ static void can_setup(struct net_device *dev)
>  	dev->mtu = CAN_MTU;
>  	dev->hard_header_len = 0;
>  	dev->addr_len = 0;
> -	dev->tx_queue_len = 10;
> +	dev->tx_queue_len = 500;
>  
>  	/* New-style flags. */
>  	dev->flags = IFF_NOARP;
> 

