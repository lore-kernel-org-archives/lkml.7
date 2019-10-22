Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40F3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EDD2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lc2b2oYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfJVCTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:19:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60078 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729573AbfJVCTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571710788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cy1H0yNRlADn6s5BcmmX0kDdj1YRyEm1IRV1QcI4xNE=;
        b=Lc2b2oYxZyahvQpUf/P3NPT4Y5rW7aajfuGYltV2ynrX1ClW0d+L/kb0ssozJuQ4Iv5aHD
        0M0vzFEoKdMBjoyyKGu2zTE2QCGU92Pyi6FnBMxDXPz31dPnelbGIFuMfoyFyUGSw+pDCS
        T/kwCIK/mBuYRf8x8oFdcsW/PvJBHNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-qGaYFtxgOfqv3l0NUq_F-w-1; Mon, 21 Oct 2019 22:19:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B345107AD31;
        Tue, 22 Oct 2019 02:19:44 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-120-98.rdu2.redhat.com [10.10.120.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7EA85C22C;
        Tue, 22 Oct 2019 02:19:21 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     linux-mm@kvack.org, kasan-dev@googlegroups.com
Cc:     Sean Paul <sean@poorly.run>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] kasan: include the hashed pointer for an object's location
Date:   Mon, 21 Oct 2019 22:18:11 -0400
Message-Id: <20191022021810.3216-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: qGaYFtxgOfqv3l0NUq_F-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vast majority of the kernel that needs to print out pointers as a
way to keep track of a specific object in the kernel for debugging
purposes does so using hashed pointers, since these are "good enough".
Ironically, the one place we don't do this is within kasan. While
simply printing a hashed version of where an out of bounds memory access
occurred isn't too useful, printing out the hashed address of the object
in question usually is since that's the format most of the kernel is
likely to be using in debugging output.

Of course this isn't perfect though-having the object's originating
address doesn't help users at all that need to do things like printing
the address of a struct which is embedded within another struct, but
it's certainly better then not printing any hashed addresses. And users
which need to handle less trivial cases like that can simply fall back
to careful usage of %px.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com
---
 mm/kasan/report.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 621782100eaa..0a5663fee1f7 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -128,8 +128,9 @@ static void describe_object_addr(struct kmem_cache *cac=
he, void *object,
 =09int rel_bytes;
=20
 =09pr_err("The buggy address belongs to the object at %px\n"
-=09       " which belongs to the cache %s of size %d\n",
-=09=09object, cache->name, cache->object_size);
+=09       " (aka %p) which belongs to the cache\n"
+=09       " %s of size %d\n",
+=09       object, object, cache->name, cache->object_size);
=20
 =09if (!addr)
 =09=09return;
--=20
2.21.0

