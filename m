Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41710C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1363B2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574688520;
	bh=BwPfiXh/zNYeFGA9sJGWZNDQpiTA2qjZ+6UpOHo6cNk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=OUHpMgNxx6lJn3U2qHQPdZUXEHGQzTj/eBG0ZoZF9xsTtmsi8mWAfExLhNhhCK55s
	 ov9jxakgvGXNTtJthMMl57ttinPsEit3375q4vcHteAa22UNMNIoR3yHghUQDzB/sG
	 549ab8HGGD7mfKOJ4Hz86tGFasTdJnyipJUB2Sow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfKYN2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:28:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41581 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfKYN2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:28:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id b18so18025661wrj.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 05:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RPa4rXJAe2pIr0ygYh4omzLjhrt5K4J/XRs2z41ID0o=;
        b=KxStKqct/jKeKxr4rUeo8/bHXjnnK/stjNHlcee0JD2f6ZrgyRPex1vocIkK9Cg0cc
         6ZZMYgOxnPIA2+BVEXcOcw6yTX1s/x7TB0mMBhfqE8OcGNkRFMYjdA7eHgyzBRJO48w5
         bw9iFWOHQhYAwhPy8yoI1sq5Y6QETPkvV+cKP+8SOkm6HdPoPnyO0dS3nTddVKebx3Y1
         763jt1Xp5pB3A0cKSyG48KscEPvp62Im2U2sJTjigjRYxaeukW6kgrbXbryY89fNhVOK
         uEIOetgUV51OHTlL+6ROsvfQHfw/6/YMAalNpDxouHY5eILfgkJVuPJIPMsgixqH+n3B
         CG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=RPa4rXJAe2pIr0ygYh4omzLjhrt5K4J/XRs2z41ID0o=;
        b=gAQtMvrBuoRVaNM7xO49beUxjRV4dgiMuLwCYhouBs49Tl6XiXx8GlLrk6AsHsIrvQ
         tcKEALmsPS3hOebIYLmrYKrOJJZFZXRIQM48Rqq+IHzHAdsbqAxQwrZgnoG3sZNoDw0m
         YWgWB7lvDCA2kn64dW3T42WmuCTHn4gStxrno0Pmh0Eb1lpn7IMOAwE2czaXkYbBS+Rh
         JnEKAMECIhbECjdPMucU2i2dvn9Gncxsl8a38x/NO+hgqsoze6pDMgvomAJCJYLtZ7Gx
         42vP0keYrSuGiIB0FiGlnPFnbTwCyP+1rd6ukTewsT2nEdxJVbU4L0SjD90ZXerW35fR
         H2ew==
X-Gm-Message-State: APjAAAV4yS1ZHV3oI7K4Z9pDj9ZWsQhXifiIG04DO9QnzyOAV+AT+t4X
        cn8ajV+EATXNcPGhCshv3FI=
X-Google-Smtp-Source: APXvYqy53JZV6YJMBOjXJw4wK30/oImOypqb5IBJ4GxrT7CaHdXtz5pDvStMk8v8cFbv4RmV9pHS2A==
X-Received: by 2002:adf:f689:: with SMTP id v9mr13356039wrp.28.1574688516814;
        Mon, 25 Nov 2019 05:28:36 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w7sm10084181wru.62.2019.11.25.05.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:28:36 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:28:34 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cleanups for v5.5
Message-ID: <20191125132834.GA42801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cleanups-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

   # HEAD: b41d62201b9772c7c750360ab668d2caa502e642 x86: Remove unused asm/rio.h

Misc cleanups, plus the removal of obsolete code such as Calgary IOMMU 
support, which code hasn't seen any real testing in a long time and 
there's no known users left.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/nmi: Remove stale EDAC include leftover

Cao jin (1):
      x86: Fix typos in comments

Christoph Hellwig (3):
      x86: Remove the calgary IOMMU driver
      x86/pci: Remove pci_64.h
      x86/pci: Remove #ifdef __KERNEL__ guard from <asm/pci.h>

Lianbo Jiang (1):
      x86/kdump: Remove the unused crash_copy_backup_region()

Thomas Gleixner (1):
      x86: Remove unused asm/rio.h

Yi Wang (1):
      x86/apic, x86/uprobes: Correct parameter names in kernel-doc comments


 MAINTAINERS                       |   10 -
 arch/x86/Kconfig                  |   30 -
 arch/x86/configs/x86_64_defconfig |    1 -
 arch/x86/include/asm/calgary.h    |   57 --
 arch/x86/include/asm/crash.h      |    1 -
 arch/x86/include/asm/pci.h        |    7 -
 arch/x86/include/asm/pci_64.h     |   28 -
 arch/x86/include/asm/rio.h        |   64 --
 arch/x86/include/asm/tce.h        |   35 -
 arch/x86/kernel/Makefile          |    1 -
 arch/x86/kernel/apic/apic.c       |    2 +-
 arch/x86/kernel/pci-calgary_64.c  | 1586 -------------------------------------
 arch/x86/kernel/pci-dma.c         |    6 -
 arch/x86/kernel/setup.c           |    6 +-
 arch/x86/kernel/tce_64.c          |  177 -----
 arch/x86/kernel/traps.c           |    5 -
 arch/x86/kernel/uprobes.c         |    2 +-
 arch/x86/mm/numa.c                |    2 +-
 18 files changed, 6 insertions(+), 2014 deletions(-)
 delete mode 100644 arch/x86/include/asm/calgary.h
 delete mode 100644 arch/x86/include/asm/pci_64.h
 delete mode 100644 arch/x86/include/asm/rio.h
 delete mode 100644 arch/x86/include/asm/tce.h
 delete mode 100644 arch/x86/kernel/pci-calgary_64.c
 delete mode 100644 arch/x86/kernel/tce_64.c
