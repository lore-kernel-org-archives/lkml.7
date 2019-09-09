Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C42C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF13C2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCjSCxmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfIIOpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:45:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43932 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfIIOpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:45:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id u72so7951418pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XMf8ipCQZaPkITVT71omWOo1hBbmFuXz3Fapv/o2YOw=;
        b=XCjSCxmcjofiz3TCPr4owcjrgEfQnZjTyxV66kdBiN9g1QnJxR0T+5ZJyrtt2kLMTE
         S4iE6SB/LeGwfGRjEmjneEf5sn6EWuBQdsP3OgbWIS7JDHvvEb1a+zSqsTZZMZfzV0IQ
         EdNDHb1Bof7+KL0XoETG11wiiAjrI26KKBzFSqh2lUg4VrJtztR35ZhNcEc9sDCty9o8
         COZiYSwy+wOPmCxTiFPJxHy4uBhuXqzVB26/AAVxG80fAE2atbhu9xXUUfB5WvZbEGiN
         BuG1KuA4KKak5y/dYjnFnOYVWJptSP6A0En+fQaIzVVvGmqgW6gcd0TCLvwlZ5s9/Rrq
         w9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XMf8ipCQZaPkITVT71omWOo1hBbmFuXz3Fapv/o2YOw=;
        b=lX5eoeinlmfFwVzgmlWI7g3VEb0+EVq7olnuUfj2kWhXbxApvUZhga0j2AumvQJL/4
         GWUgR1ER+1n4x0X16Kw7v1BckI+a4zfXpQuQhGP3z3A1IN80dc2sfXxLMW8LqXOooa5s
         xb+pdniHYGSwARkduBR1Oj5LhGK95DOUdt8aI2xM6AJoWxkSVs0hplGuYpE13Kn6ObBz
         D7fHVyefrRTMbp82z1VAgQ00PL0kl44OOs7koaRzV+jpuoor1KLpST9Edkcg0/uIhJFo
         f7HIvXy6ooBok3q3f8iWVth+KWJPkQtx5XxB3EPBP0CgFnT6m2prwLDVORVGaSrCGvPX
         y+sA==
X-Gm-Message-State: APjAAAWckhyECMO3Ui4jua9oF3X030vuYXd9PtNP4qGu2aVW1ltkYckw
        dkDPnOnMpceUrgjWr2GpPss=
X-Google-Smtp-Source: APXvYqx/Lg4qPpgqbNggALjLu2QpFVaYqXHhznXoTjfHd3CGCTIcmb3zRCsNfc/R0fXtn3RxvxKpGw==
X-Received: by 2002:a63:ec48:: with SMTP id r8mr21111166pgj.387.1568040308667;
        Mon, 09 Sep 2019 07:45:08 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id t9sm15334693pgj.89.2019.09.09.07.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:45:08 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 0/9] hacking: make 'kernel hacking' menu better structurized
Date:   Mon,  9 Sep 2019 22:44:44 +0800
Message-Id: <20190909144453.3520-1-changbin.du@gmail.com>
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

 lib/Kconfig.debug | 659 ++++++++++++++++++++++++----------------------
 1 file changed, 340 insertions(+), 319 deletions(-)

-- 
2.20.1

