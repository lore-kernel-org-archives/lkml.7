Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDEECA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF76F20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG+3WO6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfJaOai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:30:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32907 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728144AbfJaOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572532236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hdK9AU9y2RagTsYY1CTHXbikq1GyDp415JyKkuQAWjo=;
        b=AG+3WO6j98PPmCbtucNfslo0DL2wXCPwL58uPhCcG+BgxflThU1nP/3lL0u1oNrgouG8bi
        f3ZWFfWKMSioW23p2ngSYP7J8AAEXGOAQah5krkG90D0KYavCsdsjINoBQsTESDu7T3cvR
        5wOQ2wGW9snUoupQUrNa4Mxu6evpDYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-7DfiSHdLM3227xLe1wgTig-1; Thu, 31 Oct 2019 10:30:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72F43800D49;
        Thu, 31 Oct 2019 14:30:31 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F1F25D6D6;
        Thu, 31 Oct 2019 14:30:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arun KS <arunks@codeaurora.org>
Subject: [PATCH v1 09/12] powerpc/pseries: CMM: Switch to balloon_page_alloc()
Date:   Thu, 31 Oct 2019 15:29:30 +0100
Message-Id: <20191031142933.10779-10-david@redhat.com>
In-Reply-To: <20191031142933.10779-1-david@redhat.com>
References: <20191031142933.10779-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 7DfiSHdLM3227xLe1wgTig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

balloon_page_alloc() will use GFP_HIGHUSER_MOVABLE in case we have
CONFIG_BALLOON_COMPACTION. This is now possible, as balloon pages are
movable with CONFIG_BALLOON_COMPACTION. Without
CONFIG_BALLOON_COMPACTION, GFP_HIGHUSER is used.

Note that apart from that, balloon_page_alloc() uses the following
flags:
    __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN
And current code used:
    GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC

GFP_HIGHUSER/GFP_HIGHUSER_MOVABLE include
    __GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL | __GFP_HIGHMEM

GFP_NOIO is __GFP_RECLAIM.

With CONFIG_BALLOON_COMPACTION, we essentially add:
    __GFP_IO | __GFP_FS | __GFP_HARDWALL | __GFP_HIGHMEM | __GFP_MOVABLE

Without CONFIG_BALLOON_COMPACTION, we essentially add:
    __GFP_IO | __GFP_FS | __GFP_HARDWALL | __GFP_HIGHMEM

I assume this is fine, as this is what all other balloon compaction
users use. If it turns out to be a problem, we could add
__GFP_MOVABLE manually if we have CONFIG_BALLOON_COMPACTION.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arun KS <arunks@codeaurora.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/=
pseries/cmm.c
index 235fd7fe9df1..a6ec2bbb1f91 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -147,8 +147,7 @@ static long cmm_alloc_pages(long nr)
 =09=09=09break;
 =09=09}
=20
-=09=09page =3D alloc_page(GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY |
-=09=09=09=09  __GFP_NOMEMALLOC);
+=09=09page =3D balloon_page_alloc();
 =09=09if (!page)
 =09=09=09break;
 =09=09rc =3D plpar_page_set_loaned(page);
--=20
2.21.0

