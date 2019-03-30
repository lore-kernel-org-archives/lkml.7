Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAB4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FB0218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DoVzdMUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfC3Qh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:37:57 -0400
Received: from forward101j.mail.yandex.net ([5.45.198.241]:58606 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730506AbfC3Qh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:37:57 -0400
Received: from mxback2o.mail.yandex.net (mxback2o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1c])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 8F7711BE0646;
        Sat, 30 Mar 2019 19:37:52 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback2o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 1YR4K0xhLB-bfTmTF6M;
        Sat, 30 Mar 2019 19:37:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1553963870;
        bh=ua+pPFPSHTEeenSsWAP5SFeoYcFeBHynoZLbeXw8Fuk=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=DoVzdMUX1qnwqJrpMXb60TntWxN4GtWADCodkOdPYU0tODiY9WxjxOgs1Gth/w5ZT
         In7kwHcs2ipJKz2577i8Qt/J88cdSGZsmOWe+tlDHZfKsJaB2R7qtvrQRXrdIFpT2z
         d64PgIExmeKP0pwN8giHsu1+rOHiKSjmA+6Q/NFY=
Authentication-Results: mxback2o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-b3ec53dbc12b.qloud-c.yandex.net with HTTP;
        Sat, 30 Mar 2019 19:37:41 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     vgupta@synopsys.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, mark@fasheh.com,
        jlbec@evilplan.org, richard@nod.at, dedekind1@gmail.com,
        adrian.hunter@intel.com, gregkh@linuxfoundation.org,
        naveen.n.rao@linux.vnet.ibm.com, jpoimboe@redhat.com,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        ard.biesheuvel@linaro.org, George Spelvin <lkml@sdf.org>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, sfr@canb.auug.org.au
Cc:     rppt@linux.ibm.com, Morton Andrew <akpm@linux-foundation.org>,
        mhocko@suse.com, malat@debian.org, npiggin@gmail.com,
        yamada.masahiro@socionext.com, jannh@google.com, jslaby@suse.cz,
        ge.changwei@h3c.com, jiangyiwen@huawei.com, piaojun@huawei.com,
        amir73il@gmail.com, ashish.samant@oracle.com,
        yuehaibing@huawei.com, lchen@suse.com, jiang.biao2@zte.com.cn,
        gustavo@embeddedor.com, peterz@infradead.org,
        keescook@chromium.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kamalesh@linux.vnet.ibm.com
Subject: [PATCH 0/5] simple sort swap function usage improvements
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 30 Mar 2019 19:37:41 +0300
Message-Id: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the logical continuation of sort improvements by George Spelvin
"lib/sort & lib/list_sort: faster and smaller" series
(added to the linux-next really recently).

Patches from 1 to 4 replace simple swap functions with the built-in
(which is now much faster) and grouped by subsystem (after that only
3 files implement custom swap - arch/x86/kernel/unwind_orc.c,
kernel/jump_label.c and lib/extable.c).

Patch #5 replaces the int type with the size_t type of the size argument
in the swap function.

Andrey Abramov (5):
  arch/arc: unwind.c: replace swap function with built-in one
  powerpc: module_[32|64].c: replace swap function with built-in one
  ocfs2: dir,refcounttree,xattr: replace swap functions with built-in
    one
  ubifs: find.c: replace swap function with built-in one
  Lib: sort.h: replace int size with size_t size in the swap function

 arch/arc/kernel/unwind.c        | 20 ++------------------
 arch/powerpc/kernel/module_32.c | 17 +----------------
 arch/powerpc/kernel/module_64.c | 17 +----------------
 arch/x86/kernel/unwind_orc.c    |  2 +-
 fs/ocfs2/dir.c                  | 13 +------------
 fs/ocfs2/refcounttree.c         | 13 +++----------
 fs/ocfs2/xattr.c                | 15 +++------------
 fs/ubifs/find.c                 |  9 +--------
 include/linux/sort.h            |  2 +-
 kernel/jump_label.c             |  2 +-
 lib/extable.c                   |  2 +-
 lib/sort.c                      |  6 +++---
 12 files changed, 19 insertions(+), 99 deletions(-)

-- 
2.21.0


