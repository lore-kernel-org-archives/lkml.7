Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E51C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B004D20665
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwaEKlPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfIRBah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 21:30:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40714 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbfIRBah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 21:30:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id d22so2335651pll.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 18:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=33HTI06KrYihGCLmTdOTJ2bFANdV8foxW+4RD7RD/Xc=;
        b=DwaEKlPKJqyulqtleaOqVOomI2ti3y98zNUKheFHpcFrLoD0VpS3UXXrXKkemIkxX8
         uiC7GHehMljmtwdBglEjtPEX3MsNehgqWJMJRBJYw97NlR92bfad1bh0w3hNmoVjJyZ3
         MkRvKjEGoWHdJtl/ci8dN2+mRw/Hy/qlnxTuIhnHC1Aivy0x+v+Ma5fuz/5LQrMT99d/
         uzvR5TKacwSgrS+JFBmY1qhkYkH4YWSP7a86Xd5wZ07SRHLzNXYJf6INfeQOdjYFl4kW
         rRb+EHxh3FFSmya+PmRa1ureN94iSctc0FhNUnnutYCgY60zS05juBvCaxAgNxPe/Zhr
         dvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=33HTI06KrYihGCLmTdOTJ2bFANdV8foxW+4RD7RD/Xc=;
        b=ODxqDRvuCgqy86Cr6i0XDFYz1mseA+4NPOXv46D24TKhxOMDZrxtSJaJOzYYGMqdQu
         7pAYDysfm+fFhVcSHUspZoPDug+XnVEWCizWTy5vTJFzlDXwTPrCZ5tGyjNOAt8pLrmL
         +oChmQ9J8OgMpL/GzqXEu+mj/TT6e1TwS4E1aF1B4qOOA7D1vyJApITJ4dr7Y7D1G6h9
         UJN5CQvKwtp1GSodQyb17CbD34WMX+inr357RDZRX2A8cmCdEymf1kpwzREHytjQNLiy
         pQxdELuZncUkP0OMj9acEEsNvr3sSPF9ku1Wns9zCrKD2RemahXtD8XYIzJWjdxi+OqO
         wvfQ==
X-Gm-Message-State: APjAAAX7pWnKCmk9+Xw4bpd8Jn5+F1DzjbSaYjeutbwOB6pFvr6VzC22
        fFSUVPUnIyr6rcyhpkrwZgA=
X-Google-Smtp-Source: APXvYqyItSbjwB5NcNJk5Qx+expovKiT4H393ccaoUu0H9iaQqyIDAwY4aX602YQcUuCcwLEfjJDHg==
X-Received: by 2002:a17:902:aa87:: with SMTP id d7mr1560745plr.203.1568770236125;
        Tue, 17 Sep 2019 18:30:36 -0700 (PDT)
Received: from localhost ([175.223.34.14])
        by smtp.gmail.com with ESMTPSA id u7sm3323938pgr.94.2019.09.17.18.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 18:30:35 -0700 (PDT)
Date:   Wed, 18 Sep 2019 10:30:32 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: Regression in fd5f7cde1b85 ("printk: Never set
 console_may_schedule in console_trylock()")
Message-ID: <20190918013032.GA2895@jagdpanzerIV>
References: <20190917141034.gvjg7bgylqbbxyv7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190917141034.gvjg7bgylqbbxyv7@pengutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/17/19 16:10), Uwe Kleine-König wrote:
> Hello,
>
> Today it saw sysrq on an UART driven by drivers/tty/serial/imx.c report
> a lockdep issue. Bisecting pointed to
>
> 	fd5f7cde1b85 ("printk: Never set console_may_schedule in console_trylock()")

Hmmm...

I don't see how this patch can affect anything. It simply
disables preemption in printk().

> When I type <break>t I get:
> 
> [   87.940104] sysrq: SysRq : This sysrq operation is disabled.
> [   87.948752] 
> [   87.948772] ======================================================
> [   87.948787] WARNING: possible circular locking dependency detected
> [   87.948798] 4.14.0-12954-gfd5f7cde1b85 #26 Not tainted
> [   87.948813] ------------------------------------------------------
> [   87.948822] swapper/0 is trying to acquire lock:
> [   87.948829]  (console_owner){-...}, at: [<c015e438>] console_unlock+0x110/0x598
> [   87.948861] 
> [   87.948869] but task is already holding lock:
> [   87.948874]  (&port_lock_key){-.-.}, at: [<c048d5b0>] imx_rxint+0x2c/0x290
> [   87.948902] 
> [   87.948911] which lock already depends on the new lock.
> [   87.948917] 
> [   87.948923] 
> [   87.948932] the existing dependency chain (in reverse order) is:
> [   87.948938] 
> [   87.948943] -> #1 (&port_lock_key){-.-.}:
> [   87.948975]        _raw_spin_lock_irqsave+0x5c/0x70
> [   87.948983]        imx_console_write+0x138/0x15c
> [   87.948991]        console_unlock+0x204/0x598
> [   87.949000]        register_console+0x21c/0x3e8
> [   87.949008]        uart_add_one_port+0x3e4/0x4dc
> [   87.949019]        platform_drv_probe+0x3c/0x78
> [   87.949027]        driver_probe_device+0x25c/0x47c
> [   87.949035]        __driver_attach+0xec/0x114
> [   87.949044]        bus_for_each_dev+0x80/0xb0
> [   87.949054]        bus_add_driver+0x1d4/0x264
> [   87.949062]        driver_register+0x80/0xfc
> [   87.949069]        imx_serial_init+0x28/0x48
> [   87.949078]        do_one_initcall+0x44/0x18c
> [   87.949087]        kernel_init_freeable+0x11c/0x1cc
> [   87.949095]        kernel_init+0x10/0x114
> [   87.949103]        ret_from_fork+0x14/0x30

This is "normal" locking path

	console_sem -> port->lock

	printk()
	 lock console_sem
	  imx_console_write()
	   lock port->lock

> [   87.949113] -> #0 (console_owner){-...}:
> [   87.949145]        lock_acquire+0x100/0x23c
> [   87.949154]        console_unlock+0x1a4/0x598
> [   87.949162]        vprintk_emit+0x1a4/0x45c
> [   87.949171]        vprintk_default+0x28/0x30
> [   87.949180]        printk+0x28/0x38
> [   87.949189]        __handle_sysrq+0x1c4/0x244
> [   87.949196]        imx_rxint+0x258/0x290
> [   87.949206]        imx_int+0x170/0x178
> [   87.949216]        __handle_irq_event_percpu+0x78/0x418
> [   87.949225]        handle_irq_event_percpu+0x24/0x6c
> [   87.949233]        handle_irq_event+0x40/0x64
> [   87.949242]        handle_level_irq+0xb4/0x138
> [   87.949252]        generic_handle_irq+0x28/0x3c
> [   87.949261]        __handle_domain_irq+0x50/0xb0
> [   87.949269]        avic_handle_irq+0x3c/0x5c
> [   87.949277]        __irq_svc+0x6c/0xa4
> [   87.949287]        arch_cpu_idle+0x30/0x40
> [   87.949297]        arch_cpu_idle+0x30/0x40
> [   87.949305]        do_idle+0xa0/0x104
> [   87.949313]        cpu_startup_entry+0x14/0x18
> [   87.949323]        start_kernel+0x30c/0x368

This one is a "reverse" locking path...

	port->lock -> console_sem

There is more to it:

 imxint()
  lock port->lock
   uart_handle_sysrq_char()
    handle_sysrq()
     printk()
      lock conosole_sem
       imx_console_write()
        lock port->lock			[boom]

This path re-enters serial driver. But it doesn't deadlock, because
uart_handle_sysrq_char() sets a special flag port->sysrq, and serial
consoles are expected to make sure that they don't lock port->lock
in this case. Otherwise we will kill the system:

	void serial_console_write(...)
	{
	...
          if (sport->port.sysrq)
                  locked = 0;
          else if (oops_in_progress)
                  locked = spin_trylock_irqsave(&sport->port.lock, flags);
          else
                  spin_lock_irqsave(&sport->port.lock, flags);
 	...
	}

So I'd say that lockdep is correct, but there are several hacks which
prevent actual deadlock.

No idea why bisection has pointed at fd5f7cde1b85, it really doesn't
change the locking patterns.

	-ss
