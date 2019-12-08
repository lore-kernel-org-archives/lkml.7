Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE124C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 23:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716E620637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 23:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575848568;
	bh=YlmN3HfQLyrj0idD72W6ePzenjL63af//UJ9W+NsJYI=;
	h=From:Date:Subject:To:List-ID:From;
	b=jIuSVNoh1VoKleSHZ0aK+XYAEIzoY+9q9igbOvZuj9z1ovm2bl0/cdvkZhhrFPYL1
	 JWSfaPaG6at9zDDR2ZX5aHBLBV4gv7GA1pqZrKPOrt2ILNlaB+QEk+8AKCdkQqs0LS
	 wjSitDEjsSQ/W8TJ82SIm1u5k3AWBuRaSccG3VhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLHXlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 18:41:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42299 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfLHXlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 18:41:07 -0500
Received: by mail-lj1-f193.google.com with SMTP id e28so13500086ljo.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 15:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=793iQyWfJHrj/lKnPALkG8dYd8jLZU2sKaLx11jMtgU=;
        b=NUcXxC9FPswZVncPbkfK/h0Oohz/tLauuw9StesTfVF//7dKGFCt7oIcvO/kUX0ZUK
         Le9tqT0u0fuvu2Us4vp/o69seLBP3PZxL3KM5EcS09JAgh8rJ/tDYL3iBjmWk0wGJSnk
         zgFnF715dkLAPBJ3vDTkNwrRS/hGcFhRk/IV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=793iQyWfJHrj/lKnPALkG8dYd8jLZU2sKaLx11jMtgU=;
        b=l2oGDrrQgIzQPzuuctPGoCvP2req0iobWRIMs5TBto7ScSRl42tOeDVX7gIK0O8FLV
         5/ke3CUgINxaIgMEtchgJpUfIlKq08WAuJp2vVc4yTN1CS4EampET5kIkXa6GTwAEqLm
         xKUrc0cHcaJIndix/c4uFAZCpu60A79mr+ONLoSFk2lXGxFl6JenkNFFhzChCvLCkTuj
         KZsunWrvXo+Z0eBCeZn3uHacWyAg1PC9AzRHYtlwOa5GMF5oXCe9mNyIu06XsI2Sh6mr
         Ifbktk+t2Vr5nNIimwG/fmQJ4uFYkYHqERJVjF9fJbuZxVDxkAVR7mOh4aAnFzhV4H9X
         /R7A==
X-Gm-Message-State: APjAAAW27ACZjvth6aXD3mAAsohFLxDjtwGlcYuM1VAvRm/QE91t9B5N
        1lssr2LNb+uOYiORN8+14fcVXoxrkcE=
X-Google-Smtp-Source: APXvYqwhwi9asWoGarwV1ttbnvcYTBaHoXZhtcIvsmd7iDEuORxcnGrZ/vaDd+oaPUarZYQLAe1DpA==
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr15149157ljk.201.1575848465117;
        Sun, 08 Dec 2019 15:41:05 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v7sm9932156lfa.10.2019.12.08.15.41.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 15:41:04 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id y19so9201285lfl.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 15:41:04 -0800 (PST)
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr9937443lfp.106.1575848464008;
 Sun, 08 Dec 2019 15:41:04 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Dec 2019 15:40:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEJK=yo9vEhX_4b4ROvCqUA_rjK7g996h-5MbfOMeDrw@mail.gmail.com>
Message-ID: <CAHk-=wiEJK=yo9vEhX_4b4ROvCqUA_rjK7g996h-5MbfOMeDrw@mail.gmail.com>
Subject: Linux 5.5-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've had a normal merge window, and it's now early Sunday afternoon,
and it's getting closed as has been the standard rule for a long while
now.

Everything looks fairly regular - it's a tiny bit larger (in commit
counts) than the few last merge windows have been, but not bigger
enough to really raise any eyebrows. And there's nothing particularly
odd in there either that I can think of: just a bit over half of the
patch is drivers, with the next big area being arch updates. Which is
pretty much the rule for how things have been forever by now.

Outside of that, the documentation and tooling (perf and selftests)
updates stand out, but that's actually been a common pattern for a
while now too, so it's not really surprising either. And the rest is
all the usual core stuff - filesystems, core kernel, networking, etc.

The pipe rework patches are a small drop in the ocean, but ended up
being the most painful part of the merge for me personally. They
clearly weren't quite ready, but it got fixed up and I didn't have to
revert them. There may be other problems like that that I just didn't
see and be involved in, and didn't strike me as painful as a result ;)

We're missing some VFS updates, but I think we'll have Al on it for
the next merge window. On the whole, considering that this was a big
enough release anyway, I had no problem going "we can do that later".

As usual, even the shortlog is much too large to post, and nobody
would have the energy to read through it anyway. My mergelog below
gives an overview of the top-level changes so that you can see the
different subsystems that got development. But with 12,500+ non-merge
commits, there's obviously a little bit of everything going on.

Go out and test (and special thanks to people who already did, and
started sending reports even during the merge window),

               Linus

---

Al Viro (3):
    autofs updates
    vfs d_inode/d_flags memory ordering fixes
    misc vfs cleanups

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andreas Gruenbacher (1):
    GFS2 updates

Andrew Morton (3):
    updates
    more updates
    misc Kconfig updates

Andy Shevchenko (1):
    x86 platform driver updates

Arnd Bergmann (2):
    removal of most of fs/compat_ioctl.c
    y2038 cleanups

Benson Leung (1):
    chrome platform changes

Bjorn Andersson (3):
    remoteproc updates
    rpmsg updates
    hwspinlock updates

Bjorn Helgaas (1):
    PCI updates

Boris Brezillon (1):
    i3c updates

Borislav Petkov (4):
    x86 microcode updates
    RAS updates
    EDAC updates
    RAS fix

Bruce Fields (1):
    nfsd updates

Catalin Marinas (2):
    arm64 updates
    arm64 fixes

Christian Brauner (1):
    thread management updates

Christoph Hellwig (2):
    generic ioremap support
    dma-mapping updates

Corey Minyard (1):
    IPMI updates

Dan Williams (1):
    libnvdimm updates

Daniel Thompson (1):
    kgdb updates

Darrick Wong (6):
    iomap updates
    splice fix
    XFS updates
    iomap cleanups
    xfs fixes
    iomap fixes

Dave Airlie (3):
    drm updates
    drm coherent memory support for vmwgfx
    more drm updates

David Howells (3):
    AFS updates
    pipe rework
    two fixes for the pipe rework

David Miller (4):
    networking updates
    networking fixes
    networking fixes
    networking fixes

David Sterba (2):
    btrfs updates
    AFFS updates

Dennis Zhou (1):
    percpu updates

Dmitry Torokhov (2):
    input updates
    more input updates

Dominik Brodowski (1):
    pcmcia updates

Eric Biederman (1):
    sysctl system call removal

Eric Biggers (2):
    fscrypt updates
    fsverity updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greentime Hu (1):
    nds32 updates

Greg KH (6):
    USB updates
    char/misc driver updates
    staging / iio updates
    driver core updates
    tty/serial updates
    SPDX fix

Greg Ungerer (1):
    m68knommu update

Guenter Roeck (1):
    hwmon updates

Helge Deller (1):
    parisc updates

Herbert Xu (2):
    crypto updates
    crypto fixes

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (23):
    x86 objtool, cleanup, and apic updates
    x86 boot updates
    x86 cpu and fpu updates
    x86 syscall entry updates
    x86 hyperv updates
    x86 kdump updates
    x86 mm updates
    x86 platform updates
    x86 PTI updates
    x86 fixes
    x86 asm updates
    x86 iopl updates
    stacktrace cleanup
    EFI updates
    perf updates
    scheduler updates
    RCU updates
    locking updates
    x86 merge fix
    perf fixes
    x86 fixes
    irq updates
    timer updates

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (2):
    ext2, quota, reiserfs cleanups and fixes
    fsnotify updates

Jarkko Sakkinen (1):
    tpmd updates

Jason Gunthorpe (2):
    rdma updates
    hmm updates

Jassi Brar (1):
    mailbox updates

Jean Delvare (1):
    dmi updates

Jens Axboe (10):
    io_uring updates
    libata updates
    core block updates
    block driver updates
    additional block driver updates
    zoned block device update
    disk revalidation updates
    more io_uring updates
    block fixes
    more block and io_uring updates

Jessica Yu (1):
    modules updates

Jiri Kosina (1):
    HID updates

Joerg Roedel (1):
    iommu updates

John Johansen (1):
    apparmor updates

Jon Mason (1):
    NTB update

Jonathan Corbet (1):
    Documentation updates

Juergen Gross (2):
    xen updates
    more xen updates

Kees Cook (2):
    seccomp updates
    pstore bug fix

Lee Jones (2):
    backlight updates
    MFD updates

Linus Walleij (3):
    pin control updates
    pinctrl fix
    GPIO updates

Mark Brown (3):
    regmap update
    regulator updates
    spi updates

Masahiro Yamada (1):
    Kbuild updates

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    Xtensa updates

Michael Ellerman (4):
    powerpc Spectre-RSB fixes
    powerpc updates
    powerpc fixes
    more powerpc updates

Michal Simek (1):
    Microblaze updates

Mike Marshall (1):
    orangefs update

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (1):
    fuse update

Miquel Raynal (1):
    MTD updates

Olof Johansson (5):
    ARM SoC platform updates
    ARM SoC driver updates
    ARM Device-tree updates
    ARM SoC defconfig updates
    ARM SoC fixes

Paolo Bonzini (2):
    KVM updates
    more KVM updates

Paul Burton (1):
    MIPS updates

Paul Moore (2):
    selinux updates
    audit updates

Paul Walmsley (2):
    RISC-V updates
    more RISC-V updates

Pavel Machek (1):
    LED updates

Petr Mladek (2):
    printk updates
    livepatching updates

Rafael Wysocki (5):
    power management updates
    ACPI updates
    device properties framework updates
    additional power management updates
    additional ACPI updates

Richard Weinberger (2):
    UBI/UBIFS/JFFS2 updates
    UML updates

Rob Herring (1):
    Devicetree updates

Russell King (2):
    ARM updates
    ARM fixes

Sasha Levin (1):
    Hyper-V updates

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (2):
    kselftest fixes
    more kselftest fixes

Stafford Horne (1):
    OpenRISC update

Stefan Richter (1):
    FireWire updates

Stephen Boyd (1):
    clk updates

Steve French (2):
    cifs updates
    cifs fixes

Steven Rostedt (2):
    tracing updates
    more tracing updates

Takashi Iwai (2):
    sound updates
    more sound updates

Ted Ts'o (1):
    ext4 updates

Tejun Heo (2):
    workqueue updates
    cgroup updates

Thierry Reding (1):
    pwm updates

Tony Luck (1):
    ia64 update

Trond Myklebust (1):
    NFS client updates

Ulf Hansson (1):
    MMC updates

Vasily Gorbik (2):
    s390 updates
    more s390 updates

Vineet Gupta (1):
    ARC updates

Vinod Koul (1):
    dmaengine updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates

Zhang Rui (1):
    thermal management updates
