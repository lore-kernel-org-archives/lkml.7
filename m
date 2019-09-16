Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFEEC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804102067D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Skv+nit2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbfIPKyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:54:43 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44121 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIPKym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id m13so5320265ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nFwBnbJl1Pzb/az0iASSF7ufSzhkXpDlNpdyZZaDLco=;
        b=Skv+nit2CnSd4bITeugcc5c8T6mSvVhLlXCqG/DpX+/QhEyrVs78DPqor1M91eVYOj
         4cZtZWbiUEvN26GxmZJQ1kFcyW1ghVdkO0Xgu6Qeodc7Pdlaxe4PvchgOuyLH69FDRET
         ECcfeHUVKIg+pkJSrp259merQDwxatkV6avZvUP8F9vzlnRilkL8LR1oqKJ/paRZXht+
         6jZZjAZ0ppH+eWpHSK1L3JQvqTRAXxbMbMdGtMrel7DlBOTMaZNjs83kueiBBmDuEGgi
         3opHDgVNMgkkZDAQD1o8hx5yQg40gl8h2J731huEbdUEnKawabyOpGco1+JNCbCeDjgl
         +54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nFwBnbJl1Pzb/az0iASSF7ufSzhkXpDlNpdyZZaDLco=;
        b=i2h3I9e/HMiOSkWGA1goGsppA5HIOBA+A4Ylw0vALgjRBtU/o4pmIek0YXtOEw978l
         Kvw6EZDRdShkV05wsVw4o6/gkRoOdbhXD9tuRUlyTmJ1uLWMGPPdSdsXiNXO8WcgYXZj
         NMZOwWY+vmwbJfbAw1cfdbUUz0GM3VjeaDmECr9WFOAQurTmSkv84bG4PvnlXxaiyoW6
         46FPkmR+6LTphNL4RhDh88AudnIofzkw9XEDitN9usbbMiK6C9lwZYKU3qCIhTR5EYgY
         XxDQGKz4/KPER7lV4Nn0YSTdGzs7WgQV2Eo/lOSRNUkFzdtl0QEOwX2Oi2zjYFjxQqCQ
         PXwg==
X-Gm-Message-State: APjAAAWgiTjkTAIA1k9dQkG6XnyaY2PU0sdM+FVcFecZDDOJ3FSROzHO
        kIEur98LKhElqvGcIUFowauIZhoQWW8=
X-Google-Smtp-Source: APXvYqyqaibdsKf8Xv9itXXbpSGxVRm1JOiJ+d/TPun/lRWgomOMt708D07W+WkIzmVXngNZxFrtJg==
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr1654522ljo.121.1568631280219;
        Mon, 16 Sep 2019 03:54:40 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:39 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 00/14] samples: bpf: improve/fix cross-compilation
Date:   Mon, 16 Sep 2019 13:54:19 +0300
Message-Id: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains mainly fixes/improvements for cross-compilation
but not only, tested for arm, arm64, but intended for any arch.
Also verified on native build (not cross compilation) for x86_64
and arm.

Initial RFC link:
https://lkml.org/lkml/2019/8/29/1665

Prev. version:
https://lkml.org/lkml/2019/9/10/331

Besides the patches given here, the RFC also contains couple patches
related to llvm clang
  arm: include: asm: swab: mask rev16 instruction for clang
  arm: include: asm: unified: mask .syntax unified for clang
They are necessarily to verify arm build.

The change touches not only cross-compilation and can have impact on
other archs and build environments, so might be good idea to verify
it in order to add appropriate changes, some warn options could be
tuned also.

All is tested on x86-64 with clang installed (has to be built containing
targets for arm, arm64..., see llc --version, usually it's present already)

Instructions to test native on x86_64
=================================================
Native build on x86_64 is done in usual way and shouldn't have difference
except HOSTCC is now printed as CC wile building the samples.

Instructions to test cross compilation on arm64
=================================================
#Toolchain used for test:
gcc version 8.3.0
(GNU Toolchain for the A-profile Architecture 8.3-2019.03 (arm-rel-8.36))

# Get some arm64 FS, containing at least libelf
I've used sdk for TI am65x got here:
http://downloads.ti.com/processor-sdk-linux/esd/AM65X/latest/exports/\
ti-processor-sdk-linux-am65xx-evm-06.00.00.07-Linux-x86-Install.bin

# Install this binary to some dir, say "sdk".
# Configure kernel (use defconfig as no matter), but clean everything
# before.
make ARCH=arm64 -C tools/ clean
make ARCH=arm64 -C samples/bpf clean
make ARCH=arm64 clean
make ARCH=arm64 defconfig

# The kernel version used in sdk doesn't correspond to checked one,
# but for this verification only headers need to be syched,
# so install them:
make ARCH=arm64 headers_install

# or on SDK if need keep them in sync (not necessarily to verify):

make ARCH=arm64 INSTALL_HDR_PATH=/../sdk/\
ti-processor-sdk-linux-am65xx-evm-06.00.00.07/linux-devkit/sysroots/\
aarch64-linux/usr headers_install

# Build samples
make samples/bpf/ ARCH=arm64 CROSS_COMPILE="aarch64-linux-gnu-"\
SYSROOT="/../sdk/ti-processor-sdk-linux-am65xx-evm-06.00.00.07/\
linux-devkit/sysroots/aarch64-linux"

Instructions to test cross compilation on arm
=================================================
#Toolchains used for test:
arm-linux-gnueabihf-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011
or
arm-linux-gnueabihf-gcc
(GNU Toolchain for the A-profile Architecture 8.3-2019.03 \
(arm-rel-8.36)) 8.3.0

# Get some FS, I've used sdk for TI am52xx got here:
http://downloads.ti.com/processor-sdk-linux/esd/AM57X/05_03_00_07/exports/\
ti-processor-sdk-linux-am57xx-evm-05.03.00.07-Linux-x86-Install.bin

# Install this binary to some dir, say "sdk".
# Configure kernel, but clean everything before.
make ARCH=arm -C tools/ clean
make ARCH=arm -C samples/bpf clean
make ARCH=arm clean
make ARCH=arm omap2plus_defconfig

# The kernel version used in sdk doesn't correspond to checked one, but
headers only should be synched, so install them:

make ARCH=arm64 headers_install

# or on SDK if need keep them in sync (not necessarily):

make ARCH=arm INSTALL_HDR_PATH=/../sdk/\
ti-processor-sdk-linux-am57xx-evm-05.03.00.07/linux-devkit/sysroots/\
armv7ahf-neon-linux-gnueabi/usr headers_install

# Build samples
make samples/bpf/ ARCH=arm CROSS_COMPILE="arm-linux-gnueabihf-"\
SYSROOT="/../sdk/ti-processor-sdk-linux-am57xx-evm-05.03\
.00.07/linux-devkit/sysroots/armv7ahf-neon-linux-gnueabi"


Based on bpf-next/master

v3..v2:
- renamed makefile.progs to makeifle.target, as more appropriate
- left only __LINUX_ARM_ARCH__ for D options for arm
- for host build - left options from KBUILD_HOST for compatibility reasons
- split patch adding c/cxx/ld flags to libbpf by modules
- moved readme change to separate patch
- added patch setting options for cross-compile
- fixed issue with option error for syscall_nrs.S,
  avoiding overlap for ccflags-y.

v2..v1:
- restructured patches order
- split "samples: bpf: Makefile: base progs build on Makefile.progs"
  to make change more readable. It added couple nice extra patches.
- removed redundant patch:
  "samples: bpf: Makefile: remove target for native build"
- added fix:
  "samples: bpf: makefile: fix cookie_uid_helper_example obj build"
- limited -D option filter only for arm
- improved comments
- added couple instructions to verify cross compilation for arm and
  arm64 arches based on TI am57xx and am65xx sdks.
- corrected include a little order

Ivan Khoronzhuk (14):
  samples: bpf: makefile: fix HDR_PROBE "echo"
  samples: bpf: makefile: fix cookie_uid_helper_example obj build
  samples: bpf: makefile: use --target from cross-compile
  samples: bpf: use own EXTRA_CFLAGS for clang commands
  samples: bpf: makefile: use __LINUX_ARM_ARCH__ selector for arm
  samples: bpf: makefile: drop unnecessarily inclusion for bpf_load
  samples: bpf: add makefile.target for separate CC target build
  samples: bpf: makefile: base target programs rules on Makefile.target
  samples: bpf: makefile: use own flags but not host when cross compile
  samples: bpf: makefile: use target CC environment for HDR_PROBE
  libbpf: makefile: add C/CXX/LDFLAGS to libbpf.so and test_libpf
    targets
  samples: bpf: makefile: provide C/CXX/LD flags to libbpf
  samples: bpf: makefile: add sysroot support
  samples: bpf: README: add preparation steps and sysroot info

 samples/bpf/Makefile        | 179 +++++++++++++++++++++---------------
 samples/bpf/Makefile.target |  75 +++++++++++++++
 samples/bpf/README.rst      |  41 ++++++++-
 tools/lib/bpf/Makefile      |  11 ++-
 4 files changed, 225 insertions(+), 81 deletions(-)
 create mode 100644 samples/bpf/Makefile.target

-- 
2.17.1

