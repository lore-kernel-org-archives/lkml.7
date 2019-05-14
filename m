Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC49C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA11208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557817721;
	bh=o+Vkk3LBE6/pL/wtJXU8wADpeJGCXpYZzZkDMYnD/VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UMbUnhrK4rVS9YazubNka5auU5URJ/wz0bh/wEhjveSqV1qYt7VrjwmkBkbsk28Hj
	 inlrNQxgF/xtpFr7U1pxDfes+00vTwjHyA0d+vhbv4XYZpWkPPOuKFIrlO3/zutzAV
	 +fu19zNFDFIBH9ha6OLZa3varNc55zHgtL/Fqd9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfENHIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:08:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41864 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfENHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:08:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so13259158lja.8;
        Tue, 14 May 2019 00:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iS06kB5ZsaBvWO7SzJ2wNbRcRRxjQq61l0eGaYMLlY4=;
        b=C7INfTl+sLIBTqFzuyD3AGgq2AzgLe1KNFOo9RSqXv3QzIuZzSahNn+TjQVKrtjf4U
         Nx6woRk+8cZGARrOQBmv+kyNgfV5KL1VXGIhGi4ZLmhSMUvJSvSjkpfI+7H/yWtCvHQZ
         tsbdmOq3rfEh7zIyhzUL5Ff9acIbxgS20giU0qVPBOJ8nBhHm/Dfmi1FVxJjy4Hc0wDp
         pz+EXrfLsifY/lLpeOazgVFljR2v3i9hQGO7J+GG15EVxHq8azoptqXokg7mc1qEW9uu
         rjaMdUizWpemB6XaI2muT/b5wVvbTyEYOQvAMzabsXf/Lou/hE4RVKCPccdXUuzNaHDj
         pv/g==
X-Gm-Message-State: APjAAAWr6esQLBBmTwyUEsNa7RFgkAKrDBufvUTJ4hRliPyUppioLaRs
        2c+ZS1ELH2z556HoMLId3Zo=
X-Google-Smtp-Source: APXvYqwejSvY0LujlCMKwCpvdJbpE/kk14WTjcpUwVa1O8v9+OBhLFqlPuwjADSNcsmW23aZr3Dp7Q==
X-Received: by 2002:a2e:730c:: with SMTP id o12mr12659075ljc.61.1557817717250;
        Tue, 14 May 2019 00:08:37 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id b28sm3712702lfj.37.2019.05.14.00.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 00:08:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hQRY7-00011s-Rg; Tue, 14 May 2019 09:08:31 +0200
Date:   Tue, 14 May 2019 09:08:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] tty: serial: uartlite: avoid null pointer dereference
 during rmmod
Message-ID: <20190514070831.GH9651@localhost>
References: <20190514033219.169947-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514033219.169947-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 11:32:19AM +0800, Kefeng Wang wrote:
> After commit 415b43bdb008 "tty: serial: uartlite: Move uart register to
> probe", calling uart_unregister_driver unconditionally will trigger a
> null pointer dereference due to ulite_uart_driver may not registed.
> 
>   CPU: 1 PID: 3755 Comm: syz-executor.0 Not tainted 5.1.0+ #28
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
>   Call Trace:
>    __dump_stack lib/dump_stack.c:77 [inline]
>    dump_stack+0xa9/0x10e lib/dump_stack.c:113
>    __kasan_report+0x171/0x18d mm/kasan/report.c:321
>    kasan_report+0xe/0x20 mm/kasan/common.c:614
>    tty_unregister_driver+0x19/0x100 drivers/tty/tty_io.c:3383
>    uart_unregister_driver+0x30/0xc0 drivers/tty/serial/serial_core.c:2579
>    __do_sys_delete_module kernel/module.c:1027 [inline]
>    __se_sys_delete_module kernel/module.c:970 [inline]
>    __x64_sys_delete_module+0x244/0x330 kernel/module.c:970
>    do_syscall_64+0x72/0x2a0 arch/x86/entry/common.c:298
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Call uart_unregister_driver only if ulite_uart_driver.state not null to
> fix it.
> 
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/tty/serial/uartlite.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index b8b912b5a8b9..06e79c11141d 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -897,7 +897,8 @@ static int __init ulite_init(void)
>  static void __exit ulite_exit(void)
>  {
>  	platform_driver_unregister(&ulite_platform_driver);
> -	uart_unregister_driver(&ulite_uart_driver);
> +	if (ulite_uart_driver.state)
> +		uart_unregister_driver(&ulite_uart_driver);
>  }
>  
>  module_init(ulite_init);

This looks like you're just papering over the real issue, which is the
crazy idea of ultimately registering one driver per port:

	https://lkml.kernel.org/r/1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com

It appears only the preparatory patches from that series were applied,
and I think whoever is responsible should consider reverting those
instead.

If the statically allocated port state is that big of any issue, you
need to make serial core support dynamic allocation.

Johan
