Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173BAC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF782196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKMJaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:30:14 -0500
Received: from relay.sw.ru ([185.231.240.75]:39208 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfKMJaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:30:13 -0500
Received: from finist_cl7.qa.sw.ru ([10.94.4.83] helo=finist-ce7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <khorenko@virtuozzo.com>)
        id 1iUoyE-00062s-Rr; Wed, 13 Nov 2019 12:29:51 +0300
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Jessica Yu <jeyu@kernel.org>, Prarit Bhargava <prarit@redhat.com>,
        Barret Rhoden <brho@google.com>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, David Arcari <darcari@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 0/1] kernel/module.c: don't allow modprobe to hang forever on a module load
Date:   Wed, 13 Nov 2019 12:29:49 +0300
Message-Id: <20191113092950.15556-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
for modules that have finished loading")
the simple test leads to hanged modprobe process (INTERRUPTIBLE):

1. Make sure nft_ct module is not used by your firewall rules.
2. Run 3 copies of
   # export i=0; while true; if [[ $(($i % 100)) -eq 0 ]] ; then \
     echo "i=$i"; fi; do modprobe nft_ct; i=$(($i + 1)); done

3. Run 2 copies of
   # while true; do rmmod nft_ct; done

Hanged "modprobe" process will appear in ~ 10 seconds.

   # cat /proc/30184/stack
   [<0>] load_module+0x53f/0x2060
   [<0>] __do_sys_finit_module+0xd2/0x100
   [<0>] do_syscall_64+0x5b/0x1c0
   [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Konstantin Khorenko (1):
  kernel/module.c: wakeup processes in module_wq on module unload

 kernel/module.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.15.1

