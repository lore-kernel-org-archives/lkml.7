Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CF3C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 03:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C4D2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 03:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEDS8kDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfEBD1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 23:27:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41574 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfEBD1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 23:27:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id f6so393209pgs.8;
        Wed, 01 May 2019 20:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VAd0SGkp85Ez2t+J3zfmV6dJFmC5cfQc6TKioyESibE=;
        b=YEDS8kDsjQ4oc5I/WaQogus8axs3IGZlRQ4gmsIkmaYusOkDrJjkrmhb3ZfaDpnWK3
         017o5cucCMqSU8Vph7a49k+jmPKkMGrQ3wLqf3hm+LOFw0eXgJ93AmlKJ+MhgQrZ8QOp
         RO3ZjHM/LTctBRRNS9MiIEfkEAQAd5ZrzB6qTXfOyuUf0vy9ahE0wzLbRmvlFGEShlrj
         VC6Zhy3U+gBpXjiL/mINuu1tHXUiInLHq9vDXSN7FP3uRVB0pYaZnG3Gq5hbNn+iuuY+
         ls+0B7tZ2BXheiukxtNXAzNCazvcYOykKZRgIySSv9CFVzXD7wRZcW2D2nRq8RDcT+kf
         oqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VAd0SGkp85Ez2t+J3zfmV6dJFmC5cfQc6TKioyESibE=;
        b=QQSz49LDrqrjVri0bRmrm+WaTPj6IY7veDrGXkVlnaY21v0HCJ9Tu0xJz4xiiXjg9V
         Ah/uM/ZiLo6YVxTRrrT0OjvA5/gaf/zhBllLbQhV227bPkUcsL5qc8Nb0Ku1Nf3lZpQX
         5TYl21tprNrPgeWo0pzN1YZsgp8kHvZwvl/M5e9Pinxl+W6lPxO9nv67OM/CYPivg7tX
         OsL6hZpaIxV7Tbuh5v0BHCneRMfpaJISVU0/scY1SSfatUHfdDjYhOm+YFiMhHyYM6BF
         1oZRTLooh36mbNjwvbmWIxcTuwUQs4L4Tjtn44+xsvAUXUDetPsWI9VlDd/TTTC+z2mO
         q8FA==
X-Gm-Message-State: APjAAAVYGkwVj9byJOKjwpu6t2s3+8N0+gH/yk2FVzlWXfO3pF74yDzr
        ncjglmBAmniA10JGFeteVfU=
X-Google-Smtp-Source: APXvYqylTKyWwsafrns386rxx2eucGo17d+qJ8VspXZzpBOpI6ZQ3B6ljK2DZc+cED1Q5QWgYMNi3w==
X-Received: by 2002:a65:4589:: with SMTP id o9mr1462346pgq.381.1556767662820;
        Wed, 01 May 2019 20:27:42 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o2sm61070195pgq.1.2019.05.01.20.27.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 01 May 2019 20:27:41 -0700 (PDT)
Date:   Thu, 2 May 2019 11:27:29 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/27] Documentation: x86: convert earlyprintk.txt to reST
Message-ID: <20190502032727.3r75t2dot5dgxagk@mail.google.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
 <20190426153150.21228-8-changbin.du@gmail.com>
 <20190427141739.6e18f127@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427141739.6e18f127@coco.lan>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 02:17:39PM -0300, Mauro Carvalho Chehab wrote:
> Em Fri, 26 Apr 2019 23:31:30 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  .../x86/{earlyprintk.txt => earlyprintk.rst}  | 103 ++++++++++--------
> >  Documentation/x86/index.rst                   |   1 +
> >  2 files changed, 57 insertions(+), 47 deletions(-)
> >  rename Documentation/x86/{earlyprintk.txt => earlyprintk.rst} (59%)
> > 
> > diff --git a/Documentation/x86/earlyprintk.txt b/Documentation/x86/earlyprintk.rst
> > similarity index 59%
> > rename from Documentation/x86/earlyprintk.txt
> > rename to Documentation/x86/earlyprintk.rst
> > index 46933e06c972..7714e32501ec 100644
> > --- a/Documentation/x86/earlyprintk.txt
> > +++ b/Documentation/x86/earlyprintk.rst
> > @@ -1,52 +1,58 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +============
> > +Early Printk
> > +============
> >  
> >  Mini-HOWTO for using the earlyprintk=dbgp boot option with a
> >  USB2 Debug port key and a debug cable, on x86 systems.
> >  
> >  You need two computers, the 'USB debug key' special gadget and
> > -and two USB cables, connected like this:
> > +and two USB cables, connected like this::
> >  
> >    [host/target] <-------> [USB debug key] <-------> [client/console]
> >  
> > -1. There are a number of specific hardware requirements:
> > -
> > - a.) Host/target system needs to have USB debug port capability.
> > -
> > - You can check this capability by looking at a 'Debug port' bit in
> > - the lspci -vvv output:
> > -
> > - # lspci -vvv
> > - ...
> > - 00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
> > -         Subsystem: Lenovo ThinkPad T61
> > -         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> > -         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > -         Latency: 0
> > -         Interrupt: pin D routed to IRQ 19
> > -         Region 0: Memory at fe227000 (32-bit, non-prefetchable) [size=1K]
> > -         Capabilities: [50] Power Management version 2
> > -                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > -                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+
> > -         Capabilities: [58] Debug port: BAR=1 offset=00a0
> > +Hardware requirements
> > +=====================
> > +
> > +  a) Host/target system needs to have USB debug port capability.
> > +
> > +     You can check this capability by looking at a 'Debug port' bit in
> > +     the lspci -vvv output::
> > +
> > +       # lspci -vvv
> > +       ...
> > +       00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
> > +               Subsystem: Lenovo ThinkPad T61
> > +               Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> > +               Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > +               Latency: 0
> > +               Interrupt: pin D routed to IRQ 19
> > +               Region 0: Memory at fe227000 (32-bit, non-prefetchable) [size=1K]
> > +               Capabilities: [50] Power Management version 2
> > +                       Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > +                       Status: D0 PME-Enable- DSel=0 DScale=0 PME+
> > +               Capabilities: [58] Debug port: BAR=1 offset=00a0
> >                              ^^^^^^^^^^^ <==================== [ HERE ]
> > -	 Kernel driver in use: ehci_hcd
> > -         Kernel modules: ehci-hcd
> > - ...
> > +               Kernel driver in use: ehci_hcd
> > +               Kernel modules: ehci-hcd
> > +       ...
> >  
> > -( If your system does not list a debug port capability then you probably
> > -  won't be able to use the USB debug key. )
> > +     .. note::
> > +       If your system does not list a debug port capability then you probably
> > +       won't be able to use the USB debug key. )
> 
> You should remove the close parenthesis on the above line.
>
Fixed.

> >  
> > - b.) You also need a NetChip USB debug cable/key:
> > +  b) You also need a NetChip USB debug cable/key:
> >  
> >          http://www.plxtech.com/products/NET2000/NET20DC/default.asp
> >  
> >       This is a small blue plastic connector with two USB connections;
> >       it draws power from its USB connections.
> >  
> > - c.) You need a second client/console system with a high speed USB 2.0
> > -     port.
> > +  c) You need a second client/console system with a high speed USB 2.0 port.
> >  
> > - d.) The NetChip device must be plugged directly into the physical
> > -     debug port on the "host/target" system.  You cannot use a USB hub in
> > +  d) The NetChip device must be plugged directly into the physical
> > +     debug port on the "host/target" system. You cannot use a USB hub in
> >       between the physical debug port and the "host/target" system.
> >  
> >       The EHCI debug controller is bound to a specific physical USB
> > @@ -65,24 +71,26 @@ and two USB cables, connected like this:
> >       to the hardware vendor, because there is no reason not to wire
> >       this port into one of the physically accessible ports.
> >  
> > - e.) It is also important to note, that many versions of the NetChip
> > +  e) It is also important to note, that many versions of the NetChip
> >       device require the "client/console" system to be plugged into the
> >       right hand side of the device (with the product logo facing up and
> >       readable left to right).  The reason being is that the 5 volt
> >       power supply is taken from only one side of the device and it
> >       must be the side that does not get rebooted.
> >  
> > -2. Software requirements:
> > +Software requirements
> > +=====================
> >  
> > - a.) On the host/target system:
> > +  a) On the host/target system:
> >  
> > -    You need to enable the following kernel config option:
> > +    You need to enable the following kernel config option::
> >  
> >        CONFIG_EARLY_PRINTK_DBGP=y
> >  
> >      And you need to add the boot command line: "earlyprintk=dbgp".
> >  
> > -    (If you are using Grub, append it to the 'kernel' line in
> > +    .. note::
> > +     If you are using Grub, append it to the 'kernel' line in
> >      /etc/grub.conf.  If you are using Grub2 on a BIOS firmware system,
> >      append it to the 'linux' line in /boot/grub2/grub.cfg. If you are
> >      using Grub2 on an EFI firmware system, append it to the 'linux'
> >      or 'linuxefi' line in /boot/grub2/grub.cfg or
> >      /boot/efi/EFI/<distro>/grub.cfg.)
> 
> Same here: You should remove the close parenthesis on the above line.
> 
> 
> >       /etc/grub.conf.  If you are using Grub2 on a BIOS firmware system,
> >       append it to the 'linux' line in /boot/grub2/grub.cfg. If you are
> >       using Grub2 on an EFI firmware system, append it to the 'linux'
> 
> Hmm... there is another note here:
> 
>      NOTE: normally earlyprintk console gets turned off once the
>      regular console is alive - use "earlyprintk=dbgp,keep" to keep
>      this channel open beyond early bootup. This can be useful for
>      debugging crashes under Xorg, etc.
> 
> Why are you keeping it untouched?
>
I missed this block. Now fixed.

> After fixing the above:
> 
> Reviewed-by: 
> 
> > @@ -101,9 +109,9 @@ and two USB cables, connected like this:
> >      this channel open beyond early bootup. This can be useful for
> >      debugging crashes under Xorg, etc.
> >  
> > - b.) On the client/console system:
> > +  b) On the client/console system:
> >  
> > -    You should enable the following kernel config option:
> > +    You should enable the following kernel config option::
> >  
> >        CONFIG_USB_SERIAL_DEBUG=y
> >  
> > @@ -115,27 +123,28 @@ and two USB cables, connected like this:
> >      it up to use /dev/ttyUSB0 - or use a raw 'cat /dev/ttyUSBx' to
> >      see the raw output.
> >  
> > - c.) On Nvidia Southbridge based systems: the kernel will try to probe
> > +  c) On Nvidia Southbridge based systems: the kernel will try to probe
> >       and find out which port has a debug device connected.
> >  
> > -3. Testing that it works fine:
> > +Testing
> > +=======
> >  
> > -   You can test the output by using earlyprintk=dbgp,keep and provoking
> > -   kernel messages on the host/target system. You can provoke a harmless
> > -   kernel message by for example doing:
> > +You can test the output by using earlyprintk=dbgp,keep and provoking
> > +kernel messages on the host/target system. You can provoke a harmless
> > +kernel message by for example doing::
> >  
> >       echo h > /proc/sysrq-trigger
> >  
> > -   On the host/target system you should see this help line in "dmesg" output:
> > +On the host/target system you should see this help line in "dmesg" output::
> >  
> >       SysRq : HELP : loglevel(0-9) reBoot Crashdump terminate-all-tasks(E) memory-full-oom-kill(F) kill-all-tasks(I) saK show-backtrace-all-active-cpus(L) show-memory-usage(M) nice-all-RT-tasks(N) powerOff show-registers(P) show-all-timers(Q) unRaw Sync show-task-states(T) Unmount show-blocked-tasks(W) dump-ftrace-buffer(Z)
> >  
> > -   On the client/console system do:
> > +On the client/console system do::
> >  
> >         cat /dev/ttyUSB0
> >  
> > -   And you should see the help line above displayed shortly after you've
> > -   provoked it on the host system.
> > +And you should see the help line above displayed shortly after you've
> > +provoked it on the host system.
> >  
> >  If it does not work then please ask about it on the linux-kernel@vger.kernel.org
> >  mailing list or contact the x86 maintainers.
> > diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> > index 8a666c5abc85..7b8388ebd43d 100644
> > --- a/Documentation/x86/index.rst
> > +++ b/Documentation/x86/index.rst
> > @@ -13,3 +13,4 @@ Linux x86 Support
> >     exception-tables
> >     kernel-stacks
> >     entry_64
> > +   earlyprintk
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
