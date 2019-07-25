Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DF9C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA3A218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1gbxzbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfGYTpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:45:17 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:34401 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfGYTpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:45:16 -0400
Received: by mail-qk1-f180.google.com with SMTP id t8so37362524qkt.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iXtsxChd2MmUNxgx3pZCkPirOceY8Pq6lVoy8eJRFTQ=;
        b=T1gbxzbrpwChvPlipC41u/c+383ryqMrsgp+8vjxmR978jIr+FemmrrjTLA7XnWk6Q
         ziwOxCn+yoOLoRskwNVD4IFYfqt/pVDkz7UnTt2S1Z5X1GGSIRQvOtWSU0IQkl0UBPvf
         AxG574dTVlsvIBThlE/yry1FcRvmUZ6wt4BbiJNbKD52WCaWL26rCm8NNRWOzJbeoPe7
         KpBjYZ0Hmezi3q6iueTZ3VkFFYir3UGUHtQ4iE2gp/NK6gk+EyqOBOxaDuqGFujJFilm
         4MYAmbcdQdeY0emDn8oF7VnuTP/2zyvt87yWcUZL5kthLGjBqnkc227fjJ1XzwNryCuL
         HVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iXtsxChd2MmUNxgx3pZCkPirOceY8Pq6lVoy8eJRFTQ=;
        b=F4wuL9o8rwnCLpM4YORpquSLDa3P5PJfkK3CpykaOCLwUt3p+3WBbfDJyH4e8g3RaD
         SzPYNnESO4tSbvaSGvDA14couWP5I0ILUNykZRiQ+7ByJ9vG6EaHGxFYIru0OLDFLiNY
         ke80LbiFPQNRSCceglJsXuzIq0nhx2UiBypdKd3WPy0s9mY531DOGlkO/g+hVIqG80VK
         GxLSdvvjIql4nhqg714h5fJMuMS5GRqtWX33Sk4KASRQz7yBf2uXa1k9XhjhMw892zhr
         H0FaVmmuF07bEYjHuXtWRf9ASDLa1p1cFtHh2oiGziSMOq98KcprHw98KYutjyJjZtTR
         bo1Q==
X-Gm-Message-State: APjAAAUwBWbnY9ldCaX/rPCMg7u3nTcxuo99+cHZV8JoM72jD98gWHBu
        th07tcLbZad9jdmt/kVAQM2mWZIOYtkOKzK2ZR0=
X-Google-Smtp-Source: APXvYqxKnNGMtTjWT2Cp1CHPBG23v8LFuJEtC8Xf4t8QCLX5fNW0rXjCXRSQrfgjwHZPs4MfId3UJqHWxdiaQnj0ZQk=
X-Received: by 2002:a37:5f82:: with SMTP id t124mr53965327qkb.180.1564083915031;
 Thu, 25 Jul 2019 12:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAOKSTBs-cHMr7xbJVVUjZ9C3__bY6jZU-_TZ0RmMRMJ3dBk3PA@mail.gmail.com>
 <0c3f445d-1e37-1531-d3d5-f7ad75c58343@metux.net> <CADnq5_NqDNLzZW6h3cXBUfTMsBe6isvE6YQH=9Op6Gews=ubGg@mail.gmail.com>
 <CAOKSTBvjJ+3he9AJoRGkxQfQLoG_T9jY+H8p0o6A6FdmnisSJA@mail.gmail.com>
In-Reply-To: <CAOKSTBvjJ+3he9AJoRGkxQfQLoG_T9jY+H8p0o6A6FdmnisSJA@mail.gmail.com>
From:   Gilberto Nunes <gilberto.nunes32@gmail.com>
Date:   Thu, 25 Jul 2019 16:44:38 -0300
Message-ID: <CAOKSTBsRNjuKCR3-bQpuwjjPOeKpcNqcBn85RavhWV7SVHe=Ag@mail.gmail.com>
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

About sound card:

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Generic [HD-Audio Generic], device 0: ALC255 Analog [ALC255 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

Right now, I am using just the onboard sound!


---
Gilberto Nunes Ferreira

(47) 3025-5907
(47) 99676-7530 - Whatsapp / Telegram

Skype: gilberto.nunes36



Em qui, 25 de jul de 2019 =C3=A0s 16:29, Gilberto Nunes
<gilberto.nunes32@gmail.com> escreveu:
>
> Hi there!
>
> I try the kernel 5.3.0-050300rc1-generic and almost everything works
> perfectly, except there's no sound in HDMI!!!
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
