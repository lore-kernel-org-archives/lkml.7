Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0327C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DE120865
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUeAQwtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfJDBUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:20:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35436 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbfJDBU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:20:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so4039337wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 18:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLQZIvjSPOCDt9axSurKW5wDdt0lMEsivNiHJ4gB4oE=;
        b=hUeAQwtxYMBXzOWe/RGhcbRRUYRoTG881YZnt9D7/PUlJ6t+FQ7eLM2cahuJDThvlq
         hnSfrRwcrX1UxoFoXFkDoF0GMnBMhzhC1/weNm6puwjWemTCi9KfQy2HVjQ7wfGtph69
         uSt7mq9kxN5ouoNFHFqrs9H/b4ovG8iQM7/MZTWvWQO8KK9ivgfPQ1T7wpkSMgCqMIg/
         FFpoMxxg1BHHWmmScUrWj9mAoWMF8yMUs/GClejcv4g1RPymN8rt16i0NH+LLjupU0EZ
         MH0b3dngxTx4GgO0x7Q4eUOIyX50abIy8ItfW9F6KSRK2qWMhvu8qN0HeU0itLAssVTc
         S2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLQZIvjSPOCDt9axSurKW5wDdt0lMEsivNiHJ4gB4oE=;
        b=i7jQHsYwrilZ2yRLvkOguef7VtouIUDaeAT3TeyVy9K7i1SRfsSKzfr022wOhbCuXN
         K3TRx8ia4nzQ545yziEbAIzLLF/3H1uGrF4rwD/IfoosdBxkQB5UqdPVJPZaciF+TbYY
         9inUPLu6ktM+c+DFy+PZwVSNYgx989plJZ9PA6Rli4vZr5FUqiGKXwKWzsvjS6kLslzG
         cZXCGO60LPNzhGtV/ErDefKHZb8SOqteR6aigD3dZk3fDJYt7Y59BDxDtU43E5W9MgJo
         SaNhrNGxe9Dpn8rs3WM5k6CFEEjnx+ImM3tErJr+zbLiRIScQDuUIOJXov07WSygROKR
         YyPA==
X-Gm-Message-State: APjAAAUbg2Qr4zbQN96FmlKeCMRJzCL6HDztrv8E8lELdVWG9/sq7GEl
        //ylcHviPZzqgn2vn6HWvaekBCYs0w+FgA==
X-Google-Smtp-Source: APXvYqxWsnGME6HWZr7DYi55om3vkGq7sNvq1bgPC3LfGaya+9JAAU1TdTDKNpkgF/RchH8xcsn6SQ==
X-Received: by 2002:a05:600c:295d:: with SMTP id n29mr8373193wmd.36.1570152025588;
        Thu, 03 Oct 2019 18:20:25 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id a4sm4097404wmm.10.2019.10.03.18.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 18:20:24 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [RESEND PATCH v3 0/9] hacking: make kconfig menu 'kernel hacking' better structurized
Date:   Fri,  4 Oct 2019 09:20:01 +0800
Message-Id: <20191004012010.11287-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a trivial improvment for the layout of 'kernel hacking'
configuration menu. Now we have many items in it which makes takes
a little time to look up them since they are not well structurized yet.

Early discussion is here:
https://lkml.org/lkml/2019/9/1/39

This is a preview:

  │ ┌─────────────────────────────────────────────────────────────────────────┐ │  
  │ │        printk and dmesg options  --->                                   │ │  
  │ │        Compile-time checks and compiler options  --->                   │ │  
  │ │        Generic Kernel Debugging Instruments  --->                       │ │  
  │ │    -*- Kernel debugging                                                 │ │  
  │ │    [*]   Miscellaneous debug code                                       │ │  
  │ │        Memory Debugging  --->                                           │ │  
  │ │    [ ] Debug shared IRQ handlers                                        │ │  
  │ │        Debug Oops, Lockups and Hangs  --->                              │ │  
  │ │        Scheduler Debugging  --->                                        │ │  
  │ │    [*] Enable extra timekeeping sanity checking                         │ │  
  │ │        Lock Debugging (spinlocks, mutexes, etc...)  --->                │ │  
  │ │    -*- Stack backtrace support                                          │ │  
  │ │    [ ] Warn for all uses of unseeded randomness                         │ │  
  │ │    [ ] kobject debugging                                                │ │  
  │ │        Debug kernel data structures  --->                               │ │  
  │ │    [ ] Debug credential management                                      │ │  
  │ │        RCU Debugging  --->                                              │ │  
  │ │    [ ] Force round-robin CPU selection for unbound work items           │ │  
  │ │    [ ] Force extended block device numbers and spread them              │ │  
  │ │    [ ] Enable CPU hotplug state control                                 │ │  
  │ │    [*] Latency measuring infrastructure                                 │ │  
  │ │    [*] Tracers  --->                                                    │ │  
  │ │    [ ] Remote debugging over FireWire early on boot                     │ │  
  │ │    [*] Sample kernel code  --->                                         │ │  
  │ │    [*] Filter access to /dev/mem                                        │ │  
  │ │    [ ]   Filter I/O access to /dev/mem                                  │ │  
  │ │    [ ] Additional debug code for syzbot                                 │ │  
  │ │        x86 Debugging  --->                                              │ │  
  │ │        Kernel Testing and Coverage  --->                                │ │  
  │ │                                                                         │ │  
  │ │                                                                         │ │  
  │ └─────────────────────────────────────────────────────────────────────────┘ │  
  ├─────────────────────────────────────────────────────────────────────────────┤  
  │          <Select>    < Exit >    < Help >    < Save >    < Load >           │  
  └─────────────────────────────────────────────────────────────────────────────┘ 

v3:
  o change subject prefix.
v2:
  o rebase to linux-next.
  o move DEBUG_FS to 'Generic Kernel Debugging Instruments'
  o move DEBUG_NOTIFIERS to 'Debug kernel data structures'

Changbin Du (9):
  hacking: Group sysrq/kgdb/ubsan into 'Generic Kernel Debugging
    Instruments'
  hacking: Create submenu for arch special debugging options
  hacking: Group kernel data structures debugging together
  hacking: Move kernel testing and coverage options to same submenu
  hacking: Move Oops into 'Lockups and Hangs'
  hacking: Move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE
  hacking: Create a submenu for scheduler debugging options
  hacking: Move DEBUG_BUGVERBOSE to 'printk and dmesg options'
  hacking: Move DEBUG_FS to 'Generic Kernel Debugging Instruments'

 lib/Kconfig.debug | 663 ++++++++++++++++++++++++----------------------
 1 file changed, 342 insertions(+), 321 deletions(-)

-- 
2.20.1

