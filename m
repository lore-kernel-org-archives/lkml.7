Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A79CC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6725C2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH0Xe3ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390399AbfIDSS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:18:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36652 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388655AbfIDSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:18:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id p13so4932231wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=a60ULgjhRJwtOcZucq6GxVwzE7uulnTGYLh+jeez4GU=;
        b=RH0Xe3kiql/ZgfuttY+zTE4+tdinewbznVJJV8YRqDCa8ofnsvnmjNlCMm/vTZ5ziH
         NsSkquQcfMix6d+6UIHqr594WQAK1bzJt0kpYMwIg9IPFXOGkW/rrMEVwJVskigKV36h
         EkhngaZk4er6n8jfPUkgQh8aJX7DDQNnbt+5j5sy+dcD2BBhX+eCMkIcv+0LADxN55LQ
         8yJALzZDdBSf0ypiKdijRlf5ntrrWN1hZARfN6Qb91yUGoCcaYAIMq+O/7SPtVyfnEQK
         +C2arNPECRmUGDAbEb7K4sfoTm38h1/Jembz2boB7VmQzXLQY4X5BGQFnDrOUT6cxfFI
         /hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=a60ULgjhRJwtOcZucq6GxVwzE7uulnTGYLh+jeez4GU=;
        b=su3qNjoDtCoKdMTJngyLk0FLN5Wpesy5lycAaGLxYHRgHMUfFRO5jYTWy3QKvN3YWL
         5dyA7kYgpZdqudZ22UV2M0UxY/Dwm0x6jBY7zFFIzo9aV4VAqv41wrZCCB/XNdaN9Q1U
         CqMR7N0cRdRLYwAiDEfvY9gd+qzQ1yqI0hI5FSZd4j8ECJfrH0Pn6YXpIXjY0bo6OHKx
         4ShrvR1sqLiSCvy9pCNZo8I3bH70+2xir/JucGUpUmxYp9lqhY6IOmxVl7S+v0OScydy
         5S+vnkNIDFMPL2vtKx+HNAvT3sbUltcSWiE1OlZ+z3+ohycTTmx93qAz0VqYnAERJIu6
         KHqQ==
X-Gm-Message-State: APjAAAVooSakZwmPmwP/lIf82KQynfupskU+NWfE9GWQq2CAR4uOZtoa
        sAxhrVyYgTZOgzlEpv7Nd6I=
X-Google-Smtp-Source: APXvYqzHzxKAanNYZpybYtun3jZIblreKYjTz8wBsbjxGBBc2Sucv6Ll3F/oZv9DwUftXNKn1PJ1sA==
X-Received: by 2002:a05:600c:20c2:: with SMTP id y2mr5850269wmm.68.1567621102363;
        Wed, 04 Sep 2019 11:18:22 -0700 (PDT)
Received: from gmail.com ([157.230.19.186])
        by smtp.gmail.com with ESMTPSA id f66sm4519932wmg.2.2019.09.04.11.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 11:18:21 -0700 (PDT)
Date:   Wed, 4 Sep 2019 20:18:13 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] compiler-attributes for v5.3-rc8
Message-ID: <20190904181740.GA19688@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I was going to send this for 5.4 since it is not that trivial, but since
you are doing an -rc8, and it fixes an oops, please consider pulling it.

Cheers,
Miguel

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.3-rc8

for you to fetch changes up to c4814af0b75cc6856f60e8a658d829000b156729:

  compiler_attributes.h: add note about __section (2019-08-30 00:56:19 +0200)

----------------------------------------------------------------
__section cleanup that also fixes an Oops (Nick Desaulniers)

    GCC unescapes escaped string section names while Clang does not. Because
    __section uses the `#` stringification operator for the section name, it
    doesn't need to be escaped.

    This fixes an Oops observed in distro's that use systemd and not
    net.core.bpf_jit_enable=1, when their kernels are compiled with Clang.

----------------------------------------------------------------
Nick Desaulniers (13):
      s390/boot: fix section name escaping
      include/linux/compiler.h: prefer __section from compiler_attributes.h
      parisc: prefer __section from compiler_attributes.h
      um: prefer __section from compiler_attributes.h
      ia64: prefer __section from compiler_attributes.h
      arm: prefer __section from compiler_attributes.h
      mips: prefer __section from compiler_attributes.h
      sparc: prefer __section from compiler_attributes.h
      x86: prefer __section, __maybe_unused and __aligned from compiler_attributes.h
      include/asm-generic: prefer __section from compiler_attributes.h
      include/linux: prefer __section and __aligned from compiler_attributes.h
      include/linux/compiler.h: remove unused KENTRY macro
      compiler_attributes.h: add note about __section

 arch/arm/include/asm/cache.h          |  2 +-
 arch/arm/include/asm/mach/arch.h      |  4 ++--
 arch/arm/include/asm/setup.h          |  2 +-
 arch/ia64/include/asm/cache.h         |  2 +-
 arch/mips/include/asm/cache.h         |  2 +-
 arch/parisc/include/asm/cache.h       |  2 +-
 arch/parisc/include/asm/ldcw.h        |  2 +-
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
 include/linux/compiler.h              | 31 ++++---------------------------
 include/linux/compiler_attributes.h   | 10 ++++++++++
 include/linux/cpu.h                   |  2 +-
 include/linux/export.h                |  2 +-
 include/linux/init_task.h             |  4 ++--
 include/linux/interrupt.h             |  5 ++---
 include/linux/sched/debug.h           |  2 +-
 include/linux/srcutree.h              |  2 +-
 28 files changed, 49 insertions(+), 66 deletions(-)
