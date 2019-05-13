Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E306BC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E5C208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557770357;
	bh=chthummUnDi6jF96XxZxwH7LSPk/OAQm22QGXLqF65E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Dyot2HOtiQhB4ON1P1O5/77aW722Z9kitFcawRd3Gs0WPtYMb9t1qPXXx7jGAzbZ5
	 sdoCT9OjZNE1FitY/GUqipe4G/GPEJtjmsdtQMvWh82ganqvaQwGl+/5Lak6iOeknz
	 3ecES7mO7nlgWVKwlzEOa5BZPLP/LcZ8ZLy89Pfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfEMR7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:59:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33063 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfEMR7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:59:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id y3so6853547plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=PbTPqRIXK145J6jM9TocqCkiuKfdPns+VGcz+M9dsbI=;
        b=JsCEMQ4gwm4R9QRKjmWrLKaExmuouBpOoQM7J1yCTjNoWQP+YBJQzuuJtEpl1pUkAb
         kRXTtJ4efaL6aTwmrINNZl2UfuLDnQemA+pVqTTQ//jeZeyCNmaVbyqv8LkzCKYCtN4E
         XCGF2oSSScy/3DXYwLsRDhxO4PVX3kawofDWo5fF9fi6Vb4RXRKqfl2FWghQ/u72wSXh
         OEnvQ0bKvfhbGMxRBr0wrWuUXs4EVPPgzCkhoX8x+mqzIozABC0cpc4BR2bju+QAp/NG
         HUnBG4YjYovGKq48CXD/bZeD6iI6IOmH+8GaqLf1JcPqEXlkXiWi+y8s1hcDiBifFx99
         ugTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=PbTPqRIXK145J6jM9TocqCkiuKfdPns+VGcz+M9dsbI=;
        b=aLRlpp5kyby+mj8JGx2AV7U5cyvC1XDmpz3XtKpFiHC+BnBwXlRwvpgFtg+B2IsaDs
         uFQOD1fJkiJJnjAGGnrsG0ARtsyVXrUyCh34K/TpqL0iqkN+hPjsz0FLFkUPIGQXC8+Q
         PpLHKWIHl53+gEEj9KeBeoO7e3r74bfww5yypcRkJSnAS7sCs8WklpOMjUsLY6C7wt7G
         96n0bTAHa0DSzXNOHOcPtEpncxqJ8DvD0qgUWHREmsP7yTyNhBLOdDfpkPW9b4mmL78W
         pjwule8qTETrGm+NjQX/p0MmIJsfkDijM5zdXNrAUwnJy5KvuLvJCcvAfEtQp5m/2Cwh
         Rv8Q==
X-Gm-Message-State: APjAAAVDZlDDpcvrlrrhkP8OE4vQzLnbeqv40IpCGUVhh850SZHsdeti
        a8YI41wJQyMRzULT/pIHkSE=
X-Google-Smtp-Source: APXvYqzW2aD4HbQFpYeqNzLtrglqrp1Wcn6T/oBo2DESYMCoH/x3Lo4O5B20e4SMWCsfrD0nqbLJ4A==
X-Received: by 2002:a17:902:720a:: with SMTP id ba10mr32544476plb.192.1557770354971;
        Mon, 13 May 2019 10:59:14 -0700 (PDT)
Received: from localhost.localdomain ([96.79.124.202])
        by smtp.gmail.com with ESMTPSA id s12sm9536266pfd.152.2019.05.13.10.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:59:13 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/19] v6 multi-die/package topology support
Date:   Mon, 13 May 2019 13:58:44 -0400
Message-Id: <20190513175903.8735-1-lenb@kernel.org>
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

These changes should have no impact on cache topology,
NUMA topology, Linux scheduler, or system performance.

These topology changes primarily impact parts of the kernel
and some applications that care about package MSR scope.
Also, some software is licensed per package, and other tools,
such as benchmark reporting software sometimes cares about packages.

Changes since v5:
	
	The patch numbers have decremented by 3, since the first 3 patches
	in the original series are now upstream.

	The last two "Cosmetic rename" patches have been replaced with
	those by Kan, who did a more thorough variable rename than I had
	originally proposed.


	[PATCH 18/19] perf/x86/intel/uncore: Cosmetic renames in response to multi-die/pkg support
	[PATCH 19/19] perf/x86/intel/rapl: Cosmetic rename internal variables in response to multi-die/pkg support

I'm not aware of any outstanding feedback on this series,
functional or cosmetic.

thanks,
Len Brown, Intel Opensource Technology Center

--------------
The following changes since commit a13f0655503a4a89df67fdc7cac6a7810795d4b3:

  Merge tag 'iommu-updates-v5.2' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/joro/iommu (2019-05-13 09:23:18 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git x86

for you to fetch changes up to 0ddb97e121397d37933233da303556141814fa47:

  perf/x86/intel/rapl: Cosmetic rename internal variables in response to multi-die/pkg support (2019-05-13 13:41:50 -0400)

----------------------------------------------------------------
Kan Liang (5):
      perf/x86/intel/uncore: Support multi-die/package
      perf/x86/intel/rapl: Support multi-die/package
      perf/x86/intel/cstate: Support multi-die/package
      perf/x86/intel/uncore: Cosmetic renames in response to multi-die/pkg support
      perf/x86/intel/rapl: Cosmetic rename internal variables in response to multi-die/pkg support

Len Brown (9):
      x86 topology: Add CPUID.1F multi-die/package support
      x86 topology: Create topology_max_die_per_package()
      cpu topology: Export die_id
      x86 topology: Define topology_die_id()
      x86 topology: Define topology_logical_die_id()
      topology: Create package_cpus sysfs attribute
      topology: Create core_cpus and die_cpus sysfs attributes
      thermal/x86_pkg_temp_thermal: Cosmetic: Rename internal variables to zones from packages
      hwmon/coretemp: Cosmetic: Rename internal variables to zones from packages

Zhang Rui (5):
      powercap/intel_rapl: Simplify rapl_find_package()
      powercap/intel_rapl: Support multi-die/package
      thermal/x86_pkg_temp_thermal: Support multi-die/package
      powercap/intel_rapl: Update RAPL domain name and debug messages
      hwmon/coretemp: Support multi-die/package

 Documentation/cputopology.txt                |  48 ++++++---
 Documentation/x86/topology.rst               |   4 +
 arch/x86/events/intel/cstate.c               |  14 ++-
 arch/x86/events/intel/rapl.c                 |  20 ++--
 arch/x86/events/intel/uncore.c               |  80 +++++++--------
 arch/x86/events/intel/uncore.h               |   4 +-
 arch/x86/events/intel/uncore_snbep.c         |   4 +-
 arch/x86/include/asm/processor.h             |   4 +-
 arch/x86/include/asm/smp.h                   |   1 +
 arch/x86/include/asm/topology.h              |  17 ++++
 arch/x86/kernel/cpu/common.c                 |   1 +
 arch/x86/kernel/cpu/topology.c               |  88 +++++++++++++----
 arch/x86/kernel/smpboot.c                    |  69 +++++++++++++
 arch/x86/xen/smp_pv.c                        |   1 +
 drivers/base/topology.c                      |  22 +++++
 drivers/hwmon/coretemp.c                     |  36 +++----
 drivers/powercap/intel_rapl.c                |  75 +++++++-------
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 142 ++++++++++++++-------------
 include/linux/topology.h                     |   6 ++
 19 files changed, 422 insertions(+), 214 deletions(-)


