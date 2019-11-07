Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E72C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBEA2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/wAADw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfKGTGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:06:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48848 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727451AbfKGTGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573153604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7V8vcRaNgCDHefA9Xbu64DZmBbu801jLK5Q2vpg+4R0=;
        b=J/wAADw+GYodYVpL2qoAc7Itfch5a0P8LA+eB2+NNDOxU2mr7ky5RDKDEx7QwqtoF5w+Hq
        DG8CpRV4hRPHnu9SIDgmi9Egq+7uf65ba0R3AMeGO4Odbur0Ekf/qIE5qZ46vRocDQnD1T
        5VKXu3UXCnBS3G+SA2plQ5B9hezEJiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-MGRb98xaODGOeml7zPUjJw-1; Thu, 07 Nov 2019 14:06:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CE99107ACC3;
        Thu,  7 Nov 2019 19:06:38 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9583F5C548;
        Thu,  7 Nov 2019 19:06:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] hugetlbfs: Take read_lock on i_mmap for PMD sharing
Date:   Thu,  7 Nov 2019 14:06:28 -0500
Message-Id: <20191107190628.22667-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: MGRb98xaODGOeml7zPUjJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A customer with large SMP systems (up to 16 sockets) with application
that uses large amount of static hugepages (~500-1500GB) are experiencing
random multisecond delays. These delays was caused by the long time it
took to scan the VMA interval tree with mmap_sem held.

The sharing of huge PMD does not require changes to the i_mmap at all.
As a result, we can just take the read lock and let other threads
searching for the right VMA to share in parallel. Once the right
VMA is found, either the PMD lock (2M huge page for x86-64) or the
mm->page_table_lock will be acquired to perform the actual PMD sharing.

Lock contention, if present, will happen in the spinlock. That is much
better than contention in the rwsem where the time needed to scan the
the interval tree is indeterminate.

With this patch applied, the customer is seeing significant improvements
over the unpatched kernel.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b45a95363a84..087e7ff00137 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4842,7 +4842,11 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned=
 long addr, pud_t *pud)
 =09if (!vma_shareable(vma, addr))
 =09=09return (pte_t *)pmd_alloc(mm, pud, addr);
=20
-=09i_mmap_lock_write(mapping);
+=09/*
+=09 * PMD sharing does not require changes to i_mmap. So a read lock
+=09 * is enuogh.
+=09 */
+=09i_mmap_lock_read(mapping);
 =09vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 =09=09if (svma =3D=3D vma)
 =09=09=09continue;
@@ -4872,7 +4876,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned =
long addr, pud_t *pud)
 =09spin_unlock(ptl);
 out:
 =09pte =3D (pte_t *)pmd_alloc(mm, pud, addr);
-=09i_mmap_unlock_write(mapping);
+=09i_mmap_unlock_read(mapping);
 =09return pte;
 }
=20
--=20
2.18.1

