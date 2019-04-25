Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A99C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3672E20891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VQFAco9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfDYQOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:14:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42218 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfDYQOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id l25so374037eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yStFRS9IQfnjXWNa1YVd3J1qhXKuN3ukxByUvo8DgKw=;
        b=VQFAco9rkc2j4Ev08JGnPqgbNzkdJqCwCh3eqJrQnolpIHcjfBiKHzy6l0ypJSWRId
         3GUttkB3x5z22VxjeSA3KD2hDwY9wGTc2qG307inZcGBsTPeErRwpXXQnl7g0Hs9E41S
         ia6wP73LG0/QPNPDLKeJg2aNtqbpdNhUw6ogo89s3L56x8IOuwj0faR9yJwVWUvbd0zr
         NZNCLcVDCTEIKcTXCJTKducRrocXveW3cYwYVUUc1vSpfG6QMJzgSr+4Os9+ZN7gnJ8q
         co1PqL4rDC8h7Pp7o6eDOR/HLpU7YbEh182J1ViJtPl/d8ZxGQlInvEfTC9W1W4pfZOc
         cUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yStFRS9IQfnjXWNa1YVd3J1qhXKuN3ukxByUvo8DgKw=;
        b=Kr7HfB/1XtD8LM6SZjcgxyCephiHEJ4pZzL8JTtlff1nXqXF6LpoTeyzkGDUZ4puu/
         Gw+FEBrTHJZdtzGs9GVk7sSD0+xM4Ou8IYg8aYAAvoJT4gmYPNuzppWsIk2ZIHP1zf3v
         vN0rGU6Oe3mW41906/wRo78Wk4wcF0oROacCyvgMpAMXIHFhHWHt37Nz7/UJbur+rReQ
         9ajMJ+G1ZNb1gFW9soD77p/xmUMnLnX08vIeuCqoFYSA4TE1GHH1Xv6iKxxFC3T1KbCk
         AhES1G13hLlwyqOjtCpD1GSw4uStqV4XsOWVD2HsNS8PtLG/fxwWSjh3ldCSn8pYYNji
         v+cA==
X-Gm-Message-State: APjAAAVAZVXnlZNRdo6c1df6g1d7ZALXbJWd4q0woGn6KWgE8GIuOcEc
        lCa8Cd1iVxWKzLksnSvWT0Y4/wpkK00=
X-Google-Smtp-Source: APXvYqzQ1MtnMe5Nh1cOGX2/wws2cGMNWKdN2oZ+UhieEQ+0nko3FPBMqmRxbimLJ1pPqqRlsmeKBA==
X-Received: by 2002:aa7:c90f:: with SMTP id b15mr16859630edt.122.1556208858475;
        Thu, 25 Apr 2019 09:14:18 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:17 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv3 00/27] kernel: Introduce Time Namespace
Date:   Thu, 25 Apr 2019 17:13:49 +0100
Message-Id: <20190425161416.26600-1-dima@arista.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discussions around time namespace are there for a long time. The first
attempt to implement it was in 2006 by Jeff Dike. From that time, the
topic appears on and off in various discussions.

There are two main use cases for time namespaces:
1. change date and time inside a container;
2. adjust clocks for a container restored from a checkpoint.

“It seems like this might be one of the last major obstacles keeping
migration from being used in production systems, given that not all
containers and connections can be migrated as long as a time dependency
is capable of messing it up.” (by github.com/dav-ell)

The kernel provides access to several clocks: CLOCK_REALTIME,
CLOCK_MONOTONIC, CLOCK_BOOTTIME. Last two clocks are monotonous, but the
start points for them are not defined and are different for each
system. When a container is migrated from one node to another, all
clocks have to be restored into consistent states; in other words, they
have to continue running from the same points where they have been
dumped.

The main idea of this patch set is adding per-namespace offsets for
system clocks. When a process in a non-root time namespace requests
time of a clock, a namespace offset is added to the current value of
this clock and the sum is returned.

All offsets are placed on a separate page, this allows us to map it as
part of VVAR into user processes and use offsets from VDSO calls.

Now offsets are implemented for CLOCK_MONOTONIC and CLOCK_BOOTTIME
clocks.

v3: Major changes:

* Simplify two VDSO images by using static_branch() in vclock_gettime()
  Removes unwanted conflicts with generic VDSO movement patches and
  simplifies things by dropping too invasive linker magic.
  As an alternative to static_branch() we tested an attempt to introduce
  home-made dynamic patching called retcalls:
  https://github.com/0x7f454c46/linux/commit/4cc0180f6d65
  Considering some theoretical problems with toolchains, we decided to go
  with long well-tested nop-patching in static_branch(). Though, it was
  needed to provide backend for relative code.

* address Thomas' comments.
* add sanity checks for offsets:
  - the current clock time in a namespace has to be in [0, KTIME_MAX / 2).
    KTIME_MAX is divided by two here to be sure that the KTIME_MAX limit
    is still unreachable.
Link: https://lkml.org/lkml/2018/9/19/950
Link: https://lkml.org/lkml/2019/2/5/867

v2: There are two major changes:

* Two versions of the VDSO library to avoid a performance penalty for
  host tasks outside time namespace (as suggested by Andy and Thomas).

  As it has been discussed on timens RFC, adding a new conditional branch
  `if (inside_time_ns)` on VDSO for all processes is undesirable.
  It will add a penalty for everybody as branch predictor may mispredict
  the jump. Also there are instruction cache lines wasted on cmp/jmp.

  Those effects of introducing time namespace are very much unwanted
  having in mind how much work have been spent on micro-optimisation
  VDSO code.

  Addressing those problems, there are two versions of VDSO's .so:
  for host tasks (without any penalty) and for processes inside of time
  namespace with clk_to_ns() that subtracts offsets from host's time.


* Allow to set clock offsets for a namespace only before any processes
  appear in it.

  Now a time namespace looks similar to a pid namespace in a way how it is
  created: unshare(CLONE_NEWTIME) system call creates a new time namespace,
  but doesn't set it to the current process. Then all children of
  the process will be born in the new time namespace, or a process can
  use the setns() system call to join a namespace.

  This scheme allows to create a new time namespaces, set clock offsets
  and then populate the namespace with processes.

Our performance measurements show that the price of VDSO's clock_gettime()
in a child time namespace is about 8% with a hot CPU cache and about 90%
with a cold CPU cache. There is no performance regression for host
processes outside time namespace on those tests.

We wrote two small benchmarks. The first one gettime_perf.c calls
clock_gettime() in a loop for 3 seconds. It shows us performance with
a hot CPU cache (more clock_gettime() cycles - the better):

        | before     | CONFIG_TIME_NS=n | host        | inside timens
--------|------------|------------------|-------------|-------------
cycles  | 139887013  | 139453003        | 139899785   | 128792458
diff (%)| 100        | 99.7             | 100         | 92

The second one gettime_perf_cold.c calls rdtsc, clock_gettime(), rdtsc
and shows a difference of second and first rdtsc. We call this binary in
a loop 1000 times, get 1000 values and calculate MODE for them.
It should show us performance with a cold CPU cache
(lesser tsc per cycle - the better):

        | before     | CONFIG_TIME_NS=n | host        | inside timens
--------|------------|------------------|-------------|-------------
tsc     | 6748       | 6718             | 6862        | 12682
diff (%)| 100        | 99.6             | 101.7       | 188

The numbers gathered on Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz.

Cc: Adrian Reber <adrian@lisas.de>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: containers@lists.linux-foundation.org
Cc: criu@openvz.org
Cc: linux-api@vger.kernel.org
Cc: x86@kernel.org

v2: https://lore.kernel.org/lkml/20190206001107.16488-1-dima@arista.com/
RFC: https://lkml.kernel.org/r/20180919205037.9574-1-dima@arista.com/

Andrei Vagin (16):
  ns: Introduce Time Namespace
  timens: Add timens_offsets
  timens: Introduce CLOCK_MONOTONIC offsets
  timens: Introduce CLOCK_BOOTTIME offset
  timerfd/timens: Take into account ns clock offsets
  posix-timers/timens: Take into account clock offsets
  timens/kernel: Take into account timens clock offsets in
    clock_nanosleep
  x86/vdso: Add offsets page in vvar
  vdso: introduce timens_static_branch
  timens/fs/proc: Introduce /proc/pid/timens_offsets
  selftest/timens: Add a test for timerfd
  selftest/timens: Add a test for clock_nanosleep()
  selftest/timens: Add timer offsets test
  x86/vdso: Align VDSO functions by CPU L1 cache line
  selftests: Add a simple perf test for clock_gettime()
  selftest/timens: Check that a right vdso is mapped after fork and exec

Dmitry Safonov (11):
  timens: Shift /proc/uptime
  x86/vdso2c: Correct err messages on file opening
  x86/vdso2c: Convert iterator to unsigned
  x86/vdso/Makefile: Add vobjs32
  x86/vdso: Restrict splitting VVAR VMA
  x86/vdso: Rename vdso_image {.data=>.text}
  x86/vdso: Allocate timens vdso
  x86/vdso: Switch image on setns()/unshare()/clone()
  timens: Add align for timens_offsets
  selftest/timens: Add Time Namespace test for supported clocks
  selftest/timens: Add procfs selftest

 MAINTAINERS                                   |   3 +
 arch/Kconfig                                  |   5 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/Makefile                  |  16 +-
 arch/x86/entry/vdso/vclock_gettime.c          |  48 +++
 arch/x86/entry/vdso/vdso-layout.lds.S         |  10 +-
 arch/x86/entry/vdso/vdso2c.c                  |   7 +-
 arch/x86/entry/vdso/vdso2c.h                  |  24 +-
 arch/x86/entry/vdso/vma.c                     | 113 ++++++-
 arch/x86/include/asm/jump_label.h             |  14 +
 arch/x86/include/asm/vdso.h                   |  14 +-
 fs/proc/base.c                                | 101 ++++++
 fs/proc/namespaces.c                          |   4 +
 fs/proc/uptime.c                              |   3 +
 fs/timerfd.c                                  |   8 +-
 include/linux/hrtimer.h                       |   1 +
 include/linux/jump_label.h                    |   5 +
 include/linux/nsproxy.h                       |   2 +
 include/linux/proc_ns.h                       |   2 +
 include/linux/time_namespace.h                | 137 ++++++++
 include/linux/timens_offsets.h                |  18 +
 include/linux/user_namespace.h                |   1 +
 include/uapi/linux/sched.h                    |   1 +
 include/uapi/linux/time.h                     |   2 +
 init/Kconfig                                  |   8 +
 kernel/Makefile                               |   1 +
 kernel/fork.c                                 |   3 +-
 kernel/nsproxy.c                              |  41 ++-
 kernel/time/alarmtimer.c                      |  13 +-
 kernel/time/hrtimer.c                         |   3 +
 kernel/time/posix-stubs.c                     |  11 +-
 kernel/time/posix-timers.c                    |  27 +-
 kernel/time_namespace.c                       | 318 ++++++++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/timens/.gitignore     |   8 +
 tools/testing/selftests/timens/Makefile       |  12 +
 .../selftests/timens/clock_nanosleep.c        | 100 ++++++
 tools/testing/selftests/timens/config         |   1 +
 tools/testing/selftests/timens/exec.c         |  91 +++++
 tools/testing/selftests/timens/gettime_perf.c |  74 ++++
 .../selftests/timens/gettime_perf_cold.c      |  63 ++++
 tools/testing/selftests/timens/log.h          |  26 ++
 tools/testing/selftests/timens/procfs.c       | 142 ++++++++
 tools/testing/selftests/timens/timens.c       | 188 +++++++++++
 tools/testing/selftests/timens/timens.h       |  63 ++++
 tools/testing/selftests/timens/timer.c        | 116 +++++++
 tools/testing/selftests/timens/timerfd.c      | 127 +++++++
 47 files changed, 1928 insertions(+), 49 deletions(-)
 create mode 100644 include/linux/time_namespace.h
 create mode 100644 include/linux/timens_offsets.h
 create mode 100644 kernel/time_namespace.c
 create mode 100644 tools/testing/selftests/timens/.gitignore
 create mode 100644 tools/testing/selftests/timens/Makefile
 create mode 100644 tools/testing/selftests/timens/clock_nanosleep.c
 create mode 100644 tools/testing/selftests/timens/config
 create mode 100644 tools/testing/selftests/timens/exec.c
 create mode 100644 tools/testing/selftests/timens/gettime_perf.c
 create mode 100644 tools/testing/selftests/timens/gettime_perf_cold.c
 create mode 100644 tools/testing/selftests/timens/log.h
 create mode 100644 tools/testing/selftests/timens/procfs.c
 create mode 100644 tools/testing/selftests/timens/timens.c
 create mode 100644 tools/testing/selftests/timens/timens.h
 create mode 100644 tools/testing/selftests/timens/timer.c
 create mode 100644 tools/testing/selftests/timens/timerfd.c

-- 
2.21.0

