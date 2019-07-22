Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29D2C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9D02229C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563781712;
	bh=fCm+twhupd0sfoMKl3+oPJY6FX4/EFcymfZefTFmLO8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Mvw/oga3PMB8/UgVhaJFyDdFjWEgA0uW0rETY+1ucBpdZC2zP1y/PYFoj7FcMSrj0
	 fOvjHmAasv0Sb4ltCWyVrg5ZeqwZ5p52iB0TzO7wbIRZRV1orMrYtD0krguGWnzfrL
	 +uHFFQPMCsmktmecllkoOEDK6JliOPGXXo7/4Lkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfGVHsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfGVHsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:48:31 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B96182199C;
        Mon, 22 Jul 2019 07:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563781710;
        bh=fCm+twhupd0sfoMKl3+oPJY6FX4/EFcymfZefTFmLO8=;
        h=From:To:Cc:Subject:Date:From;
        b=F8zFyZIrS/zpZQrHnC9mXaN0J0K7HeaiyybgnJ9mwyxw3fFiCElwLVA8qUy2OEfe+
         OzJ+k34UT+jduVM2DYe4wVtgUGWd03QtNcjydt4XV7KxaZFh3kF2LOK6k2XcgI7cRj
         37ibeZlJlREutUvtOi0ttksrQWxTXenUeUZysu+4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
Subject: [PATCH v2 0/4] arm64: kprobes: Fix some bugs in arm64 kprobes 
Date:   Mon, 22 Jul 2019 16:48:24 +0900
Message-Id: <156378170297.12011.17385386326930403235.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the v2 patches which fixes kprobe bugs on arm64.

Naresh reported that recently ftracetest crashes kernel, and I found
there are 3 different bugs around the crash. In v1 thread, we found
one another bug of RCU and debug exception.

- Kprobes on arm64 doesn't recover pstate.D mask after single stepping.
  This causes a real kernel crash if a kprobe is unexpectedly nested.
- Some symbols which are called from blacklisted function, are not
  blacklisted.
- Debug exception is not visible to RCU, thus rcu_read_lock() cause
  a warning inside it.
- Debug exception handlers on arm64 is using rcu_read_lock(), but
  that is not needed because interrupts are disabled.

This series includes fixes for above bugs.

Thank you,

---

Masami Hiramatsu (4):
      arm64: kprobes: Recover pstate.D in single-step exception handler
      arm64: unwind: Prohibit probing on return_address()
      arm64: Make debug exception handlers visible from RCU
      arm64: Remove unneeded rcu_read_lock from debug handlers


 arch/arm64/kernel/debug-monitors.c |   14 +++++++-----
 arch/arm64/kernel/probes/kprobes.c |   41 ++++++------------------------------
 arch/arm64/kernel/return_address.c |    4 +++-
 arch/arm64/kernel/stacktrace.c     |    3 +++
 arch/arm64/mm/fault.c              |   40 +++++++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 41 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
