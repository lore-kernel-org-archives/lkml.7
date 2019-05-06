Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164FAC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC9F20C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557177987;
	bh=AKCghU0ZxP6INaXKIStQQbbUB+E2CIohMh0rUZ9BSlw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=A4vXPZicLrJ6V0csYv62cetyfrAaQp9YZeGao9oCvlQMI1LwTZ5F7/+S8ISJXw98/
	 S6KC5fD8qqnd7ptes8Qh1LzuglHYPsxE5rFxlc1zEI8DxMQ98amEub6eUpU8ZKP7s4
	 7sZJPpNLYWK6m6pf9cBviFDV30Lu+d4I0wQNiLac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfEFV00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:26:26 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39938 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfEFV00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:26 -0400
Received: by mail-it1-f196.google.com with SMTP id g71so7287375ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=SMMQzwT+fETchXK8+feq/UtIisY3Ldp9pogy+XqPg6g=;
        b=Ph91/U6y0obOgSy6JENV0BSHZbAWZDyw2mzNT8mDDh+YhVl1v1N8pqWU69ym0KyZzV
         b5CWJAJZUp9gSSw0f3x+uyYl0wLtdCR036kjvLQ6n0Ww/3e8SOJu3Nc4hGQTfp01Lr6k
         WHd8qynUjbw4rqh4yifQQNKg/38DiPybljGYfJ1qXD+QUwY9utWi82N0Zf6wwCIlA+yZ
         PMThSU1U9qtk5Y5mNFT1t+4iRARL5Fslwq5mtYueyeYKAYjH/cYtKZqkd88aXTTYBFws
         7Ci866by6kC/o10OSTfqWLni5iPj+ozG2rXHsUr51ePMmP6RdgrKQV9efLlKnuX4A+6/
         9Cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=SMMQzwT+fETchXK8+feq/UtIisY3Ldp9pogy+XqPg6g=;
        b=Wao4QRH+ZSOcq90y67zLi/WLa7F1DooMaze7JgzLGJ9AYD4h/nz+MYonjNIzC7R49U
         4A5843UiIzphZJYeix6olxDRrsDQkuAjbqWO823O7BuJipVONloLcaHSZE2MjHq5pamo
         +HZzxqtjhjKnZQGYA4r4Y1aqe7ULv1AeVB9mNCQjddM3136336Glq7zEfgsKtoQcpaPb
         0kWby3AA6HIjhtyIQ+SsKih/EUc9Y6/tHrYRXONRR4EWXRW01uV1FWMlxwyYJQxCq3Gs
         dLzONxfLakLnNbRV0RnJk/j8vpFdUCy49Fp4Yy33/orIgCFg8Ix7a1zZrqdoeds3/8uP
         Zjjw==
X-Gm-Message-State: APjAAAU24emUODYbjp7dvUFpQNwmJ9sSkA3oHYUZ/PdtBQQVjku3dkbK
        xkg1b3F8v4yLXRV9a3MhA28=
X-Google-Smtp-Source: APXvYqys25JWQwYtxuYAkgupMcCUlBlBc00aym42NMd84N2sBtkA/+iIMrJtgSceLnRiWTAt04RNEg==
X-Received: by 2002:a24:cac2:: with SMTP id k185mr19627307itg.152.1557177984903;
        Mon, 06 May 2019 14:26:24 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:23 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/22] v5 multi-die/package topology support
Date:   Mon,  6 May 2019 17:25:55 -0400
Message-Id: <20190506212617.23674-1-lenb@kernel.org>
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
Updates since v4

[PATCH 13/22] hwmon/coretemp: Support multi-die/package

	Removed a dead line that should have gone away
	in the v3 cpuinfo_x86 cleanup suggested by tglx.

[PATCH 19/22] thermal/x86_pkg_temp_thermal: rename internal variables to zones from packages
[PATCH 20/22] hwmon/coretemp: rename internal variables to zones from packages
[PATCH 21/22] perf/x86/intel/uncore: renames in response to multi-die/pkg support
[PATCH 22/22] perf/x86/intel/rapl: rename internal variables in response to multi-die/pkg support

	New syntax-only patches to clean up in-consistent variable names
	resulting from previous patches.  Suggested by ingo.

---
Updates since v2:

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

for you to fetch changes up to 9f57786ba08d4d5e913cd21693aadb0ccdba72b2:

  perf/x86/intel/rapl: rename internal variables in response to multi-die/pkg support (2019-05-06 17:17:58 -0400)

----------------------------------------------------------------
Kan Liang (3):
      perf/x86/intel/uncore: Support multi-die/package
      perf/x86/intel/rapl: Support multi-die/package
      perf/x86/intel/cstate: Support multi-die/package

Len Brown (14):
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
      thermal/x86_pkg_temp_thermal: rename internal variables to zones from packages
      hwmon/coretemp: rename internal variables to zones from packages
      perf/x86/intel/uncore: renames in response to multi-die/pkg support
      perf/x86/intel/rapl: rename internal variables in response to multi-die/pkg support

Zhang Rui (5):
      powercap/intel_rapl: Simplify rapl_find_package()
      powercap/intel_rapl: Support multi-die/package
      thermal/x86_pkg_temp_thermal: Support multi-die/package
      powercap/intel_rapl: update rapl domain name and debug messages
      hwmon/coretemp: Support multi-die/package

 Documentation/cputopology.txt                |  80 +++++++++------
 Documentation/x86/topology.txt               |   6 +-
 arch/x86/events/intel/cstate.c               |  14 ++-
 arch/x86/events/intel/rapl.c                 |  12 +--
 arch/x86/events/intel/uncore.c               |  80 +++++++--------
 arch/x86/events/intel/uncore.h               |   4 +-
 arch/x86/events/intel/uncore_snbep.c         |   2 +-
 arch/x86/include/asm/processor.h             |   4 +-
 arch/x86/include/asm/smp.h                   |   1 +
 arch/x86/include/asm/topology.h              |  17 ++++
 arch/x86/kernel/cpu/common.c                 |   1 +
 arch/x86/kernel/cpu/topology.c               |  88 +++++++++++++----
 arch/x86/kernel/smpboot.c                    |  75 +++++++++++++-
 arch/x86/xen/smp_pv.c                        |   1 +
 drivers/base/topology.c                      |  22 +++++
 drivers/hwmon/coretemp.c                     |  36 +++----
 drivers/powercap/intel_rapl.c                |  75 +++++++-------
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 142 ++++++++++++++-------------
 include/linux/topology.h                     |   6 ++
 19 files changed, 437 insertions(+), 229 deletions(-)


