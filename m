Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2464BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96922071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhV+hmq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfK0Rlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:41:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43175 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbfK0Rlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574876495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2/Wb54gH2JUj0cmiRfmHDfbzDR8shI5UiNeN+uIiqhI=;
        b=AhV+hmq5WzsNtQVnw7NmukMrTrggIgUzyvjWMOhUdl2KR4daR2qAYqv6feAR29xv/a5A/q
        WIBz4setZTnLxwfJGDtN5rN4tuo2vXCnsx3MuKpk9Gyg1Z6pyCN7Pu+7TOy3DZfVSSN18h
        V+Oz9cQ3UjLAxXsiuwUWCwlQ1ZJbRds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-7c7Vbk0_Nh-8Ul1mLCDsng-1; Wed, 27 Nov 2019 12:41:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83B64DB60;
        Wed, 27 Nov 2019 17:41:32 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-69.ams2.redhat.com [10.36.116.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E4175D9D6;
        Wed, 27 Nov 2019 17:41:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1] drivers/base/node.c: get rid of get_nid_for_pfn()
Date:   Wed, 27 Nov 2019 18:41:26 +0100
Message-Id: <20191127174126.28064-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7c7Vbk0_Nh-8Ul1mLCDsng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d84f2f5a7552 ("drivers/base/node.c: simplify
unregister_memory_block_under_nodes()") we only have a single user of
get_nid_for_pfn(). Let's just inline that code and get rid of
get_nid_for_pfn().

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/node.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 98a31bafc8a2..735073fd2926 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -744,17 +744,6 @@ int unregister_cpu_under_node(unsigned int cpu, unsign=
ed int nid)
 }
=20
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
-static int __ref get_nid_for_pfn(unsigned long pfn)
-{
-=09if (!pfn_valid_within(pfn))
-=09=09return -1;
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-=09if (system_state < SYSTEM_RUNNING)
-=09=09return early_pfn_to_nid(pfn);
-#endif
-=09return pfn_to_nid(pfn);
-}
-
 /* register memory section under specified node if it spans that node */
 static int register_mem_sect_under_node(struct memory_block *mem_blk,
 =09=09=09=09=09 void *arg)
@@ -766,8 +755,6 @@ static int register_mem_sect_under_node(struct memory_b=
lock *mem_blk,
 =09unsigned long pfn;
=20
 =09for (pfn =3D start_pfn; pfn <=3D end_pfn; pfn++) {
-=09=09int page_nid;
-
 =09=09/*
 =09=09 * memory block could have several absent sections from start.
 =09=09 * skip pfn range from absent section
@@ -784,11 +771,15 @@ static int register_mem_sect_under_node(struct memory=
_block *mem_blk,
 =09=09 * block belong to the same node.
 =09=09 */
 =09=09if (system_state =3D=3D SYSTEM_BOOTING) {
-=09=09=09page_nid =3D get_nid_for_pfn(pfn);
-=09=09=09if (page_nid < 0)
+=09=09=09if (!pfn_valid_within(pfn))
 =09=09=09=09continue;
-=09=09=09if (page_nid !=3D nid)
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+=09=09=09if (early_pfn_to_nid(pfn) !=3D nid)
 =09=09=09=09continue;
+#else
+=09=09=09if (pfn_to_nid(pfn) !=3D nid)
+=09=09=09=09continue;
+#endif
 =09=09}
=20
 =09=09/*
--=20
2.21.0

