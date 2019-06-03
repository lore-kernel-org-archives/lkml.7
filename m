Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D259C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C9627433
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXTYdOAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfFCRBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:01:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41164 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFCRBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:01:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id b21so9436382oic.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0MLgXQF5vH23h1KYWlPuV0evmen8yKWQSXaDjS7gROU=;
        b=bXTYdOAOmCBEf4dZJMRmpwMXGA9bG6Ccvf3Tcu0lzgGBdta805U47eXIQFOvzITEwV
         GzLaA/WMnLuUDj+UfCE7D/ld3YbgmbNotWvVfQstlemsJy4fQieFileAfYeF8dywWKbq
         OEkl48OlryjHpdlCqQOfH937m1t3uGidXZOVgBOY9WPDhtpp3DZ6m/j6htorHs1IPvc8
         Tlq7bF8pEf0hohGoT/oFUv/ikU27hMC2Qz+9mnhLii4phXP6GfcVWmPFNmqr5eENrbPM
         ckZgiCzehhjOKmM7h5n0rEs/6yCuwRbjo6PQe77sedJWVuIHxTkLuB/6gZXqRdq0Q3Pk
         XLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=0MLgXQF5vH23h1KYWlPuV0evmen8yKWQSXaDjS7gROU=;
        b=LLYJFQhTRjlaFf+d6zynNZUFNuoca7DssoxdEgDfVolpdRj45Jal6+I0tu17ol60G+
         psUycmNhuoUWJfygEfrdmWVD3BCxj/ui3iXqAlal2FagEBqqAgpEPwQIMzlb38fpN/2r
         Q1xwDnZzl8HhL+xlAgoG5L3LAHU419FTyzNNfSZRD6zsJTTVAwTv8lATafPINYbK6i2h
         NqMUeB68guwf86glNAnUVhQgt2AsIwEbQUo47wzrLi9XzVQwPavaVTw2h2993GUnb0bX
         jFYTlos0ClGcYxsD3Ap190FgjAFs4633YRer8htS1sa8B7a7eUxWQOAjlj0stJkDbhXw
         QVxQ==
X-Gm-Message-State: APjAAAXYgk5ULZ4vs6QxO6xwalQMLj7TjYkXLj4nlUKC/l895VIKMuyu
        71F+F98VjhXXxagVkJjdeA==
X-Google-Smtp-Source: APXvYqy386isB9eeY65vjp8u9TUF3ySUcf9XTJCl0DyAa6L5k7AmZV9/Y9kS0f3/FDI2KTuXe5FLaw==
X-Received: by 2002:aca:55d7:: with SMTP id j206mr1646137oib.71.1559581288876;
        Mon, 03 Jun 2019 10:01:28 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id t206sm1669134oig.30.2019.06.03.10.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 10:01:28 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:c2:e16b:3a60:98fc])
        by serve.minyard.net (Postfix) with ESMTPSA id 81A4C1800CD;
        Mon,  3 Jun 2019 17:01:27 +0000 (UTC)
Date:   Mon, 3 Jun 2019 12:01:25 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 02/57] drivers: ipmi: Drop device reference
Message-ID: <20190603170125.GM2742@minyard.net>
Reply-To: minyard@acm.org
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-3-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559577023-558-3-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:49:28PM +0100, Suzuki K Poulose wrote:
> Drop the reference to a device found via bus_find_device()

This change is correct, but it probably doesn't belong in this
series.  Would you like me to take it as a stand-alone change?

-corey

> 
> Cc: Corey Minyard <minyard@acm.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/char/ipmi/ipmi_si_platform.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> index f2a91c4..ff82353 100644
> --- a/drivers/char/ipmi/ipmi_si_platform.c
> +++ b/drivers/char/ipmi/ipmi_si_platform.c
> @@ -442,6 +442,7 @@ void ipmi_remove_platform_device_by_name(char *name)
>  				      pdev_match_name))) {
>  		struct platform_device *pdev = to_platform_device(dev);
>  
> +		put_device(dev);
>  		platform_device_unregister(pdev);
>  	}
>  }
> -- 
> 2.7.4
> 
