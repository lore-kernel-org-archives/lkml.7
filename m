Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C69C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E63822CB8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564042552;
	bh=uoAtSZJrQlX16jfIHQB3k0UtB6VPqRtrikHODc87HA0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cNfs924tWNEJF8ysfICx80J/2+8iu1068txfCFfMicoG76iJ6rEP+A+1cRDPY/rcN
	 77DeYMKAxLIwdFyhd6PUNHNkTyuPQK2XdVjZjLA4v9qZAaM1FnYBQ3QgcPmH0RpPwg
	 JCtoGtZPiTs0G190OIsAvhJeq5ArZEppQnnw/HE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389257AbfGYIPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388497AbfGYIPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:15:50 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B487322BEF;
        Thu, 25 Jul 2019 08:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564042549;
        bh=uoAtSZJrQlX16jfIHQB3k0UtB6VPqRtrikHODc87HA0=;
        h=From:To:Cc:Subject:Date:From;
        b=TWgihOkdvlV5beZAg9dXWD+REvK4U7QROtCGNlgzoN4k6bkl65mhIE/R0LE9SClGp
         l9fx5+EFHylIdeaatd+v4lvFk1//NlSB4VABecBla5CWxXVhs7yZPezY1fqxtTgBeY
         zcUGM6ZOJg717D8lJPWXWUlPmeL2axadLOfdUyWw=
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
Subject: [PATCH v3 0/4] arm64: kprobes: Fix some bugs in arm64 kprobes 
Date:   Thu, 25 Jul 2019 17:15:44 +0900
Message-Id: <156404254387.2020.886452004489353899.stgit@devnote2>
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

Here are the v3 patches which fixes kprobe bugs on arm64.
In this version I fixed some issues pointed by James and add Reviewed-by
and Acked-bys.

Background:
Naresh reported that recently ftracetest crashes kernel, and I found
there are 3 different bugs around the crash. In v1 thread, we found
one another bug of RCU and debug exception.

- Kprobes on arm64 doesn't recover pstate.D mask after single stepping.
  So after hitting kprobes, the debug flag status is changed.
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


 arch/arm64/include/asm/daifflags.h |    2 ++
 arch/arm64/kernel/debug-monitors.c |   14 +++++++------
 arch/arm64/kernel/probes/kprobes.c |   39 +++++------------------------------
 arch/arm64/kernel/return_address.c |    3 +++
 arch/arm64/kernel/stacktrace.c     |    3 +++
 arch/arm64/mm/fault.c              |   40 ++++++++++++++++++++++++++++++++++++
 6 files changed, 61 insertions(+), 40 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
