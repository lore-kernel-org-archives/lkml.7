Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C295FCA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9392089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H+ZDs2XY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504963AbfJRIIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:08:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32859 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfJRIIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:08:50 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so6430941ior.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsOgYMSsyTjbkroAj3oOC8H18OvB8iGYAKFSlXx+BSY=;
        b=H+ZDs2XYdH0O56HX3VDXwCQVFh++q5NGu+haqRDwCYKEITTaHB8d4gMRkeoXIC7eJR
         hPkFtA7PA/lYUOO+uW/cm6Yhd+JCwdI4k8zip2AkFKOZCJbupK2V2DlIlzPsx93h3Vlp
         9srOuJ/tZx9Kr/K/k2aNXTxcy8oxiyKZD94TkzftcCLzffOo4CD4kehQPRBpknijaiKY
         rWDp0/O/p2N/5GiCXhxiKja78a3EMuypOdTwt2Dr3at0jZU+hjJ8sZ+NoF8HAnhujla5
         H55cVpgB2Di9NHoHPKj2rbGh37oBagcQZSglTzl3W+Exw7kBuTVqupoCCGkjhb82EpIf
         j8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsOgYMSsyTjbkroAj3oOC8H18OvB8iGYAKFSlXx+BSY=;
        b=RWOLleGRMvlE9yfrelHf3SL091iZBIo70K2VAPS2cemQOx1JIQEMQrR062Q3McUgFA
         woCSn/a9zl0WHoY8gH+UJmhGky0md4PhOWvXCEP8LrzTCTK133EU7MUiYZgs1NOWfX6E
         P7UKQYDz5M5zfhm+N5dYzwQYxj+COk6QDu/NNMIpP8mdohWN98MgFoK1SlSonLX7kXHq
         +bDV0a89nUKHZ02VchtAVjAljLfMYjrSSjaeF4dtA/ESR1mHlR9V4sm53oZaOOPbeJKR
         lKyVCnB3bjRgHtWk1WneMzJHr766PpvOwhtbBneFPccuRFGYQEc7WqoeBl/AE7724xzZ
         i3rw==
X-Gm-Message-State: APjAAAX4Wy+14UOZcKxnWuTP5n5KPaXYJwPzrXx4ylN45YTMWJsCXe/e
        ++6i1cf4WpF6QIdpVGK8HY/M0aBXqYE=
X-Google-Smtp-Source: APXvYqyjWXiLACNA3jdhTpVfFb8nQ3bXXxtGvxNttTT/x6HmX+quBkUlt6blvv678FE4MDtZIT7NOA==
X-Received: by 2002:a6b:5404:: with SMTP id i4mr7524183iob.204.1571386129901;
        Fri, 18 Oct 2019 01:08:49 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z86sm2121026ilf.73.2019.10.18.01.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:08:49 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] riscv: resolve most warnings from sparse
Date:   Fri, 18 Oct 2019 01:08:33 -0700
Message-Id: <20191018080841.26712-1-paul.walmsley@sifive.com>
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

This third version drops the patch that adds one of the
__riscv_cmodel* preprocessor definitions, and uses __visible for C
functions called only by assembly code - both based on some guidance
from Luc Van Oostenryck.

This patch series incorporates some changes based on feedback from
Christoph Hellwig <hch@lst.de> and Luc Van Oostenryck
<luc.vanoostenryck@gmail.com>.

Applies on the current riscv fixes branch that is based on v5.4-rc3.

- Paul


Paul Walmsley (8):
  riscv: add prototypes for assembly language functions from entry.S
  riscv: add prototypes for assembly language functions from head.S
  riscv: init: merge split string literals in preprocessor directive
  riscv: add missing prototypes
  riscv: mark some code and data as file-static
  riscv: add missing header file includes
  riscv: fp: add missing __user pointer annotations
  riscv: for C functions called only from assembly, mark with __visible

Kernel object size difference:
  text	   data	    bss	    dec	    hex	filename
6664246	2136664	 312608	9113518	 8b0fae	vmlinux.rv64.orig
6664178	2136632	 312608	9113418	 8b0f4a	vmlinux.rv64.patched
6444536	1797560	 255184	8497280	 81a880	vmlinux.rv32.orig
6444492	1797536	 255184	8497212	 81a83c	vmlinux.rv32.patched

 arch/riscv/include/asm/irq.h        |  6 ++++++
 arch/riscv/include/asm/pgtable.h    |  2 ++
 arch/riscv/include/asm/processor.h  |  4 ++++
 arch/riscv/include/asm/ptrace.h     |  2 ++
 arch/riscv/include/asm/smp.h        |  2 ++
 arch/riscv/include/asm/switch_to.h  |  1 +
 arch/riscv/kernel/cpufeature.c      |  1 +
 arch/riscv/kernel/entry.h           | 29 +++++++++++++++++++++++++++++
 arch/riscv/kernel/head.h            | 21 +++++++++++++++++++++
 arch/riscv/kernel/module-sections.c |  1 +
 arch/riscv/kernel/process.c         |  2 ++
 arch/riscv/kernel/ptrace.c          |  4 ++--
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
 26 files changed, 109 insertions(+), 15 deletions(-)
 create mode 100644 arch/riscv/kernel/entry.h
 create mode 100644 arch/riscv/kernel/head.h

-- 
2.23.0

