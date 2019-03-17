Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F57C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 21:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937E020835
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 21:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552858766;
	bh=bW+frnf/VWP79Eh+ut4oQ805yYDNWGKsK7R2JTA2bvQ=;
	h=From:Date:Subject:To:List-ID:From;
	b=mZHxgCFIDG8gs1+0Wx2EH85cjX52pe9Feua16YPdVyi2m/ebAWRBnoRlNfXU1h58u
	 jSVoUYkqgGGfdsHVLa0H5x2RRpeFa10C/jmWjD+xz/iXoZfmkX9eSNIxBt8fnPMrc0
	 KTJ0MKvcAvjLnGNKd3umzNxmv3cbqVRcCMu2WtL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfCQVjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 17:39:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43522 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfCQVjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 17:39:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id z20so12251811ljj.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=bp4LFtqgAjxiwi8Sa3F/ysO8CMmytrtN1VL7eItbVkc=;
        b=fwjPuhjjlaEeLiX0EVLEHUEm65nIQxhN7+ityFMYufmN3va0/3n2FpG+WW06NQyUdK
         AMRDbiD0Tpi55/n2J/tzGQpa/c8BqFwG0N9NCpaIlf2Vg/MLqebwr+EQ1s/fq5Sm5O7J
         sLVgeF8T6ymUaJrulBSQ4sxc7rPnVfTSFqOP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bp4LFtqgAjxiwi8Sa3F/ysO8CMmytrtN1VL7eItbVkc=;
        b=ME6QZVhXEoqkUEcoLTz5DaxnoWdcKASp9P6un5ffgV6dVFrFbANNXXnNDjfvB30d23
         EFPeYCfEq5x3M3QrPN59bguWRSKJPgLIg9mPF7KgbfMcjxfBa4udap+R99dX7sh7CXzC
         WXc0AW9Pyp5vAQk0X14YU5jbSxHTOStu9QaD3b/6Q3KMEkXljxHGHIOQakfaLNzlzlc4
         EZKgJRv1r/bDyqJ2DdvPIXOOLRJBToTPRhizjGp/vAO8cEAB67dvYDK3Z69VCC6QdHx7
         GbRNY/lIrGRt/x+QZa1uZjKfhIgS4Z0pjhliisI+Vw1iEqYSKxzKqhl5DQrC7nf70ZYo
         xKjA==
X-Gm-Message-State: APjAAAXunK4y4AqFpiTeArjJxSFDobotIefYKPThvjFC6Opkxo96jomE
        LDeYkFFtBlwEGkfUwuc1jmnq0aeZ+94=
X-Google-Smtp-Source: APXvYqxiZ6FVOWswetG4+6/cjDHx+C0Tj5ghnbjZoNlbzHmt+osvs3WUS2Xb8XdfxUNn30hDK6PSHg==
X-Received: by 2002:a2e:4b02:: with SMTP id y2mr8677892lja.179.1552858760723;
        Sun, 17 Mar 2019 14:39:20 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id s3sm1752455lji.94.2019.03.17.14.39.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 14:39:19 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id z20so12251772ljj.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 14:39:19 -0700 (PDT)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr8587377lji.125.1552858759241;
 Sun, 17 Mar 2019 14:39:19 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Mar 2019 14:39:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1c_Tb-wwM6qaPLdggXtW3rOh1JzYUOs+O7PsHt-=+jg@mail.gmail.com>
Message-ID: <CAHk-=wj1c_Tb-wwM6qaPLdggXtW3rOh1JzYUOs+O7PsHt-=+jg@mail.gmail.com>
Subject: Linux 5.1-rc1
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's Sunday, and two weeks have passed, and everything is normal. You
all know the drill by now - the merge window is closed, and things are
supposed to calm down.

The merge window felt fairly normal to me. And looking at the stats,
nothing really odd stands out either. It's a regular sized release
(which obviously means "big" - , but it's not bigger than usual) and
the bulk of it (just over 60%) is drivers. All kinds of drivers, the
one that stands out for being different is the habanalabs AI
accelerator chip driver, but I suspect we'll be starting to see more
of that kind of stuff. But there are all the usual suspects too - gpu,
networking, block devices etc etc.

A somewhat recent development is how the tools/testing/ updates have
been quite noticeable lately. That's not new to the 5.1 merge window,
it's been going on for a while, but it's maybe just worth a mention
that we have more new selftest changes than we have architecture
updates, for example. The documentation subdirectory is also quite
noticeable.

But on the whole, there's really stuff all over, including core VFS
updates (in addition to all the usual low-level filesystem updates
too, of course).

And as always, the shortlog is much too big to post with 11k+ commits
(12k+ if counting merges). So below is my usual "mergelog" listing
submaintainers and a summary of the git pulls I've done from them..

Go forth and test,

                  Linus

---

Al Viro (5):
    vfs fixes
    misc vfs updates
    iov_iter updates
    vfs mount infrastructure updates
    vfs mount infrastructure fix

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andrew Morton (5):
    misc updates x3
    more updates
    the left-over patches

Arnd Bergmann (8):
    y2038 build fix for compat mode
    asm-generic updates
    ARM SoC platform updates
    ARM SoC device tree updates
    ARM SoC driver updates
    ARM SoC defconfig updates
    ARM new SoC family support
    ARM SoC late updates

Bartlomiej Zolnierkiewicz (1):
    fbdev updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (1):
    remoteproc updates

Bjorn Helgaas (1):
    PCI updates

Bob Peterson (1):
    gfs2 updates

Boris Brezillon (2):
    MTD updates
    i3c updates

Borislav Petkov (2):
    EDAC updates
    RAS updates

Bruce Fields (1):
    NFS server updates

Catalin Marinas (1):
    arm64 updates

Christian Brauner (1):
    pidfd system call

Christoph Hellwig (1):
    DMA mapping updates

Corey Minyard (1):
    IPMI updates

Dan Williams (3):
    filesystem-dax updates
    libnvdimm updates
    device-dax updates

Darren Hart (1):
    x86 platform driver updates

Darrick Wong (2):
    xfs updates
    xfs cleanups

Dave Airlie (2):
    drm updates
    drm fixes and updates

David Miller (4):
    networking updates
    networking fixes
    IDE updates
    networking fixes

David Sterba (2):
    btrfs updates
    btrfs fixes

Dennis Zhou (1):
    percpu updates

Dmitry Torokhov (1):
    input updates

Dominique Martinet (1):
    9p updates

Eduardo Valentin (1):
    thermal soc updates

Eric Biggers (1):
    fscrypt updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    char/misc driver updates
    driver core updates
    staging/IIO updates
    tty/serial updates
    USB/PHY updates

Greg Ungerer (1):
    m68knommu update

Guenter Roeck (1):
    hwmon updates

Helge Deller (1):
    parisc updates

Herbert Xu (2):
    crypto update
    crypto fixes

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (14):
    RCU updates
    EFI updates
    locking updates
    perf updates
    scheduler updates
    x86 alternative instruction updates
    x86 boot updates
    x86 build updates
    x86 cleanups
    x86 fpu updates
    x86 kdump update
    x86 mm cleanup
    x86 platform update
    x86 UV updates

Jacek Anaszewski (1):
    LED updates

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (2):
    SCSI updates
    more SCSI updates

James Morris (3):
    security subsystem updates
    integrity updates
    tpm updates

Jan Kara (3):
    dtype handling cleanups
    ext2 and udf fixes
    fanotify updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (4):
    libata updates
    block layer updates
    io_uring IO interface
    more block layer changes

Jiri Kosina (2):
    livepatching updates
    HID updates

Joerg Roedel (2):
    IOMMU updates
    IOMMU fix

John Johansen (1):
    apparmor fixes

Jon Mason (1):
    NTB updates

Jonathan Corbet (1):
    documentation updates

Juergen Gross (2):
    xen updates
    xen fix

Kees Cook (2):
    pstore cleanups
    gcc-plugins updates

Konrad Rzeszutek Wilk (2):
    swiotlb updates
    ibft updates

Lee Jones (2):
    backlight fixlet
    MFD updates

Ley Foon Tan (1):
    nios2 updates

Linus Walleij (2):
    GPIO updates
    pin control updates

Mark Brown (3):
    regmap updates
    regulator updates
    spi updates

Martin Schwidefsky (1):
    s390 updates

Masahiro Yamada (3):
    Kbuild updates
    Kconfig updates
    more Kbuild updates

Matthew Wilcox (1):
    XArray updates

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    xtensa updates

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    Microblaze update

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (2):
    fuse updates
    overlayfs updates

Palmer Dabbelt (1):
    RISC-V updates

Paolo Bonzini (1):
    KVM updates

Paul Burton (1):
    MIPS updates

Paul Moore (3):
    SELinux updates
    audit updates
    selinux fixes

Petr Mladek (1):
    printk updates

Rafael Wysocki (5):
    power management updates
    ACPI updates
    device properties framework updates
    more power management updates
    more ACPI updates

Richard Weinberger (2):
    UBI and UBIFS updates
    UML updates

Rob Herring (1):
    Devicetree updates

Russell King (1):
    ARM updates

Sebastian Reichel (2):
    HIS update
    power supply and reset updates

Stephen Boyd (1):
    clk subsystem updates

Steve French (2):
    smb3 updates
    more smb3 updates

Steven Rostedt (3):
    tracing fix/cleanup
    tracing updates
    tracing fixes and cleanups

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (2):
    workqueue updates
    cgroup updates

Thierry Reding (1):
    pwm updates

Thomas Gleixner (13):
    timer and clockevent updates
    irq updates
    x86/pti update
    year 2038 updates
    watchdog core update
    locking fixes
    timer fix
    x86 boot fix
    x86 fixes
    perf updates
    x86 tsx fixes
    perf fixes
    x86 asm updates

Tobin Harding (1):
    leaking_addresses updates

Trond Myklebust (2):
    NFS client updates
    NFS client bugfixes

Ulf Hansson (1):
    MMC updates

Vinod Koul (1):
    dmaengine updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    i2c fixes
