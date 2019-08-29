Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800DDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B29221874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfH2W3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:29:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:59080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727686AbfH2W33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:29:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE9A2ACC4;
        Thu, 29 Aug 2019 22:29:27 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Breno Leitao <leitao@debian.org>,
        Russell Currey <ruscur@russell.cc>,
        Nicolai Stange <nstange@suse.de>,
        Michael Neuling <mikey@neuling.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] Disable compat cruft on ppc64le v5
Date:   Fri, 30 Aug 2019 00:28:35 +0200
Message-Id: <cover.1567117050.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Less code means less bugs so add a knob to skip the compat stuff.

This is tested on ppc64le top of

https://patchwork.ozlabs.org/cover/1153556/

Changes in v2: saner CONFIG_COMPAT ifdefs
Changes in v3:
 - change llseek to 32bit instead of builing it unconditionally in fs
 - clanup the makefile conditionals
 - remove some ifdefs or convert to IS_DEFINED where possible
Changes in v4:
 - cleanup is_32bit_task and current_is_64bit
 - more makefile cleanup
Changes in v5:
 - more current_is_64bit cleanup
 - split off callchain.c 32bit and 64bit parts

Michal Suchanek (5):
  powerpc: make llseek 32bit-only.
  powerpc: move common register copy functions from signal_32.c to
    signal.c
  powerpc/64: make buildable without CONFIG_COMPAT
  powerpc/64: Make COMPAT user-selectable disabled on littleendian by
    default.
  powerpc/perf: split callchain.c by bitness

 arch/powerpc/Kconfig                     |   5 +-
 arch/powerpc/include/asm/thread_info.h   |   4 +-
 arch/powerpc/kernel/Makefile             |   7 +-
 arch/powerpc/kernel/entry_64.S           |   2 +
 arch/powerpc/kernel/signal.c             | 144 ++++++++-
 arch/powerpc/kernel/signal_32.c          | 140 ---------
 arch/powerpc/kernel/syscall_64.c         |   6 +-
 arch/powerpc/kernel/syscalls/syscall.tbl |   2 +-
 arch/powerpc/kernel/vdso.c               |   5 +-
 arch/powerpc/perf/Makefile               |   4 +
 arch/powerpc/perf/callchain.c            | 379 +----------------------
 arch/powerpc/perf/callchain.h            |  11 +
 arch/powerpc/perf/callchain_32.c         | 218 +++++++++++++
 arch/powerpc/perf/callchain_64.c         | 185 +++++++++++
 14 files changed, 579 insertions(+), 533 deletions(-)
 create mode 100644 arch/powerpc/perf/callchain.h
 create mode 100644 arch/powerpc/perf/callchain_32.c
 create mode 100644 arch/powerpc/perf/callchain_64.c

-- 
2.22.0

