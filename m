Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDAEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E511205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391090AbfC0SsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:48:15 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34572 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732279AbfC0SsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:48:12 -0400
Received: by mail-oi1-f193.google.com with SMTP id v10so9392610oib.1;
        Wed, 27 Mar 2019 11:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2Syk7Xn91T5K8r9BoPWPS/Vbl5KuJG6l9tLwU9jezA=;
        b=Xxh4Iro6Ug9+RR3lkHsoCY8XoXHoSCiTvqyDm8go8nvX/HYrdOZUesGHKpQeVBCW/p
         7yJQTlZSsUQ8Ek7Ut6gn3v4qhoXeH0sslKlIdugdUl/vppMWi4wLo4s6HQAcfX7PwN5w
         VlHg/7QgIlOY/ypcCaycZFIGNdadE9ILkjMTrfjLK4ClmaOXyOyV9FeK1RYLNgGtofmg
         naDlhwFFMB5IeRjLDGf5GHd8hby61mOrpiwzOnDhXznrwraw7IHphv4+maWi+ObzB8v6
         Dd0Bj0PdiTiF2MMNcySgDuEtguVSJOALqUEKnFUKx+VGhnTRyEjQ3RoRZwJlewYa9/Xw
         JHjw==
X-Gm-Message-State: APjAAAUsPBmrL1pUYYCQEf04trzdA7bN5kgzeKbpIuR3uTJo/ntKcqAA
        QEu24JMhrf+t8c/BrNwCMTOg5mRveLk=
X-Google-Smtp-Source: APXvYqzBzdMHdZ2U7s/PAChtp4x6tRU6EkTBJXx/V6jNmq2ND0DUXTs3nUs//P/gz4CVgDHEQCLJTg==
X-Received: by 2002:aca:ecd1:: with SMTP id k200mr20432692oih.15.1553712490924;
        Wed, 27 Mar 2019 11:48:10 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id i17sm7836291otr.36.2019.03.27.11.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 11:48:09 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id y84so13711081oia.12;
        Wed, 27 Mar 2019 11:48:09 -0700 (PDT)
X-Received: by 2002:aca:f1d4:: with SMTP id p203mr9229624oih.154.1553712488537;
 Wed, 27 Mar 2019 11:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
 <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com> <1f3a370e-1c47-2fcb-6816-2b136713c68d@nxp.com>
In-Reply-To: <1f3a370e-1c47-2fcb-6816-2b136713c68d@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 27 Mar 2019 13:47:56 -0500
X-Gmail-Original-Message-ID: <CADRPPNTDvbbnGKqS4E8yd_rM5VryM518BYMge+rzhG0uQMR7qg@mail.gmail.com>
Message-ID: <CADRPPNTDvbbnGKqS4E8yd_rM5VryM518BYMge+rzhG0uQMR7qg@mail.gmail.com>
Subject: Re: [RESEND] i2c: imx: defer probing on dma channel request
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Steven Price <steven.price@arm.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Ying Zhang <ying.zhang22455@nxp.com>,
        "upstream-release@linux.nxdi.nxp.com" 
        <upstream-release@linux.nxdi.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 8:46 AM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
> Hello,
>
> Just FYI, I'm still seeing issues with the dma driver compiled _out_,
> trying to test i2c without dma support. I get the crash below in generic
> driver code later in the boot process, debug is in progress.

That probably means the dma API shouldn't return -EPROBE_DEFER when
the driver is not compiled in?

>
> P.S. This is seen on an NXP LS1043A chip.
>
> [    5.152697] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000010
> [    5.161483] Mem abort info:
> [    5.164311]   ESR = 0x96000004
> [    5.167407]   Exception class = DABT (current EL), IL = 32 bits
> [    5.173391] device_initialize: dev = ffff800027756808
> [    5.178446] usb 4-1: new SuperSpeed Gen 1 USB device number 2 using
> xhci-hcd
> [    5.185489]   SET = 0, FnV = 0
> [    5.188532]   EA = 0, S1PTW = 0
> [    5.191676] Data abort info:
> [    5.194599]   ISV = 0, ISS = 0x00000004
> [    5.198476]   CM = 0, WnR = 0
> [    5.201485] [0000000000000010] user address but active_mm is swapper
> [    5.207894] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    5.213455] Modules linked in:
> [    5.216502] CPU: 0 PID: 18 Comm: kworker/0:1 Not tainted
> 5.1.0-rc2-next-20190327-00021-g7b1a4c075381-dirty #15
> [    5.226489] Hardware name: LS1043A RDB Board (DT)
> [    5.231189] Workqueue: events deferred_probe_work_func
> [    5.236317] pstate: a0000005 (NzCv daif -PAN -UAO)
> [    5.241098] pc : device_reorder_to_tail+0x13c/0x1b8
> [    5.245965] lr : device_reorder_to_tail+0xd8/0x1b8
> [    5.250743] sp : ffff000011823c70
> [    5.254046] x29: ffff000011823c70 x28: 0000000000000000
> [    5.259347] x27: ffff0000117abcd8 x26: ffff000011293a20
> [    5.264649] x25: ffff00001102a000 x24: ffff00001102a708
> [    5.269950] x23: ffff00001102a700 x22: ffff000010d28000
> [    5.275251] x21: ffff80007393b9a0 x20: fffffffffffffff8
> [    5.280552] x19: ffff80007393b8f0 x18: ffffffffffffffff
> [    5.285853] x17: 0000000000000002 x16: 0000000000000000
> [    5.291154] x15: ffff00001127d6c8 x14: 000000000000017e
> [    5.296454] x13: 0000000000000001 x12: 0000000000000000
> [    5.301755] x11: 0000000000000000 x10: 0000000000000980
> [    5.307055] x9 : ffff0000118238c0 x8 : ffff800073872560
> [    5.312356] x7 : ffff800073871d00 x6 : 0000000000000058
> [    5.317656] x5 : 000000000000000f x4 : 0000000000000100
> [    5.322957] x3 : 000080006a351000 x2 : 0991ec05b7534200
> [    5.328257] x1 : fffffffffffffff8 x0 : 0000000000000000
> [    5.333560] Process kworker/0:1 (pid: 18, stack limit =
> 0x(____ptrval____))
> [    5.340509] Call trace:
> [    5.342945]  device_reorder_to_tail+0x13c/0x1b8
> [    5.347466]  device_for_each_child+0x50/0xa8
> [    5.351725]  device_reorder_to_tail+0xc4/0x1b8
> [    5.356157]  device_pm_move_to_tail+0x34/0x50
> [    5.360502]  deferred_probe_work_func+0x64/0xa0
> [    5.365023]  process_one_work+0x1c8/0x320
> [    5.369021]  worker_thread+0x234/0x428
> [    5.372761]  kthread+0xf4/0x120
> [    5.375892]  ret_from_fork+0x10/0x18
> [    5.379458] Code: 911c2318 911c02f7 d0004e19 b4000274 (f9400e84)
> [    5.385541] ---[ end trace ab4b151d346a8d41 ]---
>
> ---
> Best Regards, Laurentiu
>
> On 25.03.2019 19:12, Steven Price wrote:
> > On 25/03/2019 15:30, laurentiu.tudor@nxp.com wrote:
> >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>
> >> If the dma controller is not yet probed, defer i2c probe.
> >> The error path in probe was slightly modified (no functional change)
> >
> > There is a functional change for cases like:
> >
> >>      ret = pm_runtime_get_sync(&pdev->dev);
> >>      if (ret < 0)
> >>              goto rpm_disable;
> >
> > ...as rpm_disable will no longer fall through to the call of
> > clk_disable_unprepare().
> >
> >> to avoid triggering this WARN_ON():
> >> "cg-pll0-div1 already disabled
> >> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb0"
> >
> > I'm also not sure how this WARN_ON was hit. i2c_imx_probe() calls
> > clk_prepare_enable() which should increment the reference count. So it
> > should always be possible to decrememt the enable_count. What am I missing?
> >
> >> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >> ---
> >>   drivers/i2c/busses/i2c-imx.c | 21 +++++++++++++--------
> >>   1 file changed, 13 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> >> index 42fed40198a0..4e34b1572756 100644
> >> --- a/drivers/i2c/busses/i2c-imx.c
> >> +++ b/drivers/i2c/busses/i2c-imx.c
> >> @@ -1111,7 +1111,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
> >>                              pdev->name, i2c_imx);
> >>      if (ret) {
> >>              dev_err(&pdev->dev, "can't claim irq %d\n", irq);
> >> -            goto clk_disable;
> >> +            clk_disable_unprepare(i2c_imx->clk);
> >> +            return ret;
> >>      }
> >>
> >>      /* Init queue */
> >> @@ -1161,19 +1162,25 @@ static int i2c_imx_probe(struct platform_device *pdev)
> >>      pm_runtime_mark_last_busy(&pdev->dev);
> >>      pm_runtime_put_autosuspend(&pdev->dev);
> >>
> >> +    /* Init DMA config if supported */
> >> +    ret = i2c_imx_dma_request(i2c_imx, phy_addr);
> >> +    if (ret) {
> >> +            if (ret != -EPROBE_DEFER)
> >> +                    dev_info(&pdev->dev, "can't use DMA, using PIO instead.\n");
> >> +            else
> >> +                    goto del_adapter;
> >> +    }
> >> +
> >
> > This can be simplified by reversing the condition:
> >
> >       if (ret) {
> >               if (ret == -EPROBE_DEFER)
> >                       goto del_adapter;
> >               dev_info();
> >       }
> >
> > or even:
> >
> >       if (ret == -EPROBE_DEFER)
> >               goto del_adapter;
> >       else if (ret)
> >               dev_info();
> >
> >>      dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
> >>      dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
> >>      dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
> >>              i2c_imx->adapter.name);
> >>
> >> -    /* Init DMA config if supported */
> >> -    ret = i2c_imx_dma_request(i2c_imx, phy_addr);
> >> -    if (ret < 0)
> >> -            goto clk_notifier_unregister;
> >> -
> >>      dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
> >>      return 0;   /* Return OK */
> >>
> >> +del_adapter:
> >> +    i2c_del_adapter(&i2c_imx->adapter);
> >
> > This looks like a separate fix (previously the call to
> > i2c_add_numbered_adapter() was not undone in case of later errors). It
> > worth spelling this out in the commit message.
> >
> > Thanks,
> >
> > Steve
> >
> >>   clk_notifier_unregister:
> >>      clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
> >>   rpm_disable:
> >> @@ -1182,8 +1189,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
> >>      pm_runtime_set_suspended(&pdev->dev);
> >>      pm_runtime_dont_use_autosuspend(&pdev->dev);
> >>
> >> -clk_disable:
> >> -    clk_disable_unprepare(i2c_imx->clk);
> >>      return ret;
> >>   }
> >>
> >>
> >
