Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9229CC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8F420679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564753048;
	bh=/0L4iGPzgOvwzgnXoAgmZHTkRkRMWXkx4P6ckdBfMK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oYzwB1cEC0QKL+P0CUM+VkzqDaPPn02wXItpGJR2kt1HwW9grWeyTHWKdWRl0TM2U
	 SvQEgculmLqnVy/sudH0h804umROqTu1RqrQ2ec9wsSg9GjLFhZGekg5D3BI+aGnID
	 80SWKDJkldfjbFuzOoRf0mDfnK/83I87zSg60rEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436504AbfHBNh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731146AbfHBNT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:19:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F292216C8;
        Fri,  2 Aug 2019 13:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564751995;
        bh=/0L4iGPzgOvwzgnXoAgmZHTkRkRMWXkx4P6ckdBfMK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZVZOHWyOrLhwCddQ0NZYHlbz9XP8rzkrHyNuVleh38J++4kLIcnEMd57kzi12Cl0G
         +KKltrxsP0+zyuIGYh0aim/zmqNz0NxnvhB5s7Kz7N8JPNxosmKBWtVusgbrE6vFBZ
         A6yJ5gy+7kDKCJdRuYMga6DehbPixHpOIsjfTJyk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Farhan Ali <alifm@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 03/76] vfio-ccw: Set pa_nr to 0 if memory allocation fails for pa_iova_pfn
Date:   Fri,  2 Aug 2019 09:18:37 -0400
Message-Id: <20190802131951.11600-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Farhan Ali <alifm@linux.ibm.com>

[ Upstream commit c1ab69268d124ebdbb3864580808188ccd3ea355 ]

So we don't call try to call vfio_unpin_pages() incorrectly.

Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <33a89467ad6369196ae6edf820cbcb1e2d8d050c.1562854091.git.alifm@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_cp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 0e79799e9a719..79eb40bdaf9f4 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -89,8 +89,10 @@ static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
 				  sizeof(*pa->pa_iova_pfn) +
 				  sizeof(*pa->pa_pfn),
 				  GFP_KERNEL);
-	if (unlikely(!pa->pa_iova_pfn))
+	if (unlikely(!pa->pa_iova_pfn)) {
+		pa->pa_nr = 0;
 		return -ENOMEM;
+	}
 	pa->pa_pfn = pa->pa_iova_pfn + pa->pa_nr;
 
 	pa->pa_iova_pfn[0] = pa->pa_iova >> PAGE_SHIFT;
-- 
2.20.1

