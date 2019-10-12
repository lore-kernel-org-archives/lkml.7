Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13608C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 20:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF4D205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 20:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DlKXNXRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfJLUKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 16:10:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35561 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbfJLUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 16:10:54 -0400
Received: by mail-io1-f66.google.com with SMTP id q10so28786313iop.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 13:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=w4/POuTWUDiZtOhUix11luXG+xnY9Yx35d0vIUWcKFE=;
        b=DlKXNXRs6QgShbGdEn/kZP9ek6vlfp+9Nkuj/VBQgO+gM4l1hR8CavApjGkyY44uat
         pxuov27CpBZx6QF+yN89kE5WZsIvZF6HOJbrdBxJAEcWA8WlZ0JwgM2xyOGRmZ+f3yoO
         muTjP6sSWHS2jRsxzt6f8KgsgXGPUQ6ZrDvfps5AEdo8EalcNhGVh8qvEA2/s7mlpZAL
         KbK7RNuLPha9WCvf2WmcqGm5ipkFzRw3bydc4oyIMi4GSnEF6+ikVdTLWdFEYyjRJMFv
         AAzEo8Xqt2cQrZhnC7eYQKX4WTdFL8onI+HDqc+SNdYJhqw7l5m1gz4j0W9oB3FhrrAq
         aQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=w4/POuTWUDiZtOhUix11luXG+xnY9Yx35d0vIUWcKFE=;
        b=snMFl7MiJdb9xBZ2GTXfzSiJ5fMj+ctnjhWEO7cwUIg+NJNSjXl61+Kj6CVeifgxSC
         oZNQRVHj7zij+C9oqVvynk/nzXDwYjsbyEoVo9I0Qg377MnygmVrqAI8xfcr6V1PV81o
         GeuoN1safGvChQlG3Wm93kl60yt0sLj8vWbmLKz3Id06buGF9USZGluWzRXtXhrbvoxt
         4L6fiJVb1dqkZBm9GxZErVpbgI/+tSs8HheqGkfT1dH2pIIWWMUU7YDPHNptGi3EDX50
         QjjCy2HqDtxi44IBspfUALUALWI/wTpJDO/tfMhI8ay5auA4JnAUFOXiyu7NCke3eRbW
         hZmQ==
X-Gm-Message-State: APjAAAUXaamEXBp1VqHpCAgbbcvxFxcJt7uSIQ2EZ54L3nZaB0oT5073
        B1Dy4HKd8HcHuFDXhU4XjLtZmmCDm7Y=
X-Google-Smtp-Source: APXvYqzmy+Sa3CxJDUMcVmYUrwvMkOknIMN4j2mDR0wZZEvzVGV/iFzMbPM39F1SIqcWA3tPPVvPHw==
X-Received: by 2002:a6b:7609:: with SMTP id g9mr4529225iom.130.1570911053230;
        Sat, 12 Oct 2019 13:10:53 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id a14sm9138006ioo.85.2019.10.12.13.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 13:10:52 -0700 (PDT)
Date:   Sat, 12 Oct 2019 13:10:52 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v5.4-rc3
Message-ID: <alpine.DEB.2.21.9999.1910121307270.18026@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc3

for you to fetch changes up to cd9e72b80090a8cd7d84a47a30a06fa92ff277d1:

  RISC-V: entry: Remove unneeded need_resched() loop (2019-10-09 16:48:27 -0700)

----------------------------------------------------------------
RISC-V updates for v5.4-rc3

Some RISC-V fixes for v5.4-rc3:

- Fix several bugs in the breakpoint trap handler

- Drop an unnecessary loop around calls to preempt_schedule_irq()

----------------------------------------------------------------
Valentin Schneider (1):
      RISC-V: entry: Remove unneeded need_resched() loop

Vincent Chen (3):
      riscv: avoid kernel hangs when trapped in BUG()
      riscv: avoid sending a SIGTRAP to a user thread trapped in WARN()
      riscv: Correct the handling of unexpected ebreak in do_trap_break()

 arch/riscv/kernel/entry.S |  3 +--
 arch/riscv/kernel/traps.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

