Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD17C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B419B2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="QMNp5d8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbfFYQMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:12:54 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:28063 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731629AbfFYQMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sAAsGr5aya7rHncrNbs1gvq6cIgrrMYiXY3ywGrXYhQ=; b=QMNp5d8cwIP5v16UkqgbU+KLuu
        wtu37K7gscVrjsH7LuRWQ/hbTe8vpYlpwsgcJMlbLVirR3xZeTfuZcbgxFdt6KmMtq2gTDfVLs0nk
        Ll7XMiZIl/h5j9O/aHcbA4p8gX0rhT7ad78w5CINqwHFuydSdyZWQRkOipGat9tdadYxi2R8lsyt4
        T4MJBZJqldvndWZT1B61gl9pGAzEwEJgKYYniNDNLvg4bV1HM8b9waNBfqpFjErMldhpRb92UeEvP
        tYWVb5t8rYkf5EjEik0q7oWCcY4/RTVtq8yZYVFmEayQHOJ+DtD9yatQP+wLFQKr6KDpK4nT9kjm9
        yLzldqXQ==;
Received: from [10.7.4.141] (port=44632 helo=cello.cs.msu.ru)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hfo3E-0006Uf-70; Tue, 25 Jun 2019 19:12:08 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Vladimir D. Seleznev" <vseleznv@altlinux.org>,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, Arseny Maslennikov <ar@cs.msu.ru>
Date:   Tue, 25 Jun 2019 19:11:46 +0300
Message-Id: <20190625161153.29811-1-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 10.7.4.141
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH v2 0/7] TTY Keyboard Status Request
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces TTY keyboard status request, a feature of
the n_tty line discipline that reserves a character in struct termios
(^T by default) and reacts to it by printing a short informational line
to the terminal and sending a Unix signal to the tty's foreground
process group. The processes may, in response to the signal, output a
textual description of what they're doing.

The feature has been present in a similar form at least in
Free/Open/NetBSD; it would be nice to have something like this in Linux
as well. There is an LKML thread[1] where users have previously
expressed the rationale for this.

The current implementation does not break existing kernel API in any
way, since, fortunately, all the architectures supported by the kernel
happen to have at least 1 free byte in the termios control character
array.

The series should cleanly apply to tty-next.

To thoroughly test these, one might need at least a patched stty among
other tools, so I've brought up a simple initrd generator[2] which can
be used to create a lightweight environment to boot up in a VM and to
fiddle with.

[1] https://lore.kernel.org/lkml/1415200663.3247743.187387481.75CE9317@webmail.messagingengine.com/
[2] https://github.com/porrided/tty-kb-status-userspace

v2 <- v1: removed useless debugging bits.

Discussion of v1:
https://lore.kernel.org/lkml/20190605081906.28938-1-ar@cs.msu.ru/

Arseny Maslennikov (7):
  signal.h: Define SIGINFO on all architectures
  tty: termios: Reserve space for VSTATUS in .c_cc
  n_tty: Send SIGINFO to fg pgrp on status request character
  linux/signal.h: Ignore SIGINFO by default in new tasks
  tty: Add NOKERNINFO lflag to termios
  n_tty: ->ops->write: Cut core logic out to a separate function
  n_tty: Provide an informational line on VSTATUS receipt

 arch/alpha/include/asm/termios.h         |   4 +-
 arch/alpha/include/uapi/asm/termbits.h   |   2 +
 arch/arm/include/uapi/asm/signal.h       |   1 +
 arch/h8300/include/uapi/asm/signal.h     |   1 +
 arch/ia64/include/asm/termios.h          |   4 +-
 arch/ia64/include/uapi/asm/signal.h      |   1 +
 arch/ia64/include/uapi/asm/termbits.h    |   2 +
 arch/m68k/include/uapi/asm/signal.h      |   1 +
 arch/mips/include/asm/termios.h          |   4 +-
 arch/mips/include/uapi/asm/signal.h      |   1 +
 arch/mips/include/uapi/asm/termbits.h    |   2 +
 arch/parisc/include/asm/termios.h        |   4 +-
 arch/parisc/include/uapi/asm/signal.h    |   1 +
 arch/parisc/include/uapi/asm/termbits.h  |   2 +
 arch/powerpc/include/asm/termios.h       |   4 +-
 arch/powerpc/include/uapi/asm/signal.h   |   1 +
 arch/powerpc/include/uapi/asm/termbits.h |   2 +
 arch/s390/include/asm/termios.h          |   4 +-
 arch/s390/include/uapi/asm/signal.h      |   1 +
 arch/sparc/include/asm/termios.h         |   4 +-
 arch/sparc/include/uapi/asm/signal.h     |   2 +
 arch/sparc/include/uapi/asm/termbits.h   |   2 +
 arch/x86/include/uapi/asm/signal.h       |   1 +
 arch/xtensa/include/uapi/asm/signal.h    |   1 +
 arch/xtensa/include/uapi/asm/termbits.h  |   2 +
 drivers/tty/Makefile                     |   3 +-
 drivers/tty/n_tty.c                      |  70 ++++-
 drivers/tty/n_tty_status.c               | 337 +++++++++++++++++++++++
 include/asm-generic/termios.h            |   4 +-
 include/linux/sched.h                    |   7 +
 include/linux/signal.h                   |   5 +-
 include/linux/tty.h                      |   7 +-
 include/uapi/asm-generic/signal.h        |   1 +
 include/uapi/asm-generic/termbits.h      |   2 +
 34 files changed, 457 insertions(+), 33 deletions(-)
 create mode 100644 drivers/tty/n_tty_status.c

-- 
2.20.1

