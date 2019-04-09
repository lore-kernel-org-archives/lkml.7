Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C348C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0364F21841
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDIKCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:02:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfDIKCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:02:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05A59307D98D;
        Tue,  9 Apr 2019 10:02:00 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-49.ams2.redhat.com [10.36.117.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DF0D5D71E;
        Tue,  9 Apr 2019 10:01:48 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Banman <andrew.banman@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arun KS <arunks@codeaurora.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oscar Salvador <osalvador@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v1 0/4] mm/memory_hotplug: Better error handling when removing memory
Date:   Tue,  9 Apr 2019 12:01:44 +0200
Message-Id: <20190409100148.24703-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 09 Apr 2019 10:02:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error handling when removing memory is somewhat messed up right now. Some
errors result in warnings, others are completely ignored. Memory unplug
code can essentially not deal with errors properly as of now.
remove_memory() will never fail.

We have basically two choices:
1. Allow arch_remov_memory() and friends to fail, propagating errors via
   remove_memory(). Might be problematic (e.g. DIMMs consisting of multiple
   pieces added/removed separately).
2. Don't allow the functions to fail, handling errors in a nicer way.

It seems like most errors that can theoretically happen are really corner
cases and mostly theoretical (e.g. "section not valid"). However e.g.
aborting removal of sections while all callers simply continue in case of
errors is not nice.

If we can gurantee that removal of memory always works (and WARN/skip in
case of theoretical errors so we can figure out what is going on), we can
go ahead and implement better error handling when adding memory.

E.g. via add_memory():

arch_add_memory()
ret = do_stuff()
if (ret) {
	arch_remove_memory();
	goto error;
}

Handling here that arch_remove_memory() might fail is basically impossible.
So I suggest, let's avoid reporting errors while removing memory, warning
on theoretical errors instead and continuing instead of aborting.

Compile-tested on x86-64, powerpc, s390x. Tested on x86-64 with DIMMs.
Based on git://git.cmpxchg.org/linux-mmots.git

David Hildenbrand (4):
  mm/memory_hotplug: Release memory resource after arch_remove_memory()
  mm/memory_hotplug: Make unregister_memory_section() never fail
  mm/memory_hotplug: Make __remove_section() never fail
  mm/memory_hotplug: Make __remove_pages() and arch_remove_memory()
    never fail

 arch/ia64/mm/init.c            | 11 ++----
 arch/powerpc/mm/mem.c          | 11 +++---
 arch/s390/mm/init.c            |  5 +--
 arch/sh/mm/init.c              | 11 ++----
 arch/x86/mm/init_32.c          |  5 +--
 arch/x86/mm/init_64.c          | 10 ++----
 drivers/base/memory.c          | 16 +++------
 include/linux/memory.h         |  2 +-
 include/linux/memory_hotplug.h |  8 ++---
 mm/memory_hotplug.c            | 63 +++++++++++++++++-----------------
 10 files changed, 60 insertions(+), 82 deletions(-)

-- 
2.17.2

