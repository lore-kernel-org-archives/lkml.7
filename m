Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C067C49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD9221670
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393913AbfIJPSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:18:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfIJPSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:18:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4E9C300BCE9;
        Tue, 10 Sep 2019 15:18:47 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6BEC19C58;
        Tue, 10 Sep 2019 15:18:40 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 0/2] x86/kdump: Reserve extra memory when SME or SEV is active
Date:   Tue, 10 Sep 2019 23:13:39 +0800
Message-Id: <20190910151341.14986-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 10 Sep 2019 15:18:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series let kernel reserve extra memory for kdump when SME or SEV is
active.

When SME or SEV is active, SWIOTLB will be always be force enabled, and
this is also true for kdump kernel. As a result kdump kernel will
run out of already scarce pre-reserved memory easily.

So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
is specified or any offset is used. With high reservation an extra low
memory region will always be reserved and that is enough for SWIOTLB.
With offset format, user should be fully aware of any possible kdump
kernel memory requirement and have to organize the memory usage carefully.

Patch 1/2 simply split some code out of the reserve_crashkernel, prepare
for the change of next patch.

Patch 2/2 will let crashkernel reserve extra memory when SME or SEV is
active, and explains more details and history about why this change is
introduced.

Update from V2:
- Refactor and split some function out of reserve_crashkernel to make
  it cleaner, as suggested by Borislav Petkov
- Split into 2 patches

Update from V1:
- Use mem_encrypt_active() instead of "sme_active() || sev_active()"
- Don't reserve extra memory when ",high" or "@offset" is used, and
don't print redundant message.
- Fix coding style problem

Kairui Song (2):
  x86/kdump: Split some code out of reserve_crashkernel
  x86/kdump: Reserve extra memory when SME or SEV is active

 arch/x86/kernel/setup.c | 106 ++++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 32 deletions(-)

-- 
2.21.0

