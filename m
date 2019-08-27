Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0679AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A9B20656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdNIo6KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfH0UkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:40:23 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45061 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfH0UkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:40:22 -0400
Received: by mail-pf1-f201.google.com with SMTP id w16so219188pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3W7eRAky0SO34aDoGgthEg6qM+hmUITULPqAHpZ+WVQ=;
        b=tdNIo6KMBjKj09xYN83R42tUyenUSk79tqoWrH+L32PpOgekzlVxkU6jYrQWoPCVWb
         Zq9ds3S1lD2jg5vvy9PU2rxQzSReXxw0m2SpDwzrrZCvqnVaKMmu22BkvHd8oXrmzBq6
         fs5Uk4TLHBuSp5mUAla8zjl9vK17cveIMUrAAkFyCchx1KQ/yFlbQ6beYzw/rFDn0VRB
         1jaKoT/p2Z+DN41ppThoj3dIXLkvSW1Ti1nHulHiT/ZlOGqgDiUyiJpTomlO+7WsxEc5
         QjDNFrqaSx9D5ep7+VPY8mE5VniTUl+usjV9iQrRjduqRJyBvVjhi7nRa2MAeUxg8taE
         9C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3W7eRAky0SO34aDoGgthEg6qM+hmUITULPqAHpZ+WVQ=;
        b=jsd1t1PNQBH6F93ZCHUy+5WryBMEPGDm6f9wvJR1C7IW3ZaE5ztKh7MekbtPCMLXo8
         raFhhYELKSWulmSqEpZ/rRowTU3MNUg1KTsrKwmi7Z08mJxYAUB80SR0pkW7sdkLJcyR
         o95eHF/OapmILjG753T+2/0IStEPHrXJm6Oaglds4OSDBRfWEfDOfQuHvTXNrYsRl/Re
         e/unv3TYQ6XFLOWTxLzNFeY+kfTAe2mOIJbI3YQlwgAYoFxK5I7gfOhguKkwzn16C4S4
         89KSHUkEN5f2ay6PeKt3HLW+fl/7kp2hmVFkzVwxzUdSDP2f5hfLINCWgKvB35DNVZsR
         wxPw==
X-Gm-Message-State: APjAAAWqgj7mzQIY5Ei7b17QnTKVq0TR1SGMkCXsMN2b65ipXsoygKl4
        wa8riSoGPm3Ym1adDnOOrfgnPURFR2QLU93gdGI=
X-Google-Smtp-Source: APXvYqyVYP5whNbD1OIELSHVxc7PExTeOyZPFG6GBDxaQlbHXg6RYWsDb4d3fNJugQqfbyk3h6cDayROy3YCkd8U0kE=
X-Received: by 2002:a63:d210:: with SMTP id a16mr272406pgg.77.1566938421663;
 Tue, 27 Aug 2019 13:40:21 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:39:53 -0700
Message-Id: <20190827204007.201890-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 00/14] treewide: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

This fixes an Oops observed in distro's that use systemd and not
net.core.bpf_jit_enable=1, when their kernels are compiled with Clang.

Instead, we should:
1. Prefer __section(.section_name_no_quotes).
2. Only use __attribute__((__section(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
https://bugs.llvm.org/show_bug.cgi?id=42950
https://marc.info/?l=linux-netdev&m=156412960619946&w=2

Changes V1 -> V2:
* drop arm64, arc, and sh patches as they were picked up by their
  maintainers.
* Split the previous V1 hunk from include/linux that touched
  include/linux/compiler.h off into its own patch for inclusion in
  stable, as it fixes a user visible issue.
* Collect Acks and Tested by tags.

Nick Desaulniers (14):
  s390/boot: prefer __section from compiler_attributes.h
  include/linux/compiler.h: prefer __section from compiler_attributes.h
  parisc: prefer __section from compiler_attributes.h
  um: prefer __section from compiler_attributes.h
  ia64: prefer __section from compiler_attributes.h
  arm: prefer __section from compiler_attributes.h
  mips: prefer __section from compiler_attributes.h
  sparc: prefer __section from compiler_attributes.h
  powerpc: prefer __section and __printf from compiler_attributes.h
  x86: prefer __section from compiler_attributes.h
  include/asm-generic: prefer __section from compiler_attributes.h
  include/linux: prefer __section from compiler_attributes.h
  include/linux/compiler.h: remove unused KENTRY macro
  compiler_attributes.h: add note about __section

 arch/arm/include/asm/cache.h          |  2 +-
 arch/arm/include/asm/mach/arch.h      |  4 ++--
 arch/arm/include/asm/setup.h          |  2 +-
 arch/ia64/include/asm/cache.h         |  2 +-
 arch/mips/include/asm/cache.h         |  2 +-
 arch/parisc/include/asm/cache.h       |  2 +-
 arch/parisc/include/asm/ldcw.h        |  2 +-
 arch/powerpc/boot/main.c              |  3 +--
 arch/powerpc/boot/ps3.c               |  6 ++----
 arch/powerpc/include/asm/cache.h      |  2 +-
 arch/powerpc/kernel/btext.c           |  2 +-
 arch/s390/boot/startup.c              |  2 +-
 arch/sparc/include/asm/cache.h        |  2 +-
 arch/sparc/kernel/btext.c             |  2 +-
 arch/um/kernel/um_arch.c              |  6 +++---
 arch/x86/include/asm/cache.h          |  2 +-
 arch/x86/include/asm/intel-mid.h      |  2 +-
 arch/x86/include/asm/iommu_table.h    |  5 ++---
 arch/x86/include/asm/irqflags.h       |  2 +-
 arch/x86/include/asm/mem_encrypt.h    |  2 +-
 arch/x86/kernel/cpu/cpu.h             |  3 +--
 include/asm-generic/error-injection.h |  2 +-
 include/asm-generic/kprobes.h         |  5 ++---
 include/linux/cache.h                 |  6 +++---
 include/linux/compiler.h              | 31 ++++-----------------------
 include/linux/compiler_attributes.h   | 10 +++++++++
 include/linux/cpu.h                   |  2 +-
 include/linux/export.h                |  2 +-
 include/linux/init_task.h             |  4 ++--
 include/linux/interrupt.h             |  5 ++---
 include/linux/sched/debug.h           |  2 +-
 include/linux/srcutree.h              |  2 +-
 32 files changed, 54 insertions(+), 74 deletions(-)

-- 
2.23.0.187.g17f5b7556c-goog

