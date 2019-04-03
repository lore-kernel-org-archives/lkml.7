Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5D0C10F0D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AAA2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDCTdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:33:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfDCTdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:33:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 21AB33001C82;
        Wed,  3 Apr 2019 19:33:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-125-190.rdu2.redhat.com [10.10.125.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 034E2605CA;
        Wed,  3 Apr 2019 19:33:40 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3 10/12] mm/hmm: add helpers to test if mm is still alive or not
Date:   Wed,  3 Apr 2019 15:33:16 -0400
Message-Id: <20190403193318.16478-11-jglisse@redhat.com>
In-Reply-To: <20190403193318.16478-1-jglisse@redhat.com>
References: <20190403193318.16478-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 03 Apr 2019 19:33:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

The device driver can have kernel thread or worker doing work against
a process mm and it is useful for those to test wether the mm is dead
or alive to avoid doing useless work. Add an helper to test that so
that driver can bail out early if a process is dying.

Note that the helper does not perform any lock synchronization and thus
is just a hint ie a process might be dying but the helper might still
return the process as alive. All HMM functions are safe to use in that
case as HMM internal properly protect itself with lock. If driver use
this helper with non HMM functions it should ascertain that it is safe
to do so.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/hmm.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index e5834082de60..a79fcc6681f5 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -438,6 +438,30 @@ struct hmm_mirror {
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm);
 void hmm_mirror_unregister(struct hmm_mirror *mirror);
 
+/*
+ * hmm_mirror_mm_is_alive() - test if mm is still alive
+ * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
+ * Returns: false if the mm is dead, true otherwise
+ *
+ * This is an optimization it will not accurately always return -EINVAL if the
+ * mm is dead ie there can be false negative (process is being kill but HMM is
+ * not yet inform of that). It is only intented to be use to optimize out case
+ * where driver is about to do something time consuming and it would be better
+ * to skip it if the mm is dead.
+ */
+static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
+{
+	struct mm_struct *mm;
+
+	if (!mirror || !mirror->hmm)
+		return false;
+	mm = READ_ONCE(mirror->hmm->mm);
+	if (mirror->hmm->dead || !mm)
+		return false;
+
+	return true;
+}
+
 
 /*
  * Please see Documentation/vm/hmm.rst for how to use the range API.
-- 
2.17.2

