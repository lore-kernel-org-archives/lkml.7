Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E2BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19E42064B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfLPM76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:59:58 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:38445 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727553AbfLPM76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:59:58 -0500
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 07:59:57 EST
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 16 Dec 2019 04:44:48 -0800
Received: from akaher-lnx-dev.eng.vmware.com (unknown [10.110.19.203])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id A3F70401D3;
        Mon, 16 Dec 2019 04:44:44 -0800 (PST)
From:   Ajay Kaher <akaher@vmware.com>
To:     <gregkh@linuxfoundation.org>
CC:     <torvalds@linux-foundation.org>, <punit.agrawal@arm.com>,
        <akpm@linux-foundation.org>, <kirill.shutemov@linux.intel.com>,
        <willy@infradead.org>, <will.deacon@arm.com>,
        <mszeredi@redhat.com>, <stable@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <srivatsab@vmware.com>, <srivatsa@csail.mit.edu>,
        <amakhalov@vmware.com>, <srinidhir@vmware.com>,
        <bvikas@vmware.com>, <anishs@vmware.com>, <vsirnapalli@vmware.com>,
        <srostedt@vmware.com>, <akaher@vmware.com>
Subject: [PATCH v3 0/8] Backported fixes for 4.4 stable tree
Date:   Tue, 17 Dec 2019 02:15:40 +0530
Message-ID: <1576529149-14269-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: akaher@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches include few backported fixes for the 4.4 stable
tree.
I would appreciate if you could kindly consider including them in the
next release.

Ajay

---

[Changes from v2]:
Merged following changes from Vlastimil's series [1]:
- Added page_ref_count() in [Patch v3 5/8]
- Added missing refcount overflow checks on x86 and s390 [Patch v3 5/8]
- Added [Patch v3 8/8]
- Removed 7aef4172c795 i.e. [Patch v2 3/8]

[1] https://lore.kernel.org/stable/20191108093814.16032-1-vbabka@suse.cz/

---

[PATCH v3 1/8]:
Backporting of upstream commit f958d7b528b1:
mm: make page ref count overflow check tighter and more explicit

[PATCH v3 2/8]:
Backporting of upstream commit 88b1a17dfc3e:
mm: add 'try_get_page()' helper function

[PATCH v3 3/8]:
Backporting of upstream commit a3e328556d41:
mm, gup: remove broken VM_BUG_ON_PAGE compound check for hugepages

[PATCH v3 4/8]:
Backporting of upstream commit d63206ee32b6:
mm, gup: ensure real head page is ref-counted when using hugepages

[PATCH v3 5/8]:
Backporting of upstream commit 8fde12ca79af:
mm: prevent get_user_pages() from overflowing page refcount

[PATCH v3 6/8]:
Backporting of upstream commit 7bf2d1df8082:
pipe: add pipe_buf_get() helper

[PATCH v3 7/8]:
Backporting of upstream commit 15fab63e1e57:
fs: prevent page refcount overflow in pipe_buf_get

[PATCH v3 8/8]:
x86, mm, gup: prevent get_page() race with munmap in paravirt guest

