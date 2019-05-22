Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC61C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88C921473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2IgirfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfEVODH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:03:07 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:45585 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfEVODH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:03:07 -0400
Received: by mail-ua1-f52.google.com with SMTP id n7so879229uap.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvqEy54XO7BgBzdjPUCyWw5uvopLvvCkS57Vvoseego=;
        b=k2IgirfGhODm3PzKcm5/NzKgfhMrDHVKOd+f0LsXxoUTS44hwvopJ4a0MvwJOGfTKy
         HdQjJZ9xS0K5aAnXxeR4rL2S2wAbdr5D3NpqYa6UuFK/lzcJnO9FiwJBoKUu9egnSq3l
         +LG1d3WpAC18rs/zi7FKOuF5Nd054rcnbn2o5+DKAFTtaA6t2zFMAWhTImx5YWZG800l
         SBRJu92oIz5rW/EpzjCQnNU7kqwoHqzmsjTwMCDOZUbR+iCDTms0u+YQ8AEwPPff3FSi
         7IrCXBDX7MkaIkuCZEpKxSVYRZggvxPleb/Kff06aGcWqR3uMSEQBbEct/y6TnO1IMcG
         3neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvqEy54XO7BgBzdjPUCyWw5uvopLvvCkS57Vvoseego=;
        b=i5SgAmtgn9+FuVqon579fGl/Lmjg11hqB6g998cAcG4w9cuAlCSokRg00LNoYDOps0
         E60aG114G+LQs30s9M1C6LYUxG9dW7WJDMf7Pn3uxdAJxCX5wflHdi8vNFYdR4jrxEIr
         LirVLv6qTJ/Kp4fTTX3MOZ1CAX0xo9N5Azbj+uHplEs4gyf6mJTG+hMsw4Ac0R+L7P90
         eucfU8GcN5h+hfzFgmx0HfeWtqMYT7Y1nBTxD3n5t42oLP04sozxfOJ9n6yDD9LfYjJF
         8iHJxpvrjvJ5SAEdTUnRlcja+s+J+zevjy0f0zpcW1dxJQwV6fLPeR7Orby/QkNH4Jsc
         wWAg==
X-Gm-Message-State: APjAAAVHQEPsN2wgT9WvAEwnCnN6nV4BKIadkpwhNSZXAYVKufVSLbFO
        HM3ubfU1P6tKRixxrHdY1cfvBU4u/QaqGsWpEIntQqpq
X-Google-Smtp-Source: APXvYqzK7uaFOjkmNgoFkthau6cdTzaYvVbwsCZLSXdMysfu8mWnJJXd+Rcp3EpzASg5ImrieK9BfagOqvpxgQHBWvc=
X-Received: by 2002:a9f:2c90:: with SMTP id w16mr29775757uaj.103.1558533785814;
 Wed, 22 May 2019 07:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGqxeWTh0NJ177cH5a4ph-W49pFehjdEcVv+SLm__TiHJc_aQ@mail.gmail.com>
 <9f0becda-4ee1-1330-91c4-df919507cb2c@ti.com>
In-Reply-To: <9f0becda-4ee1-1330-91c4-df919507cb2c@ti.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Wed, 22 May 2019 10:03:11 -0400
Message-ID: <CAOGqxeXwnSJT7uN8jOEG5p1e=A72K0y0q=gkdLaZzvRvtANu8Q@mail.gmail.com>
Subject: Re: Generic PHY "unload" crash
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here the crash dump:
# echo >unbind 8b39000.xhci_v2
[168374.367560] xhci-brcm 8b39000.xhci_v2: remove, state 4
[168374.372914] usb usb2: USB disconnect, device number 1
[168374.379314] xhci-brcm 8b39000.xhci_v2: USB bus 2 deregistered
[168374.385771] xhci-brcm 8b39000.xhci_v2: remove, state 1
[168374.391170] usb usb1: USB disconnect, device number 1
[168374.396425] usb 1-1: USB disconnect, device number 2
[168374.416980] xhci-brcm 8b39000.xhci_v2: USB bus 1 deregistered
[168374.427437] Unable to handle kernel paging request at virtual
address d1265234
[168374.434916] pgd = cc887ac0
[168374.437843] [d1265234] *pgd=80000040007003, *pmd=4ca1a003, *pte=00000000
[168374.444872] Internal error: Oops: 207 [#1] SMP ARM
[168374.449824] Modules linked in:
[168374.453045] CPU: 0 PID: 1699 Comm: sh Not tainted 4.9.135-1.12pre #2
[168374.459544] Hardware name: Broadcom STB (Flattened Device Tree)
[168374.465614] task: cc9361c0 task.stack: cb3b0000
[168374.470306] PC is at usb_uninit_xhci+0x40/0x8c
[168374.474960] LR is at brcm_usb_phy_exit+0x110/0x130
[168374.479933] pc : [<c05ab870>]    lr : [<c05aa608>]    psr: 200e0113
[168374.479933] sp : cb3b1d78  ip : cb3b1d90  fp : cb3b1d8c
[168374.491698] r10: cc831d0c  r9 : cb218a80  r8 : cb3b1f68
[168374.497096] r7 : cc960990  r6 : cc960800  r5 : cd34f38c  r4 : cd34f310
[168374.503811] r3 : d1265200  r2 : c0c2dfa0  r1 : 00400000  r0 : cd34f310
[168374.510523] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment user
[168374.517901] Control: 30c5383d  Table: 4c887ac0  DAC: fffffffd
[168374.523899] Process sh (pid: 1699, stack limit = 0xcb3b0210)
[168374.529718] Stack: (0xcb3b1d78 to 0xcb3b2000)
[168374.534216] 1d60:
     cd34f310 cd34f38c
[168374.542578] 1d80: cb3b1dac cb3b1d90 c05aa608 c05ab83c c05aa4f8
00000000 cc960800 cc960990
[168374.550937] 1da0: cb3b1dcc cb3b1db0 c05a9104 c05aa504 cb12b000
cb12b000 00000010 c1a76a0c
[168374.559346] 1dc0: cb3b1de4 cb3b1dd0 c07da9c0 c05a906c cd368410
cd368410 cb3b1dfc cb3b1de8
[168374.567717] 1de0: c068a4b0 c07da980 cd368410 c1a76a0c cb3b1e14
cb3b1e00 c0687a6c c068a488
[168374.576082] 1e00: cd368444 cd368410 cb3b1e2c cb3b1e18 c0687b34
c06879e0 c1a69a38 cd368410
[168374.584443] 1e20: cb3b1e4c cb3b1e30 c06866f4 c0687b14 c068666c
cc831d00 00000000 00000000
[168374.592804] 1e40: cb3b1e64 cb3b1e50 c0685874 c0686678 c0685844
cc831d00 cb3b1e7c cb3b1e68
[168374.601223] 1e60: c03d1eec c0685850 00000010 cc831d00 cb3b1eb4
cb3b1e80 c03d165c c03d1ea8
[168374.609596] 1e80: 00000000 00000000 c036f488 c1a03088 c16ab240
c03d1580 cb3b1f68 00000000
[168374.618018] 1ea0: 000df2a0 00000010 cb3b1f34 cb3b1eb8 c035d9f4
c03d158c 00000000 00000052
[168374.626426] 1ec0: 00000000 00000000 00000000 00040987 0000000a
cd2efe00 cc887780 0000000a
[168374.634850] 1ee0: 00000400 c037f90c cb3b1f24 cb3b1ef8 c037ef4c
00040987 00000000 00000000
[168374.643217] 1f00: cb263a80 00040987 00000000 00000010 c16ab240
000df2a0 cb3b1f68 00000000
[168374.651577] 1f20: 000df2a0 00000010 cb3b1f64 cb3b1f38 c035e8e4
c035d9b8 c16ab240 c037f44c
[168374.659929] 1f40: c1a03088 c16ab240 00000000 00000000 c16ab240
000df2a0 cb3b1fa4 cb3b1f68
[168374.668274] 1f60: c035f804 c035e83c 00000000 00000000 c037f2d4
00040987 000e0a48 00000010
[168374.676618] 1f80: 000df2a0 b6eddd60 00000004 c02092a4 cb3b0000
00000004 00000000 cb3b1fa8
[168374.684961] 1fa0: c0209100 c035f7b4 00000010 000df2a0 00000001
000df2a0 00000010 00000000
[168374.693303] 1fc0: 00000010 000df2a0 b6eddd60 00000004 000df2a0
00000010 000b8228 000b57d8
[168374.701646] 1fe0: 00000000 befc5a1c b6e40bab b6e7d2c6 00070030
00000001 00000000 00000000
[168374.710015] [<c05ab870>] (usb_uninit_xhci) from [<c05aa608>]
(brcm_usb_phy_exit+0x110/0x130)
[168374.718628] [<c05aa608>] (brcm_usb_phy_exit) from [<c05a9104>]
(phy_exit+0xa4/0xc8)
[168374.726458] [<c05a9104>] (phy_exit) from [<c07da9c0>]
(xhci_brcm_remove+0x4c/0x70)
[168374.734202] [<c07da9c0>] (xhci_brcm_remove) from [<c068a4b0>]
(platform_drv_remove+0x34/0x4c)
[168374.742904] [<c068a4b0>] (platform_drv_remove) from [<c0687a6c>]
(__device_release_driver+0x98/0x134)
[168374.752298] [<c0687a6c>] (__device_release_driver) from
[<c0687b34>] (device_release_driver+0x2c/0x38)
[168374.761778] [<c0687b34>] (device_release_driver) from [<c06866f4>]
(unbind_store+0x88/0x108)
[168374.770385] [<c06866f4>] (unbind_store) from [<c0685874>]
(drv_attr_store+0x30/0x3c)
[168374.778303] [<c0685874>] (drv_attr_store) from [<c03d1eec>]
(sysfs_kf_write+0x50/0x54)
[168374.786396] [<c03d1eec>] (sysfs_kf_write) from [<c03d165c>]
(kernfs_fop_write+0xdc/0x1b8)
[168374.794746] [<c03d165c>] (kernfs_fop_write) from [<c035d9f4>]
(__vfs_write+0x48/0x140)
[168374.802832] [<c035d9f4>] (__vfs_write) from [<c035e8e4>]
(vfs_write+0xb4/0x178)
[168374.810306] [<c035e8e4>] (vfs_write) from [<c035f804>] (SyS_write+0x5c/0xbc)
[168374.817505] [<c035f804>] (SyS_write) from [<c0209100>]
(ret_fast_syscall+0x0/0x1c)
[168374.825242] Code: e5943000 e592101c e3510000 0a000006 (e5932034)
[168374.831584] ---[ end trace 91aec3f8a9835a40 ]---

Thanks
Al


On Tue, May 21, 2019 at 3:15 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Alan,
>
> On 21/05/19 1:40 PM, Alan Cooper wrote:
> > I'm seeing an issue on a system where I have a generic PHY that is
> > used by a USB XHCI driver. The XHCI driver does the phy_init() in
> > probe and the phy_exit() in remove. The problem happens when I use
> > sysfs to "unload" the PHY driver before doing an unload of the XHCI
> > driver. This is a result of the XHCI driver calling into the PHY
> > driver's phy_exit routine after it's been removed. It seems like this
> > issue will exist for other PHY provider/user pairs and I don't see an
> > easy solution. I was wondering if anyone had any suggestions on how to
> > solve this problem.
>
> Can you share the crash dump please?
>
> Thanks
> Kishon
