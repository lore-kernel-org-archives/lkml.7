Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8777C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB382086D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfHGGzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:55:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbfHGGzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:55:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FB273DE02;
        Wed,  7 Aug 2019 06:55:07 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EE3D1001281;
        Wed,  7 Aug 2019 06:55:04 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgg@ziepe.ca,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 02/10] vhost: don't set uaddr for invalid address
Date:   Wed,  7 Aug 2019 02:54:41 -0400
Message-Id: <20190807065449.23373-3-jasowang@redhat.com>
In-Reply-To: <20190807065449.23373-1-jasowang@redhat.com>
References: <20190807065449.23373-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 07 Aug 2019 06:55:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not setup uaddr for the invalid address, otherwise we may
try to pin or prefetch mapping of wrong pages.

Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 0536f8526359..488380a581dc 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2082,7 +2082,8 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
 	}
 
 #if VHOST_ARCH_CAN_ACCEL_UACCESS
-	vhost_setup_vq_uaddr(vq);
+	if (r == 0)
+		vhost_setup_vq_uaddr(vq);
 
 	if (d->mm)
 		mmu_notifier_register(&d->mmu_notifier, d->mm);
-- 
2.18.1

