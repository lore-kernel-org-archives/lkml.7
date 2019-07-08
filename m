Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21C8C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A3D21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562603283;
	bh=RSOyQPGuqo2Ektk1/T3q33xV5yaDm18j2rHpYs5l/3Q=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=j2auiool1NSRSz8ZFhXeK3V1xmMo+zoPcIDS92wqvxtN3DGRncaHBvEBi7GHgKUtt
	 jkb/Th4vZk4wJ5UC2G1xOrAGghCwl8qwNP9M+21Iy1WD21n526fOOsmtSntjGlSUi/
	 Ci1BwZKpEm62E3Pi/3O6tru1qUleEpMCQk3n3fP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfGHQ2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:28:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37716 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfGHQ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:28:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so157750wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ouK9evEJhjAVMk+/YE2G0orSDwgzJNLXQ7fBdFbs3CI=;
        b=DcCtJgNUN146/g2R+AC4nUnKn5sNN3631w9YVmx43c/XOC6gbmGtA7T+yXXt35l7hz
         Eix2DwAHxIn2evFN72sH5jCJFFPfA1icye0PLtXsrAmjkIGww6oe4HFVBdw2pAcqgIaq
         clA2shDIZbayQnSvkwNATsM1KGPbM65HwtCPXXVy7lWgYyElAyhyhdU0zz3idukg/n23
         UhHq4l6pGrdCezvaIl1Cgp38trEPtvhhBXpeYszzsHZKGsXAxtA28adR+l2XiBcVb9D+
         797y5sf3uR/tBexEAWqVMelTTtTAkt6vk73fPf2AlesoPp3s3TPJWNVcvTZQbBuInncy
         cAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ouK9evEJhjAVMk+/YE2G0orSDwgzJNLXQ7fBdFbs3CI=;
        b=be0RkL31ZO/fjry43+CRO3wL9WstEf6oSfMWVob+81J8wIOVR2iHaE+xD1t1dnoewD
         mGFNpUqxrDVQuCvtzEGaCaJUxaJ7w0f6FcccunzMs8PfEypbNuYcd15Qn2ZhE3WeENQ1
         M9Fl4imjTYdxXOdbQIoq2p6RjmLzjUHHYJLg2DJx40k0zYxOxSDUAsVvwaTqQEF5V+P0
         iJwC7KJMbXE9RV1o+Gk8D0J2dlElgv+UNBc3mwfDm1/NL27uIWvp939PrVzv+NDspaEt
         vQK3mJAE5I22dezyt/UnrUgVDfmt31JpBYMDb/ebI2/ULZFpGmJAH/hSsOnhfFqW6/Oy
         +LIQ==
X-Gm-Message-State: APjAAAUSSAkIdp/7jktYuCwfbDJv6CfyP/T+LjXZTKpc526Jl2kouwJS
        dyBw4AxjZdIncaiS8pUJRQw=
X-Google-Smtp-Source: APXvYqzHqFhE2wgNPnmJ3eHNmxFUTsDTmIxcbcPw7EKuNIc9wj4lVW7Whkp82thKOCtWWX9j7MHTZA==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr13618720wmi.16.1562603279261;
        Mon, 08 Jul 2019 09:27:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s10sm83861wmf.8.2019.07.08.09.27.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:27:58 -0700 (PDT)
Date:   Mon, 8 Jul 2019 18:27:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/topology changes for v5.3
Message-ID: <20190708162756.GA69120@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-topology-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-topology-for-linus

   # HEAD: eb876fbc248e6eb4773a5bc80d205ff7262b1bb5 perf/x86/intel/rapl: Cosmetic rename internal variables in response to multi-die/pkg support

Implement multi-die topology support on Intel CPUs and expose the die 
topology to user-space tooling, by Len Brown, Kan Liang and Zhang Rui.

These changes should have no effect on the kernel's existing 
understanding of topologies, i.e. there should be no behavioral impact on 
cache, NUMA, scheduler, perf and other topologies and overall system 
performance.


  out-of-topic modifications in x86-topology-for-linus:
  -------------------------------------------------------
  drivers/base/topology.c            # 2e4c54dac7b3: topology: Create core_cpus a
                                   # b73ed8dc0597: topology: Create package_cpu
                                   # 0e344d8c709f: cpu/topology: Export die_id
  drivers/hwmon/coretemp.c           # 835896a59b95: hwmon/coretemp: Cosmetic: Re
                                   # cfcd82e63288: hwmon/coretemp: Support mult
  drivers/powercap/intel_rapl.c      # 9ea7612c4658: powercap/intel_rapl: Update 
                                   # 32fb480e0a2c: powercap/intel_rapl: Support
                                   # aadf7b383371: powercap/intel_rapl: Simplif
  drivers/thermal/intel/x86_pkg_temp_thermal.c# b2ce1c883df9: thermal/x86_pkg_temp_thermal
                                   # 724adec33c24: thermal/x86_pkg_temp_thermal
  include/linux/topology.h           # 2e4c54dac7b3: topology: Create core_cpus a
                                   # 0e344d8c709f: cpu/topology: Export die_id

 Thanks,

	Ingo

------------------>
Kan Liang (5):
      perf/x86/intel/uncore: Support multi-die/package
      perf/x86/intel/rapl: Support multi-die/package
      perf/x86/intel/cstate: Support multi-die/package
      perf/x86/intel/uncore: Cosmetic renames in response to multi-die/pkg support
      perf/x86/intel/rapl: Cosmetic rename internal variables in response to multi-die/pkg support

Len Brown (9):
      x86/topology: Add CPUID.1F multi-die/package support
      x86/topology: Create topology_max_die_per_package()
      cpu/topology: Export die_id
      x86/topology: Define topology_die_id()
      x86/topology: Define topology_logical_die_id()
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
