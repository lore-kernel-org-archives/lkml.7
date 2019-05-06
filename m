Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08741C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2F420830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jamnwn5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfEFUc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 16:32:57 -0400
Received: from mail.efficios.com ([167.114.142.138]:40208 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEFUc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 16:32:57 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 572A61E0D28;
        Mon,  6 May 2019 16:32:55 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id a9NS-zVfljiK; Mon,  6 May 2019 16:32:54 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6B03D1E0D1F;
        Mon,  6 May 2019 16:32:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6B03D1E0D1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1557174774;
        bh=BYvMNDDLG8Btx2+MJ23qT1uNxMmPkWNKPuhMmXOQ5ko=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jamnwn5fwm/aR0gXfoK2HG/1mvDvFu9FdlrOdBBi3BeDXgel8tSRLEHyfj9GFIGO1
         o0pM06FqOKafwniVkq8mrZoZ3hykGJCohZrWMeJHDNFrdGIRzgukL4Mp1zwle0QT8K
         x7mTCSiJjQfCsFgDClv7nHHN/MtCFe1HhzDLmsHHYPdHFttMM2O0E/aSJ0YTYfsYRz
         qxGNIoeeBa9RpVfszLIS7t78evGa+M5+Df9n/CsGZQ6JREModr3RG3PAeeT4GA/ePR
         rArpciZZw6ay/JS+jra/zLtyWu2TPhYSIIfp9YRmDzk9plwdKRLvoFAM/3jVFoaFbi
         caV19KbTPXdMQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id iPKMjiVeMDFT; Mon,  6 May 2019 16:32:54 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 530241E0D18;
        Mon,  6 May 2019 16:32:54 -0400 (EDT)
Date:   Mon, 6 May 2019 16:32:54 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org,
        rp@svcs.cs.pdx.edu
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <990796059.510.1557174774246.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] Userspace RCU 0.11
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Index: 2Iev/flw77z+21I02ATmbGCqmUpBFA==
Thread-Topic: Userspace RCU 0.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a 0.11 release of the Userspace RCU project.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

Here is the high-level view of the changes introduced in this release:

* Allow combining many urcu flavors within the same
  compile unit. Prefix public APIs with urcu_<flavor>_ prefix. Keep old
  symbols as aliases for backward compatibility.

* liburcu flavors public headers are moved, including them from previous
  headers for backward compatibility:

  urcu-bp.h -> urcu/urcu-bp.h
  urcu-qsbr.h -> urcu/urcu-qsbr.h
  urcu.h -> urcu/urcu-memb.h
  urcu.h (after #define RCU_MEMBARRIER) -> urcu/urcu-memb.h
  urcu.h (after #define RCU_MB) -> urcu/urcu-mb.h
  urcu.h (after #define RCU_SIGNAL) -> urcu/urcu-mb.h

* The library liburcu is renamed to liburcu-memb, keeping the old
  library name as alias for backward compatibility.

* RCU lock-free hash table debugging:

  --enable-cds-lfht-iter-debug is introduced.

  Building liburcu with --enable-cds-lfht-iter-debug and rebuilding
  application to match the ABI change allows finding cases where the hash
  table iterator is re-purposed to be used on a different hash table
  while still being used to iterate on a hash table.

  This option alters the rculfhash ABI. Make sure to compile both library
  and application with matching configuration.

* Added support for RISC-V architecture.

* Use membarrier PRIVATE_EXPEDITED when available from liburcu-bp and
  liburcu-memb flavors.

The backward compatibility header files, library shared objects, and
symbols will be kept for a few liburcu versions before being removed, at
which point a major soname bump will happen.

As always, feedback is welcome!

Thanks,

Mathieu

Changelog:

2019-05-06 Userspace RCU 0.11.0
        * Bump library version to 6:0:1
        * Cleanup: update code layout to fix old gcc warning
        * Fix: typo CPPLAGS in examples Makefile
        * Harmonize pprint macro across projects
        * Check for TLS support after CC detection
        * Update macros from the autotools archive
        * tap-driver.sh: flush stdout after each test result
        * Update dead link in lgpl-relicensing.txt
        * Add multiflavor compat identifiers
        * Cleanup: missing sign compare fixes
        * Cleanup: enable signed/unsigned compare compiler warning
        * Cleanup: compiler warning on 32-bit architectures
        * config.h.in: rename CONFIG_RCU_MULTIFLAVOR to CONFIG_RCU_HAVE_MULTIFLAVOR
        * rculfhash: implement iterator debugging config option
        * Fix: examples silent rules on Solaris
        * Add missing fall through annotations
        * Fix: symbol aliases with TLS compat
        * Port: no symbols aliases on MacOS
        * Add -Wextra to CFLAGS
        * Add silent mode to examples Makefiles
        * doc: update examples to API changes
        * test multiflavor single compile unit
        * Update README following API changes
        * Use new header locations for includes from urcu code
        * Update call-rcu.h and defer.h comments and include guards
        * rculfqueue.h: do not include urcu-call-rcu.h
        * rculfhash: support use with multiple flavors per compile unit
        * rculfhash: do not include urcu-call-rcu.h from public API
        * Refactor liburcu to support many flavors per compile unit
        * Fix: only wait if work queue is empty in real-time mode
        * Fix: don't wait after completion of a work queue job batch
        * Fix: don't wait after completion of job batch if work queue is empty
        * Fix: workqueue: struct urcu_work vs rcu_head mixup
        * Cleanup: workqueue: update comments referring to call-rcu
        * Fix: mixup between URCU_WORKQUEUE_RT and URCU_CALL_RCU_RT
        * test_rwlock: Add per-thread count to verbose output
        * Add *.exe to gitignore for Cygwin
        * Fix: pthread_rwlock initialization on Cygwin
        * Fix: compat_futex_noasync on Cygwin
        * wfcqueue: allow defining CDS_WFCQ_WAIT_SLEEP to override `poll'
        * Update documentation for call_rcu before/after fork
        * Add support for the RISC-V architecture
        * Tests: Add tap-driver.sh for automake < 1.12
        * Tests: Replace prove by autotools tap runner
        * liburcu-bp: Use membarrier private expedited when available
        * liburcu: Use membarrier private expedited when available
        * rculfhash: improve error handling of mmap backend
        * Fix: don't use overlapping mmap mappings on Cygwin
        * Tests fix: errors in shell scripts
        * Revert "Use initial-exec tls model"
        * Use initial-exec tls model
        * Fix: don't use membarrier SHARED syscall command in liburcu-bp
        * Tests fix: add missing Cygwin thread id
        * Fix: assignment from incompatible pointer type warnings
        * Tests fix: unused variable warnings
        * Fix: add missing m68k headers to dist
        * Bump version to 0.11-pre


Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
