Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AC5C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9AB20700
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iXmF/pVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfLOUKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:10:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35565 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfLOUKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:10:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so2442298pgk.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 12:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=4oVTeaUcizdZRek2jakws5ojZHkLSM8+eDXqYTbgspk=;
        b=iXmF/pVjPzHQtbRFRjSfW8jrsAtwaiiAgq4s4q7wkV8JseHdyEWTD2FMJEbCI8iaah
         Qi/kZHESbjtzz+AHX0SWQcniiipqzHZgaT5DqCdJmXlwrY/dzAEytylEIdUJwh3b4w8V
         8BJaFIA9JnHl+5dWnqWq8DtHUfNdaBWjNKNW1sSLICM/o0tFHbIo66j8dGD42oWYrp79
         3sEaB152YysTBn/O5AURQ7vSsLCbusEfTKMv+4uMaiIV/hlcgt+TkB+MVPPt0MyDBE9W
         blx07XlveTByiQ/w8tXS8J4XFc1jV1Gcc8zPowUR4kQZ9VmOYX3JoZCkbOoacTxxtkef
         6Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=4oVTeaUcizdZRek2jakws5ojZHkLSM8+eDXqYTbgspk=;
        b=LbgHT2wznfsSG6mcrWOPYZJNynOu4Wyq5flljl4VNZNHiOrK8PKr9gMOy9OsSP0Akq
         8qurOBSqCqvkHlsCDHE2OICZVMSGG/zRKwRIPXumW0YNqFOg8fQVNWgXQTphMfI0QKfg
         Uj3bjdHmNSgq/tcIHWRphGVZGJEisLv9/HYVkvNCav8ogFIMKbhUkl7oU6LjjynyPmDr
         U0zuRMTva3V9QibRnpy9lJghy9ICWKxCuqldxeWGIhKqByvF08uFse3NHmaDcQqWr87j
         nUJU+agpnIjmydN90WQMV0jUSeMzk/V3IOXeS4//Q5V20+fCp8sCdwOC7HKTtLdCphuq
         ZeQg==
X-Gm-Message-State: APjAAAXjKRSTrtiH613mnDEH4YZjLIODNVqqVldvVMhKGcQWeE/RJ0q7
        kSZzNkym+AR2PwOaaNLcFnO/8g==
X-Google-Smtp-Source: APXvYqywrbqkJTQcPY0XPbhNZieALwwt9vPR0wqVwSChoxaOw/tpU9V4+tOjrmXuFK+Ope4J1nop6w==
X-Received: by 2002:a63:a508:: with SMTP id n8mr13494053pgf.278.1576440636218;
        Sun, 15 Dec 2019 12:10:36 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id h5sm19549500pfk.30.2019.12.15.12.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 12:10:35 -0800 (PST)
Date:   Sun, 15 Dec 2019 12:10:34 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [GIT PULL] RISC-V updates for v5.5-rc2
Message-ID: <alpine.DEB.2.21.9999.1912151208120.91169@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc2

for you to fetch changes up to bc3e8f5d42d5cfac3f7ac9b458c2eeb02e8b1cf7:

  riscv: only select serial sifive if TTY is enabled (2019-12-08 20:29:01 -0800)

----------------------------------------------------------------
RISC-V updates for v5.5-rc2

Two minor build fixes:

- Fix builds of the ELF loader when built with 'make -j1' (nommu only)

- Fix CONFIG_SOC_SIFIVE builds when CONFIG_TTY is disabled (found
  during randconfig testing)

----------------------------------------------------------------
Kefeng Wang (1):
      riscv: only select serial sifive if TTY is enabled

Olof Johansson (1):
      riscv: Fix build dependency for loader

 arch/riscv/Kconfig.socs  | 4 ++--
 arch/riscv/boot/Makefile | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Kernel object size difference:
   text	   data	    bss	    dec	    hex	filename
6894571	2330908	 313920	9539399	 918f47	vmlinux.rv64.orig
6894571	2330908	 313920	9539399	 918f47	vmlinux.rv64.patched
6655594	1939880	 257640	8853114	 87167a	vmlinux.rv32.orig
6655594	1939880	 257640	8853114	 87167a	vmlinux.rv32.patched
1172124	 354264	 130024	1656412	 19465c	vmlinux.nommu_virt.orig
1172124	 354264	 130024	1656412	 19465c	vmlinux.nommu_virt.patched

