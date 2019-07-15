Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF20AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BF4212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199708;
	bh=WgXYvtTnjazAHhtyrr/obVc8SL5pAcJi7MVcWDJqQTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PNTsQ6UgowX34Co7JQNSFj7Pik7BtnK97pnIzzMYzuNLYZNOklTWlXEtbBfCRbqNI
	 gnGLrVlGwxHUxuPcVUUA7CSDo8FcYLfijupDO2SfYPK9hGgnYrnHNgOFqv5Fzv6I4h
	 bzg1rYOqN6KWoEkA2b5e8k9+S7tPmN7hCbrRssfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbfGOOI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388499AbfGOOIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:08:23 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2913D21530;
        Mon, 15 Jul 2019 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199702;
        bh=WgXYvtTnjazAHhtyrr/obVc8SL5pAcJi7MVcWDJqQTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFCZuNRQlQiLP37ktGzY2z31+Kbw5+YQNTmcsVQpWZ/wWpz6zz5HotjnG5Xa1w3ui
         c7Q0Vofma9pdhHZjZLcrcbY9dlynqXD2wdDT0EmmsNXRE4r9HJgmibK62H30XpwSXj
         wvzJt/JAA+X9nsX0riQxj72kWurAlqAhjs4RMtKI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.1 077/219] iommu: Fix a leak in iommu_insert_resv_region
Date:   Mon, 15 Jul 2019 10:01:18 -0400
Message-Id: <20190715140341.6443-77-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Auger <eric.auger@redhat.com>

[ Upstream commit ad0834dedaa15c3a176f783c0373f836e44b4700 ]

In case we expand an existing region, we unlink
this latter and insert the larger one. In
that case we should free the original region after
the insertion. Also we can immediately return.

Fixes: 6c65fb318e8b ("iommu: iommu_get_group_resv_regions")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 109de67d5d72..2d06c507fbed 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -241,18 +241,21 @@ static int iommu_insert_resv_region(struct iommu_resv_region *new,
 			pos = pos->next;
 		} else if ((start >= a) && (end <= b)) {
 			if (new->type == type)
-				goto done;
+				return 0;
 			else
 				pos = pos->next;
 		} else {
 			if (new->type == type) {
 				phys_addr_t new_start = min(a, start);
 				phys_addr_t new_end = max(b, end);
+				int ret;
 
 				list_del(&entry->list);
 				entry->start = new_start;
 				entry->length = new_end - new_start + 1;
-				iommu_insert_resv_region(entry, regions);
+				ret = iommu_insert_resv_region(entry, regions);
+				kfree(entry);
+				return ret;
 			} else {
 				pos = pos->next;
 			}
@@ -265,7 +268,6 @@ static int iommu_insert_resv_region(struct iommu_resv_region *new,
 		return -ENOMEM;
 
 	list_add_tail(&region->list, pos);
-done:
 	return 0;
 }
 
-- 
2.20.1

