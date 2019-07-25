Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0A5C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DA6218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcFtG2aZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfGYTug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:50:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54235 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfGYTug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:50:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so46017863wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 12:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FV1xDJoP9a0vwOXDEvXEM+/RPFrYOHva7RrN0TOy9Co=;
        b=BcFtG2aZ5PiXakx2S5FN3AxBrs99PwJIjVKFkTjJZ6C2jOdIPihUCqzwIGvHbtZUQM
         tCK8oys1Ol7MIJal/tIi8TvSd64AW1nOci+wJpEUZhyqsDETYxeujipYE9oAMV30P1ZD
         +h9U87DwcQhHyn6EBXqWEodnu9MPIrDLGqt7tkScq3ir7jCni7BfgtgJMnjlcwWqp1C7
         eHyJz5Wy+TFj0gMTYNBKX9GksLbZn9UCcdD/LrRGZjn1YUzi0HwZtGMX2seREvCk9+SS
         Dn8krF19Eh/NuTnnp7Gawygl0x+dSCmwmy8HvPbl2bZud0Fx51Qo6XiREHYIh+phPIM+
         6uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FV1xDJoP9a0vwOXDEvXEM+/RPFrYOHva7RrN0TOy9Co=;
        b=SVHqME83/3mBOlOjoa3Dd5J4ItgpPNJTO/hnLDeC1PSRhfGzquxBmT51ihvC38VbIz
         knE9I7jSBWMVhkEcDjPTuM+Y2yrXtXZmcrlJ7OBSoEBgkdG4MpJ5KLrdk5RKQteS1t3c
         PnsMJ1ycGbWm1saQzsbuRammqD5/ghX+7gU7Yd2T1NNGk1PBtH8NyQZ7k1arXTKLA7vr
         Ha6IDytsaFn8cvtTevAWSnaFV5dob5S9exrhvZzEt+YdkL0Z3ziUvO7TnAPDaaBoKuk6
         PW1JNhoDWfB4PlHksGJG7n/ozMY7T243fn4zZBd0iHfdmUuz8kf6bhXJ82YefwQXm6Y5
         hhxg==
X-Gm-Message-State: APjAAAVQbzpouRGjh/3YI8657Zy6lpkxxeXlpx20CsyRS1c54Jv1Jtpa
        v7F0jEXbOOMj5/pmj/Kh7L11gWajDpASodC4XDU=
X-Google-Smtp-Source: APXvYqxM6VipCe3Akez4fcovXOfIwBfjz8dYtJ9asbenHiKkND5es85mKjTFXB+UyLkAzeKCoVwOMutAaAWzItLyzSE=
X-Received: by 2002:a7b:c751:: with SMTP id w17mr84979969wmk.127.1564084233178;
 Thu, 25 Jul 2019 12:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOKSTBs-cHMr7xbJVVUjZ9C3__bY6jZU-_TZ0RmMRMJ3dBk3PA@mail.gmail.com>
 <0c3f445d-1e37-1531-d3d5-f7ad75c58343@metux.net> <CADnq5_NqDNLzZW6h3cXBUfTMsBe6isvE6YQH=9Op6Gews=ubGg@mail.gmail.com>
 <CAOKSTBvjJ+3he9AJoRGkxQfQLoG_T9jY+H8p0o6A6FdmnisSJA@mail.gmail.com>
In-Reply-To: <CAOKSTBvjJ+3he9AJoRGkxQfQLoG_T9jY+H8p0o6A6FdmnisSJA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Jul 2019 15:50:20 -0400
Message-ID: <CADnq5_Mjq9GxeO3m3F2bEjfmWr7k2KbGkNVJ7k7YKNdVsyMb5Q@mail.gmail.com>
Subject: Re: AMD Drivers
To:     Gilberto Nunes <gilberto.nunes32@gmail.com>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        LKML <linux-kernel@vger.kernel.org>,
        dri devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 3:29 PM Gilberto Nunes
<gilberto.nunes32@gmail.com> wrote:
>
> Hi there!
>
> I try the kernel 5.3.0-050300rc1-generic and almost everything works
> perfectly, except there's no sound in HDMI!!!

Sounds is fixed with this patch:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-fixes-5.3&id=3D92=
e6475ae0a0383b012eb21c1aaf0e5456b1a3d9
which is on it's way upstream for rc2.

Alex

> Pavucontrol show me device unplugged!
> But I have now work properly NIC and GPU!
>
>
> lspci
> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Root Complex
> 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Family 15h (Models
> 60h-6fh) I/O Memory Management Unit
> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev c8)
> 00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Kabini
> HDMI/DP Audio
> 00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Host Bridge
> 00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Root Port
> 00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Root Port
> 00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Host Bridge
> 00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Root Port
> 00:08.0 Encryption controller: Advanced Micro Devices, Inc. [AMD] Device =
1578
> 00:09.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157d
> 00:09.2 Audio device: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Audio Controller
> 00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
> XHCI Controller (rev 20)
> 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
> Controller [AHCI mode] (rev 49)
> 00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
> EHCI Controller (rev 49)
> 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (r=
ev 4a)
> 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (re=
v 11)
> 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Function 0
> 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Function 1
> 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Function 2
> 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Function 3
> 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Function 4
> 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> (Models 60h-6fh) Processor Function 5
> 01:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
> RTL8411B PCI Express Card Reader (rev 01)
> 01:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
> 02:00.0 Network controller: Qualcomm Atheros QCA9377 802.11ac Wireless
> Network Adapter (rev 31)
> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]
> Lexa PRO [Radeon RX 550/550X] (rev c3)
> ---
> Gilberto Nunes Ferreira
>
> (47) 3025-5907
> (47) 99676-7530 - Whatsapp / Telegram
>
> Skype: gilberto.nunes36
>
>
> Em qui, 25 de jul de 2019 =C3=A0s 14:26, Alex Deucher
> <alexdeucher@gmail.com> escreveu:
> >
> > On Thu, Jul 25, 2019 at 3:30 AM Enrico Weigelt, metux IT consult
> > <lkml@metux.net> wrote:
> > >
> > > On 24.07.19 16:17, Gilberto Nunes wrote:
> > >
> > > Hi,
> > >
> > > crossposting to dri-devel, as it smells like a problem w/ amdgpu driv=
er.
> > >
> > > > CPU - AMD A12-9720P RADEON R7, 12 COMPUTE CORES 4C+8G
> > > > GPU - Wani [Radeon R5/R6/R7 Graphics] (amdgpu)
> > > > Network Interface card:
> > > > 01:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > > > RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
> > > >
> > > > When I install kernel 4.18.x or 5.x, the network doesn't work anymo=
re...
> > >
> > > What about other versions (eg. v4.19) ?
> > > Which is the last working version ?
> > >
> > > > I can loaded the modulo r8169 andr8168.
> > > > I saw enp1s0f1 as well but there's no link at all!
> > > > Even when I fixed the IP none link!
> > > > I cannot ping the network gateway or any other IP inside LAN!
> > > > Right now, I booted my laptop with kernel
> > > > Linux version 5.2.2-050202-generic (kernel@kathleen) (gcc version
> > > > 9.1.0 (Ubuntu 9.1.0-9ubuntu2)) #201907231250 SMP Tue Jul 23 12:53:2=
1
> > > > UTC 2019
> > >
> > > Could you also try 5.3 ?
> > >
> > > > The system boot slowly, and I have a SSD Samsung, which in kernel
> > > > 4.15, boot quickly.
> > > > And there's many errors in dmesg command, like you can see in this =
pastbin
> > > >
> > > > https://paste.ubuntu.com/p/YhbjnzYYYh/
> > >
> > > looks like something's wrong w/ reading gpu registers (more precisely
> > > waiting for some changing), that's causing the soft lockup. (maybe to=
o
> > > big timeout ?)
> >
> > It looks like the dGPU fails to power up properly when you attempt to
> > use it.  You can append amdgpu.runpm=3D0 to the kernel command line in
> > grub to disable dynamically powering down the dGPU.
> >
> > Alex
> >
> > >
> > > > Oh! By the way, the network card r8169 are work wonderful!
> > >
> > > Didn't you say (above) that it does not work ?
> > > Or is it just an immediate fail and later comes back ?
> > >
> > >
> > > --mtx
> > >
> > >
> > > --
> > > Enrico Weigelt, metux IT consult
> > > Free software and Linux embedded engineering
> > > info@metux.net -- +49-151-27565287
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
