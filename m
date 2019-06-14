Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC0BC31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41C82173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="neN3kBOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFNAMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 20:12:06 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18268 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNAMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 20:12:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d02e6550000>; Thu, 13 Jun 2019 17:12:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 17:12:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 13 Jun 2019 17:12:05 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 00:12:04 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 00:12:00 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 14 Jun 2019 00:12:00 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d02e64f0000>; Thu, 13 Jun 2019 17:11:59 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     <nouveau@lists.freedesktop.org>, <linux-mm@kvack.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH] drm/nouveau/dmem: missing mutex_lock in error path
Date:   Thu, 13 Jun 2019 17:11:21 -0700
Message-ID: <20190614001121.23950-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560471125; bh=2rNJ7DTMjMPhOlVosuT+dcn+kIR1ESSVOR99OmM6ZKM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=neN3kBOM4fwFzxxjmxWL1ltp+tFO8bAcbqFK/NkF6ljwaGDjCyCUNjyfFcYeKG9T4
         5LdGR7QCJzezPlMCmrdKYb1uNBS/iIAEnpK1hMJVC4YlXEsNnr9L2qFHaYil+aBIyJ
         60wMyDHM5XN/zwZxTsCkESQujXLaoeWvhG5kKgnBZubuDk3cxpKMsqfWLQComwBkgO
         y8MOe90H/Rqb7zeWBsQG5hqIu9N7CqlNp/FIgtnz3xiNXN0ispWt/+exKroPpJ9wCJ
         Pz57q/vucsb+GtG/qX1XENQ8dZu+F/CYr0G+CV/G3g2ekKciae45Ha0N3zk6j+9N+U
         gbTCIFIddddug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nouveau_dmem_pages_alloc(), the drm->dmem->mutex is unlocked before
calling nouveau_dmem_chunk_alloc().
Reacquire the lock before continuing to the next page.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

I found this while testing Jason Gunthorpe's hmm tree but this is
independant of those changes. I guess it could go through
David Airlie's tree for nouveau or Jason's tree.

 drivers/gpu/drm/nouveau/nouveau_dmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouve=
au/nouveau_dmem.c
index 27aa4e72abe9..00f7236af1b9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -379,9 +379,10 @@ nouveau_dmem_pages_alloc(struct nouveau_drm *drm,
 			ret =3D nouveau_dmem_chunk_alloc(drm);
 			if (ret) {
 				if (c)
-					break;
+					return 0;
 				return ret;
 			}
+			mutex_lock(&drm->dmem->mutex);
 			continue;
 		}
=20
--=20
2.20.1

