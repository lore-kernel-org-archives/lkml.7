Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6DFC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0412082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557135309;
	bh=huIACiIBjmWbSTxsLu9gbwVrno+enrHwzv+rYcwmQ1w=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DQk+CQVT5Hq1uMOXM0RScFUHMHXADy8m8MJ26s1MwFMANcqv+grKk3rq6tduOmCqZ
	 L0w95Op8wSl5mLLb9MpcnzJOZ5aL3cOH1SM2kqbEstI9ePVc9JtuCoMyg2UQ+uvbi9
	 XC8ZoaWlZW06EG50uJm90Xjw/qOZaj7llLtKRiGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEFJfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:35:08 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39863 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFJfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:35:07 -0400
Received: by mail-wr1-f45.google.com with SMTP id v10so4072568wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=awhhrnN2/+oxUF2NNig63hHj+UDu6IjGilpFCLNHsYc=;
        b=thAZLvYifY0AML0erfiAC1u3F2RTmP3/msIYKbnNfcCyLlvwvk5eQPui1qSVjhkLKf
         lhx6olM9LApDXJG/osmfaW/+bubFdLd27yUfpSgmOJI1QcLEDfAZtzAS3tHxF+M63PR0
         /rZN1OStxvB4nPRxi40ofxNkpnwf+ACB7Lq2E5xEcQHLvHirA4I9kevtbaZ1x6wR4BGN
         VQbaD4IrcKzBCehG0ENJWL7fuNGm5zxkZPs975LlaUTs7JjRsF7K0m0nk7PlT7oIrnyN
         wGgQHdQS3CdWBiFoNHyhYMiUV7K4uaCjPOlIIsCWHOR1pxdsSKlpzADlWSGrl5b83zWR
         PWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=awhhrnN2/+oxUF2NNig63hHj+UDu6IjGilpFCLNHsYc=;
        b=h0ir4hqd8UsZCmMF5BS6EcTTW4IGaAVq+q7HUOrCse4lOr+GAdGQsuKPo9kWGOC9sc
         7xjSUBEZuP2sE8HNtcPXMNB8Y+g4Ms8pXPmW6TbEH/2lw/HNIcv5WxdYZv4Rj74NU2yn
         4mLXb0v7hI1szXYGaqq6H+I/5ONJNxLMGx5LvdUqN34aip4AfRqpYVg5yn/enIzZZVXs
         RFfMt72yQy0RIoDWEI63yPB6Wk6YBphZotVqkp9TiaeXPGB+9CsDy3ATJxB6ozqSl0hG
         npSNBMV59ZKsnsnmQa7k0Vuhr075OutVzgqjh4L9m3WJwBwkq0wCLCvtZiNmGG1GILo9
         xSrA==
X-Gm-Message-State: APjAAAV+Ldu4GbAdBrVmXXYvRc9w6DkD+ROdRUmDS6fR5DO8WHPVlyke
        WBug+g4OWot20vctOQH7sse6JRB5
X-Google-Smtp-Source: APXvYqyrujTuX8ge/NPahf0KLgmOo1CEQQ/zMSF03eg+PnSj9qmP6hbjeCZuHmRPCNocvva7WUtPpA==
X-Received: by 2002:adf:e907:: with SMTP id f7mr10579427wrm.125.1557135305934;
        Mon, 06 May 2019 02:35:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 91sm15645125wrs.43.2019.05.06.02.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:35:05 -0700 (PDT)
Date:   Mon, 6 May 2019 11:35:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/asm changes for v5.2
Message-ID: <20190506093503.GA55099@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-asm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

   # HEAD: 3855f11d54a07256cc4a6fb85c692000208a73a7 x86/um/vdso: Drop unnecessary cc-ldoption

This tree includes the following changes:

 - cpu_has() cleanups
 - sync_bitops.h modernization to the rmwcc.h facility, similarly to bitops.h
 - Continued LTO annotations/fixes
 - misc cleanups and smaller cleanups

 Thanks,

	Ingo

------------------>
Andi Kleen (2):
      x86/asm: Mark all top level asm statements as .text
      x86/cpu/amd: Exclude 32bit only assembler from 64bit build

Borislav Petkov (4):
      x86/cpufeature: Remove __pure attribute to _static_cpu_has()
      x86/asm: Clarify static_cpu_has()'s intended use
      x86: Convert some slow-path static_cpu_has() callers to boot_cpu_has()
      x86/mm: Convert some slow-path static_cpu_has() callers to boot_cpu_has()

Jan Beulich (1):
      x86/asm: Modernize sync_bitops.h

Jann Horn (1):
      x86/uaccess: Fix implicit cast of __user pointer

Leonardo Brás (1):
      x86/vdso: Rename variable to fix -Wshadow warning

Masahiro Yamada (1):
      x86/build/vdso: Add FORCE to the build rule of %.so

Nick Desaulniers (1):
      x86/um/vdso: Drop unnecessary cc-ldoption


 arch/x86/entry/vdso/Makefile         |  2 +-
 arch/x86/entry/vdso/vdso2c.h         | 13 +++++++------
 arch/x86/include/asm/cpufeature.h    | 11 +++++++----
 arch/x86/include/asm/fpu/internal.h  |  7 +++----
 arch/x86/include/asm/sync_bitops.h   | 31 +++++++++----------------------
 arch/x86/include/asm/uaccess.h       |  3 +--
 arch/x86/kernel/apic/apic_numachip.c |  2 +-
 arch/x86/kernel/cpu/amd.c            |  5 ++++-
 arch/x86/kernel/cpu/aperfmperf.c     |  6 +++---
 arch/x86/kernel/cpu/common.c         |  2 +-
 arch/x86/kernel/cpu/mce/inject.c     |  2 +-
 arch/x86/kernel/cpu/proc.c           | 10 +++++-----
 arch/x86/kernel/kprobes/core.c       |  1 +
 arch/x86/kernel/ldt.c                | 14 +++++++-------
 arch/x86/kernel/paravirt.c           |  2 +-
 arch/x86/kernel/process.c            |  4 ++--
 arch/x86/kernel/reboot.c             |  2 +-
 arch/x86/kernel/vm86_32.c            |  2 +-
 arch/x86/lib/error-inject.c          |  1 +
 arch/x86/mm/dump_pagetables.c        |  4 ++--
 arch/x86/mm/pgtable.c                |  4 ++--
 arch/x86/mm/pti.c                    |  2 +-
 arch/x86/um/vdso/Makefile            |  2 +-
 23 files changed, 63 insertions(+), 69 deletions(-)

