Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33EFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF53521928
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IEZZ4Tea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732948AbfJXW6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:58:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43285 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfJXW6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:58:51 -0400
Received: by mail-io1-f66.google.com with SMTP id c11so189318iom.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LUBTpk9ooV35xQmJoHGn2mN1fpHGsBmiJOBvpI0fOq4=;
        b=IEZZ4TeaPYu9KusTwoj7WfdPn1cK9KTxR4CsgVIUWzNM7sVDrk3QIl2JqN9AP1q0fD
         mQXxqZpLv+F4Ydq+wQp+MJN/9hawT5YJAt+K9tIz6QieiXo0WvRn8I3QJPxmkUA/T0hn
         cpV5d5m4J3wPcN2XdvKbdGsqTagFTIPB8b/3uzjMERWxapHtaBLtmCNwGpnmZdsLLejh
         FhVD6WbH5LS1wKsH4UWrLuZQ27dBPSyLar0UMkbAufifbBJb9MamMy0Jjn3rcFBLSNp8
         ZhWEIPwBzFvS5cxxxuHtZWn7eq8Y7pAtrgiUUXBzQ66D4OswlcQgnNug4JdMNlAxil2E
         aWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LUBTpk9ooV35xQmJoHGn2mN1fpHGsBmiJOBvpI0fOq4=;
        b=nNdi/dAYX2NXt1vMjw7YhyAd+oH+Dt5aqiwrwjVrxqBvSO6tH4YmYyscKTH2n/3KOx
         vY13dXfq9X3MVZzxuWJb5FKDNVnALrRH721qbUgbGD6Epm615NHEjRdXiHs+mhJpgpfX
         hjCjWx3EauUS2R1LtqulufXXhYVZxEdV4kY7UbTYn2Rz9rjHEzn5OHLp/zHRW0EBZCAb
         tq4vwSOS/lphnIn1NuWBL63n1tyWQwpW1OrRC0vLcD13A2JAii79dMldOTUptNPPdMoH
         D1a5JZueOGNGP4AbBzJSsHy9kVgmF7pEdIVtX88mR1BLABpffWw8wqZjtKIhj+5/RR4D
         UQ8A==
X-Gm-Message-State: APjAAAUAD3HYCotWNFPS0ENzgiTKXiTuhQW4FPw8iifyNjxBxCzVkP5C
        KrPcuzOgm0Noi1hjxz8mnwHqcw==
X-Google-Smtp-Source: APXvYqxalK2YIo83Fu+BbBhgGuXezPvIjtKCSmn+b8821E2LzS3kdbtWvqRZW1DApkW9NtiE75wsTw==
X-Received: by 2002:a5d:8d0e:: with SMTP id p14mr637597ioj.4.1571957928395;
        Thu, 24 Oct 2019 15:58:48 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id b18sm58112ilo.70.2019.10.24.15.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:58:47 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.dev, greentime.hu@sifive.com,
        luc.vanoostenryck@gmail.com
Subject: [PATCH v4 0/8] riscv: resolve most warnings from sparse
Date:   Thu, 24 Oct 2019 15:58:32 -0700
Message-Id: <20191024225838.27743-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.24.0.rc0
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

This fourth version drops some patches that were in the previous
versions, and restructures some of what was left.  Much of this was
based on feedback from Christoph Hellwig <hch@lst.de>, Luc Van
Oostenryck <luc.vanoostenryck@gmail.com>, and Greentime Hu
<greentime.hu@sifive.com>.

Applies on the current riscv fixes branch, which itself is based on
v5.4-rc5.  Tested on RV32 QEMU, RV64 QEMU, and the SiFive HiFive
Unleashed board.


- Paul


Paul Walmsley (6):
  riscv: add prototypes for assembly language functions from head.S
  riscv: init: merge split string literals in preprocessor directive
  riscv: mark some code and data as file-static
  riscv: add missing header file includes
  riscv: fp: add missing __user pointer annotations
  riscv: for C functions called only from assembly, mark with __visible

Kernel object size difference:
   text	   data	    bss	    dec	    hex	filename
6662533	2136168	 312608	9111309	 8b070d	vmlinux.rv64.orig
6662537	2136160	 312608	9111305	 8b0709	vmlinux.rv64.patched
6443041	1792976	 255184	8491201	 8190c1	vmlinux.rv32.orig
6443021	1792968	 255184	8491173	 8190a5	vmlinux.rv32.patched

 arch/riscv/include/asm/irq.h        |  3 +++
 arch/riscv/include/asm/switch_to.h  |  1 +
 arch/riscv/kernel/cpufeature.c      |  1 +
 arch/riscv/kernel/head.h            | 21 +++++++++++++++++++++
 arch/riscv/kernel/irq.c             |  2 +-
 arch/riscv/kernel/module-sections.c |  1 +
 arch/riscv/kernel/process.c         |  2 ++
 arch/riscv/kernel/ptrace.c          |  4 ++--
 arch/riscv/kernel/reset.c           |  1 +
 arch/riscv/kernel/setup.c           |  2 ++
 arch/riscv/kernel/signal.c          |  8 ++++----
 arch/riscv/kernel/smp.c             |  2 ++
 arch/riscv/kernel/smpboot.c         |  5 ++++-
 arch/riscv/kernel/syscall_table.c   |  1 +
 arch/riscv/kernel/time.c            |  1 +
 arch/riscv/kernel/traps.c           |  5 +++--
 arch/riscv/kernel/vdso.c            |  3 ++-
 arch/riscv/mm/context.c             |  1 +
 arch/riscv/mm/fault.c               |  2 ++
 arch/riscv/mm/init.c                |  5 +++--
 arch/riscv/mm/sifive_l2_cache.c     |  2 +-
 21 files changed, 59 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/kernel/head.h

-- 
2.24.0.rc0

