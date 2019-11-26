Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EA2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1B020684
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFY1BB+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKZRy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:54:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56577 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbfKZRy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574790865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jH4n5LJEgEFoXEBsyDUNpdLdyn9LnH0pqtbnZfED+0w=;
        b=bFY1BB+NFlpotlh3KRBnoxxOjQy0bnnDW7UKY8Iy2uMFb6QQG28FunIgRcYU62YKttVwSy
        MnOAf2TZm4DyFhUODhwKRbYnE7Hgt8eHKuhXtW++CxGgt4fSU80jFzm7KJI1Pc3bE4YpP7
        imu2hBfrUjErsLaKlbh7a+PnwNNZlkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-Z58OA4CgNMa5aUinv2X9WA-1; Tue, 26 Nov 2019 12:54:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A72F80183C;
        Tue, 26 Nov 2019 17:54:22 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EC5E5D9CD;
        Tue, 26 Nov 2019 17:54:17 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        hch@lst.de, cai@lca.pw, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     jsnitsel@redhat.com
Subject: [PATCH v4] iommu: fix KASAN use-after-free in iommu_insert_resv_region
Date:   Tue, 26 Nov 2019 18:54:13 +0100
Message-Id: <20191126175413.4350-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Z58OA4CgNMa5aUinv2X9WA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the new region gets merged into another one, the nr
list node is freed. Checking its type while completing the
merge algorithm leads to a use-after-free. Use new->type
instead.

Fixes: 4dbd258ff63e ("iommu: Revisit iommu_insert_resv_region()
implementation")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Qian Cai <cai@lca.pw>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Stable <stable@vger.kernel.org> #v5.3+

---

v3 -> v4:
- s/nr/new in the comment
- Added Jerry's R-b

v2 -> v3:
- directly use new->type

v1 -> v2:
- remove spurious new line
---
 drivers/iommu/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d658c7c6a2ab..dea1069334a4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -312,8 +312,8 @@ int iommu_insert_resv_region(struct iommu_resv_region *=
new,
 =09list_for_each_entry_safe(iter, tmp, regions, list) {
 =09=09phys_addr_t top_end, iter_end =3D iter->start + iter->length - 1;
=20
-=09=09/* no merge needed on elements of different types than @nr */
-=09=09if (iter->type !=3D nr->type) {
+=09=09/* no merge needed on elements of different types than @new */
+=09=09if (iter->type !=3D new->type) {
 =09=09=09list_move_tail(&iter->list, &stack);
 =09=09=09continue;
 =09=09}
--=20
2.20.1

