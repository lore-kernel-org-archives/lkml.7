Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7597EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4805B206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpotNEY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfKLMst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 07:48:49 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46461 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfKLMst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:48:49 -0500
Received: by mail-oi1-f195.google.com with SMTP id n14so14600025oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 04:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jzm7986JS/rnjdFEfFSppu8t4BpdNBEDWXZlt0QkzRM=;
        b=hpotNEY2jP9EbNNf1lY01Z4p8VZIHhK5Uf/xk9kM4m5UjiTl2tVwaeqotaFn/MYzSM
         uJ4Mq0BTFkLcY129vsyTy4KaTMfLeqYAmhTOUMsz+471cQqdWkLsqYn13ePb5PP3GQAl
         FIJr/Gs+mx892sKJSAmXY3hBRAXniQmqOLy/dfvlvbfaChxaLoslE362YzCtXxlio1rV
         4Mplt/KjTVhRNHDLvKzPgCRAPXynQi8sS51oPWq6D3eze9ddnVYHt2/DWrYg8aFEhDuU
         +hV6wWmnaSnWGSqbavzyD+Q+DnsFLOzGeACwqjE0oNyz7ptTjDepUQo8AZgkSrhp54sm
         vKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=Jzm7986JS/rnjdFEfFSppu8t4BpdNBEDWXZlt0QkzRM=;
        b=Za1xkfw79sTPrdllnYdkZUA1IwgOZNVEn5zN6mpHOed1nXHXB32tmqRyv0Xu/OnzPw
         CfoR1qKJWu7Ykj8OiRnrWCkb51CsDXvd0N16lzNx7BrzvAPpU3MUWHfhmWdZ4zvntt40
         WqZMlGSKGUrbfxe73KKNJLP/hXe7Y583oKWDkofQheKlag8MqIgrS7odXygfd4vnF7q4
         5zUkOmXXVE0gVm1/Ruiaind3bKlCkAw6dQ9mV1fNzhg1QoGRkhpWG1vg5ggdgNu8cW53
         SfeE+kU0bjj3sqJfY3aXj8fTafYtTIGcID12t8+wTMGV7VFXfQxiE7McrbDt5mzYdAQZ
         ESJw==
X-Gm-Message-State: APjAAAVq6ssIQgnGhb5YrGd2r0YgUPhXwTMOCH5ADzKbPyXTajPS6Z9+
        nv7SgcBa1XcslBHxE6gYGw==
X-Google-Smtp-Source: APXvYqxtYYaMppT1AsUoDPjRx/kCU171B9mYR9+ekZc1K7T40+2H65m90zVCtGZFXPwcrcaNpUGmew==
X-Received: by 2002:aca:58d6:: with SMTP id m205mr3771826oib.32.1573562927956;
        Tue, 12 Nov 2019 04:48:47 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id l32sm6193445otl.74.2019.11.12.04.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 04:48:47 -0800 (PST)
Received: from minyard.net (unknown [192.168.27.180])
        by serve.minyard.net (Postfix) with ESMTPSA id B47A6180046;
        Tue, 12 Nov 2019 12:48:46 +0000 (UTC)
Date:   Tue, 12 Nov 2019 06:48:45 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, cminyard@mvista.com,
        asmaa@mellanox.com, joel@jms.id.au, linux-aspeed@lists.ozlabs.org,
        sdasari@fb.com
Subject: Re: [PATCH 2/2] drivers: ipmi: Modify max length of IPMB packet
Message-ID: <20191112124845.GE2882@minyard.net>
Reply-To: minyard@acm.org
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
 <20191112023610.3644314-2-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112023610.3644314-2-vijaykhemka@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 06:36:10PM -0800, Vijay Khemka wrote:
> As per IPMB specification, maximum packet size supported is 255,
> modified Max length to 240 from 128 to accommodate more data.

I couldn't find this in the IPMB specification.

IIRC, the maximum on I2C is 32 byts, and table 6-9 in the IPMI spec,
under "IPMB Output" states: The IPMB standard message length is
specified as 32 bytes, maximum, including slave address.

I'm not sure where 128 came from, but maybe it should be reduced to 31.

-corey

> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/char/ipmi/ipmb_dev_int.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
> index 2419b9a928b2..7f9198bbce96 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -19,7 +19,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/wait.h>
>  
> -#define MAX_MSG_LEN		128
> +#define MAX_MSG_LEN		240
>  #define IPMB_REQUEST_LEN_MIN	7
>  #define NETFN_RSP_BIT_MASK	0x4
>  #define REQUEST_QUEUE_MAX_LEN	256
> -- 
> 2.17.1
> 
