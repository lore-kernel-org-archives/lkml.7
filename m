Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC90C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA78420879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558079709;
	bh=qbF3/Hqw/7ip+2ZWKi+N4Olloffuq4ChzZr9IXxoU2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qsuTt6/i4Vv933KGqQSSrkqLZx01ie5IdLtjsD3JPJ0vqs36RTLH6jTDb/fZBeCWB
	 A0mxy10Xbo6K0nSU59p/sS/oxfC8JbXal7PxNl21Q1to0fA4s27gB1X4oV14kdW4j0
	 1+1l4TQgWPY5JpbfoiQjt8f5/ngDwXBjqUVXtX3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfEQHzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:55:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37444 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfEQHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:55:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id h19so5448302ljj.4;
        Fri, 17 May 2019 00:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pEdqxUq2kFPbQG6ltN8L5vlpCirLiiFr+zJtL30RO/Y=;
        b=QgMtzGY9oyw2QOxL8X1KKLClM4GK3nj8aSvDXaXilCixD15BqPDmEL0dT2lQc3o/gc
         7Lj5D1+JasXwdRntWWudbnxXFYKqStuUZgTXibSQRTdOwBNMkIcy3IzJoJwOS13eItn0
         Im+4xPKPqQbK01JVIlhQW5QFrEO0Rs9oH5/neuuLKvX+2aY56wCikD5LuDmqc90kX58O
         WGhpxK/Om8p3fTK5WoPVSOa30p3vvW4DODagxQs/CQZln+8gFvn9tOxu7cLQo4yC0czh
         QInijDLaIMFOp9jTBxALIeKj4zyQvAr6tp/7u0M/21lVe5TnrWXvEBRewraVF3rYhLDk
         YmfA==
X-Gm-Message-State: APjAAAUFJUFqDTgl5RiHOtRECv3HPHuIAz1XqFnht3FRcWpzm/qI49X3
        hztxfy+1/hqP7HKGtnHzm/Y=
X-Google-Smtp-Source: APXvYqyaCo7hyNeRbDAczxTHKhv/KtVGXRBwVH4UKcAudvLikrJqh3bOgouA4ZoMoHZnpHXC1Mfm1w==
X-Received: by 2002:a2e:4c7:: with SMTP id a68mr9429936ljf.165.1558079706380;
        Fri, 17 May 2019 00:55:06 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h11sm1407169lfh.8.2019.05.17.00.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 00:55:05 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hRXhm-0002dA-IX; Fri, 17 May 2019 09:55:02 +0200
Date:   Fri, 17 May 2019 09:55:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jacmet@sunsite.dk, gregkh@linuxfoundation.org, jslaby@suse.com,
        shubhrajyoti.datta@xilinx.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial-uartlite: Fix null-ptr-deref in ulite_exit
Message-ID: <20190517075502.GE28564@localhost>
References: <20190516040931.16276-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516040931.16276-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 12:09:31PM +0800, YueHaibing wrote:
> If ulite_probe is not called or failed to registed
> uart_register_driver, unload the module will call
> uart_unregister_driver, which will tigger NULL
> pointer dereference like this:
> 
> BUG: KASAN: null-ptr-deref in tty_unregister_driver+0x19/0x100
> Read of size 4 at addr 0000000000000034 by task syz-executor.0/4246

> This patch fix this by moving uart_unregister_driver
> to ulite_remove.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/tty/serial/uartlite.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index b8b912b..2e49fb6 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -867,6 +867,7 @@ static int ulite_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	uart_unregister_driver(&ulite_uart_driver);

This broken. Consider what happens if you have tho ports registered and
you unbind the first.

Someone else sent a fix for this here

	https://lkml.kernel.org/r/20190514033219.169947-1-wangkefeng.wang@huawei.com

That fix also has some issues, but is still better given the current
state this driver is in.

>  	return rc;
>  }
>  
> @@ -897,7 +898,6 @@ static int __init ulite_init(void)
>  static void __exit ulite_exit(void)
>  {
>  	platform_driver_unregister(&ulite_platform_driver);
> -	uart_unregister_driver(&ulite_uart_driver);
>  }
>  
>  module_init(ulite_init);

Johan
