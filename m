Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442F8CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 23:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51DD20640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 23:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="c+/Cz8A6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbfJRXgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 19:36:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35154 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfJRXgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 19:36:17 -0400
Received: by mail-io1-f68.google.com with SMTP id t18so5286481iog.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 16:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=bj8M5crgXS5pe7Ws6B0DEpoTTFjZ4fX9IydxSQ38V1g=;
        b=c+/Cz8A6qw3uKYGodKqQFc5z6qEWLPGgwY5JjZAGLGVEXT2Hov4diwVZa2+YkwU/NO
         hwIQ254JhbLsrr+y1K+m3ZjMolyHZZnE3p1kjKN2V67A6xHp8pW79hlCt/Uma6WOvBK6
         vrja9DnKBgku7UdqrNtrwatBRXjqWSntuLjU7xUPpcCfolYiuDbOO45qb2EAqO6J/j5N
         OfwvN6E0aVamDtLf2LCJuf1BQ1RQ17BnL/eVouRYYfQekC45p87tu+ly3MVsZfqqGSIM
         xgG0Y+AbeqO4WQ1ShaaSggMaDI/fa4unKCAQtFS8awKUm3rUfiUvcWl1Ak2lJ0klwoRr
         OpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=bj8M5crgXS5pe7Ws6B0DEpoTTFjZ4fX9IydxSQ38V1g=;
        b=ZoZsfaxQJT9Xb3qBlWnmusL19H1XbdEw0QkSkpfj5MCejd/1aEW1cvTLOlMCD9zgtF
         gsLLSjbKbUmq8CBhtRmRnUyi9UPAEvb7Anttb00Ak1DR47J0XyUz3ZXQEj5TWsdeVyZO
         Xa9kNFq19TqICKY/zXUgobzbZqticQsx12uKq7A89WWtwdVI3CXR7/FKTOdxi6Wjxi/y
         7KlZLAdNHGr94JysfgT7velrHRM2FZNMOgKnnVMFrxRjHsXxC0lhZEF2byDyJesp/0cv
         AokxQggS2FdNieVnDe9x+/MWllSwEU1vvC2HhRan6cHYwChzqn+peKGbXNDjs7wp3fYJ
         W6Pw==
X-Gm-Message-State: APjAAAUxxlAttmwxrJof0tm39s5tGIg80O9C6XqA458XCEpI6gmDvXoQ
        QPjlFfrmFzX7bkKR2QKx+Rf+6g==
X-Google-Smtp-Source: APXvYqwzjDExcfN8hf9accYZrJ5ml9DhB+vSBaeWSzRDN7u5f9VNnSCicJvyTwMGuokrdEquJxdHhQ==
X-Received: by 2002:a5d:9dcf:: with SMTP id 15mr54904ioo.83.1571441776385;
        Fri, 18 Oct 2019 16:36:16 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id r5sm3202124ill.12.2019.10.18.16.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 16:36:15 -0700 (PDT)
Date:   Fri, 18 Oct 2019 16:36:14 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v5.4-rc4
Message-ID: <alpine.DEB.2.21.9999.1910181634460.21875@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc4

for you to fetch changes up to 5bf4e52ff0317db083fafee010dc806f8d4cb0cb:

  RISC-V: fix virtual address overlapped in FIXADDR_START and VMEMMAP_START (2019-10-15 22:47:41 -0700)

----------------------------------------------------------------
RISC-V updates for v5.4-rc4

Some RISC-V fixes for v5.4-rc4:

- Fix the virtual memory layout so the fixaddr region doesn't overlap
  with other regions.  (This was originally intended to go in as part
  of an earlier patch, but I inadvertently dropped it during a
  rebase.)

- Add the DT chosen/stdout-path property to the HiFive Unleashed DT
  file.  This is so "earlycon" can be specified with no arguments on
  the kernel command line, and the correct UART will be automatically
  selected.

And two cleanup patches:

- Simplify the code in our breakpoint trap handler.

- Drop a comment in our TLB flush code that has caused some confusion.

----------------------------------------------------------------
Greentime Hu (1):
      RISC-V: fix virtual address overlapped in FIXADDR_START and VMEMMAP_START

Paul Walmsley (2):
      riscv: dts: HiFive Unleashed: add default chosen/stdout-path
      riscv: tlbflush: remove confusing comment on local_flush_tlb_all()

Vincent Chen (1):
      riscv: remove the switch statement in do_trap_break()

 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  1 +
 arch/riscv/include/asm/pgtable.h                   | 16 ++++++++--------
 arch/riscv/include/asm/tlbflush.h                  |  4 ----
 arch/riscv/kernel/traps.c                          | 22 +++++++++++-----------
 4 files changed, 20 insertions(+), 23 deletions(-)
