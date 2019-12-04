Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D28C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A7220656
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtlE1b5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfLDUyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:54:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727889AbfLDUyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575492842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DjFPZ5urTuKqmC6fst64X7L6zO/s1PJZoDmuLpfMvyg=;
        b=WtlE1b5Vl/eNPCcDxg0CPbX2kAlh7X9oJE/qnCiYVRkj5kUQoufqxYS3nG+i4KplF+/kUA
        bUXOujo2LSV+V2lNTxBzhwVS2lfrKG3OL6jO0cwOw/vct7IIhWLln98AkW04AmFyadmQaQ
        j9j8a0SuRadKPC1F3SA4gQvWIKP/5S8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-OFZlbzXVNM2DmqaCT_swYA-1; Wed, 04 Dec 2019 15:53:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C17219057A1;
        Wed,  4 Dec 2019 20:53:15 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-80.ams2.redhat.com [10.36.116.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 243CF60BE2;
        Wed,  4 Dec 2019 20:53:09 +0000 (UTC)
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
Subject: [PATCH] powerpc/pseries/cmm: fix wrong managed page count when migrating between zones
Date:   Wed,  4 Dec 2019 21:53:09 +0100
Message-Id: <20191204205309.8319-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: OFZlbzXVNM2DmqaCT_swYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case we have to migrate a ballon page to a newpage of another zone, the
managed page count of both zones is wrong. Paired with memory offlining
(which will adjust the managed page count), we can trigger kernel crashes
and all kinds of different symptoms.

Fix it by properly adjusting the managed page count when migrating.

I did not try to reproduce on powerpc, however,I just resolved a long
known issue when ballooning+offlining in virtio-balloon. The same should
apply to powerpc/cmm since it started using the balloon compaction
infrastructure (luckily just recently).

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

virtio-ballon fix with more details:

https://lkml.kernel.org/r/20191204204807.8025-1-david@redhat.com/

---
 arch/powerpc/platforms/pseries/cmm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/=
pseries/cmm.c
index 91571841df8a..665298fe2990 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -551,6 +551,10 @@ static int cmm_migratepage(struct balloon_dev_info *b_=
dev_info,
 =09 */
 =09plpar_page_set_active(page);
=20
+=09/* fixup the managed page count (esp. of the zone) */
+=09adjust_managed_page_count(page, 1);
+=09adjust_managed_page_count(newpage, -1);
+
 =09/* balloon page list reference */
 =09put_page(page);
=20
--=20
2.21.0

