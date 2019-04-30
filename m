Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D822CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F59E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556657777;
	bh=vIonBKxvBO/0Url8PBV02Z1MbaAI+P/UqSe7365pugo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RojMLyILlA9R2DFkQE5Qlor4QBvOeEfyL/b+0LAlu1qNFL5j6I1Zg7GTcL+by6E5s
	 iD6760Pmz8fIKcQ2LYRVa5XDyCh4tkUrmQizo2N3RI8ni2mUKDBiyGTwjdSmSmYwUw
	 PrSd2SH77f3lCVnnEvgd2GvWa2e2EltDEzlYa3zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfD3U4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:56:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35795 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3U4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:56:16 -0400
Received: by mail-io1-f67.google.com with SMTP id r18so13488739ioh.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=qosL0dV6bbRZ3VIPPW56CxbgXb6OsdU10dHOhPo3aH4=;
        b=WW/R1/jxdzJKTqMajuGmJFkqOoYYsZxqx1kxNX5u42RI2vIKCNW/lr1bYFCskSsKfl
         r6iv3AHPUmTjtkCbcx8rVRPJAP3e+DcX634mrWho6mY8DpGTe8G41lT0Nbu8t1Hiku9o
         /fhszQLfRLc6szroeok15yf/7tMQis1YDHzsi2D2AQMHNHnZ53tqlmoeVEtzWbM2Onmf
         LfTrfhSyTmwm9Fg0G3aX+QyPFyMMxOrOUJBXlSQ5PSDdMsPrfJVJTacRQu5IrQ0PKmuM
         XuRFBNjFrCGKBBFc0X35+mBWSsL7cAdlV+6SETHCZkQ0F4doYLxXm1zKZeyMF7cI1Bpq
         W/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=qosL0dV6bbRZ3VIPPW56CxbgXb6OsdU10dHOhPo3aH4=;
        b=YRs6siNpAwB/i28XB+bILGnPMLjtnoj8fUfGEgjZ80ihENne9/OVeiXhYBswMtc3Hb
         sMRr8eiHiQELv/wi9+ciqm8BYBTR7zdferkA0cM3+z1b7Wro4NvVyagvlntWqznpfkSm
         zx2d/Yye6sPB7Mcv7aapEMLmjnpFksZnOAWYbuiPnimRAyinz+MBWv3cJmXbVSKj5ulo
         nBe6rPSy32fatSn9+TGkcmCgJrqIY09AeNKT4NdsEMEOqIiGy31PgFbzzcZEgAHetRh/
         X0ASA1ktEV4jsVRFqD7mbkYTXo4BQJ7Msx+Ja9cjUEU59tFvdl0YM6of2CZmL0R/pYi1
         G/8Q==
X-Gm-Message-State: APjAAAXzjKnTixDXQb6tB2oVlz2q3oB4d60nHCp7/nPJxDvPE59+BFs5
        X+/W++LX26XgmcL8gAZEfsA=
X-Google-Smtp-Source: APXvYqwkzcTKYFhUpJ1OwJhi/0RJgXLwLsoYa9NShOMOU6JrUsn9ty0NMgkTXHcX2ftmRmaKEXuSAQ==
X-Received: by 2002:a6b:6405:: with SMTP id t5mr29043205iog.190.1556657775034;
        Tue, 30 Apr 2019 13:56:15 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:14 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/18] v3 multi-die/package topology support
Date:   Tue, 30 Apr 2019 16:55:45 -0400
Message-Id: <20190430205559.30226-1-lenb@kernel.org>
X-Mailer: git-send-email 2.18.0-rc0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does 4 things.

1. Parse the new CPUID.1F leaf to discover multi-die/package topology

2. Export multi-die topology inside the kernel

3. Update 4 places (coretemp, pkgtemp, rapl, perf) that that need to know
   the difference between die and package-scope MSR.

4. Export multi-die topology to user-space via sysfs

These changes should have 0 impact on cache topology,
NUMA topology, Linux scheduler, or system performance.

These topology changes primarily impact parts of the kernel
and some applications that care about package MSR scope.
Also, some software is licensed per package, and other tools,
such as benchmark reporting software sometimes cares about packages.

---
Updates since v2:

All review feedback has been addressed.

In response to brice, peterz and Morten Rasmussen,
used the word "cpu" rather than "thread" for the new sysfs attributes.

In response to tglx, replaced access to cpuinfo_x86.x86_max_dies,
with macro topology_max_die_per_package().  In doing so,
deleted this new per-cpu field entirely, as a global is sufficient.

Also, appended 3 patches from Kan Liang, updating the perf code
to be multi-die aware.  These patches are similar to the preceding
power and temperature patches.  I believe that with these patches,
this series now includes all needed multi-die kernel support.

---
The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git x86

for you to fetch changes up to 6c4891c7f2f1eacfcab00bf5d84b5ac119f654b9:

  perf/x86/intel/cstate: Support multi-die/package (2019-04-30 16:49:26 -0400)

----------------------------------------------------------------
Kan Liang (3):
      perf/x86/intel/uncore: Support multi-die/package
      perf/x86/intel/rapl: Support multi-die/package
      perf/x86/intel/cstate: Support multi-die/package

Len Brown (10):
      x86 topology: Fix doc typo
      topology: Simplify cputopology.txt formatting and wording
      x86 smpboot: Rename match_die() to match_pkg()
      x86 topology: Add CPUID.1F multi-die/package support
      x86 topology: Create topology_max_die_per_package()
      cpu topology: Export die_id
      x86 topology: Define topology_die_id()
      x86 topology: Define topology_logical_die_id()
      topology: Create package_cpus sysfs attribute
      topology: Create core_cpus and die_cpus sysfs attributes

Zhang Rui (5):
      powercap/intel_rapl: Simplify rapl_find_package()
      powercap/intel_rapl: Support multi-die/package
      thermal/x86_pkg_temp_thermal: Support multi-die/package
      powercap/intel_rapl: update rapl domain name and debug messages
      hwmon/coretemp: Support multi-die/package

 Documentation/cputopology.txt                | 80 +++++++++++++++----------
 Documentation/x86/topology.txt               |  6 +-
 arch/x86/events/intel/cstate.c               | 14 +++--
 arch/x86/events/intel/rapl.c                 | 10 ++--
 arch/x86/events/intel/uncore.c               | 20 ++++---
 arch/x86/include/asm/processor.h             |  4 +-
 arch/x86/include/asm/smp.h                   |  1 +
 arch/x86/include/asm/topology.h              | 17 ++++++
 arch/x86/kernel/cpu/common.c                 |  1 +
 arch/x86/kernel/cpu/topology.c               | 88 ++++++++++++++++++++++------
 arch/x86/kernel/smpboot.c                    | 75 +++++++++++++++++++++++-
 arch/x86/xen/smp_pv.c                        |  1 +
 drivers/base/topology.c                      | 22 +++++++
 drivers/hwmon/coretemp.c                     |  9 +--
 drivers/powercap/intel_rapl.c                | 75 +++++++++++++-----------
 drivers/thermal/intel/x86_pkg_temp_thermal.c |  8 +--
 include/linux/topology.h                     |  6 ++
 17 files changed, 322 insertions(+), 115 deletions(-)

