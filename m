Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC30CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9C621852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436892;
	bh=dcVigU6fDMmZoextzHaCniTrTK6eBi3KgAmY8viInsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rgLiUWtP1GfJu6U+bI1UmpHJpicaG1r2+6PJeROa8zzDBSaRTNj2iwjPQ7Bwx3Ohl
	 malYsk6BJTUY/XY6WztcXp1Zj9Xuzo2JcHal6TpP4ZdW+K233dTTm07F2wXY6MagEQ
	 /8g2JhjBWgzq32Mhr9Jj6YzsMvLVPdPAbqD79F4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392403AbfJRWOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388719AbfJRWJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:09:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BEE72246A;
        Fri, 18 Oct 2019 22:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436556;
        bh=dcVigU6fDMmZoextzHaCniTrTK6eBi3KgAmY8viInsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z5TSf3fEqy8DarWcxh48UXXVG1XUS5/ElpNR7Xh7idaj9R7si1WGh9hHD1ndkK0Ck
         TJhHeMOi6Xn/oxp7QJlb8wt3tKj98969aYlo33RxEdstMKCRwy6AjMZpm4Oo75no9b
         z/L1nKHCrGd7T5VJ+a7cSjCtd1NCoABQ+4XgqUvE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>, Mike Christie <mchristi@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 4.14 53/56] nbd: fix possible sysfs duplicate warning
Date:   Fri, 18 Oct 2019 18:07:50 -0400
Message-Id: <20191018220753.10002-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220753.10002-1-sashal@kernel.org>
References: <20191018220753.10002-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 862488105b84ca744b3d8ff131e0fcfe10644be1 ]

1. nbd_put takes the mutex and drops nbd->ref to 0. It then does
idr_remove and drops the mutex.

2. nbd_genl_connect takes the mutex. idr_find/idr_for_each fails
to find an existing device, so it does nbd_dev_add.

3. just before the nbd_put could call nbd_dev_remove or not finished
totally, but if nbd_dev_add try to add_disk, we can hit:

debugfs: Directory 'nbd1' with parent 'block' already present!

This patch will make sure all the disk add/remove stuff are done
by holding the nbd_index_mutex lock.

Reported-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a234600849558..3e45004407963 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -228,8 +228,8 @@ static void nbd_put(struct nbd_device *nbd)
 	if (refcount_dec_and_mutex_lock(&nbd->refs,
 					&nbd_index_mutex)) {
 		idr_remove(&nbd_index_idr, nbd->index);
-		mutex_unlock(&nbd_index_mutex);
 		nbd_dev_remove(nbd);
+		mutex_unlock(&nbd_index_mutex);
 	}
 }
 
-- 
2.20.1

