Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEFBC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4950206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563744840;
	bh=oTC/Q9+5qsd96BuF4DZL7MLDF/ZLsKY2142ssWy86WI=;
	h=From:Date:Subject:To:List-ID:From;
	b=QEq+46QqnLh3rniKIcZJZC5Zmg3hEEUF1uO9P64yjgJV38jjtLOQLPtp9JMqIVSGk
	 Zt9WjwlCP8w7Shoy7v3UnbZsxoRS2MK9ioZsHSdy8YWQ28ampnB1GohthHa2lN/0mO
	 D38QFhKvbKm8QRdHlxY8/HYLuO8PQY2CDT3kwLYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfGUVd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 17:33:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40150 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfGUVd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 17:33:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so25158235lff.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ysf6NXyHxyINdybSYhzJ6GTI+4mpCuoKjt0u636B+z0=;
        b=BBHxEbteuWqwDueQnwVwdQ0c+gaHO3ivOXHi4+NkNJb5K8bOuA6tsJml1ZOPdQZ3th
         GT/kwOogijRS3JLaLNunNmTX80M8+y2URxtuSis4YOa+hK+XRO6NEUVjdTeeuWXXFx3b
         Wy+vqJrXC9bNh0u/nqAKxjlm0+Bx1YPfJQG8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ysf6NXyHxyINdybSYhzJ6GTI+4mpCuoKjt0u636B+z0=;
        b=uB6JtEpDwmJK+8j7wpQSkk1TIKIwnv7C/tDBeJo5r30iIGysvz0b0x/YXfYi7p37Vk
         Kmn+a7C6+X1jJLjH/Tu/drW51RPTkVoTumebbiBGe/kpwHUSaOZf5CTxEdxYLnbeo2cX
         aSlw9g8BTJupJnMUuL4kRFlr3Rehuz3XZoFW3gAO4qeVtXDoA+0UbvDtRBUWkmegA1j9
         KMbqqzAxhj9/rbAmfmcH+PlcK24nVsRREID1R+U6wl9TUQlFTPmQ85S9Vp5aWKSrE123
         FbFvaDl7sv6TJZkz1U83S0kLFh4NedFYpWKJ/rG+ce0Eaag+EtsjUM2+3hEPMzLy0mET
         fK4g==
X-Gm-Message-State: APjAAAUeMb2eukoVkbnmMqiKWWXLUKY5O9XV5Ot5ILepOk3XRSTPRrFL
        8KdlgY0iMJSbmSMQOTqy2UEudqM/CEI=
X-Google-Smtp-Source: APXvYqwRzEKUUi/jK3ZhefIeA+2QwgKV5Wqeqc6J8jdvDktjUySWtQ+EiaZcodriGRBisXMrNcK/Vw==
X-Received: by 2002:a19:8093:: with SMTP id b141mr30855771lfd.137.1563744835629;
        Sun, 21 Jul 2019 14:33:55 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id b68sm8160216ljb.0.2019.07.21.14.33.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 14:33:55 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id k18so35542031ljc.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 14:33:54 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr4676574ljg.52.1563744834600;
 Sun, 21 Jul 2019 14:33:54 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Jul 2019 14:33:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
Message-ID: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
Subject: Linux 5.3-rc1
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been two weeks, and the merge window is over, and Linux 5.3-rc1
is tagged and pushed out.

This is a pretty big release, judging by the commit count. Not the
biggest ever (that honor still goes to 4.9-rc1, which was
exceptionally big), and we've had a couple of comparable ones (4.12,
4.15 and 4.19 were also big merge windows), but it's definitely up
there.

The merge window also started out pretty painfully, with me hitting a
couple of bugs in the first couple of days. That's never a good sign,
since I don't tend to do anything particularly odd, and if I hit bugs
it means code wasn't tested well enough. In one case it was due to me
using a simplified configuration that hadn't been tested, and caused
an odd issue to show up - it happens. But in the other case, it really
was code that was too recent and too rough and hadn't baked enough.
The first got fixed, the second just got reverted.

Anyway, despite the rocky start, and the big size, things mostly
smoothed out towards the end of the merge window. And there's a lot to
like in 5.3. Too much to do the shortlog with individual commits, of
course, so appended is the usual "mergelog" of people I merged from
and a one-liner very high-level "what got merged". For more detail,
you should go check the git tree.

As always: the people credited below are just the people I pull from,
there's about 1600 individual developers (for 12500+ non-merge
commits) in this merge window.

Go test,

            Linus

---

Al Viro (5):
    vfs mount updates
    adfs updates
    misc vfs updates
    dcache and mountpoint updates
    vfs documentation typo fix

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (1):
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (3):
    updates
    more updates
    yet more updates

Andy Shevchenko (2):
    x86 platform driver updates
    another x86 platform driver update

Arnd Bergmann (1):
    asm-generic updates

Bartlomiej Zolnierkiewicz (1):
    fbdev updates

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (3):
    rpmsg updates
    remoteproc updates
    hwspinlock updates

Bjorn Helgaas (1):
    PCI updates

Boris Brezillon (1):
    ic3 updates

Bruce Fields (1):
    nfsd updates

Catalin Marinas (1):
    arm64 updates

Christian Brauner (3):
    pidfd updates
    clone3 system call
    pidfd and clone3 fixes

Christoph Hellwig (2):
    dma-mapping updates
    dma-mapping fixes

Corey Minyard (1):
    IPMI updates

Dan Williams (2):
    libnvdimm updates
    dax updates

Daniel Vetter (1):
    drm fixes

Darrick Wong (6):
    iomap updates
    copy_file_range updates
    common SETFLAGS/FSSETXATTR parameter checking
    xfs updates
    xfs cleanups
    iomap split/cleanup

Dave Airlie (1):
    drm updates

David Howells (5):
    misc keyring updates
    request_key improvements
    keyring namespacing
    keyring ACL support
    afs updates

David Miller (5):
    networking updates
    IDE update
    networking fixes
    sparc updates
    networking fixes

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Denis Efremov (1):
    floppy ioctl verification fixes

Dennis Zhou (1):
    percpu updates

Dmitry Torokhov (2):
    input updates
    more input updates

Dominique Martinet (1):
    9p updates

Eric Biederman (1):
    force_sig() argument change

Eric Biggers (1):
    fscrypt updates

Geert Uytterhoeven (2):
    m68k updates
    m68k fix

Greg KH (5):
    char / misc driver updates
    staging and IIO driver updates
    tty / serial driver updates
    USB / PHY updates
    driver core and debugfs updates

Greg Ungerer (1):
    m68nommu updates

Guenter Roeck (1):
    hwmon updates

Guo Ren (1):
    arch/csky updates

Helge Deller (2):
    parisc updates
    parisc fixes

Herbert Xu (2):
    crypto updates
    crypto fixes

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (17):
    RCU updates
    locking updates
    RAS updates
    scheduler updates
    x86 asm updates
    x86 build updates
    x86 cache resource control update
    x86 cleanups
    x86 AVX512 status update
    x86 paravirt updates
    x86 platform updates
    x86 topology updates
    perf updates
    scheduler fix
    x86 fix
    locking fix
    perf fixes

Jacek Anaszewski (1):
    LED updates

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (3):
    SCSI updates
    SCSI scatter-gather list updates
    SCSI fixes

James Morris (1):
    capabilities update

Jan Kara (2):
    fsnotify updates
    ext2, udf and quota updates

Jarkko Sakkinen (1):
    tpm updates

Jason Gunthorpe (2):
    HMM updates
    rdma updates

Jassi Brar (1):
    mailbox updates

Jeff Layton (1):
    file locking updates

Jens Axboe (4):
    block updates
    libata updates
    io_uring updates
    more block updates

Jessica Yu (1):
    module updates

Jiri Kosina (2):
    livepatching updates
    HID updates

Joerg Roedel (1):
    iommu updates

Jon Mason (1):
    NTB updates

Jonathan Corbet (1):
    Documentation updates

Juergen Gross (1):
    xen updates

Kees Cook (2):
    pstore updates
    security/loadpin updates

Kirill Smelkov (1):
    stream_open() updates

Konrad Rzeszutek Wilk (1):
    swiotlb updates

Lee Jones (2):
    MFD updates
    backlight updates

Ley Foon Tan (1):
    arch/nios2 updates

Linus Walleij (3):
    GPIO updates
    pin control updates
    GPIO fixes

Mark Brown (3):
    regmap updates
    regulator updates
    spi updates

Masahiro Yamada (3):
    Kbuild updates
    Kconfig updates
    more Kbuild updates

Mauro Carvalho Chehab (2):
    media updates
    rst conversion of docs

Max Filippov (1):
    Xtensa updates

Micah Morton (1):
    safesetid updates

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio, vhost updates

Mike Marshall (1):
    orangefs updates

Mike Snitzer (2):
    device mapper updates
    more device mapper updates

Mimi Zohar (1):
    integrity updates

Miquel Raynal (1):
    MTD updates

Olof Johansson (4):
    ARM SoC platform updates
    ARM SoC-related driver updates
    ARM Devicetree updates
    ARM SoC defconfig updates

Paolo Bonzini (2):
    KVM updates
    more KVM updates

Paul Burton (1):
    MIPS updates

Paul Moore (2):
    audit updates
    selinux updates

Paul Walmsley (1):
    RISC-V updates

Petr Mladek (1):
    printk updates

Rafael Wysocki (6):
    power management updates
    ACPI updates
    device properties framework updates
    ACPI fix
    more ACPI updates
    more power management updates

Richard Weinberger (2):
    UML updates
    UBIFS updates

Rob Herring (2):
    Devicetree updates
    Devicetree fixes

Russell King (1):
    ARM updates

Sasha Levin (1):
    hyper-v updates

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (1):
    Kselftest updates

Stephen Boyd (1):
    clk updates

Steve French (2):
    cifs updates
    cifs fixes

Steven Rostedt (2):
    tracing updates
    tracing fix

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

Thomas Gleixner (22):
    debugobjects updates
    Reed-Solomon library updates
    SMP/hotplug updates
    irq updates
    timer updates
    x96 apic updates
    x86 vsyscall updates
    x86 FPU updates
    x86 CPU feature updates
    x86 timer updates
    x86 pti updates
    x86 boot updates
    x865 kdump updates
    irq fixes
    stacktrace fix
    timer fixes
    x86 fixes
    CONFIG_PREEMPT_RT stub config
    smp fix
    core fixes
    perf tooling updates
    x86 fixes

Tony Luck (1):
    EDAC updates

Trond Myklebust (1):
    NFS client updates

Tyler Hicks (1):
    eCryptfs updates

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

Yoshinori Sato (2):
    SH updates
    h8300 update

Zhang Rui (1):
    thermal management updates
