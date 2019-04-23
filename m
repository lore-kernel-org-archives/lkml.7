Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1A1C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E2620811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 00:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aDuHijj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfDWARt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 20:17:49 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:32924 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbfDWARs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 20:17:48 -0400
Received: by mail-ot1-f46.google.com with SMTP id j10so11252107otq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 17:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=juMVrKHWe6BA8aLmU2ilY/nSc2lXa6zcTAF7dsxRPQs=;
        b=aDuHijj5KgRVDUQ2ySlFDqHU1xFop6sW1O3BLtOeH7vbKiL/FUVBBlSb+8MiLIU+Tg
         zcploVM30tpjdIKKd3+W6zqAHaUUHjGIPazPnZ59w2L1KaCIc5sBkzAr7s/rfGzE0Ucs
         jmSmMUU8vOLz6mt62DMapWoAZE+zVSZ2+sgwAqsCn/CjC+g4xk3KXUsviNzgLzzwnoTb
         r5HefrvhdkozYSTK/JIvJMRSOyorZldunfSecAZzanT0nDQ/niGkk+S78UzMmss1Gn1G
         TUs9/byPaBzOMopq+ph0yvQXA9iKBMq40ueVCvCD+dTjygnzE8xFeSKLduY3nCS7RzEs
         O60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=juMVrKHWe6BA8aLmU2ilY/nSc2lXa6zcTAF7dsxRPQs=;
        b=Q22WCR1E8weO0cvtgvgYj96oOGlP3GDktloPBkxcfUjyIceCvfejUiVoIIq3EYrb9t
         Q6apqIaU6p/mHKb1tDMzhba+mMJSb5LiTTVeDL6D5RACzbSHftG+AIYMPk9MnvsFQ0tI
         gtb2dNGCOHMQa6+YZrQXsfxEhnWF3fgsLPO2H7d2zMf2OLuQNNj7eu82dL1dEMuy/sIW
         PI9/ZJ2P+Y005HoG62FWIuhfNG9p4gKRJ8yARUumYzjgPOCZ7Z0L4lmVlM6Z4e4bdmnX
         c+xSTr3LfApaqUaJ9Hx39b8bGzMpsrYSDrKFChEbGaO2Q2mbO8cHacCK+7FsU3P7ZBs+
         nGxQ==
X-Gm-Message-State: APjAAAWzKx5YAcJzC64rcat9bxcioJQnxNsObgzC9K3IXCbD8m3nEEXk
        zh5dP9Fc3zEHV+BTzqFg2W4bwA==
X-Google-Smtp-Source: APXvYqwJDH0ahqtxz6b+vjzzuEsFRL9/rFt0U0fWQhjhqUG0gxjx1O1PQjfEQLmmpraiD6wIb4E9aw==
X-Received: by 2002:a05:6830:1559:: with SMTP id l25mr13480418otp.355.1555978666763;
        Mon, 22 Apr 2019 17:17:46 -0700 (PDT)
Received: from localhost (175.sub-174-209-26.myvzw.com. [174.209.26.175])
        by smtp.gmail.com with ESMTPSA id h23sm7189658oic.10.2019.04.22.17.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 17:17:45 -0700 (PDT)
Date:   Mon, 22 Apr 2019 17:17:43 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
cc:     khilman@baylibre.com
Subject: Testing the recent RISC-V DT patchsets
Message-ID: <alpine.DEB.2.21.9999.1904221705170.18377@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I've heard from two separate people who have had trouble getting started 
with BBL & open-source FSBL test flows with arbitrary DT files on the 
Freedom Unleashed board.  The following instructions should help get 
people started.

The core issue, aside from general unfamiliarity, is that multiple parts 
of the pre-kernel software stack try to parse and/or modify the kernel DT.
We wish to avoid this as much as possible.

Testing with U-boot and OpenSBI is currently left as an exercise for the 
reader, for a similar reason and because those ports are still quite new.

The following instructions are provided with no warranty whatsoever, and 
assume knowledge of the shell and Linux.  If implemented carelessly, may 
trash your filesystems or do other horrible things.


- Paul


These instructions assume that bare metal and Linux RV64 cross-toolchains 
are installed.  If not, consider using crosstool-ng with the 
"riscv64-unknown-elf" and "riscv64-unknown-linux-gnu" experimental sample 
configurations.  You will need both.

1. Put the location of the temporary build tree into the BASE
   environment variable, and set up some initial directories:
   export BASE=~/riscv-test; mkdir -p ${BASE}/work

2. Partition a microSD card with (at least) two GPT partitions.
   Here is a sample sfdisk dump:

label: gpt
label-id: 074689DB-0440-411C-91DB-440DFE5BA0B6
device: /dev/sda
unit: sectors
first-lba: 34
last-lba: 62333918

/dev/sda1 : start=        2048, size=        2048, type=5B193300-FC78-40CD-8002-E86C45580B47, uuid=DEAD9378-45FF-44FB-B2E3-F3FEA45ADC9E, name="fsbl"
/dev/sda2 : start=        4096, size=       65536, type=2E54B353-1271-4842-806F-E436D6AF6985, uuid=1B48DE68-8004-444D-BA47-AAA8DBEBFA60, name="bbl"
/dev/sda3 : start=       69632, size=    62264287, type=0FC63DAF-8483-4772-8E79-3D69D8477DE4, uuid=D672F1FC-3E45-4CC1-835A-E6384A26C395, name="rootfs"


3. Download the open-source FSBL:
   cd ${BASE}
   git clone https://github.com/sifive/freedom-u540-c000-bootloader

4. Build the open-source FSBL:
   cd freedom-u540-c000-bootloader
   CROSSCOMPILE=/opt/rv64gc-mmu-elf/bin/riscv64-unknown-elf- make

5. Write the open-source FSBL to the first partition of the SD card with
   something like:
   sudo dd if=fsbl.bin of=/dev/SD-CARD-DEVICE1 conv=nocreat

6. Copy an initramfs sysroot into ${BASE}/work/buildroot_initramfs_sysroot.
   A reasonable one to start with is the sysroot built by
   freedom-u-sdk, in work/buildroot_initramfs_sysroot.

7. Set the CROSS_COMPILE environment variable to point to your
   cross-compiler, in the Linux kernel form:
   export CROSS_COMPILE=/opt/rv64gc-mmu-linux-8.2.0/bin/riscv64-unknown-linux-gnu-

8. Put something like this into a script and run it:

if [ ! -d ${BASE} ]; then
    echo Base build directory must be set in the BASE environment variable
fi
if [ ! -x ${CROSS_COMPILE}gcc ]; then
    echo Path to cross-compiler must be set in the CROSS_COMPILE 
environment variable
fi

export ARCH=riscv
export OBJCOPY=${CROSS_COMPILE}objcopy
export CC=${CROSS_COMPILE}gcc

CORES=$(getconf _NPROCESSORS_ONLN)

#
#

cd ${BASE}
git clone -b dev/paulw/reduce-dt-load-v1 
https://github.com/sifive/riscv-pk
git clone -b dev/paulw/dts-v5.1-rc6-experimental 
https://github.com/sifive/riscv-linux

cd riscv-linux
make -j${CORES} defconfig dtbs vmlinux

${CROSS_COMPILE}strip -o ${BASE}/work/vmlinux-stripped 
${BASE}/riscv-linux/vmlinux

rm -rf ${BASE}/work/riscv-pk
mkdir -p ${BASE}/work/riscv-pk
cd ${BASE}/work/riscv-pk
ln -sf 
${BASE}/riscv-linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dtb 
${BASE}/riscv-pk/linux.dtb
${BASE}/riscv-pk/configure \
	--host=riscv64-unknown-linux-gnu \
	--enable-print-device-tree --with-payload=../vmlinux-stripped
CFLAGS="-mabi=lp64d -march=rv64imafdc" make

$OBJCOPY -S -O binary --change-addresses -0x80000000 bbl ../bbl.bin


9.  Write ${BASE}/work/bbl.bin to the second partition of your microSD 
    card with something like:
    sudo dd if=${BASE}/work/bbl.bin of=/dev/SD-CARD-DEVICE2 bs=64k conv=nocreat

10. Boot the microSD card on your Unleashed board.


