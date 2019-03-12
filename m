Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523B7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A46B2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBDCnbtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfCLRIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:08:49 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:37967 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfCLRIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:08:49 -0400
Received: by mail-ua1-f43.google.com with SMTP id d4so1046489uap.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAhBKSluy9/y0u5fxmhSeKzynL6GOY0xNa5QYg/ZBOo=;
        b=UBDCnbtFGcPoGpCPVFGI6o7l54AzhSolT/2eOhiJJNRuX1HfnWi+oU3rVM+t/WlIU6
         mixSQsgJz66Rb1/sKu7Ajt4GVCs1CWy0AxPSZwUnkKOVp6/8luHFQWPnrpAvC00klVkG
         Cma9OS11qmJ24tup0Btuwveo2UfFY59R08EXIh/jyyGFyKsgXaHU3Bg49U+ccc9DO4a7
         Y+9TflQ2AMoGdoOusykwmDTgGynHBd+iwfzW/SK04JuWqLGNMLEQ+x3z8nTwZhv8n1X8
         NNAcF+MRNHxHBCdcTt8GEpngLLoOkbDDdMLqZGoN2vw8plnOyj66wqzNOvaO9RYPJ37J
         B/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAhBKSluy9/y0u5fxmhSeKzynL6GOY0xNa5QYg/ZBOo=;
        b=MRmwocd/QhNLA58BC0+Flt/zNiCiktcSMQ2CgXs+M6x70UFQH9x6uA0KT9p+a6c5uS
         JDYqtXupjaUjF3o1pJP7+o0mVbl07Z3ZyLy8GfYnjW9ERmaWTOlARDnKUJ+dbTVS/yto
         9ZIVs5BGwGzx7gipRCGc/q/VZBJS4rnIzRrQccvz0/lLcV5ac35LWMXv1fvXN4gzQ1iZ
         A8YVDxkRCj20v0qGY0tWedqFS98faliwb3+Ywnw6x2DJ7vtQs/oamssAsYYmo6DS0Jn+
         12e6ikeEWIZDwg3Bo9JBUIssThoDFCgfCJgozfS1afC13t3yxDOaGYJDqOEsI9euCIY/
         1lIw==
X-Gm-Message-State: APjAAAXIaw27da6HNrIakXNWcxAwEGbYp/WCv16Pj/EKknJ8jJNyGkH4
        cHEHDYrruPjwEg1TYLv/IlXLf6C775EyGi6+0OQ=
X-Google-Smtp-Source: APXvYqzErWdVjSzoR2G+d2qDyp51YMf8lr9xsoZq0mBgPAxWVzauaJxpJ8TZiNcuIpybuFPpkFoPiUjmeJ9bHVEpQ/8=
X-Received: by 2002:ab0:4222:: with SMTP id i31mr20580160uai.47.1552410527892;
 Tue, 12 Mar 2019 10:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
 <2c5d240eabdb56913f4abcc9aacf2b6b@mailhost.ics.forth.gr> <CAOuPNLg4dfoovZ_eqL5XvNW3Ak9dGeCVr=vbG6G5t4Rxo-nC9Q@mail.gmail.com>
 <00078ed3-fe1d-722e-0943-80bb189ee3ab@arm.com>
In-Reply-To: <00078ed3-fe1d-722e-0943-80bb189ee3ab@arm.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 12 Mar 2019 22:38:36 +0530
Message-ID: <CAOuPNLhvPypbTU+AbodYTFdGHW_Uqxj4UQvo6usNCKZh30uTig@mail.gmail.com>
Subject: Re: ssh session with qemu-arm using busybox
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 7:41 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
>
> On 12/03/2019 14:02, Pintu Agarwal wrote:
> >>
> >> -netdev user,id=unet,hostfwd=tcp::2222-:22 \
> >> -net user \
> >>
> >> and you 'll get guest's port 22 to be forwarded to hosts port 2222, so
> >> you can do
> >>
> >> ssh root@localhost:2222
> >>
> >> from the host.
> >>
> >
> > I tried many different options, but unfortunately none worked for me.
> > 1)
> > qemu-system-arm -M vexpress-a9 -m 1024M -kernel
> > ../KERNEL/linux/arch/arm/boot/zImage -dtb
> > ../KERNEL/linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -initrd
> > rootfs.img.gz -append "console=ttyAMA0 root=/dev/ram rdinit=/sbin/init
> > ip=dhcp" -nographic -smp 4 -netdev user,id=unet,hostfwd=tcp::2222-:22
> > -net user
> >
> > With this the eth0 interface is removed, and I see this message
> > (although login works):
> > qemu-system-arm: warning: hub 0 with no nics
> > qemu-system-arm: warning: netdev unet has no peer
> > Booting Linux on physical CPU 0x0
> > <skip>
> > NET: Registered protocol family 17
> > <skip>
> > Run /sbin/init as init process
> > ifconfig: SIOCSIFADDR: No such device
> > route: SIOCADDRT: Network is unreachable
> >
> > But, ssh is still not working.
> > ssh root@localhost:2222
> > ssh: Could not resolve hostname localhost:2222: Name or service not known
>
> man ssh
>
> +
>
> Make sure you have sshd in your custom rootfs and has been stared.
>

My busybox is a very minimal rootfs. It hardly contains any commands.
Is there any precompiled busybox for arm (cpio image), available (with
ssh, scp and networking in-built), which I can use directly to boot ?

what else I am missing to make ssh/scp working on qemu ?
