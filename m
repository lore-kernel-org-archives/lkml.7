Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2A9C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309C5216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562602799;
	bh=nFIEF674eTjRL4NtJWR1yg9xkZ3ceGuFo/Es0xMV4us=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=otf+MsFBgsJTlGdhG2j9Kpo+Ew+GvVDd75tWHRO9Rk1Ud0sRNCt4V0m5B223HOBKU
	 QHPS2bHFB5cFfS0vucZ3wC6bvoMj0jxd1QPP5MCE7cAZTob6AYd9QlM4NSCBbcf64r
	 dhxzar675rL1+P749+UsGz82QMVmep4qy44pRl4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391151AbfGHQT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:19:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42902 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfGHQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:19:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id a10so16713005wrp.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ssJY1qamXYCfGxIthjgUxMdYAMchJ/DdKcse06j62Yg=;
        b=Am/1lPdQW891KZjQ5d9LksnbFRRqmOSAyXeAzVwqlSI8GL0dvFcSXjyaXmWUsCpM5M
         Ie3oKkT7bKSQOe8125CGoJ7zSxiN0izP2XMJKHF1TneH2YNMAiecqym2RnD326N5CGVR
         sWVt3mxzKLzCMuulBKTZL4rMqhY32XrfHvzkqJwGQnvULZrs009NR0FmmRskewTUI3J5
         fIvpoY0yHZm9RBvKEylh9GMkGD2f26rRCWYWFfZm3pDmzT2oHR6boiBAmMwwX2CdnV4X
         V6MdsxwkzUVkM56PMpGWqMgIqViaJiy/Z50ywvZlR6D2ucInz3iUyuM+W+v9FLHV+kWP
         yIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ssJY1qamXYCfGxIthjgUxMdYAMchJ/DdKcse06j62Yg=;
        b=LHEnwLMKcr17n89DbWr4hhp5XOzPZEB2PgK252lefN+j4k1EQHAmfyAowa0nNSeK7X
         xc4Tr5DWr08tQTT6m7WM21aemp+Ak4feaxqjG1JfSynnQLhtxjKuaK3VMA8toOvA2GG9
         Ca7lg1sg6fObyeT5t1aLuOaDukHsf/hMApoCVOsH6PNGn42Wx6SOgdjCjZLIxiBSkf/2
         Yi/zySw+8ckdnmn3YZ9DW25t2PXhCcxaaxCPlUuLqs0e4B+GbOxORLjkx0KaYKV9yKCI
         aFvikSPYNEVJsRdH6cqVkFxh1ojlXNGpyb2DR6X737z/7esXcRwAVkNwi3UEJpbbt98a
         kScw==
X-Gm-Message-State: APjAAAWJX36KFAHRjno6YrhaRu+sdBLzl1OYGAITYXfyraP9peYBTJz6
        xsNqx3RLsAqIxjrrtXkDkYw=
X-Google-Smtp-Source: APXvYqzQaeTIq/c82iJz/3KccT75kGLmh4nj7tkebwLJ21ZgCPQp1Q9Mq4SBQfQAl9EF7sLovE4ObA==
X-Received: by 2002:adf:a143:: with SMTP id r3mr19850852wrr.352.1562602793507;
        Mon, 08 Jul 2019 09:19:53 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w14sm14569894wrk.44.2019.07.08.09.19.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:19:52 -0700 (PDT)
Date:   Mon, 8 Jul 2019 18:19:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/platform changes for v5.3
Message-ID: <20190708161951.GA27443@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-platform-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

   # HEAD: d97ee99bf225d35a50ed8812c3d037b2ba7ad2ea x86/jailhouse: Mark jailhouse_x2apic_available() as __init

Most of the commits add ACRN hypervisor guest support, plus two cleanups.

  out-of-topic modifications in x86-platform-for-linus:
  -------------------------------------------------------
  drivers/hv/Kconfig                 # ecca25029473: x86/Kconfig: Add new X86_HV_

 Thanks,

	Ingo

------------------>
Linus Walleij (1):
      x86/platform/geode: Drop <linux/gpio.h> includes

Zhao Yakui (3):
      x86/Kconfig: Add new X86_HV_CALLBACK_VECTOR config symbol
      x86: Add support for Linux guests on an ACRN hypervisor
      x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR for ACRN guest upcall vector

Zhenzhong Duan (1):
      x86/jailhouse: Mark jailhouse_x2apic_available() as __init


 arch/x86/Kconfig                  | 14 ++++++++
 arch/x86/entry/entry_64.S         |  5 +++
 arch/x86/include/asm/acrn.h       | 11 +++++++
 arch/x86/include/asm/hardirq.h    |  2 +-
 arch/x86/include/asm/hypervisor.h |  1 +
 arch/x86/kernel/cpu/Makefile      |  1 +
 arch/x86/kernel/cpu/acrn.c        | 69 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/hypervisor.c  |  4 +++
 arch/x86/kernel/irq.c             |  2 +-
 arch/x86/kernel/jailhouse.c       |  2 +-
 arch/x86/platform/geode/alix.c    |  1 -
 arch/x86/platform/geode/geos.c    |  1 -
 arch/x86/platform/geode/net5501.c |  1 -
 arch/x86/xen/Kconfig              |  1 +
 drivers/hv/Kconfig                |  1 +
 15 files changed, 110 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/include/asm/acrn.h
 create mode 100644 arch/x86/kernel/cpu/acrn.c

