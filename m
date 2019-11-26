Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CABC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B06220748
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBPtyFST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfKZK14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:27:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43703 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727724AbfKZK14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574764074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tTo+z7GRdEpyDEyvmGX1mKfcZRDUg8TD8VPVW7nr34c=;
        b=hBPtyFSTQCIlnUrfFM3BaKNlqWx543PzOaOlvmE4YPWdhzM5zOThUFNGlVWHN5SUEypZ0l
        DR23qYGBJm+qvuzrdqC8pkyL94tzYCamdlBtBEoMBcI79COjAmCuDomupMR07PJAkZBn1Z
        uFeXmlzDxh2NjuylrZ0fdtymgZHo13I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-Ns7fCixZMkCzNmMzbMTBrw-1; Tue, 26 Nov 2019 05:27:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57F468017CC;
        Tue, 26 Nov 2019 10:27:52 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E7165D6BE;
        Tue, 26 Nov 2019 10:27:47 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        hch@lst.de, cai@lca.pw, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] iommu: fix KASAN use-after-free in iommu_insert_resv_region
Date:   Tue, 26 Nov 2019 11:27:43 +0100
Message-Id: <20191126102743.3269-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Ns7fCixZMkCzNmMzbMTBrw-1
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
Cc: Stable <stable@vger.kernel.org> #v5.3+

---

v2 -> v3:
- directly use new->type

v1 -> v2:
- remove spurious new line
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d658c7c6a2ab..285ad4a4c7f2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -313,7 +313,7 @@ int iommu_insert_resv_region(struct iommu_resv_region *=
new,
 =09=09phys_addr_t top_end, iter_end =3D iter->start + iter->length - 1;
=20
 =09=09/* no merge needed on elements of different types than @nr */
-=09=09if (iter->type !=3D nr->type) {
+=09=09if (iter->type !=3D new->type) {
 =09=09=09list_move_tail(&iter->list, &stack);
 =09=09=09continue;
 =09=09}
--=20
2.20.1

