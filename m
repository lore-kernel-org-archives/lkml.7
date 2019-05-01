Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC0AC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7916E20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556684676;
	bh=8JM7tmhx4kza/orZTA6N7xqdf/NQ5lxuRQIdyY1DtBA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SdZsC678qKvm9hKCynL6O8jYr9VY2ckBTw9cfwWaa2dMMD+N2ZzG/kEBxF20Ty+Xo
	 sBvKnlzE/sv8LICM9DRvGybnxX+2wz2NrH6I8/8G6YgIHmH4Ll71I+LD3n4IsTLIDr
	 YTIcL32U/5gIuKFMWuZn9hJMdmlS/qoWV8dmDH1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfEAEYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:24:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39161 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfEAEYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:34 -0400
Received: by mail-it1-f196.google.com with SMTP id t200so8368572itf.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=6+vxEoGuhOqrP8QRMx3WfeqWYO+yDAELb4vIHp9rT1I=;
        b=Kw8apbqVYns321ok/Z7aFHim+N12Ow1gn+FjePKHWyzFF+4iJUPy6FqVJKcJRo1YRZ
         gAaZjny46QUhvL8Sz87P/ETs18qOdSWu/m8T5ZKK4ltEYHEvR4NN27/Q2sTqL2azBlyr
         IdBj9YbtKCiWFO/4odqUuKk1OfDXLQrpmLV8EQb34+GH4tOAe1bmg0TuqJKez/PC9DbD
         oaOB1shiOe7BNqox7poi5Ax1CDsejTCHMSBLYeQ6Ife+397lClb/5O8jwg/wRVf4mRMR
         eVTkW1+EV3dCXJoQ6YRXIPKFxzo7Id7tJhGsqojwMXhFwEPfu+m5cqItYApcpDAqzkLz
         ShMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=6+vxEoGuhOqrP8QRMx3WfeqWYO+yDAELb4vIHp9rT1I=;
        b=ZdtopnymHS/v+VxcFfAY0rc/+cuV4nNWMyXMFHVNCaIJRS/n363HCvlQCE1m+V66aE
         It3GF5X9q5WZNo0eHPs4R51JOJYtWrZLLmCuYOWqN+tSF7otPKblcyk4TZl9qFDDWsel
         RxqwLEJLxwE3UxEzTREFuBJizg5JTdH1IIsffJQH6eFbR3aI9GOTKLrs1SRiF5VR9b+7
         1b61UEimQ/HKmnVdiNaWZC+E8pkvYiXWADvzGHrCJmgQxEp27CLMQfiVD2So/wiC6FSW
         MsU0HLwhnzys/aAu/ul3OMWFT8pgsCVuu2jI3yOubrIDG6ec2oguaM7f7o9FFMTSaydv
         efdQ==
X-Gm-Message-State: APjAAAWwnEa2HzWfDndovZuZ8kTYkTPV7GEPjdzioEQb6loAjcN/8iCm
        oRK1MZg725nyuYmHiyRzURPIv0m5
X-Google-Smtp-Source: APXvYqzmfQ3q0MU07EteYezN2osyU3W9YtmjuSxumM/vEUFA1u/92pZjMWfIlpunw1UqnAR385F/YA==
X-Received: by 2002:a24:c685:: with SMTP id j127mr7103801itg.21.1556684673656;
        Tue, 30 Apr 2019 21:24:33 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:32 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/18] v4 multi-die/package topology support
Date:   Wed,  1 May 2019 00:24:09 -0400
Message-Id: <20190501042427.13156-1-lenb@kernel.org>
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
Updates since v3:

None!

Earlier today I sent the correct v3 e-mail header, pointing to the
correct git branch, but ran git-send-email from the wrong directory
and it happily spammed you with a copy of the old 14-patch v1 series.
Sorry about that!

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

