Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B897C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A9D2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HJwBkM1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfICW1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 18:27:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36215 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfICW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:27:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so6160502pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TDK0yPP3UaTvpEb1rUB8fJ3YnVhy6RuZ/98K7uw4/fc=;
        b=HJwBkM1gUIyoLQcA3L83Yg22Me5qhPjoVorl/nz2aRsANwmKCBUMbzfgJ16CFP4hjd
         w9KzoH6FxY5PhXVdf8ouJQo3hK5gmzFbLBA3jgUlRNIeB244LlwZAd8ufFP0NC+zvf+5
         50xMa0Rz4gmhtaLFhJolaToJKT5l7g6Fo+sJA04CjLzIUlDH1XYOAV0M+nCUxCrwEm4b
         lyEpWzLQ77p5Fx5/4G/74O50/aA+NrzNzMrHwyNbPu5YWtsgYQFu4IIE01A85qdvfxFK
         p+X5pydbdyeQ+Ef+aTVKt6lll+DQFvECjjd6A7is+i6ZMpSD7oEzJzFS9bgI2PCVqw0y
         CMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TDK0yPP3UaTvpEb1rUB8fJ3YnVhy6RuZ/98K7uw4/fc=;
        b=pS4P+aqoQHbBvwh4EgaM98kAUYOAVHd/YZ3HDEV37tYlUtQD5QUT9cQFBn9tH5eMZ9
         PW0zWRpqVOd9d97ySsuMLHagYWs5Ar+JGO2x6I2Fsae9dTMmAzH3YYFDtGmNnu5rUvFM
         KLDmouS5+PhItSZc6ipxujGJv0WB7hEbl03WtNSfbSgZjfhEPca3L+l95cQVFHA/P4XY
         sZ6EMvgZlAilF6d9yQPF9xK3SUhhr9eWKBcvcxIms4cgUBzUoqnsEvL3YTkEhxLqt5Qi
         GNZOo/rymPclyut0BWuHONd6L4/e4mbE/NEP6HFsTHHkC+Sqazouz2r5H/NyBKi5mObT
         Zixg==
X-Gm-Message-State: APjAAAU+xwNBT3+WPnubWH90YYz/I7LxT6P+2Ufo54VYk1eNbD0Cz/Ga
        zq6qZ06HhcZVM8LpUF5phnEdDQ+yM6tiEw==
X-Google-Smtp-Source: APXvYqyCxZAyHS5bALzM5AAA/1h452WNgdmENzF8lc4UoFSzfyh0aYXJVa3SUFGrZNigtoeHcIcYLA==
X-Received: by 2002:a62:7641:: with SMTP id r62mr41163391pfc.201.1567549633023;
        Tue, 03 Sep 2019 15:27:13 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id w10sm490850pjv.23.2019.09.03.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 15:27:12 -0700 (PDT)
Date:   Tue, 03 Sep 2019 15:27:12 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Sep 2019 15:24:39 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: add support for SECCOMP and SECCOMP_FILTER
In-Reply-To: <419CB0D1-E51C-49D5-9745-7771C863462F@amacapital.net>
CC:     keescook@chromium.org, david.abdurachmanov@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, oleg@redhat.com, wad@chromium.org,
        shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        tglx@linutronix.de, allison@lohutok.net, alexios.zavras@intel.com,
        Anup Patel <Anup.Patel@wdc.com>, vincentc@andestech.com,
        alankao@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, me@carlosedp.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     luto@amacapital.net
Message-ID: <mhng-c8a768f7-1a90-4228-b654-be9e879c92ec@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 10:52:05 PDT (-0700), luto@amacapital.net wrote:
>
>
>> On Aug 25, 2019, at 2:59 PM, Kees Cook <keescook@chromium.org> wrote:
>> 
>>> On Thu, Aug 22, 2019 at 01:55:22PM -0700, David Abdurachmanov wrote:
>>> This patch was extensively tested on Fedora/RISCV (applied by default on
>>> top of 5.2-rc7 kernel for <2 months). The patch was also tested with 5.3-rc
>>> on QEMU and SiFive Unleashed board.
>> 
>> Oops, I see the mention of QEMU here. Where's the best place to find
>> instructions on creating a qemu riscv image/environment?
>
> I don’t suppose one of you riscv folks would like to contribute riscv support to virtme?  virtme-run —arch=riscv would be quite nice, and the total patch should be just a couple lines.  Unfortunately, it helps a lot to understand the subtleties of booting the architecture to write those couple lines :)

What mailing list should I sent this to?  You need to use the "virtme" branch 
of kernel.org/palmer/linux.git until I send the defconfig patches.

commit a8bd7b318691891991caea298f9a5ed0f815c322
gpg: Signature made Tue 03 Sep 2019 03:22:45 PM PDT
gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
gpg:                issuer "palmer@dabbelt.com"
gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
Author: Palmer Dabbelt <palmer@sifive.com>
Date:   Tue Sep 3 14:39:39 2019 -0700

    Add RISC-V support

    This expects a kernel with the plan 9 stuff supported (not yet in
    defconfig) and a new QEMU (as described in the README).  I'm also not
    100% sure it's working, as I'm getting

        /bin/sh: exec: line 1: /run/virtme/guesttools/virtme-init: not found

    Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

diff --git a/README.md b/README.md
index 51b6583..d53a456 100644
--- a/README.md
+++ b/README.md
@@ -112,6 +112,14 @@ PPC64

 PPC64 appears to be reasonably functional.

+RISC-V
+------
+
+riscv64 works out of the box, but you'll neet at least QEMU-4.1.0 to be
+able to run `vmlinux`-style kernels.  riscv32 is not supported because
+there are no existing userspace images for it.  Support is provided via
+QEMU's `virt` machine with OpenSBI for firmware.
+
 Others
 ------

diff --git a/virtme/architectures.py b/virtme/architectures.py
index 9871ea4..ee84494 100644
--- a/virtme/architectures.py
+++ b/virtme/architectures.py
@@ -207,6 +207,30 @@ class Arch_ppc64(Arch):
         # Apparently SLOF (QEMU's bundled firmware?) can't boot a zImage.
         return 'vmlinux'

+class Arch_riscv64(Arch):
+    def __init__(self, name):
+        Arch.__init__(self, name)
+
+        self.defconfig_target = 'riscv64_defconfig'
+        self.qemuname = 'riscv64'
+        self.linuxname = 'riscv'
+        self.gccname = 'riscv64'
+
+    def qemuargs(self, is_native):
+        ret = Arch.qemuargs(is_native)
+
+        ret.extend(['-machine', 'virt'])
+        ret.extend(['-bios', 'default'])
+
+        return ret
+
+    @staticmethod
+    def serial_console_args():
+        return ['console=ttyS0']
+
+    def kimg_path(self):
+        return 'arch/riscv/boot/Image'
+
 class Arch_sparc64(Arch):
     def __init__(self, name):
         Arch.__init__(self, name)
@@ -264,6 +288,7 @@ ARCHES = {
     'arm': Arch_arm,
     'aarch64': Arch_aarch64,
     'ppc64': Arch_ppc64,
+    'riscv64': Arch_riscv64,
     'sparc64': Arch_sparc64,
     's390x': Arch_s390x,
 }

