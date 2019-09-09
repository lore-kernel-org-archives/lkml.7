Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3246C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AEE2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i85xtAdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfIIOSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:18:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45140 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbfIIOSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:18:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id 4so7899886pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FqsLE6dJQNaae2r2OnNd0/3uT5v9jEmc9F7smfHJzOg=;
        b=i85xtAdSj/Ovn9w3u5IjryrlyxD1yNYZsEUT9DO8msjHFXK6XmideyjU9pv9TXGzwe
         QAnHYkIVkVd2wYfLSaT5x56fDTkIpYClyNK5jTgWas5yp0WXUN592U3Ui1QPZ4UADhmZ
         dsA6BGlRiRnhhstjE/B76wSNVo03e6cTOLQrN84I7YHks5u3J1MqRcMRKF2sJCmQwRc4
         cJ+NoMNEGLheaLnWhFUZCb2g4nn2YiLx1nsNlqP2KdJtVUGp4mo0bfm4hWNP5qDCoeSE
         xLnokbjrPKEaQqoBsI/5/2i0DweVJc3b50LJZzNXbzMwZdhqCopo1GZt9gFDJ/w0ZPQz
         cwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FqsLE6dJQNaae2r2OnNd0/3uT5v9jEmc9F7smfHJzOg=;
        b=rM1R4kYvqdvBNaSBiIifIrK3I3+/8uI+9ZJrsjG8jnPip/JyzNyk0y85L2adNN29jK
         Cbgv9SweCrIrOdcRGUbdkWx6dlyKO4QpDk4XJfE/XSt0uFp01SvhIPXmwt0qUXZmuK1L
         +tW0YR6C5SLsNqBtCRCS6CfRF3omz2XsiL0edJEezWmi/NSPAhKFwol3HExXKWEJ6tzz
         0lH0hCZpTUwomeaVs3KMfH8ZokY+whK62R26uhde1FyZfS7u344p2siBs4IiQvqEDIsL
         +yzPfmjtS1M+giwvJVN23LgFBo0jxCmXDSuo+yKFEvm/+ofjEt6uRqlgULx/64pUNwmD
         8orQ==
X-Gm-Message-State: APjAAAX8fCFPjvFZNphwOaGb9TX02+/qSMLoRVOuI6HlJI/s+W1R3OER
        /vNMt0lervv8uEEFJR/YKF4=
X-Google-Smtp-Source: APXvYqz+dGeabjjLKNKdrHogZYJQjkqMcbrUiViVB8VAsQZU2tg/Cj58FCVgoZDetMKQ4rDU8wZFEQ==
X-Received: by 2002:a62:2b51:: with SMTP id r78mr27327966pfr.149.1568038721724;
        Mon, 09 Sep 2019 07:18:41 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id w6sm34574695pfw.84.2019.09.09.07.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:18:41 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 0/9] kconfig/hacking: make 'kernel hacking' menu better structurized
Date:   Mon,  9 Sep 2019 22:18:14 +0800
Message-Id: <20190909141823.8638-1-changbin.du@gmail.com>
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

v2:
  o rebase to linux-next.
  o move DEBUG_FS to 'Generic Kernel Debugging Instruments'
  o move DEBUG_NOTIFIERS to 'Debug kernel data structures'

Changbin Du (9):
  kconfig/hacking: Group sysrq/kgdb/ubsan into 'Generic Kernel Debugging
    Instruments'
  kconfig/hacking: Create submenu for arch special debugging options
  kconfig/hacking: Group kernel data structures debugging together
  kconfig/hacking: Move kernel testing and coverage options to same
    submenu
  kconfig/hacking: Move Oops into 'Lockups and Hangs'
  kconfig/hacking: Move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE
  kconfig/hacking: Create a submenu for scheduler debugging options
  kconfig/hacking: Move DEBUG_BUGVERBOSE to 'printk and dmesg options'
  kconfig/hacking: Move DEBUG_FS to 'Generic Kernel Debugging
    Instruments'

 lib/Kconfig.debug | 659 ++++++++++++++++++++++++----------------------
 1 file changed, 340 insertions(+), 319 deletions(-)

-- 
2.20.1

