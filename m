Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5027EC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228F3216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568640318;
	bh=OiAkGyDRKCvfn3vNFv3C2SeQILtTHjdtRNQHWGNDemA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gjbZA/8cB3G8eUtPthc4YZjSlQRt5qP1i2vvIPukg2vqTF6T/tJkHkopSHBSF8PFN
	 jTC8PP6rCV5eL4RJneTlFwvaQvgY37ThLxlLSuot1fVcSft7njDsM8Pf2Cp4h6CEww
	 bP+7+4wfpgIGBQPAqoNKvmZ8SGbOTgX79K5ZIiR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733176AbfIPNZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:25:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54723 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfIPNZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:25:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so10140898wmp.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=X7H3NzseuQmpiOdoQmBafMaPyBN8wulz+EJiV4/1jLk=;
        b=rATz4Fb9jvhoiyikJwq3HPAiEs/Z5q7GFzsREtY55wZRarLu/lBzHwB3NzKYiR/dLv
         +81WKNDBc/s/Dlgmg3sMqoXoL5Fa3rCRGsVHQph4Ef8v+vBdcR6/PCx/ESrY/SfHaQrD
         G5GqqfnFAlcYUqHV1uvYwK3EN5Ihwu65jVhSVBTTmkCB6SxoQk7f/sOxH5jxPq9HkUBW
         MRM+a10EMGKQse695TxAjULME4CpmEPFuj4Ya9/EBv7JxIXLM3dO/CPu3qjut0sL6E4q
         UWy9AgO8yo1PWkQwuP+wau1nxdEG/0P1qQxjzIuhaKD8bEyTvNWOeJ8Nhdtyc0Sjui88
         Bplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=X7H3NzseuQmpiOdoQmBafMaPyBN8wulz+EJiV4/1jLk=;
        b=RKShcBF73Vf58lYB6jGTDo84P5qsf5EyDu0eoNXPWTb2Q4Mzy8TaXMpGi39+vtSJlT
         NrYuoPk89pBfNUthNYDx3dLLzOH40g1oq0TNRfCCmX7XaehfYN33DYcqcVz0EYBmI2ls
         Cmd0J3ASPlG/QJkuErNCDBKxnriDwZXqK01oZkHHbOiAMBp4VQi3Eqgz0GjH2uyQnatQ
         Byk/f9vAgmTMFRiS1FtKmO4/uHXg7virHmrvHqWlrf6Mdqdl+C0IYBIGLUFizOdfZ2xs
         y/rCkz5G6nfvIb8CaiIuE4TlgS5dLhf+RWERwRGRhG//72YBwtjUzChOJxmVZGZOD5nn
         GBCw==
X-Gm-Message-State: APjAAAX9q8ylM7zbNSZLolA8JB/34a6ihVAP+TacEUNCwCoZeNm8RY8g
        /K5mYSjdPWMVvQ6m197p5T4=
X-Google-Smtp-Source: APXvYqwLPHmLO843aXcS4+u2r7JB+gu25VRB12QJT+1YK9zpCgN0xt3jbEUdqv5Ukv7OLtOmcDvClA==
X-Received: by 2002:a1c:99cd:: with SMTP id b196mr13741244wme.83.1568640313280;
        Mon, 16 Sep 2019 06:25:13 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b16sm56001105wrh.5.2019.09.16.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 06:25:12 -0700 (PDT)
Date:   Mon, 16 Sep 2019 15:25:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/mm changes for v5.4
Message-ID: <20190916132510.GA28017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-mm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

   # HEAD: bc04a049f058a472695aa22905d57e2b1f4c77d9 x86/mm: Fix cpumask_of_node() error condition

The changes in this cycle were:

 - Make cpumask_of_node() more robust against invalid node IDs

 - Simplify and speed up load_mm_cr4()

 - Unexport and remove various unused set_memory_*() APIs

 - Misc cleanups

 Thanks,

	Ingo

------------------>
Cao jin (1):
      x86/fixmap: Cleanup outdated comments

Christoph Hellwig (4):
      x86/mm: Unexport set_memory_x() and set_memory_nx()
      x86/mm: Remove the unused set_memory_array_*() functions
      x86/mm: Remove set_pages_x() and set_pages_nx()
      x86/mm: Remove the unused set_memory_wt() function

Jan Kiszka (1):
      x86/mm: Avoid redundant interrupt disable in load_mm_cr4()

Peter Zijlstra (1):
      x86/mm: Fix cpumask_of_node() error condition

Vlastimil Babka (1):
      x86/kconfig: Remove X86_DIRECT_GBPAGES dependency on !DEBUG_PAGEALLOC


 arch/x86/Kconfig                   |   2 +-
 arch/x86/events/core.c             |   2 +-
 arch/x86/include/asm/fixmap.h      |   5 +-
 arch/x86/include/asm/mmu_context.h |   8 +--
 arch/x86/include/asm/set_memory.h  |   8 ---
 arch/x86/include/asm/tlbflush.h    |  30 +++++++---
 arch/x86/kernel/machine_kexec_32.c |   4 +-
 arch/x86/mm/init_32.c              |   2 +-
 arch/x86/mm/numa.c                 |   4 +-
 arch/x86/mm/pageattr.c             | 110 -------------------------------------
 arch/x86/mm/tlb.c                  |   2 +-
 11 files changed, 37 insertions(+), 140 deletions(-)
