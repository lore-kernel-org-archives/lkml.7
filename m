Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03E6C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724C52081B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfT45Awk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfGYR0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:26:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34125 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfGYR0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:26:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so51673067wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUfPpidGaXW1JR+PDwlAYzwSLRaesJn6wZTx7CMAfSw=;
        b=DfT45AwkHcvsxfoBm9B6LCOAoiewqd0xitUDiwUnABB17hQoA7GX7mhanjC+G662DR
         UIXGhjnaSyNP6ziZ7nX1GXpBeW9QCugb8MF+9+6lfJanD2O14SM9kqdx/UKqljt6AZg4
         +GUFp43DFSBX53VYB0uuvGZWRLoZio15YmeiThbZYf6wr+13bQ7Yj62UrFCyr/Kf1R3o
         tBevTrXs6baJib1/V3UjcLhOPWAh1FKrq+kMTX8mNc7eTMBvrgcNY0q+KuKgPy4XJc/B
         dE8R6j3P2hLJXqFllSxon9e3b5frVXFwFXE5kh7lDULCvjfzn9LxL0OzB+J2rzNd5S5k
         IECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUfPpidGaXW1JR+PDwlAYzwSLRaesJn6wZTx7CMAfSw=;
        b=id0KezikEz81mlx3KmrnEsbB0lPkAWq7mvL40jfgvTNl0hS/D10+IDrllW8Vuio3dp
         RLulZ1kJKTC5e8pbU4ogNrtXBl/DWoqCa9ChS6huG5m/fLSWCfqFuuduEI1kN6Z5Z1yt
         i5HdOsbFrjDUXDbvxTjgmqM5N1ZYxOH20E60cpWuDld5Lhv+XF7i3c2by1zqT8Iam+Ao
         Ns/jfTFmi4W7CcNUP/BBF+DN7tsY9BD9dYnTHQhw7nUcnUpE6uf/l1VfH0oUy9dsri98
         HJJx5cQmnNVArvFGj40WhQrJctfgafOKvusBwmOXzkqKLkYSFW1PqlaIWnq6rPmPIbCr
         K5HA==
X-Gm-Message-State: APjAAAVCkE1TwcRogErZADPYuoQ9Hp5M7HeBcQPEDK6fnuDO1qyHFoRo
        VNS0UzMiUWmqsyc19s8cE553ezvR79g51EWGuDlJJg==
X-Google-Smtp-Source: APXvYqzpCt+ykuPCj162sciP1+JajnBPVm6VFFQTgxMu4B0n6jDcSvnRA7P49Rle8xp3aCczF+zk8go9CUNiHRR5IoU=
X-Received: by 2002:a5d:6ccd:: with SMTP id c13mr93113559wrc.4.1564075566899;
 Thu, 25 Jul 2019 10:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAOKSTBs-cHMr7xbJVVUjZ9C3__bY6jZU-_TZ0RmMRMJ3dBk3PA@mail.gmail.com>
 <0c3f445d-1e37-1531-d3d5-f7ad75c58343@metux.net>
In-Reply-To: <0c3f445d-1e37-1531-d3d5-f7ad75c58343@metux.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Jul 2019 13:25:55 -0400
Message-ID: <CADnq5_NqDNLzZW6h3cXBUfTMsBe6isvE6YQH=9Op6Gews=ubGg@mail.gmail.com>
Subject: Re: AMD Drivers
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Gilberto Nunes <gilberto.nunes32@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 3:30 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 24.07.19 16:17, Gilberto Nunes wrote:
>
> Hi,
>
> crossposting to dri-devel, as it smells like a problem w/ amdgpu driver.
>
> > CPU - AMD A12-9720P RADEON R7, 12 COMPUTE CORES 4C+8G
> > GPU - Wani [Radeon R5/R6/R7 Graphics] (amdgpu)
> > Network Interface card:
> > 01:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
> >
> > When I install kernel 4.18.x or 5.x, the network doesn't work anymore...
>
> What about other versions (eg. v4.19) ?
> Which is the last working version ?
>
> > I can loaded the modulo r8169 andr8168.
> > I saw enp1s0f1 as well but there's no link at all!
> > Even when I fixed the IP none link!
> > I cannot ping the network gateway or any other IP inside LAN!
> > Right now, I booted my laptop with kernel
> > Linux version 5.2.2-050202-generic (kernel@kathleen) (gcc version
> > 9.1.0 (Ubuntu 9.1.0-9ubuntu2)) #201907231250 SMP Tue Jul 23 12:53:21
> > UTC 2019
>
> Could you also try 5.3 ?
>
> > The system boot slowly, and I have a SSD Samsung, which in kernel
> > 4.15, boot quickly.
> > And there's many errors in dmesg command, like you can see in this pastbin
> >
> > https://paste.ubuntu.com/p/YhbjnzYYYh/
>
> looks like something's wrong w/ reading gpu registers (more precisely
> waiting for some changing), that's causing the soft lockup. (maybe too
> big timeout ?)

It looks like the dGPU fails to power up properly when you attempt to
use it.  You can append amdgpu.runpm=0 to the kernel command line in
grub to disable dynamically powering down the dGPU.

Alex

>
> > Oh! By the way, the network card r8169 are work wonderful!
>
> Didn't you say (above) that it does not work ?
> Or is it just an immediate fail and later comes back ?
>
>
> --mtx
>
>
> --
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
