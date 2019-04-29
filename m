Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33372C46470
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18B82064A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="L2NDNSrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfD2P7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:59:09 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57677 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfD2P7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:59:08 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44t8Tw6f7Qz9vD3V;
        Mon, 29 Apr 2019 17:59:00 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=L2NDNSrr; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hkeVVjfzCfqx; Mon, 29 Apr 2019 17:59:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44t8Tw5N2zz9vD3T;
        Mon, 29 Apr 2019 17:59:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556553540; bh=Kp+aYmFfv0JnYmtls8kr+xjU9L+AwS+/axPDLN7qAsk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L2NDNSrrHtZM9ifT2jdeIcFKfGkJFjJOEa3L/AgvNxvyqEk2zKI8+BQYvcm5iw3Cx
         p57f+V5CMVuIh4MQHinoRagT8tQdRCW8S/7gN8XZdtSjCsG0WlJMUWEf5Y/qBOZcm0
         fBe4xPw6PxTLgIKLcQcKMB6nrGtG9CNdp6aRGXqE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E91B88B8B4;
        Mon, 29 Apr 2019 17:59:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AeKoec8SOXJI; Mon, 29 Apr 2019 17:59:05 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D02D8B8B3;
        Mon, 29 Apr 2019 17:59:04 +0200 (CEST)
Subject: Re: [PATCH 22/41] drivers: tty: serial: cpm_uart: fix logging calls
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org,
        linux-serial@vger.kernel.org, andrew@aj.id.au,
        gregkh@linuxfoundation.org, sudeep.holla@arm.com,
        liviu.dudau@arm.com, linux-mips@vger.kernel.org, vz@mleia.com,
        linux@prisktech.co.nz, sparclinux@vger.kernel.org,
        khilman@baylibre.com, macro@linux-mips.org,
        slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk,
        linux-amlogic@lists.infradead.org,
        andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
        davem@davemloft.net
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <1556369542-13247-23-git-send-email-info@metux.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a00ba23b-e73e-c964-a6d0-347cb605b8c8@c-s.fr>
Date:   Mon, 29 Apr 2019 17:59:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556369542-13247-23-git-send-email-info@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/04/2019 à 14:52, Enrico Weigelt, metux IT consult a écrit :
> Fix checkpatch warnings by using pr_err():
> 
>      WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
>      #109: FILE: drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c:109:
>      +		printk(KERN_ERR
> 
>      WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
>      #128: FILE: drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c:128:
>      +		printk(KERN_ERR
> 
>      WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
>      +           printk(KERN_ERR
> 
>      WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
>      +           printk(KERN_ERR
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

But is that really worth doing those changes ?

If we want to do something useful, wouldn't it make more sense to 
introduce the use of dev_err() in order to identify the faulting device 
in the message ?

Christophe

> ---
>   drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c | 6 ++----
>   drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c | 6 ++----
>   2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
> index 56fc527..aed61e9 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
> @@ -71,8 +71,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
>   	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
>   	dp_offset = cpm_dpalloc(dpmemsz, 8);
>   	if (IS_ERR_VALUE(dp_offset)) {
> -		printk(KERN_ERR
> -		       "cpm_uart_cpm1.c: could not allocate buffer descriptors\n");
> +		pr_err("cpm_uart_cpm1.c: could not allocate buffer descriptors\n");
>   		return -ENOMEM;
>   	}
>   	dp_mem = cpm_dpram_addr(dp_offset);
> @@ -90,8 +89,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
>   
>   	if (mem_addr == NULL) {
>   		cpm_dpfree(dp_offset);
> -		printk(KERN_ERR
> -		       "cpm_uart_cpm1.c: could not allocate coherent memory\n");
> +		pr_err("cpm_uart_cpm1.c: could not allocate coherent memory\n");
>   		return -ENOMEM;
>   	}
>   
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
> index 40cfcf4..a0fccda 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
> @@ -106,8 +106,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
>   	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
>   	dp_offset = cpm_dpalloc(dpmemsz, 8);
>   	if (IS_ERR_VALUE(dp_offset)) {
> -		printk(KERN_ERR
> -		       "cpm_uart_cpm.c: could not allocate buffer descriptors\n");
> +		pr_err("cpm_uart_cpm.c: could not allocate buffer descriptors\n");
>   		return -ENOMEM;
>   	}
>   
> @@ -125,8 +124,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
>   
>   	if (mem_addr == NULL) {
>   		cpm_dpfree(dp_offset);
> -		printk(KERN_ERR
> -		       "cpm_uart_cpm.c: could not allocate coherent memory\n");
> +		pr_err("cpm_uart_cpm.c: could not allocate coherent memory\n");
>   		return -ENOMEM;
>   	}
>   
> 
