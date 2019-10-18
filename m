Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743FDCA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4749021852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GYOLJ/hG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407189AbfJRAtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:49:47 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35885 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfJRAtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:49:46 -0400
Received: by mail-il1-f193.google.com with SMTP id z2so3955106ilb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jFfZXZiKtRiLwkH3KZouo9ewXcERlfI4Qt0T9yHG1+Y=;
        b=GYOLJ/hGsqg9L3+YH0VojwgZ7sJyAI9IvNkUYkqm6vEr18NHeVtIC9WtuUVPWo89lN
         qpd9aqBAqBhN233DhZ+UUlG4OV7cCA05fb3AZQiE7KXgQdQyjlg311F4avHOGlcHh6gU
         vCRxfTR1WZCHhIkSDL4zD56KWMQKrbY9JYXaOvx4rT96hnd0ImbqmNUKxpEnKgwSDGpY
         vzzYu8QQ7+KWP/J77A80k+nqodwhb5WVvdCM5o1DwFlNR39tW0yKiBhEXeNCOFl5/2kb
         0yaq6YiaRLKg0RjzRYueXp5yKqZulygbYoAwqISUpKMyAxhDnutwMMVSpHso7KwxZFi5
         BntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jFfZXZiKtRiLwkH3KZouo9ewXcERlfI4Qt0T9yHG1+Y=;
        b=GjCr44kCeGC4nzJEeZyWuKCpiHzu/RHm0J/D8hDU1nfECbymYB1sHFzqGxDekbULMD
         EXILg1HZfeNAZKJHAaH9UMB8Tuf36O6z9jzq54HSGbgxS2vgK+KgnfSCZlZ1sNWHP/GX
         toqBmt+N08o3CHQnXo15iSoPQ/WbMqCC7UZDlJOShWnewwYs/dHSC7f4AWQzkkbo3sqE
         XqCTWkmI0anBnkaZ7oy49jEoFdPVzNhTqEdFvmzLZgvlg2of3LGSZGhKqfk6yEd3bmSt
         BlsP+5HJt54x8+HYpvsXTFwCdAgRjKYzLZV3Dm+36CJHR6bHff7q8ROXFhUS5jSBWt57
         Bu0Q==
X-Gm-Message-State: APjAAAVOswqkRlLdVVHjUka2kdF6HZFoVlickUR+bWZFYzqhCRttQhBH
        UEtw4Q8AscMfMXmHazRQotKeBZp+HH4=
X-Google-Smtp-Source: APXvYqwyrG116vwg8myi/qv9m0/GlzNq94ku4zq8HETmqKe/a0qZ85AOPQzXEPT3HCudMAel6Z7Ayg==
X-Received: by 2002:a92:c60f:: with SMTP id p15mr7450539ilm.19.1571359785740;
        Thu, 17 Oct 2019 17:49:45 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z20sm1493891iof.38.2019.10.17.17.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:49:45 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] riscv: resolve most warnings from sparse
Date:   Thu, 17 Oct 2019 17:49:21 -0700
Message-Id: <20191018004929.3445-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve most warnings from the 'sparse' static analysis tool for the
arch/riscv codebase.  This makes life easier for us as maintainers,
and makes it easier for developers to use static analysis tools on
their own changes.

This patch series incorporates some changes based on feedback from
Christoph Hellwig <hch@lst.de>.

Applies on the current riscv fixes branch that is based on v5.4-rc3.


- Paul


Paul Walmsley (8):
  riscv: add prototypes for assembly language functions from entry.S
  riscv: add prototypes for assembly language functions from head.S
  riscv: init: merge split string literals in preprocessor directive
  riscv: ensure RISC-V C model definitions are passed to static
    analyzers
  riscv: add missing prototypes
  riscv: mark some code and data as file-static
  riscv: add missing header file includes
  riscv: fp: add missing __user pointer annotations

Kernel object size difference:
   text	   data     bss	    dec	    hex	filename
6664206 2136568  312608 9113382  8b0f26	vmlinux.orig
6664186 2136552	 312608 9113346  8b0f02	vmlinux.patched

 arch/riscv/Makefile                 |  2 ++
 arch/riscv/include/asm/irq.h        |  6 ++++++
 arch/riscv/include/asm/pgtable.h    |  2 ++
 arch/riscv/include/asm/processor.h  |  4 ++++
 arch/riscv/include/asm/ptrace.h     |  4 ++++
 arch/riscv/include/asm/smp.h        |  2 ++
 arch/riscv/include/asm/switch_to.h  |  1 +
 arch/riscv/kernel/cpufeature.c      |  1 +
 arch/riscv/kernel/entry.h           | 29 +++++++++++++++++++++++++++++
 arch/riscv/kernel/head.h            | 21 +++++++++++++++++++++
 arch/riscv/kernel/module-sections.c |  1 +
 arch/riscv/kernel/process.c         |  2 ++
 arch/riscv/kernel/reset.c           |  1 +
 arch/riscv/kernel/setup.c           |  2 ++
 arch/riscv/kernel/signal.c          |  6 ++++--
 arch/riscv/kernel/smp.c             |  2 ++
 arch/riscv/kernel/smpboot.c         |  3 +++
 arch/riscv/kernel/stacktrace.c      |  6 ++++--
 arch/riscv/kernel/syscall_table.c   |  1 +
 arch/riscv/kernel/time.c            |  1 +
 arch/riscv/kernel/traps.c           |  2 ++
 arch/riscv/kernel/vdso.c            |  3 ++-
 arch/riscv/mm/context.c             |  1 +
 arch/riscv/mm/fault.c               |  2 ++
 arch/riscv/mm/init.c                | 17 ++++++++++-------
 arch/riscv/mm/sifive_l2_cache.c     |  2 +-
 26 files changed, 111 insertions(+), 13 deletions(-)
 create mode 100644 arch/riscv/kernel/entry.h
 create mode 100644 arch/riscv/kernel/head.h

-- 
2.23.0

