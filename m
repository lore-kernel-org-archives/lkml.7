Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D88DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704732082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyy2ZVwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfKYKfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:35:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30049 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727266AbfKYKfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574678146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZMYkA3jI8+ywNR+OhV3jpIlPger7eOA5dEPy09p1d6E=;
        b=dyy2ZVwk9P1P6CI6YlUeRdXMkmj6h6DHx9ZsORsqi1X17W72/3ZEjvkJOIvgx3m9ld2TXV
        Uvtq8M8mdf6s9NdiPIamRF7qrZUtQGpUBdMiDlZld3P9c/skUY258gtks+g2R5ODR2/shS
        +qQELQDJeZOF1C3S/b5fbyYkOe8Q2/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-8pbgYF59MamGTDCxyCAzoQ-1; Mon, 25 Nov 2019 05:35:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10B44107B765;
        Mon, 25 Nov 2019 10:35:44 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C39319C69;
        Mon, 25 Nov 2019 10:35:39 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        hch@lst.de, cai@lca.pw, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: fix KASAN use-after-free in iommu_insert_resv_region
Date:   Mon, 25 Nov 2019 11:35:35 +0100
Message-Id: <20191125103535.22782-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 8pbgYF59MamGTDCxyCAzoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the new region type in a variable. In case the new region
gets merged into another one, the new node is freed and nr shall
not be used anymore.

Fixes: 4dbd258ff63e ("iommu: Revisit iommu_insert_resv_region()
implementation")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Qian Cai <cai@lca.pw>
CC: Stable <stable@vger.kernel.org> #v5.3+
---
 drivers/iommu/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d658c7c6a2ab..338769f96d17 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -293,6 +293,8 @@ int iommu_insert_resv_region(struct iommu_resv_region *=
new,
 =09=09=09     struct list_head *regions)
 {
 =09struct iommu_resv_region *iter, *tmp, *nr, *top;
+=09enum iommu_resv_type nr_type =3D new->type;
+
 =09LIST_HEAD(stack);
=20
 =09nr =3D iommu_alloc_resv_region(new->start, new->length,
@@ -313,7 +315,7 @@ int iommu_insert_resv_region(struct iommu_resv_region *=
new,
 =09=09phys_addr_t top_end, iter_end =3D iter->start + iter->length - 1;
=20
 =09=09/* no merge needed on elements of different types than @nr */
-=09=09if (iter->type !=3D nr->type) {
+=09=09if (iter->type !=3D nr_type) {
 =09=09=09list_move_tail(&iter->list, &stack);
 =09=09=09continue;
 =09=09}
--=20
2.20.1

