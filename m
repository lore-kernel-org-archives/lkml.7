Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A041C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1403D208CA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="h4Eh3owQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfFEIjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:39:06 -0400
Received: from mx.cs.msu.ru ([188.44.42.42]:50334 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbfFEIjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Px/uehKk6pJuFy+aIZjSZmKKKoFS+/3im61p33sMu30=; b=h4Eh3owQAMheBMo2vdna3mYbww
        qUnB4wwLd8cv78+2tpdWfund7vMNdBm1qqzs4C7LgiIOF4XGRCnHfOwCHFlFgqmJLAbTM9ORocQV0
        /OaVYWxMK+Djp/E64u4Ii+zHz6jJ9ctvLz1YwG1J7gTSrJmgoCpCnQtayeKhp+aSAzTYZwx6svqyK
        r/GjocoDVzlqzBN0JFAQ1/o7TzsLBuuxSj59bmV56qy9yT6qMXo2vIh/5vk5aKe6EMwnxWji+Fddg
        DJWim0OQuzdJA6HUDI+61tlrbkjRPbDlznPeC+y9OgGa1KQ0RY5NE4NWqyvJV4Kl8cTv4z/EmeIiV
        EfLOKeGw==;
Received: from [37.204.119.143] (port=55354 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1hYR9H-0008s7-ME; Wed, 05 Jun 2019 11:19:57 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Vladimir D . Seleznev" <vseleznv@altlinux.org>,
        Arseny Maslennikov <ar@cs.msu.ru>
Date:   Wed,  5 Jun 2019 11:18:59 +0300
Message-Id: <20190605081906.28938-1-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH 0/7] TTY Keyboard Status Request
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: No (on mail.cs.msu.ru); Unknown failure
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
 drivers/tty/n_tty.c                      |  69 ++++-
 drivers/tty/n_tty_status.c               | 363 +++++++++++++++++++++++
 include/asm-generic/termios.h            |   4 +-
 include/linux/signal.h                   |   5 +-
 include/linux/tty.h                      |   7 +-
 include/uapi/asm-generic/signal.h        |   1 +
 include/uapi/asm-generic/termbits.h      |   2 +
 33 files changed, 475 insertions(+), 33 deletions(-)
 create mode 100644 drivers/tty/n_tty_status.c

-- 
2.20.1

