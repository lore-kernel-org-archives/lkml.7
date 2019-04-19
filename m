Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A08C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7422171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZAY1/+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfDSTgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:36:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36749 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfDSTgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:36:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so2951805pfn.3;
        Fri, 19 Apr 2019 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+o1tngadn98ZyAUYEhwRFi3Q7XYD8FWqFNNmIK45jIU=;
        b=SZAY1/+z5O3W4LRFO1uJDi3WeKRgh6Y0Sqex2c5i4QufQeU+6zUXW8DG4oSZ3t+goA
         ISBFb5T1Q/dZkDaxhUysEfrhsseCNvwP4MyGDQ8SWvM9Gcyf1Igw1V7HKWmQAoSy4VwJ
         LIPZUGjGKi4PpbHuPdlPaTSrj/e3nSRe9sCB/FC+ssO+HUpxIOqPKveCXIets5U2xv0d
         tm4ZTix3TqGfq+lPyADzEvhmUYOaLuadzCJzO15qIAgeu4G3UW/pJKTVdjR4rkOenSCQ
         +fIvJpAaMHABMFNpc/CYzz5FNqCmbB/bY8gL4FY6DtrYyVzn5BeipUlZPFbBBJCEpCBT
         MIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+o1tngadn98ZyAUYEhwRFi3Q7XYD8FWqFNNmIK45jIU=;
        b=ERZ/7PwccExf8nVSdfndef+mZwo5uJwa6xx53ib8YlGJND1lglJRWwSOL4KZWPxGM4
         myse5ZwoCXfPUlCcjJnfbGgM054kqM4nWvTONZZeKc+AZyaNVNGmYlonKscqSmw3A6Hu
         NuaEOj49ww1Re2PL6qAY5ky5q1H99ZWkll39TCJasU+NN+T5SbEEP8fiU2/KDke8+im4
         A91rYI2T+xGe9X1rozhf3Y8Q1W6StpMYRLvh9d4RZxTuvrqHIi7uysONrYg2bqFFj8kH
         mqDipuezHYBSPt7mTGnF0JM+7kLCRbj+uAcgu7EAHeaVsQI0haljWudzVR1xBr0fA+/x
         6iiw==
X-Gm-Message-State: APjAAAWP+PCRv6DekfZx5tNHpxrz7hz3avWlCu3m2qyXovBfhHJYsu9V
        kjVRpqyGtMOR/Sfm6i3GChH9Z2yL
X-Google-Smtp-Source: APXvYqy4C8mQQgn9ZuIS6MX/6T1FEK7OAFBQT5zHh06CkiZv/QuBihCIhyXO6RiaDm8gIrTbe93dnQ==
X-Received: by 2002:a63:7c45:: with SMTP id l5mr5532791pgn.303.1555702613182;
        Fri, 19 Apr 2019 12:36:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p26sm16570286pfa.49.2019.04.19.12.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 12:36:52 -0700 (PDT)
Date:   Fri, 19 Apr 2019 12:36:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, longman@redhat.com,
        mingo@kernel.org, akpm@linux-foundation.org, bp@alien8.de,
        a.p.zijlstra@chello.nl, will.deacon@arm.com,
        tim.c.chen@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, dave@stgolabs.net, dbueso@suse.de,
        torvalds@linux-foundation.org, peterz@infradead.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON()
 macro
Message-ID: <20190419193650.GA10656@roeck-us.net>
References: <20190404174320.22416-7-longman@redhat.com>
 <tip-3b4ba6643d26a95e08067fca9a5da1828f9afabf@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-3b4ba6643d26a95e08067fca9a5da1828f9afabf@git.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:04:41AM -0700, tip-bot for Waiman Long wrote:
> Commit-ID:  3b4ba6643d26a95e08067fca9a5da1828f9afabf
> Gitweb:     https://git.kernel.org/tip/3b4ba6643d26a95e08067fca9a5da1828f9afabf
> Author:     Waiman Long <longman@redhat.com>
> AuthorDate: Thu, 4 Apr 2019 13:43:15 -0400
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Wed, 10 Apr 2019 10:56:03 +0200
> 
> locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro
> 
> Currently, the DEBUG_RWSEMS_WARN_ON() macro just dumps a stack trace
> when the rwsem isn't in the right state. It does not show the actual
> states of the rwsem. This may not be that helpful in the debugging
> process.
> 
> Enhance the DEBUG_RWSEMS_WARN_ON() macro to also show the current
> content of the rwsem count and owner fields to give more information
> about what is wrong with the rwsem. The debug_locks_off() function is
> called as is done inside DEBUG_LOCKS_WARN_ON().
> 

This patch results in a large number of runtime warnings with several
architectures (at least arm, arm64, ppc, s390, sparc64, x86) if lock
debugging is enabled.

Example backtrace (ppc64):

DEBUG_RWSEMS_WARN_ON(sem->owner != current): count = 0x0, owner = 0x0, curr
0xc0000000012e0e00, list empty
WARNING: CPU: 0 PID: 0 at kernel/locking/rwsem.h:277 .up_write+0x138/0x150
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.1.0-rc5-next-20190418-08527-g856544124538 #1
NIP:  c00000000015b7c8 LR: c00000000015b7c4 CTR: c0000000007b37a0
REGS: c00000000141f940 TRAP: 0700   Not tainted
(5.1.0-rc5-next-20190418-08527-g856544124538)
MSR:  8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 24000444  XER: 00000000
IRQMASK: 0 
GPR00: c00000000015b7c4 c00000000141fbd0 c00000000141ff00 000000000000006a 
GPR04: 0000000000000001 c000000000179fe8 0000000000000000 0000000000000001 
GPR08: c0000000012e0e00 0000000000000001 c00000000207ff00 0000000000000000 
GPR12: 0000000022000444 c000000002118000 000000003fde7ee0 0000000001fce4d8 
GPR16: 0000000001fce218 0000000001fce8f8 0000000002470000 0000000001fdcee8 
GPR20: 0000000000000000 fffffffffffffffd 0000000001fcea18 00000000ffffffff 
GPR24: 0000000001000000 c0000000014324bc c00000000104cf00 c00000000104c4f0 
GPR28: 0000000000000008 c000000000fd13d0 0000000000000000 c0000000012919b0 
NIP [c00000000015b7c8] .up_write+0x138/0x150
LR [c00000000015b7c4] .up_write+0x134/0x150
Call Trace:
[c00000000141fbd0] [c00000000015b7c4] .up_write+0x134/0x150 (unreliable)
[c00000000141fc60] [c000000000729808] .double_unlock_wsem+0x38/0x50
[c00000000141fce0] [c0000000007312f0] .dotest+0x88/0x7e8
[c00000000141fe20] [c00000000072f394] .locking_selftest+0x664/0x21e8
[c00000000141fed0] [c000000001102628] .start_kernel+0x4c4/0x640
[c00000000141ff90] [c00000000000aef0] start_here_common+0x1c/0x52c
Instruction dump:
7fe9fb78 e9490051 7fa95000 419e002c 3d02ffbd 39083bf8 3c82ffbd 3c62ffbd 
38843cc0 38633c50 4bf7bd81 60000000 <0fe00000> 4bffff64 3d02ffc2 39080e18 

Reverting the patch fixes the problem.

Bisect log (generated from ppc64 qemu run) attached.

Guenter

---
# bad: [856544124538f33105302451a9fbf0676598dddb] block: avoid scatterlist offsets > PAGE_SIZE
	Note: This was on top of next-20190418
# good: [dc4060a5dc2557e6b5aa813bf5b73677299d62d2] Linux 5.1-rc5
git bisect start 'HEAD' 'v5.1-rc5'
# good: [d49e1f8649c84f154e7df59300264f59b736f329] Merge remote-tracking branch 'crypto/master'
git bisect good d49e1f8649c84f154e7df59300264f59b736f329
# good: [06a21957e5c0aae87fb94b97ef965818bd7c9dac] Merge remote-tracking branch 'spi/for-next'
git bisect good 06a21957e5c0aae87fb94b97ef965818bd7c9dac
# bad: [c44f3caed068c67fe01056329e7e6cbf8f4920a8] Merge remote-tracking branch 'staging/staging-next'
git bisect bad c44f3caed068c67fe01056329e7e6cbf8f4920a8
# bad: [7b621018ce44727ffcc1f548187fead9e8fd6680] Merge remote-tracking branch 'usb-chipidea-next/ci-for-usb-next'
git bisect bad 7b621018ce44727ffcc1f548187fead9e8fd6680
# bad: [c8d9806ebb40150b6b4ee20f24ad0220fee7970a] Merge branch 'core/core'
git bisect bad c8d9806ebb40150b6b4ee20f24ad0220fee7970a
# good: [b9541e74fdc7673058c0db87dd9901aa10dda221] Merge branch 'perf/urgent'
git bisect good b9541e74fdc7673058c0db87dd9901aa10dda221
# bad: [408da98e8208df4664e775f393b1af9052ce61c6] Merge branch 'locking/core'
git bisect bad 408da98e8208df4664e775f393b1af9052ce61c6
# good: [cabf5ebbabcd4ad59b6eb216876c4c2e56fd3386] Merge tag 'perf-core-for-mingo-5.2-20190402' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core
git bisect good cabf5ebbabcd4ad59b6eb216876c4c2e56fd3386
# bad: [ad53fa10fa9e816067bbae7109845940f5e6df50] locking/qspinlock_stat: Introduce generic lockevent_*() counting APIs
git bisect bad ad53fa10fa9e816067bbae7109845940f5e6df50
# good: [f1887143f5984f23d2360f2efed6ef481bb41117] Documentation/atomic_t: Clarify signed vs unsigned
git bisect good f1887143f5984f23d2360f2efed6ef481bb41117
# good: [f7c2b7477bdc79a1e0cc3751a26c28031c1ab609] Merge branch 'lkmm-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into locking/core
git bisect good f7c2b7477bdc79a1e0cc3751a26c28031c1ab609
# good: [12a30a7fc142a123c61da9623bd824d95d36c12e] locking/rwsem: Move rwsem internal function declarations to rwsem-xadd.h
git bisect good 12a30a7fc142a123c61da9623bd824d95d36c12e
# good: [a68e2c4c637918da47b3aa270051545cff7d8245] locking/rwsem: Add debug check for __down_read*()
git bisect good a68e2c4c637918da47b3aa270051545cff7d8245
# bad: [3b4ba6643d26a95e08067fca9a5da1828f9afabf] locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro
git bisect bad 3b4ba6643d26a95e08067fca9a5da1828f9afabf
# first bad commit: [3b4ba6643d26a95e08067fca9a5da1828f9afabf] locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro
