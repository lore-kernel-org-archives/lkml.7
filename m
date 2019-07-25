Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29F1C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F590218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmranaj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGYURO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:17:14 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:39783 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfGYURN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:17:13 -0400
Received: by mail-qt1-f170.google.com with SMTP id l9so50332812qtu.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FkjxPL7XMOpuLg8h3aU837wQ3g4RTfaP6Qi98DUbLE8=;
        b=gmranaj6TIlJDaZauUR3Uu/j9hWcNZ2K9G6+aoEO3kxrCD9IyksKJKuUGGW+F5cqb4
         2WZy2z9WtNs6fLWG70BESuKn2f7w6Uo7XMdg3/12oNWIuu/xn7wEH7vgDYEVObRjRP/+
         Bu3r8sQH4ao2zmfeXSgALb0JjL4e7EFLEJb32RyXJaTtqYyLiYLvceSFmytw12P/snqG
         OLceq8yPW/V/LDf6UVwoGH/vJ3glOGFM6nvav30eGpnRuIp1liAYQ7IqKdHPPxfZuUvX
         plVNZs4pUmXG1yRtIxbPnaO9mFw8bZwXJyivdcbqC5h2yLYcYTHt5MUSN3E3eVxl3sxu
         k2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FkjxPL7XMOpuLg8h3aU837wQ3g4RTfaP6Qi98DUbLE8=;
        b=I8Z/mW59YzalrWLpx08DT+tBMrNF5Q0eGq7seX120WQlK3Bje1fgZe3XN54U++LXLj
         ahlRqDNA5bQyGsX8nSeIMmvW4d5DKDJmyVjJjvZVndnSCnmA70yI5LZDJ+KELTWDhCYW
         EVliPK4jRJa8p1Gc1aIyjGPcWpHx5xwDAGq2gzqKhAmvqYmdc/rQQ1ZDKOXALgZgVYhy
         x0p0nBDcxt66VZmAOUsBKoLH9NeS3uHknNC+YxlMGfSA+9glvw+EMnri2cVsNCz9Gf0g
         ektbN657R0FJKm9bAYHa+akoLMt7nB3+0it2neF+82/H3sD2xFiZjm3ZvE5reVKanjJ9
         AzIw==
X-Gm-Message-State: APjAAAW+vf0Mr07/adaQo7jjvtV5KRwkvQE03ioXpD+5nk8HtaNzc6sU
        StMt7WDqSk7GKM64k5X0REPctRdRFNiM58IHQOU=
X-Google-Smtp-Source: APXvYqxR1kHWxg3snhWFMbH+zcFIIZggZGUrl/9Q6f2TNTpB5w1b5ZTwo9CbaHlxX36BEchMERFKO0G/FkGq6u8Cvjk=
X-Received: by 2002:ac8:7219:: with SMTP id a25mr63380875qtp.234.1564085832246;
 Thu, 25 Jul 2019 13:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAOKSTBs-cHMr7xbJVVUjZ9C3__bY6jZU-_TZ0RmMRMJ3dBk3PA@mail.gmail.com>
 <0c3f445d-1e37-1531-d3d5-f7ad75c58343@metux.net> <CADnq5_NqDNLzZW6h3cXBUfTMsBe6isvE6YQH=9Op6Gews=ubGg@mail.gmail.com>
 <CAOKSTBvjJ+3he9AJoRGkxQfQLoG_T9jY+H8p0o6A6FdmnisSJA@mail.gmail.com>
 <CADnq5_Mjq9GxeO3m3F2bEjfmWr7k2KbGkNVJ7k7YKNdVsyMb5Q@mail.gmail.com> <CAOKSTBvoakV3TeTFCnVRScT82U-Hc52DV5C8e2TyakoDGc8Big@mail.gmail.com>
In-Reply-To: <CAOKSTBvoakV3TeTFCnVRScT82U-Hc52DV5C8e2TyakoDGc8Big@mail.gmail.com>
From:   Gilberto Nunes <gilberto.nunes32@gmail.com>
Date:   Thu, 25 Jul 2019 17:16:35 -0300
Message-ID: <CAOKSTBvrQOSdbA46tCtsfG0v-CxLPN43toxUkjvxhboBaWkHXw@mail.gmail.com>
Subject: Re: AMD Drivers
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        LKML <linux-kernel@vger.kernel.org>,
        dri devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYK!
I also noted that I received this message in dmesg command:

[    2.492134] amdgpu: [powerplay] Voltage value looks like a Leakage
ID but it's not patched
[    2.492173] amdgpu: [powerplay] Voltage value looks like a Leakage
ID but it's not patched
[    2.492198] amdgpu: [powerplay] Voltage value looks like a Leakage
ID but it's not patched
[    2.492224] amdgpu: [powerplay] Voltage value looks like a Leakage
ID but it's not patched
[    2.492249] amdgpu: [powerplay] Voltage value looks like a Leakage
ID but it's not patched
[    2.492274] amdgpu: [powerplay] Voltage value looks like a Leakage
ID but it's not patched
[    2.492299] amdgpu: [powerplay] Voltage value looks like a Leakage
ID but it's not patched

It's look like just a warning and to no impact the system for now!
---
Gilberto Nunes Ferreira

(47) 3025-5907
(47) 99676-7530 - Whatsapp / Telegram

Skype: gilberto.nunes36


Em qui, 25 de jul de 2019 =C3=A0s 17:02, Gilberto Nunes
<gilberto.nunes32@gmail.com> escreveu:
>
> Awesome, thanks for the update! I will wait for the next upstrem...
> Besides this minor problem everything is wonderful!
> Even retroarch works now!
> With 4.18.x 5.1.x and 5.2.x freeze the entire system when access amdgpu..=
.
>
> Thanks a lot!
> ---
> Gilberto Nunes Ferreira
>
> (47) 3025-5907
> (47) 99676-7530 - Whatsapp / Telegram
>
> Skype: gilberto.nunes36
>
>
>
>
> Em qui, 25 de jul de 2019 =C3=A0s 16:50, Alex Deucher
> <alexdeucher@gmail.com> escreveu:
> >
> > On Thu, Jul 25, 2019 at 3:29 PM Gilberto Nunes
> > <gilberto.nunes32@gmail.com> wrote:
> > >
> > > Hi there!
> > >
> > > I try the kernel 5.3.0-050300rc1-generic and almost everything works
> > > perfectly, except there's no sound in HDMI!!!
> >
> > Sounds is fixed with this patch:
> > https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-fixes-5.3&id=
=3D92e6475ae0a0383b012eb21c1aaf0e5456b1a3d9
> > which is on it's way upstream for rc2.
> >
> > Alex
> >
> > > Pavucontrol show me device unplugged!
> > > But I have now work properly NIC and GPU!
> > >
> > >
> > > lspci
> > > 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Processor Root Complex
> > > 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Family 15h (Models
> > > 60h-6fh) I/O Memory Management Unit
> > > 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > > [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev c8)
> > > 00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Kabini
> > > HDMI/DP Audio
> > > 00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Host Bridge
> > > 00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Processor Root Port
> > > 00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Processor Root Port
> > > 00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Host Bridge
> > > 00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Processor Root Port
> > > 00:08.0 Encryption controller: Advanced Micro Devices, Inc. [AMD] Dev=
ice 1578
> > > 00:09.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157d
> > > 00:09.2 Audio device: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Audio Controller
> > > 00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
> > > XHCI Controller (rev 20)
> > > 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
> > > Controller [AHCI mode] (rev 49)
> > > 00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
> > > EHCI Controller (rev 49)
> > > 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controlle=
r (rev 4a)
> > > 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge=
 (rev 11)
> > > 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Processor Function 0
> > > 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Processor Function 1
> > > 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Processor Function 2
> > > 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Processor Function 3
> > > 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Processor Function 4
> > > 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
> > > (Models 60h-6fh) Processor Function 5
> > > 01:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
> > > RTL8411B PCI Express Card Reader (rev 01)
> > > 01:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > > RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
> > > 02:00.0 Network controller: Qualcomm Atheros QCA9377 802.11ac Wireles=
s
> > > Network Adapter (rev 31)
> > > 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]
> > > Lexa PRO [Radeon RX 550/550X] (rev c3)
> > > ---
> > > Gilberto Nunes Ferreira
> > >
> > > (47) 3025-5907
> > > (47) 99676-7530 - Whatsapp / Telegram
> > >
> > > Skype: gilberto.nunes36
> > >
> > >
> > > Em qui, 25 de jul de 2019 =C3=A0s 14:26, Alex Deucher
> > > <alexdeucher@gmail.com> escreveu:
> > > >
> > > > On Thu, Jul 25, 2019 at 3:30 AM Enrico Weigelt, metux IT consult
> > > > <lkml@metux.net> wrote:
> > > > >
> > > > > On 24.07.19 16:17, Gilberto Nunes wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > crossposting to dri-devel, as it smells like a problem w/ amdgpu =
driver.
> > > > >
> > > > > > CPU - AMD A12-9720P RADEON R7, 12 COMPUTE CORES 4C+8G
> > > > > > GPU - Wani [Radeon R5/R6/R7 Graphics] (amdgpu)
> > > > > > Network Interface card:
> > > > > > 01:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > > > > > RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev =
12)
> > > > > >
> > > > > > When I install kernel 4.18.x or 5.x, the network doesn't work a=
nymore...
> > > > >
> > > > > What about other versions (eg. v4.19) ?
> > > > > Which is the last working version ?
> > > > >
> > > > > > I can loaded the modulo r8169 andr8168.
> > > > > > I saw enp1s0f1 as well but there's no link at all!
> > > > > > Even when I fixed the IP none link!
> > > > > > I cannot ping the network gateway or any other IP inside LAN!
> > > > > > Right now, I booted my laptop with kernel
> > > > > > Linux version 5.2.2-050202-generic (kernel@kathleen) (gcc versi=
on
> > > > > > 9.1.0 (Ubuntu 9.1.0-9ubuntu2)) #201907231250 SMP Tue Jul 23 12:=
53:21
> > > > > > UTC 2019
> > > > >
> > > > > Could you also try 5.3 ?
> > > > >
> > > > > > The system boot slowly, and I have a SSD Samsung, which in kern=
el
> > > > > > 4.15, boot quickly.
> > > > > > And there's many errors in dmesg command, like you can see in t=
his pastbin
> > > > > >
> > > > > > https://paste.ubuntu.com/p/YhbjnzYYYh/
> > > > >
> > > > > looks like something's wrong w/ reading gpu registers (more preci=
sely
> > > > > waiting for some changing), that's causing the soft lockup. (mayb=
e too
> > > > > big timeout ?)
> > > >
> > > > It looks like the dGPU fails to power up properly when you attempt =
to
> > > > use it.  You can append amdgpu.runpm=3D0 to the kernel command line=
 in
> > > > grub to disable dynamically powering down the dGPU.
> > > >
> > > > Alex
> > > >
> > > > >
> > > > > > Oh! By the way, the network card r8169 are work wonderful!
> > > > >
> > > > > Didn't you say (above) that it does not work ?
> > > > > Or is it just an immediate fail and later comes back ?
> > > > >
> > > > >
> > > > > --mtx
> > > > >
> > > > >
> > > > > --
> > > > > Enrico Weigelt, metux IT consult
> > > > > Free software and Linux embedded engineering
> > > > > info@metux.net -- +49-151-27565287
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
