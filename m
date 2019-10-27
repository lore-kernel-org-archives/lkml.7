Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E056ACA9EB9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 00:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A223320863
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 00:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="caY2+KFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfJ0ACt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 20:02:49 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38210 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfJ0ACt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 20:02:49 -0400
Received: by mail-il1-f195.google.com with SMTP id y5so4947767ilb.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 17:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=TkHK+LczTbJSvpWQAyXBad4CDMq6IejY7MsNk9Sty/g=;
        b=caY2+KFU6Ctu9z8FO/dJ/geKBV+ZhppvnEqO8mVA5yNfpIQQArxoZA5VG60uPUGt/w
         E1fce+mS4Dyh/f4hENE9P/dVrxCCY1zMsuGstP1+IaU3YdcQfI1scmjHQK1vl4k7VQ6T
         yrAnt5bKj5JzFpxIMbj+WaqSdl2I7AF8PwxEEAvwYiOW6n+HwegKJtVBbkmsD6KdiU+O
         +Lu7BvFhnR8M1U9bysaE97f4y+j+YAjunSnhLFRXB3jwUsUmJVERIcZbu07C0TcgVUEK
         qXoAU7zYpO2B+R7FxBwHY1yMYaVUefCmUXiHTGFYDdQbQDbcUJYKOFimegUcMt/t2T6K
         wiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=TkHK+LczTbJSvpWQAyXBad4CDMq6IejY7MsNk9Sty/g=;
        b=aQdkLVI/wdCVqPCF/gGrbwwfHvEBT+wimbwbEXPvy3sSoqMlw/MYIglOQfPERX77HR
         6SdOznBDB109VX6L90y9T+VSoqfNXGcfqiUuS5KAGcZveDf2prI3F5X8CQy5IS1E9p8s
         d2yt3qPRt2AnOrLRWzPJhmVPvwz0xnhKbPEfBWom1U6Z3kC15o52gBhxLSrxHPpD9xW8
         +0ut10Vxy502DyMAUSdCo/51ccNZU07Bqi/0jvzCPBQkA/P//A33m3NnE6HcpzbOYElS
         /pNJQLZyqgQb39/UDLqi5bRnuagKVCW/tzrul/Z7oH0OJbgnmQrhG+qF5iKPY+4jMpI/
         2E3A==
X-Gm-Message-State: APjAAAVBDvAjZvM1nGjiDN9dV/rAZy2eK2MW57BWX2P1C5PPtfw6KTqu
        DbXYrvWfT/X8/jIz+kXTaPPImA==
X-Google-Smtp-Source: APXvYqwBFcwr9ysVivTLsXhBPD6G/eWIDo2HBJjBtPIHRJ1UA+yXrdjjoZvrwZmwMnw4jGBGPmrOeQ==
X-Received: by 2002:a92:1f44:: with SMTP id i65mr12227031ile.123.1572134566763;
        Sat, 26 Oct 2019 17:02:46 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id t74sm898683ili.17.2019.10.26.17.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 17:02:46 -0700 (PDT)
Date:   Sat, 26 Oct 2019 17:02:43 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v5.4-rc5
Message-ID: <alpine.DEB.2.21.9999.1910261701250.12828@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc5-b

for you to fetch changes up to e8f44c50dfe75315d1ff6efc837d62cbe7368c9b:

  riscv: cleanup do_trap_break (2019-10-25 16:32:38 -0700)

----------------------------------------------------------------
RISC-V updates for v5.4-rc5

Several minor fixes and cleanups for v5.4-rc5:

- Three build fixes for various SPARSEMEM-related kernel configurations

- Two cleanup patches for the kernel bug and breakpoint trap handler code

----------------------------------------------------------------
Christoph Hellwig (2):
      riscv: cleanup <asm/bug.h>
      riscv: cleanup do_trap_break

David Abdurachmanov (1):
      riscv: fix fs/proc/kcore.c compilation with sparsemem enabled

Kefeng Wang (2):
      riscv: Fix implicit declaration of 'page_to_section'
      riscv: Fix undefined reference to vmemmap_populate_basepages

 arch/riscv/include/asm/bug.h     | 16 +++-------------
 arch/riscv/include/asm/pgtable.h |  7 +------
 arch/riscv/kernel/traps.c        | 26 ++++++--------------------
 arch/riscv/mm/init.c             |  2 +-
 4 files changed, 11 insertions(+), 40 deletions(-)
