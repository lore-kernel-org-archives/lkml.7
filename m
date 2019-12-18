Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E660C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B8B218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLRUkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:40:05 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:39661 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRUkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:40:04 -0500
Received: by mail-qk1-f171.google.com with SMTP id c16so2738317qko.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l89ZK9pw45KPr7sU4NoYin+EzM5dKZ/KLpBAwi3U67k=;
        b=AzCBYiABPNMB7EF86TFmXJPfRqNRGvc6EmYd406Ee7HolSSTnko5YHBdZWSt/KSuWR
         JvDouMhFRkm5/R0gUE+5h7PFKZVcgRQmMSpc8UV1mTcIB6n5Qo6ApVbUffLSP/TbZgRR
         /ElENB08uL6TrqtK4ejQVn9+mCryqIl8EjSqve5gY+dt9fS3qu5rka+1OOqxvXaBxFak
         IZsqNpTUtn9j9SArv6k47/nPvmsuchvWAE2xiKYsUPLdHRI5QkDEa7zH8snHhytAKIrq
         1PRPREPnO7casn4jzetMvHQLJZutxD5O9q/s1u/pMp7nwf/MJQtLLSrYHLX9PnqXIpv0
         3XTw==
X-Gm-Message-State: APjAAAU3K9kuNIoEYLbs0Ka1YGuibouLXgBRpccx94wejqFLK9FifmlM
        KBnDsiDaaPpP5/HeM9ipu3PezaKT
X-Google-Smtp-Source: APXvYqwA2fi2pdL/IEQq2asppEpCf8iVffklKH2mPPDGC8pCmXtXt6ejHqYp9UepPxK7RWVbTBCWWA==
X-Received: by 2002:a37:8085:: with SMTP id b127mr4554792qkd.424.1576701603875;
        Wed, 18 Dec 2019 12:40:03 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t7sm993347qkm.136.2019.12.18.12.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:40:03 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 00/24] Consolidate dummy_con initialization
Date:   Wed, 18 Dec 2019 15:39:38 -0500
Message-Id: <20191218204002.30512-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series moves initialization of conswitchp to dummy_con into vt.c,
and configures DUMMY_CONSOLE unconditionally when CONFIG_VT is enabled.

The patches after the second one remove conswitchp = &dummy_con; from
the various architecture setup functions where it currently appears. If
the first two look ok, I was thinking of sending the others
individually.

Arvind Sankar (24):
  console/dummycon: Remove bogus depends on from DUMMY_CONSOLE
  vt: Initialize conswitchp to dummy_con if unset
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization
  arch/setup: Drop dummy_con initialization

 arch/alpha/kernel/setup.c             | 2 --
 arch/arc/kernel/setup.c               | 4 ----
 arch/arm/kernel/setup.c               | 2 --
 arch/arm64/kernel/setup.c             | 3 ---
 arch/c6x/kernel/setup.c               | 4 ----
 arch/csky/kernel/setup.c              | 4 ----
 arch/ia64/kernel/setup.c              | 3 ---
 arch/m68k/kernel/setup_mm.c           | 4 ----
 arch/m68k/kernel/setup_no.c           | 4 ----
 arch/m68k/sun3x/config.c              | 1 -
 arch/microblaze/kernel/setup.c        | 4 ----
 arch/mips/kernel/setup.c              | 2 --
 arch/nds32/kernel/setup.c             | 5 -----
 arch/nios2/kernel/setup.c             | 4 ----
 arch/openrisc/kernel/setup.c          | 5 -----
 arch/parisc/kernel/setup.c            | 4 ----
 arch/powerpc/kernel/setup-common.c    | 3 ---
 arch/powerpc/platforms/cell/setup.c   | 3 ---
 arch/powerpc/platforms/maple/setup.c  | 3 ---
 arch/powerpc/platforms/pasemi/setup.c | 4 ----
 arch/powerpc/platforms/ps3/setup.c    | 4 ----
 arch/riscv/kernel/setup.c             | 4 ----
 arch/s390/kernel/setup.c              | 2 --
 arch/sh/kernel/setup.c                | 4 ----
 arch/sparc/kernel/setup_32.c          | 4 ----
 arch/sparc/kernel/setup_64.c          | 4 ----
 arch/unicore32/kernel/setup.c         | 2 --
 arch/x86/kernel/setup.c               | 2 --
 arch/xtensa/kernel/setup.c            | 2 --
 drivers/tty/vt/vt.c                   | 5 +++--
 drivers/video/console/Kconfig         | 1 -
 31 files changed, 3 insertions(+), 99 deletions(-)

-- 
2.24.1

