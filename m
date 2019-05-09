Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B31C004C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E927214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 03:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ge+Pjvx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfEID0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 23:26:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34417 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfEID0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 23:26:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so783095wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 20:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRhRc+8pG5xCFTlPPF8IH5Jn8EJcWR+taQ45d02yZww=;
        b=Ge+Pjvx3g4sMxcB8INSQA8PNEWybLExQ+5MUy+EJX2Ni9nrkR5JxNznOE6+q30QnsC
         1U5+RQwNnumYj+vpNrx19iK+ntOAKV8hoFvrCvVtw7fbS10Cb045l2xHPhXvRhck6Au/
         HZNuIJH++2TqxiXkI0y8J1fceqH8otIZSGPA8F6XbgbRbF6EonFPymw+94sf4FQYAyGV
         IBp+4kcUO2C9T53N3d+UkGcgfa8Sr3eDkv15sXU/9Vw1GgGg/7mbPaOLQtuR/cBEeHwK
         AfUYO1Qu0JQZ2gQDyDdnkn2Zsl+ofJNcwGxHzxTMUZe5gi+bIrMWCrpfBCkyByZgHy1v
         wibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRhRc+8pG5xCFTlPPF8IH5Jn8EJcWR+taQ45d02yZww=;
        b=Jk7aKrqF0rX941Uo2N7myaSIFr3aGmrKu/x4PESho49YXuYtL/lG9Zr9r3r7zT5VzX
         LGw+0/mdkItoKPdfS2JuWE+tDsExG/C7r2b14DaF57Juv5Kx7TMoeavNcJekIeqJ+kJt
         y2yvduFoiXHBBUSRnFGzbPcuvQ/58JEKrp1oYqDV7V5GzjKLfU2p6czbJ6wknf4i4EtZ
         uf4m5+9B+hb1qJlWDylJ2WZr/DiFhzcCIxkqmuPLjpIQli2BG5eyVPf8ukcQx7QcmWeT
         jaydw8Q9qziGFmxyA/pmh7/A3kUXVjgIbOmJK6VwEryPR87dGVfg7LobfyVfsMZuRwli
         wRfg==
X-Gm-Message-State: APjAAAVpINomD93OXyndLZ3ZIk4iIcimg2Ta50MNiSnuqloDT6WiZbSY
        CC6xPIVbNBWRFAO5vHftc8RK3S8oWB6pcay/zzTZnA==
X-Google-Smtp-Source: APXvYqwavGD8Uf37ZBJXMkSF/61pdtw/gAuyxjoSTqrxEnjIpwqD/q2DxlhPKPgM+SPcDf6Hm9tDb/uyRSjZRQsyq60=
X-Received: by 2002:a5d:50c2:: with SMTP id f2mr916900wrt.253.1557372370271;
 Wed, 08 May 2019 20:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
 <5d58059c-1b10-665f-983b-a1d018a30d1f@gmail.com>
In-Reply-To: <5d58059c-1b10-665f-983b-a1d018a30d1f@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 8 May 2019 20:25:58 -0700
Message-ID: <CALAqxLVyPxTsM34wmMtJGvVHUUq27gh0BDzbS=YWnLbNvpibiw@mail.gmail.com>
Subject: Re: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
To:     Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, "Yang, Fei" <fei.yang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 12:01 AM Andrzej Pietrasiewicz
<andrzejtp2010@gmail.com> wrote:
>
> Hi John,
>
> += Marek
>
> W dniu 08.05.2019 o 04:18, John Stultz pisze:
> > Since commit 772a7a724f69 ("usb: gadget: f_fs: Allow scatter-gather
> > buffers"), I've been seeing trouble with adb transfers in Android on
> > HiKey960, HiKey and now Dragonboard 845c.
> >
> > Sometimes things crash, but often the transfers just stop w/o any
> > obvious error messages.
> >
> > Initially I thought it was an issue with the HiKey960 dwc3 usb patches
> > being upstreamed, and was using the following hack workaround:
> >    https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-5.1&id=dcdadaaec9db7a7b78ea9b838dd1453359a2f388
> >
> > Then dwc2 added sg support, and I ended up having to revert it to get
> > by on HiKey:
> >    https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey-5.1&id=6e91b4c7bd1e94bdd835263403c53e85a677b848
> >
> > (See thread here: https://lkml.org/lkml/2019/3/8/765)
> >
> > And now I've reproduced the same issue (with the same dwc3 workaround)
> > on the already upstream code for Dragonboard 845c.
> >
> > Fei Yang has also reached out and mentioned he was seeing similar
> > problems with the f_fs sg support.
> >
> > Andrzej: Do you have any ideas or suggestions on this? I'm happy to
> > test or run any debug patches, if it would help narrow the issue down.
> >
>
> There is a patch:
>
> https://www.spinics.net/lists/linux-usb/msg178536.html
> https://www.spinics.net/lists/linux-usb/msg179653.html
>
> which fixes a subtle bug, but hasn't been applied yet.
>

So, the "fix zlp handling" doesn't seem to changes things on hikey w/
the dwc2 hardware.

I still see the following crash right away:
   13.571611] functionfs read size 512 > requested size 24, splitting
request into multiple reads.
[   13.571773] ------------[ cut here ]------------
[   13.585205] kernel BUG at mm/slub.c:3944!
[   13.589215] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[   13.594698] Modules linked in:
[   13.597754] Process adbd (pid: 408, stack limit = 0x000000001b71cb6b)
[   13.604197] CPU: 0 PID: 408 Comm: adbd Not tainted 5.1.0-06623-g27dc6c9 #168
[   13.611243] Hardware name: HiKey Development Board (DT)
[   13.616465] pstate: 40400005 (nZcv daif +PAN -UAO)
[   13.621266] pc : kfree+0x210/0x258
[   13.624672] lr : ffs_epfile_io.isra.12+0xf8/0x6b8
[   13.629371] sp : ffffff8011b63b50
[   13.632682] x29: ffffff8011b63b50 x28: ffffffc06b918e00
[   13.637993] x27: ffffffc0703af138 x26: 00000000000001e8
[   13.643303] x25: ffffff8011b63c98 x24: ffffffc074c3e800
[   13.648613] x23: ffffffc074affa00 x22: ffffff80114b9000
[   13.653923] x21: ffffff80108b19b0 x20: ffffff8011c2d000
[   13.659233] x19: ffffffbf00470b40 x18: 0000000000000000
[   13.664542] x17: 0000000000000000 x16: ffffffc06b918e00
[   13.669851] x15: 0000000000000000 x14: 0000000000000000
[   13.675160] x13: 0000000000000000 x12: 0000000000000000
[   13.680469] x11: 0000000000000000 x10: 0000000000000000
[   13.685779] x9 : 0000000000000000 x8 : 00000073d8dd6150
[   13.691088] x7 : 00000073d8dd6598 x6 : 0000007280805113
[   13.696398] x5 : 0000007280805113 x4 : 0000000000000000
[   13.701707] x3 : ffffffc0703af100 x2 : 0000000000000000
[   13.707020] x1 : ffffffbf00470b48 x0 : ffffffbf00470b48
[   13.712334] Call trace:
[   13.714784]  kfree+0x210/0x258
[   13.717837]  ffs_epfile_io.isra.12+0xf8/0x6b8
[   13.722191]  ffs_epfile_read_iter+0xb4/0x188
[   13.726459]  new_sync_read+0xf4/0x190
[   13.730118]  __vfs_read+0x2c/0x40
[   13.733430]  vfs_read+0x8c/0x148
[   13.736654]  ksys_read+0x64/0xf0
[   13.739878]  __arm64_sys_read+0x14/0x20
[   13.743715]  el0_svc_common.constprop.0+0xa8/0x100
[   13.748504]  el0_svc_handler+0x28/0x78
[   13.752250]  el0_svc+0x8/0xc
[   13.755132] Code: f9400260 378000a0 f9400660 37000060 (d4210000)
[   13.761225] ---[ end trace 0220b13deaa73ab7 ]---
[   13.783381] Kernel panic - not syncing: Fatal exception
[   13.788616] SMP: stopping secondary CPUs
[   13.792814] Kernel Offset: disabled
[   13.796301] CPU features: 0x002,24002004
[   13.800219] Memory Limit: none
[   13.820708] Rebooting in 5 seconds..

thanks
-john
