Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B3DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D174C2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upitj2pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfCLODL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:03:11 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:39427 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfCLODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:03:10 -0400
Received: by mail-ua1-f46.google.com with SMTP id s15so816575uap.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvaI0VCBVCzTg+3CN9M2PU/lJ1a9ZkyRLn/CJ2kOuIk=;
        b=upitj2pdA9z4IducWBk84T+ll0TxWaillRih4wY/PCZEefKdSb5ILHNiIyZfLoVNv9
         WE+AUu1HBag1IbBeavJSV0p1D0PdHdo7SDTio4UyxYAil/x1zmydzxQUqGAAv0njx8GK
         9HS0Nn8h+A9WGMfpqmeJQjFIRcEAfbv5cTHZlhhbTlp/H+n7bUzvEj3gS+P2q0PB56FX
         orajZ5X3WfFXk4Iyxa4ZzJXOZxe8rpzFbrnGj8nEYpY6WBvzccFEYNE45yflVpcrt+SZ
         FCV16YQNdqI7eSjGT/TkSxI1l5dN1MLLRG768t5Ex8jh3D8zd8+fut7oa2nh9lIwEPiM
         Mk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvaI0VCBVCzTg+3CN9M2PU/lJ1a9ZkyRLn/CJ2kOuIk=;
        b=NQHdBu7k1bkUg8d/hPgfrd9DuLLB3494JMryrbCNw9NmuMpoQdufT3s2IhQFXwhpKj
         SQjJv5DUEi6wIgoPMZLlp8mr+reMcqdMmG/YenXWTbXpTyyUCyJp8iNDWunm3gi4uLvZ
         RmwCo765doDsdBOYLoHITGr1X1KCyWpHaNO8cRlxi0eOh71LeGQmW7ZrAJ2Jdvsv5jhU
         6goi27dhCvn8vEbjbJjmcnFn2YmSv0Q4YRddARM2g+iitZij3nvqvYzquzN/e7hJapho
         ONoSabTyAdF03cHIKU6xr8K+vG6sh2LJFKNLDw6OyRrBC52v7jTLRX96luOOkTH1Okl5
         P64g==
X-Gm-Message-State: APjAAAVrnTFHTIx0mCvSYaYXOTynGAMsXWkYdlgSVYa82kG9awJ/pCFD
        OTExSWkdvFc8zrg+lYsJiGrfKnAsTicnjaIpU7c=
X-Google-Smtp-Source: APXvYqy6XhBwtFoMwZq0HDm9m4Uzw7JNBFdW4J1FiaBosJaBZmncW9aniaEAZwiIHokYb4uR5LhqZvLUw31QuYiTuns=
X-Received: by 2002:ab0:7483:: with SMTP id n3mr19892981uap.131.1552399389065;
 Tue, 12 Mar 2019 07:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
 <2c5d240eabdb56913f4abcc9aacf2b6b@mailhost.ics.forth.gr>
In-Reply-To: <2c5d240eabdb56913f4abcc9aacf2b6b@mailhost.ics.forth.gr>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 12 Mar 2019 19:32:57 +0530
Message-ID: <CAOuPNLg4dfoovZ_eqL5XvNW3Ak9dGeCVr=vbG6G5t4Rxo-nC9Q@mail.gmail.com>
Subject: Re: ssh session with qemu-arm using busybox
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> -netdev user,id=unet,hostfwd=tcp::2222-:22 \
> -net user \
>
> and you 'll get guest's port 22 to be forwarded to hosts port 2222, so
> you can do
>
> ssh root@localhost:2222
>
> from the host.
>

I tried many different options, but unfortunately none worked for me.
1)
qemu-system-arm -M vexpress-a9 -m 1024M -kernel
../KERNEL/linux/arch/arm/boot/zImage -dtb
../KERNEL/linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -initrd
rootfs.img.gz -append "console=ttyAMA0 root=/dev/ram rdinit=/sbin/init
ip=dhcp" -nographic -smp 4 -netdev user,id=unet,hostfwd=tcp::2222-:22
-net user

With this the eth0 interface is removed, and I see this message
(although login works):
qemu-system-arm: warning: hub 0 with no nics
qemu-system-arm: warning: netdev unet has no peer
Booting Linux on physical CPU 0x0
<skip>
NET: Registered protocol family 17
<skip>
Run /sbin/init as init process
ifconfig: SIOCSIFADDR: No such device
route: SIOCADDRT: Network is unreachable

But, ssh is still not working.
ssh root@localhost:2222
ssh: Could not resolve hostname localhost:2222: Name or service not known


2) if I give "-net nic" I get eth0 interface but still ssh does not work.
qemu-system-arm: warning: netdev unet has no peer
Booting Linux on physical CPU 0x0

3) With this there is no error, but still ssh not working
qemu-system-arm -M vexpress-a9 -m 1024M -kernel
../KERNEL/linux/arch/arm/boot/zImage -dtb
../KERNEL/linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -initrd
rootfs.img.gz -append "console=ttyAMA0 root=/dev/ram
rdinit=/sbin/init" -nographic -netdev
user,id=net0,hostfwd=tcp::2222-:22 -device
virtio-net-device,netdev=net0 -net user -net nic

ssh root@localhost:2222
ssh: Could not resolve hostname localhost:2222: Name or service not known

4) I also followed the steps mentioned in the below document, but its
same result:
https://wiki.qemu.org/Documentation/Networking

-------------
So, I have some doubts:
- Do, I need anything to be configured on host PC as well ?
  I am using Ubuntu 16.04 desktop, and it is connected to only one
office LAN network
- Do I need any network configuration changes on host ?
- Do I need to enable any thing in kernel side ?
- I am using minimal busybox and I see there is no "ssh" command
there. Do I need a different busybox or a dropbear ?
- Will it work easily with buildroot ?
- Is there any precompiled arm32-rootfs image present somewhere, which
which ssh can work by default ?
  Because, I really don't care much about user side, so any arm-rootfs
should be fine for me
- I haven't really explored "bridge/tap" network yet. Is that worth to
try in these conditions.


Regards,
Pintu
