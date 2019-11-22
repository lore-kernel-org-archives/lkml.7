Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A5DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04DF20658
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyyPfQzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKVTkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:40:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43621 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfKVTkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:40:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id l20so7516618oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 11:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4mNZznLq/HyHs5kXhx2p+YBsBEb0wBOCJBKkau1d/eU=;
        b=HyyPfQzWpc8gEAzKgbjaANfO6ZJPyl/nYq3tasa5hwn2pLlipB8FxyMdO2iT7csZ1j
         RuFheadqpUwwJNGiQOqrVrSF/yT3SCkCMkyqZskj8zdGRX/oUZhAxEjXe6CP2GkhLdUz
         lykmNy12ZKv3V/zZlPhLwRP/Teoy9GWiX+6Sp3Vnnz6KmTwAIRmwnUNIBZVztYDVGNSZ
         gXfwFQUsOMwVwSGtGXOeEAcB9zaMMDHaQdP0p9vfMku8aVer4U7zdmg+hYelCjiJRK8p
         nZgLpU6NxW/SUvNcQkVpJuZH8zX9FMyoxF/xJlQMwOsoIArYMU9Ixk+AIxe20V/iultt
         WelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=4mNZznLq/HyHs5kXhx2p+YBsBEb0wBOCJBKkau1d/eU=;
        b=b5P/v3NWrvFxGuazHnyY0xbv1T+D13k3trSWRcZAs4kGjKapfClEcPgXuE6TLrbh+L
         dYx+Wnqeok43spYOHNDUWH268rnfZnoJx3vgHbIv19gDN/Gwyrd8VP+oUN5cH/mo35Of
         GjU7y+av1IVGwg3dVsa5A6VOzAKR01RClRV7oQW79UWNLuPIJ6EcL/Hn/t2p3PcOHa9M
         yoC01G0Pkgrum+CoqhhSN9XjzzLzDS/c0wB1AY67tBwTXyzFOd8XWfEbr0vfqU/rnCif
         Pz0k6TXdrEk2an/78jNj8JgQItkPfoE9HJhbugDvz/bYizFL6jiNvXPg5MxpZQUlkpgZ
         HCRA==
X-Gm-Message-State: APjAAAWI2g2E0MG++113ABLtdIYOfdUKK0kYBaRxmMOEiZJ/uwehHdoA
        oX7M2Cf2zq9hhgwFUNvCRg==
X-Google-Smtp-Source: APXvYqxh0roDPrrTD6PX5fwbpjiYSOczNF6n2ENV3DqhV6cHC+S1PlSTng9VId57nPA4jPLh71CzKw==
X-Received: by 2002:aca:2818:: with SMTP id 24mr13954482oix.26.1574451644038;
        Fri, 22 Nov 2019 11:40:44 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id x65sm2506290ota.16.2019.11.22.11.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:40:43 -0800 (PST)
Received: from minyard.net (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id E4199180059;
        Fri, 22 Nov 2019 19:40:42 +0000 (UTC)
Date:   Fri, 22 Nov 2019 13:40:41 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Asmaa Mnebhi <Asmaa@mellanox.com>
Subject: Re: [PATCH] ipmi: fix ipmb_poll()'s return type
Message-ID: <20191122194041.GB3527@minyard.net>
Reply-To: minyard@acm.org
References: <20191120000741.30657-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120000741.30657-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 01:07:41AM +0100, Luc Van Oostenryck wrote:
> ipmb_poll() is defined as returning 'unsigned int' but the
> .poll method is declared as returning '__poll_t', a bitwise type.
> 
> Fix this by using the proper return type and using the EPOLL
> constants instead of the POLL ones, as required for __poll_t.

Copying the author for comment, but this looks ok with me.

-corey

> 
> CC: Corey Minyard <minyard@acm.org>
> CC: openipmi-developer@lists.sourceforge.net
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/char/ipmi/ipmb_dev_int.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
> index 285e0b8f9a97..2ea51147c3e8 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -154,16 +154,16 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
>  	return ret ? : count;
>  }
>  
> -static unsigned int ipmb_poll(struct file *file, poll_table *wait)
> +static __poll_t ipmb_poll(struct file *file, poll_table *wait)
>  {
>  	struct ipmb_dev *ipmb_dev = to_ipmb_dev(file);
> -	unsigned int mask = POLLOUT;
> +	__poll_t mask = EPOLLOUT;
>  
>  	mutex_lock(&ipmb_dev->file_mutex);
>  	poll_wait(file, &ipmb_dev->wait_queue, wait);
>  
>  	if (atomic_read(&ipmb_dev->request_queue_len))
> -		mask |= POLLIN;
> +		mask |= EPOLLIN;
>  	mutex_unlock(&ipmb_dev->file_mutex);
>  
>  	return mask;
> -- 
> 2.24.0
> 
