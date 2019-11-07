Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04C1C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3253207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbfKGOeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:34:00 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:45369 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729047AbfKGOeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:34:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0ThQoCKT_1573137161;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0ThQoCKT_1573137161)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Nov 2019 22:32:49 +0800
From:   shile.zhang@linux.alibaba.com
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [RFC PATCH 0/4] Speed booting by sorting ORC unwind tables at build time
Date:   Thu,  7 Nov 2019 22:32:01 +0800
Message-Id: <20191107143205.206606-1-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shile Zhang <shile.zhang@linux.alibaba.com>

Hi,

I found the unwind_init taken long time (more than 90ms) in kernel
booting, mainly spent on sorting the two ORC unwind tables, orc_unwind
and orc_unwind_ip.

I also noticed that this issued has reported and discussed last year:
https://lkml.org/lkml/2018/10/8/342
But seems no final solution until now, I tried to sort the ORC tables at
build time, followed the helpful hints from Josh and Ingo in that thread.
And mainly referred the implementation of 'sortextable' tool:
https://lore.kernel.org/linux-mips/1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com/

What I did:

- Add a Kconfig to control build-time sorting or runtime sorting;
- Referred 'sortextable', create a similar helper tool 'sortorctable',
  help to sort the ORC unwind tables at vmlinux link process.

One potential improvement is to sort the module ORC tables in future.

Thanks!

Shile Zhang (4):
  scripts: Add sortorctable to sort ORC unwind tables
  kbuild: Sort ORC unwind tables in vmlinux link process
  x86/unwind/orc: Skip sorting if BUILDTIME_ORCTABLE_SORT is configured
  x86/Kconfig: Add a Kconfig option to sort ORC tables at build time

 arch/x86/Kconfig.debug       |   9 ++
 arch/x86/kernel/unwind_orc.c |   2 +
 scripts/.gitignore           |   1 +
 scripts/Makefile             |   2 +
 scripts/link-vmlinux.sh      |  10 ++
 scripts/sortorctable.c       | 246 +++++++++++++++++++++++++++++++++++
 scripts/sortorctable.h       |  25 ++++
 7 files changed, 295 insertions(+)
 create mode 100644 scripts/sortorctable.c
 create mode 100644 scripts/sortorctable.h

-- 
2.24.0.rc2

