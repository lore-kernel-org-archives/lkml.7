Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347A1C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0B82082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574689113;
	bh=dWbzYOU+bRrP6xakmEMeeH+lgk7SwLwvQkomm8ilLdw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DKkXL7i4nbEXWjUsM2bXpkrJYw2Oei6fqA9UTcz5t+v7xLFniK5JFOTyAt9kRQHfa
	 bgXU/S/X8yXlRTTS2ot9/RWHAv54/jngtmKlXqVFlGGxzT/3kV3+JeEDMt/6A5NcVD
	 yGOxpnt1jxJSp4TWUHk9T1JeQhNZQqLRREMlx/jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfKYNic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:38:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36124 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKYNib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:38:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so18065423wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 05:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FlshBZLn8Dtz/tmFcJUBq/jo7RmSZXp/coZ76SfQlvY=;
        b=kk7wV8P6IerK+yYawmp4nwDw3d9cepjP2q8xWeXb0zfkSqM6jfU+NiyVszvfDcpeq3
         Z2nxVwBlwVtA9/oTFT9on/LtUJhqHvSLetIvzDQV3NJ3uFCrfqo8FDqTBi1fyUH18aId
         BN5cz8Us+pwW0JlKUzp2YtTBqr1q709+4O6X/mCZZFyIlD1AvkElPe8kTKOMzJbOOxoE
         o1Em7i8dqUk0iA6o2nD4uQfOGlo8QzjUx+rpMrc1P15GgvbiRfIBmr3YhkPX7rZq56eV
         AHCVwHdJQuSmcHMI134T2PnzKFrqwvcQo9FDZcqb4w4pxo5OcCbO2Jn+R5Z0JwMJM+DJ
         +IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=FlshBZLn8Dtz/tmFcJUBq/jo7RmSZXp/coZ76SfQlvY=;
        b=s6KIBqmtCzcFnFiD44D2zg91syE5AOt27aetH5Y6pV7dTJ/VlimXtHUsmw5DgR9yfC
         3GS5fLqdjUNPpPdwdMS8WeU50fL1Ae0zETQ0QMdTQYEI4PZBPyvgPek075RNNrmFNZT6
         Wgxg+y2MrbIZft4AWNdjFsazUFr1HCxc/0RJ/hvE2bULm2rRMXlr9LFnrnW2DzpwHmGm
         2ABHyrZNJuxPVEANIvm0m6qdyUNB28lBWDQNS4mBclb33Lv3ytQl3AJ/y9O1hLgWXWjV
         OgOtORNJINJOT9qClB5KHr2eqGvBcxFRudfodxLk8I477A11Gi88VFJ4NI+n5WTXP9ql
         2Htg==
X-Gm-Message-State: APjAAAVnkfQt8TXUG1kg7tob2w3tb8c4oCgiBwtqZ8NtSJk/mY6nJmEH
        usJVUb3vD1/aJjT8UOzYyp0K+EUO
X-Google-Smtp-Source: APXvYqwiZSuLmOXL2EkTjlktrcRUA69wRuyiI6+1YuYhNACXJS3M8FPvdghRsAwfW3kZDnUKkui2Rg==
X-Received: by 2002:adf:f20d:: with SMTP id p13mr30104912wro.325.1574689109430;
        Mon, 25 Nov 2019 05:38:29 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id m3sm11170256wrb.67.2019.11.25.05.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:38:28 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:38:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cpu changes for v5.5
Message-ID: <20191125133826.GA88582@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

   # HEAD: db8c33f8b5bea59d00ca12dcd6b65d01b1ea98ef x86/cpu: Align the x86_capability array to size of unsigned long

Misc changes:

 - math-emu fixes,

 - CPUID updates,

 - sanity-check RDRAND output to see whether the CPU at least
   pretends to produce random data,

 - various unaligned-access across cachelines fixes in preparation of 
   hardware level split-lock detection,

 - Fix MAXSMP constraints to not allow !CPUMASK_OFFSTACK kernels with 
   larger than 512 NR_CPUS.


 Thanks,

	Ingo

------------------>
Arnd Bergmann (2):
      x86/math-emu: Check __copy_from_user() result
      x86/math-emu: Limit MATH_EMULATION to 486SX compatibles

Babu Moger (3):
      x86/cpufeatures: Add feature bit RDPRU on AMD
      x86/Kconfig: Rename UMIP config parameter
      x86/umip: Make the comments vendor-agnostic

Borislav Petkov (1):
      x86/rdrand: Sanity-check RDRAND output

Fenghua Yu (2):
      x86/cpu: Align cpu_caps_cleared and cpu_caps_set to unsigned long
      x86/cpu: Align the x86_capability array to size of unsigned long

Scott Wood (1):
      x86/Kconfig: Enforce limit of 512 CPUs with MAXSMP and no CPUMASK_OFFSTACK


 arch/x86/Kconfig                               | 22 +++++++++++-----------
 arch/x86/Kconfig.cpu                           | 25 ++++++++++++++++---------
 arch/x86/Makefile_32.cpu                       |  1 +
 arch/x86/include/asm/cpufeatures.h             |  1 +
 arch/x86/include/asm/disabled-features.h       |  2 +-
 arch/x86/include/asm/module.h                  |  2 ++
 arch/x86/include/asm/processor.h               | 10 +++++++++-
 arch/x86/include/asm/umip.h                    |  4 ++--
 arch/x86/kernel/Makefile                       |  2 +-
 arch/x86/kernel/cpu/common.c                   |  5 +++--
 arch/x86/kernel/cpu/rdrand.c                   | 22 +++++++++++++++++++++-
 arch/x86/kernel/umip.c                         | 12 ++++++------
 arch/x86/math-emu/fpu_system.h                 |  6 ++++--
 arch/x86/math-emu/reg_ld_str.c                 |  6 +++---
 tools/arch/x86/include/asm/disabled-features.h |  2 +-
 15 files changed, 82 insertions(+), 40 deletions(-)

