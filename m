Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B28C468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A702083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfFGVkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:40:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52404 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbfFGVkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:40:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZMam-0007jO-8x; Fri, 07 Jun 2019 15:40:08 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hZMak-00082z-Rz; Fri, 07 Jun 2019 15:40:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de,
        axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        omar.kilani@gmail.com, tglx@linutronix.de, stable@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        <linux-arch@vger.kernel.org>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com>
Date:   Fri, 07 Jun 2019 16:39:54 -0500
In-Reply-To: <20190606140814.GA13440@redhat.com> (Oleg Nesterov's message of
        "Thu, 6 Jun 2019 16:08:14 +0200")
Message-ID: <87k1dxaxcl.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hZMak-00082z-Rz;;;mid=<87k1dxaxcl.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Ncj5b4HEVUXN16mr/5Fc1PInrICo6P5o=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC PATCH 0/5]: Removing saved_sigmask
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


While reviewing Oleg's patches I realized a bunch of the logic around
saved_sigmask was redundant.  So I dug just to see what I could see.

I turns out that real_blocked and saved_sigmask were different
implementations of the same idea for slightly different purposes.
Which means we only need either real_blocked or saved_sigmask.

I chose real_blocked as it has just a little bit of code associated
with it to disable optimizations on the signal sending path that do
not apply to blocked signals.

I did a little bit of cleanup of the users.  Modified the core to keep
real_blocked in sync with blocked except while a clever system call that
like pselect or sigtimedwait is running.

After the dust cleared this allowed restore_sigmask and all of the logic
to keep it valid to be removed entirely.

I have only done the most cursory of testing at this point.  Does anyone
have any thoughts in cleaning up the code in this direction?

Eric W. Biederman (5):
      signal: Teach sigsuspend to use set_user_sigmask
      signal/kvm:  Stop using sigprocmask in kvm_sigset_(activate|deactivate)
      signal: Always keep real_blocked in sync with blocked
      signal: Remove saved_sigmask
      signal: Remove the unnecessary restore_sigmask flag

 arch/arc/include/asm/thread_info.h       |  1 -
 arch/arm/include/asm/thread_info.h       |  1 -
 arch/arm64/include/asm/thread_info.h     |  1 -
 arch/c6x/include/asm/thread_info.h       |  1 -
 arch/csky/include/asm/thread_info.h      |  2 -
 arch/h8300/include/asm/thread_info.h     |  1 -
 arch/hexagon/include/asm/thread_info.h   |  1 -
 arch/m68k/include/asm/thread_info.h      |  1 -
 arch/mips/include/asm/thread_info.h      |  1 -
 arch/nds32/include/asm/thread_info.h     |  2 -
 arch/nios2/include/asm/thread_info.h     |  2 -
 arch/riscv/include/asm/thread_info.h     |  1 -
 arch/s390/include/asm/thread_info.h      |  1 -
 arch/sparc/include/asm/thread_info_32.h  |  1 -
 arch/um/include/asm/thread_info.h        |  1 -
 arch/unicore32/include/asm/thread_info.h |  1 -
 arch/xtensa/include/asm/thread_info.h    |  1 -
 include/linux/sched.h                    |  5 --
 include/linux/sched/signal.h             | 84 +-------------------------------
 kernel/ptrace.c                          | 15 ++----
 kernel/signal.c                          | 56 +++++++++------------
 virt/kvm/kvm_main.c                      | 11 +----
 22 files changed, 31 insertions(+), 160 deletions(-)

Eric
