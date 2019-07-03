Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40081C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0971B218BE
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562186051;
	bh=X988kz2eLJEdgeKP5PbvA76wFevq0vcVQQV0GAFtt3E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZQSOB6HmUMAVEOC9D2AcH0JXZnyti4U+N6cEGLHIRmkSG+sqqn02xu04bLAsYxkLK
	 dY5cngrK+mn3LU3ZpQmueUCBbz8Zd+zVlmGS4ToyeyI2tcu/KFyHhFU4u7dO4puBor
	 Fan8fbyyiS5n+HMiXxAwwMjqropBODpjiOG64g3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfGCUeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGCUeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:34:09 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9DFA218A0;
        Wed,  3 Jul 2019 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562186048;
        bh=X988kz2eLJEdgeKP5PbvA76wFevq0vcVQQV0GAFtt3E=;
        h=From:To:Cc:Subject:Date:From;
        b=RqbH8bSaINR/QOcNfIvtJLimvQ8CZVibcFZZqbVsjvvdR41J1zNsiB02nUHP4TmBy
         rQTbbb4jTFMeSyhkgM97NghDzK80VA4VK5CYID1R6/q4FHz9r6Ho0osDB75lU0iICs
         W1OGE54XXYxwtklu+zks7NFe3EX1SHAQw4TSTqsk=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/4] x32 and compat syscall improvements
Date:   Wed,  3 Jul 2019 13:34:01 -0700
Message-Id: <cover.1562185330.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a couple of minor cleanups and a major change
to the way that x32 syscalls work.  We currently have a range of
syscall numbers starting at 512 that are rather annoying -- they've
been known to cause security problems for seccomp filter authors who
don't know about them, and they cause people to think that x86_64
will run out of syscall numbers after 511 due to a conflict with
x32.

With this series applied, 512-547 can be just a silly legacy oddity
just like all the other silly legacy oddities we have, and we can go
on with our lives without kludges starting at 548 :)

Andy Lutomirski (4):
  x86/syscalls: Use the compat versions of rt_sigsuspend() and
    rt_sigprocmask()
  x86/syscalls: Disallow compat entries for all types of 64-bit syscalls
  x86/syscalls: Split the x32 syscalls into their own table
  x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long

 arch/x86/entry/common.c                       | 13 +--
 arch/x86/entry/syscall_64.c                   | 25 ++++++
 arch/x86/entry/syscalls/syscall_32.tbl        |  4 +-
 arch/x86/entry/syscalls/syscalltbl.sh         | 35 ++++----
 arch/x86/include/asm/syscall.h                |  4 +
 arch/x86/include/asm/unistd.h                 |  6 --
 arch/x86/include/uapi/asm/unistd.h            |  2 +-
 arch/x86/kernel/asm-offsets_64.c              | 20 +++++
 tools/testing/selftests/x86/Makefile          |  2 +-
 .../testing/selftests/x86/syscall_numbering.c | 89 +++++++++++++++++++
 10 files changed, 168 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/x86/syscall_numbering.c

-- 
2.21.0

