Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1421CC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 23:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F5920578
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 23:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558307771;
	bh=B0Z30DudEMcQcV+9I2196U2YeWW2UhNiGEyPfHgOe+c=;
	h=From:Date:Subject:To:List-ID:From;
	b=MwB1wBST6pby3uUbM9xpU14HbYqkg/kssgS+DQbrMfbrl7XDJxPWtbIMRkjwlhXBc
	 XYP5EzlpOFJxNPa+ZtcAOZnJkdrKMab6jOu5Q1lyW65ojXUmatQCcora6e4QkDwZI9
	 79xyipcHi9zE362Sl+UoZxXO6b3UfW8O2fRDraXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfESXQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 19:16:10 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:44577 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfESXQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 19:16:10 -0400
Received: by mail-lf1-f41.google.com with SMTP id n134so8863393lfn.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 16:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ylVvDDleoXn9gi4sKu1as992YThvdXnAVng58Z4p+s4=;
        b=b1mw99qHkULGGpwOHv9P3oNMMON/q6PvtxkENly0L17ISzF7lCAeEpLKtnsHF5Zgvz
         Gqlih0mYwZyt0X7QtfrTxsFvPqEifRdMqh9PujdasHMaVqwEFB5V2FSiOR7dM9ZgPBTq
         O3Hm1orxEiNDLgWTE14/HWJcv3ZK4SI12yt9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ylVvDDleoXn9gi4sKu1as992YThvdXnAVng58Z4p+s4=;
        b=gpBTYjI1FRHOjcBk4sooac9y1JNmA416RxfdQWhWHtUutVyTpFMYHZUi2F0usmbao/
         Ch5pXRJmmQVwuu9DhEP96mYNoF20Ptsn1d4FnO5kQYWBPsZHBfXhWrKd9oIy8r/XkQjH
         EY11Eba3QSWzJiQs6MTutL5TmiQafcc/WYl4qzIKyBhKR+JgIse8g2rSDnN7KM+hUoAR
         5Gn96t2bmU+4P6DJ8m6/9C+8yU5yvhSayYHXpdbJRfHctwt+pQWYFLgQlX24XktPE2hF
         oFnwqAYU9AZ0k56o/1SsMry6D/gWfdbY5sSW21JNk+uPytNjfeDJNSQqsskdcLo73iWL
         5tcg==
X-Gm-Message-State: APjAAAVJ7NvLfcHPo4alYpCG+StK1iUraezw6cDZbczccQ7WQ2vcYGT3
        Gua92M40iSlr+TKDWQ9q9C1c2aBdQqA=
X-Google-Smtp-Source: APXvYqwB29eDsVgVnjze9pvyFnSDcfwF4o2xaFCtJQesgR231UGYa/XkFrMHdEcQXp1iT5kR2GK9Ow==
X-Received: by 2002:a19:4acf:: with SMTP id x198mr33817773lfa.7.1558307767172;
        Sun, 19 May 2019 16:16:07 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f9sm3370631ljf.69.2019.05.19.16.16.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 16:16:06 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 14so10728687ljj.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 16:16:06 -0700 (PDT)
X-Received: by 2002:a2e:2f03:: with SMTP id v3mr18125384ljv.6.1558307765716;
 Sun, 19 May 2019 16:16:05 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 May 2019 16:15:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxi6fnxZ+p5Zdqr-i4s=xhOCBJL6s_RauYkjxM2CpXeA@mail.gmail.com>
Message-ID: <CAHk-=wgxi6fnxZ+p5Zdqr-i4s=xhOCBJL6s_RauYkjxM2CpXeA@mail.gmail.com>
Subject: Linux 5.2-rc1
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing particularly odd going on this merge window. I had some travel
in the middle of it, but to offset that I had a new faster test-build
setup, and most of the pull requests came in early (thank you) so my
travels didn't actually end up affecting the merge window all that
much.

We did have a few late pull requests too, but since that meshed fairly
well with my schedule as per above, and people generally made the
proper noises ("sorry for late pull request, I had good reasons: xyz")
I didn't mind this time. But let's try to not repeat that, ok?

Things look fairly normal. Just about two thirds of the patch is
drivers (all over), with the bulk of the rest being arch updates,
tooling, documentation and vfs/filesystem updates, of which there were
more than usual (the unicode tables for ext4 case insensitivity do end
up being a big part of the "bulk" side).

But there's core networking, kernel and vm changes too - it's just
that the other areas tend to simply be much bulkier. Drivers etc tend
to just have a ton more lines to them, if only by virtue of there
being so many of them (although admittedly also sometimes because some
drivers tend to just be very verbose and have a lot of register
definitions etc).

Size-wise things look fairly normal. 12k+ commits (plus another ~750
merge commits) is about normal for us by now. And hard to summarize in
a release email. So appended is obviously just the usual shortlog of
merges I did and their sources, for a kind of overview of the _areas_
that have changed, rather than any real detail. You'll need to go look
at the git tree to see the details.

Go forth and test,

                 Linus

---

Al Viro (8):
    vfs inode freeing updates
    vfs stable fodder fixes
    misc dcache updates
    mount ABI updates
    vfs 'struct file' related updates
    misc vfs updates
    vfs mount fix
    more vfs mount updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andreas Gruenbacher (1):
    GFS2 updates

Andrew Morton (3):
    misc updates
    more updates
    yet more updates

Andy Shevchenko (1):
    x86 platform driver updates

Anna Schumaker (1):
    NFS client updates

Arnd Bergmann (1):
    nommu generic uaccess updates

Bartlomiej Zolnierkiewicz (1):
    fbdev updates

Benson Leung (1):
    chrome platform updates

Bjorn Helgaas (1):
    PCI updates

Boris Brezillon (1):
    i3c update

Borislav Petkov (5):
    x86 microcode loading update
    EDAC updates
    RAS updates
    x86 FPU state handling updates
    EDAC fixes

Bruce Fields (1):
    nfsd updates

Christian Brauner (2):
    pidfd updates
    pidfd fixes

Christoph Hellwig (2):
    DMA mapping updates
    configfs update

Corey Minyard (1):
    IPMI updates

Dan Williams (1):
    libnvdimm updates

Daniel Thompson (1):
    kgdb updates

Darrick Wong (2):
    iomap updates
    xfs updates

Dave Airlie (2):
    drm updates
    drm fixes

Dave Kleikamp (1):
    jfs updates

David Howells (3):
    AFS updates
    misc AFS fixes
    AFS callback promise fixes

David Miller (5):
    networking updates
    IDE update
    sparc updates
    networking fixes
    networking fixes

David Sterba (1):
    btrfs updates

Dennis Zhou (1):
    percpu updates

Dmitry Torokhov (1):
    input updates

Eduardo Valentin (1):
    thermal soc updates

Geert Uytterhoeven (1):
    m68k updates

Greentime Hu (1):
    nds32 updates

Greg KH (6):
    driver core/kobject updates
    staging / IIO driver updates
    char/misc update part 1
    char/misc update part 2
    USB/PHY updates
    tty/serial updates

Guenter Roeck (1):
    hwmon updates

Guo Ren (2):
    arch/csky updates
    arch/csky perf update

Gustavo A (1):
    Wimplicit-fallthrough updates

Helge Deller (2):
    parisc updates
    more parisc updates

Herbert Xu (2):
    crypto update
    crypto fixes

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (36):
    unified TLB flushing
    objtool updates
    RCU updates
    rseq updates
    speculation mitigation update
    stack trace updates
    EFI updates
    irq updates
    locking updates
    perf updates
    scheduler updates
    CPU hotplug updates
    timer updates
    x86 apic update
    x86 asm updates
    x86 build updates
    x86 cache QoS updates
    x86 cleanups
    x86 cpu updates
    x86 entry cleanup
    x86 irq updates
    x86 kdump update
    x86 mm updates
    x86 platform updates
    x86 timer updates
    x86 topology updates
    core fixes
    locking fix
    perf fixes
    time fixes
    x86 fixes
    core fixes
    EFI fix
    IRQ chip updates
    clocksource updates
    perf tooling updates

Jacek Anaszewski (1):
    LED updates

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (1):
    SCSI updates

James Morris (4):
    security subsystem updates
    intgrity updates
    smack updates
    tomoyo updates

Jan Kara (2):
    misc filesystem updates
    fsnotify fixes

Jason Gunthorpe (2):
    rdma updates
    more rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (5):
    block updates
    io_uring updates
    libata updates
    more block updates
    io_uring fixes

Jessica Yu (1):
    modules updates

Jiri Kosina (2):
    HID updates
    livepatching updates

Joerg Roedel (1):
    IOMMU updates

Jonathan Corbet (2):
    documentation updates
    more documentation updates

Juergen Gross (1):
    xen updates

Kees Cook (2):
    compiler-based variable initialization updates
    gcc plugin fix

Kirill Smelkov (1):
    stream_open conversion

Konrad Rzeszutek Wilk (1):
    swiotlb updates

Lee Jones (2):
    MFD updates
    backlight updates

Linus Walleij (2):
    pin control updates
    gpio updates

Mark Brown (3):
    regmap updates
    regulator updates
    spi updates

Martin Schwidefsky (2):
    s390 updates
    more s390 updates

Masahiro Yamada (3):
    Kbuild updates
    Kconfig updates
    more Kbuild updates

Mauro Carvalho Chehab (2):
    media updates
    media fixes

Max Filippov (1):
    xtensa updates

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio updates

Mike Marshall (1):
    orangefs updates

Mike Snitzer (1):
    device mapper updates

Miklos Szeredi (2):
    fuse update
    overlayfs update

Olof Johansson (5):
    ARM SoC platform updates
    ARM Device-tree updates
    ARM SoC-related driver updates
    ARM SoC defconfig updates
    ARM SoC late updates

Palmer Dabbelt (1):
    RISC-V updates

Paolo Bonzini (1):
    KVM updates

Paul Burton (2):
    MIPS updates
    a few more MIPS updates

Paul Moore (2):
    selinux updates
    audit updates

Petr Mladek (2):
    printk updates
    printk fixup

Rafael Wysocki (5):
    ACPI updates
    power management updates
    device properties framework updates
    more power management updates
    more ACPI updates

Richard Weinberger (4):
    UML updates
    MTD updates
    UBI/UBIFS updates
    UBIFS fixes

Rob Herring (2):
    Devicetree updates
    Devicetree vendor prefix conversion

Russell King (1):
    ARM updates

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (2):
    Kselftest updates
    more kselftest updates

Stephen Boyd (2):
    clk framework updates
    more clk framework updates

Steve French (2):
    cifs fixes
    cifs fixes

Steven Rostedt (3):
    ktest updates
    tracing updates
    more ktest updates

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (4):
    ext4 updates
    fscrypt updates
    randomness updates
    ext4 fixes

Tejun Heo (3):
    workqueue updates
    cgroup updates
    cgroup fix

Thierry Reding (1):
    pwm updates

Thomas Gleixner (1):
    x86 MDS mitigations

Ulf Hansson (1):
    MMC updates

Vinod Koul (1):
    dmaengine updates

Will Deacon (2):
    mmiowb removal
    arm64 updates

Willy Tarreau (1):
    RISC-V nolibc header update

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    i2c updates

Zhang Rui (1):
    thermal management updates
