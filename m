Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A362070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfCNJqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfCNJqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:46:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43176301BE82;
        Thu, 14 Mar 2019 09:46:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC1375F9D2;
        Thu, 14 Mar 2019 09:46:49 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, keescook@chromium.org, kirill@shutemov.name,
        yamada.masahiro@socionext.com, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, x86@kernel.org, thgarnie@google.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 0/6] Several patches to fix code bugs, improve documents and clean up
Date:   Thu, 14 Mar 2019 17:46:39 +0800
Message-Id: <20190314094645.4883-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 14 Mar 2019 09:46:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v4 post. The v3 post can be found here:
http://lkml.kernel.org/r/20190216140008.28671-1-bhe@redhat.com

The v2 post was here:
https://lkml.org/lkml/2018/9/9/56

This patchset includes the original three code bug fix patches in v2,
and two new patches to improve code comments about kaslr_memory_region
and open code unnecessary function get_padding(), meanwhile carry the
known SGI UV bug fix.

This patchset sits on top of another patchset earlier posted:
http://lkml.kernel.org/r/20190308025616.21440-1-bhe@redhat.com
[PATCH v3 0/2] x86/mm/KASLR: Change the granularity of randomization to PUD size in 5-level
[PATCH v3 2/2] x86/mm/KASLR: Change the granularity of randomization to PUD size in 5-level
[PATCH v3 1/2] x86/mm/KASLR: Only build one PUD entry of area for real mode trampoline

Note:
SGI UV bug fix is not tested yet, the idea was approved by SGI UV expert
Mike Travis, and the old post as below was tested and has been merged
into our RHEL distros. This new change doesn't change the way to
calculate the size of the direct mapping section, but only wrap the
calculation code into a new function calc_direct_mapping_size()
according to Ingo's suggestion.
https://lkml.org/lkml/2017/5/18/102

Changelog:
v3->v4:
  Update patches according to Kees's reviewing comments:
    - Fix typos and move operation comment above
      kernel_randomize_memory() for patch 1/6;
    - Change 'PAGE_SIZE' to 'PAGE_SIZE/4' in patch 3/6;
    - Add code comment about the calculation of vmemmap in patch 5/6;
v2->v3:
  Added three patches according to Ingo's suggestions:
    - Add code comment about struct kaslr_memory_region;
    - Open code get_padding();
    - Carry the SGI UV fix;

Baoquan He (6):
  x86/mm/KASLR: Improve code comments about struct kaslr_memory_region
  x86/mm/KASLR: Open code unnecessary function get_padding
  mm: Add build time sanity chcek for struct page size
  x86/mm/KASLR: Fix the wrong calculation of memory region initial size
  x86/mm/KASLR: Calculate the actual size of vmemmap region
  x86/mm/KASLR: Do not adapt the size of the direct mapping region for
    SGI UV system

 arch/x86/mm/kaslr.c | 134 +++++++++++++++++++++++++++++++++++---------
 mm/page_alloc.c     |   2 +
 2 files changed, 109 insertions(+), 27 deletions(-)

-- 
2.17.2

