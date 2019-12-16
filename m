Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79309C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DCD206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NITuPJbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfLPKbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:31:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43896 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727319AbfLPKbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576492269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Eo005stHRd9C8m5vBASr94rer3WPzPVBtfLVLTsOZZo=;
        b=NITuPJbLOcemBHHPJDB1gmUZxyFb/GvKypQeAm7uyCPyBatpxWiZUKAwLQFU6cEQJWYOB5
        Jd6MyDyt5aLJejhL10Vl/Z2LZ/ieq4d1D2jjoFvOeiRPBwlIpu/DmlBtU2Nmejq0oeFuNm
        E0nwUjfjf5UVOvrk1RYtvOlyQgBDBu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-8fcKe7vtONSMgfiW6jjRQw-1; Mon, 16 Dec 2019 05:31:06 -0500
X-MC-Unique: 8fcKe7vtONSMgfiW6jjRQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5041CDC23;
        Mon, 16 Dec 2019 10:31:04 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D75485C241;
        Mon, 16 Dec 2019 10:30:58 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arun KS <arunks@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/pseries/cmm: fix managed page counts when migrating pages between zones
Date:   Mon, 16 Dec 2019 11:30:58 +0100
Message-Id: <20191216103058.4958-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 63341ab03706 (virtio-balloon: fix managed page counts when migrati=
ng
pages between zones) fixed a long existing BUG in the virtio-balloon
driver when pages would get migrated between zones.  I did not try to
reproduce on powerpc, but looking at the code, the same should apply to
powerpc/cmm ever since it started using the balloon compaction
infrastructure (luckily just recently).

In case we have to migrate a ballon page to a newpage of another zone, th=
e
managed page count of both zones is wrong. Paired with memory offlining
(which will adjust the managed page count), we can trigger kernel crashes
and all kinds of different symptoms.

Fix it by properly adjusting the managed page count when migrating if
the zone changed.

We'll temporarily modify the totalram page count. If this ever becomes a
problem, we can fine tune by providing helpers that don't touch
the totalram pages (e.g., adjust_zone_managed_page_count()).

Fixes: fe030c9b85e6 ("powerpc/pseries/cmm: Implement balloon compaction")
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arun KS <arunks@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Link virtio-balloon fix commit
- Check if the zone changed
- Move fixup further up, before enqueuing the new newpage (where we are
  guaranteed to hold a reference to both pages)

---
 arch/powerpc/platforms/pseries/cmm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platform=
s/pseries/cmm.c
index 91571841df8a..9dba7e880885 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -539,6 +539,16 @@ static int cmm_migratepage(struct balloon_dev_info *=
b_dev_info,
 	/* balloon page list reference */
 	get_page(newpage);
=20
+	/*
+	 * When we migrate a page to a different zone, we have to fixup the
+	 * count of both involved zones as we adjusted the managed page count
+	 * when inflating.
+	 */
+	if (page_zone(page) !=3D page_zone(newpage)) {
+		adjust_managed_page_count(page, 1);
+		adjust_managed_page_count(newpage, -1);
+	}
+
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	balloon_page_insert(b_dev_info, newpage);
 	balloon_page_delete(page);
--=20
2.23.0

