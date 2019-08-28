Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B4BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A8B233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJO1nrZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfH1Wz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:55:59 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:50703 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfH1Wz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:55:59 -0400
Received: by mail-qt1-f202.google.com with SMTP id i19so1369673qtq.17
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vmkPJV9jMrJwQvE5Ss1xczsiHeyIxtDKHz+ul9sH194=;
        b=HJO1nrZsxBudiwX0IFcbCagPaBiL58Z9Db3lknMALGFxTqPFuQNhfOsPS0LcmKb4nR
         Yl/4ZqLg/HU5fD04c2oa8I3+nzFZo2BSq5A+ERCQIFXHvdw60Z/5NAH1BbDlYrrVDD5R
         mYnlq23ZPHurD71eHMxnL3QUtaB/eh+G9SQzsgAWHZXYNhcXW9Kq20f9eOEkgjqy4R+K
         DB+PpUMLanLJ5LhKwT5h1dYv+xAK0F3HtIffszpK5FBz/DPFC6bUnvdus7vouBYPCUNS
         EL0FggJst2SjFH8kGqUDZIpgHJAIepph3aBkS4uIJ2abzddsJOngPZiLBmVB3jOa2mYu
         p/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vmkPJV9jMrJwQvE5Ss1xczsiHeyIxtDKHz+ul9sH194=;
        b=D+STX3lLAKslueMacvpONnBVFTk+AN/AYb/5fFB8W7FpAMBMQEzYNt9JTnExDGI9Oj
         QwJ5aQm6RUJZUSVS0v5FNoY+i9HWttZOMFboa55cOHA2x5guNS6D9haDK58gyeFGJZJX
         tpIvHW66rSPrtybntD2OqE/WjrPudHHjX6kMsqlGGCs4IkF4IE6okKuX0IgdKLTJa3co
         ZQ8O2+iq+uDk402vDMDCCm9FrVfaMdWtI6xo92KRQiiw0sJQ1rDWmmAYQNfgeLeZWmd7
         yywOPC+YcD+ALNGcyavhwj7nHaeOyyFEddA/jL9RqoA+Uy1r0gjvD5Hd6LXPlZKw3kVK
         nsqw==
X-Gm-Message-State: APjAAAUW+1GHkJnb7mLSmpY7DOOJciVKgF01m3UZ8MfbauEuANGHD7CF
        c9/2ZGXthxEbgDeq47NAwWtT22hvs9gYd6WwHVY=
X-Google-Smtp-Source: APXvYqysfLwbjmzbD9gOAVnZie0Ti1DhCPzHsryvMnnM0kTHkWPL+PJTbsy7WJLQu76O+2hiYA7VtSCkW/LRH6m5TCo=
X-Received: by 2002:a05:620a:15f4:: with SMTP id p20mr6111368qkm.303.1567032957837;
 Wed, 28 Aug 2019 15:55:57 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:21 -0700
Message-Id: <20190828225535.49592-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 00/14] treewide: prefer __section from compiler_attributes.h
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
2. Only use __attribute__((__section__(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
https://bugs.llvm.org/show_bug.cgi?id=42950
https://marc.info/?l=linux-netdev&m=156412960619946&w=2
https://github.com/ClangBuiltLinux/linux/issues/619

Changes V2 -> V3:
* s/__attribute__((__section/__attribute__((__section__ in commit
  messages as per Joe.
Changes V1 -> V2:
* drop arm64, arc, and sh patches as they were picked up by their
  maintainers.
* Split the previous V1 hunk from include/linux that touched
  include/linux/compiler.h off into its own patch for inclusion in
  stable, as it fixes a user visible issue.
* Collect Acks and Tested by tags.

Nick Desaulniers (14):
  s390/boot: fix section name escaping
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

