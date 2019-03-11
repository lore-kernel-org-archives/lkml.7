Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A99BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0701D2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBsCXiJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfCKOfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:35:06 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:34355 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKOfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:35:05 -0400
Received: by mail-vs1-f43.google.com with SMTP id h7so2825451vsl.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IkL3TilxmjLPZ7z5ub8nkczbG3RJDxaWpYc/0Ak8W1k=;
        b=JBsCXiJrFf+/kFrEuFj864Y3//r1GTE1CkDSegx9JB6RjhjtEX2GpmpUIUMzo0mwxF
         JBu4mwzPp5XXx/eMvZ4x4rzxg0xTDZRRAYlhcL1edmhWIf4VAQD1dna0AZuk20RxJN9s
         u4nxd6A2Q+s5UBx7CxpAwqqxyuISWTZqk3ybNSqv70nHYZ7BrHl13LXGznILDNL5FK0q
         WJb8gkzUwQIsp/FMD0ffFgdOJlNc3xZrDcaRLZtbE86gnZ0waYeqoHsIhsZolNInihvt
         SwJEBc9V7fuR2HS/jkyyQP9LpuPP3LsS+nhviHzeakHHEAc86gML2iN2irpqFBlutpAx
         7ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IkL3TilxmjLPZ7z5ub8nkczbG3RJDxaWpYc/0Ak8W1k=;
        b=o9iHLVzrBQushdrXj+4PBMYzQ+WyL4Wnv67/BHvyBgSPZ2oFjteL8QDZ9/cQXVMDNe
         E1E6toNYd+/vjUX0EVHGoeJxouFi7wnyRx1ZyIxuaUl8QYEIn2zyKQUdDmIqTFVHHkH7
         7xgW/WtQ1l7pTIKJvm3ApgOqWleNAXNQCvDVcsZC5GbYYgNMmDYeusaub2zCdOgn9XLw
         NukhSjGSg6RIsIo1JHbMmReJgUdHXSup4QPwzeDLQXUT06ilkpXBkbxBa9DmaNL50hYM
         xHhUtMyG8rBNAlSWw/8dNkiK8QXkD7RYj9697in6UeoqdO5g+g/XgHgAjiI3rceR9y66
         AHFA==
X-Gm-Message-State: APjAAAUZcC5IRCEsZYd012LB412LxFnzw9RQV9DMnWcODmo+7tBkptbZ
        PZRFTES+0v5bGuO5DOAYwH0j0AhwPRgP7HojIoVUE6Txty0=
X-Google-Smtp-Source: APXvYqwQf4abKOPNFAlcwbnC36FV5xBg1SpnV4ba02lkB4K0Nmgpx0sH2j86PfLQyvnJD0tnNvsGEQGzaeLOJ+FuK1U=
X-Received: by 2002:a67:7f07:: with SMTP id a7mr16125690vsd.196.1552314904118;
 Mon, 11 Mar 2019 07:35:04 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 11 Mar 2019 20:04:53 +0530
Message-ID: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
Subject: ssh session with qemu-arm using busybox
To:     open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, qemu-devel@nongnu.org,
        =?UTF-8?B?7KCE7KeE7JiB?= <jy0.jeon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a qemu-arm setup with busybox which I normally use to test my
kernel changes.
I use this command to boot it:

QEMU-ARM$
qemu-system-arm -M vexpress-a9 -m 1024M -kernel
../KERNEL/linux/arch/arm/boot/zImage -dtb
../KERNEL/linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -initrd
rootfs.img.gz -append "console=ttyAMA0 root=/dev/ram rdinit=/sbin/init
ip=dhcp" -nographic -smp 4

This includes, my own custom kernel and rootfs build.
For rootfs I use busybox and create cpio image and use it as initrd.

But, every time, if I have to copy some files inside qemu, I need to
create create roofs image.
This is painful.

So, now I am exploring how to transfer files from my ubuntu pc to
qemu-session using "ssh".
I know this is possible, but I am still not successful, and bit lazy
to explore these.

I am sure, many of you people would have explored already "how to use
ssh over qemu" and found a easy method.
So, if anybody have easy setup please share with me.

I could see that after adding "ip=dhcp" I get the eth0 interface like this:
/ # ifconfig
eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1180 (1.1 KiB)  TX bytes:1180 (1.1 KiB)
          Interrupt:22

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

But I could not ping it from ubuntu PC.


Regards,
Pintu
