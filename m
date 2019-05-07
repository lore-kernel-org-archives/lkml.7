Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7C8C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B478E205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208821;
	bh=sHvKIOAEfB3iQ5fvdbpeeCL0PmmTlXV9b4O9QDwhKUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ULuznLTv6MMe8O1bwgt8QGWbKWaAGLybzDsAFJUpt/XP+EJFAbRW+pgogK1QT68Q6
	 xUXZxxYpbcjN4i88rp41nWJnE8LHy+hUCw+JGzf63XqEw8vYmFUUcoX1ObB9YitOm2
	 ajtwi+h76SdfaapNuEUBPZommTEQIwqKLHWTQOqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfEGFgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbfEGFgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:36:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A1E20989;
        Tue,  7 May 2019 05:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207367;
        bh=sHvKIOAEfB3iQ5fvdbpeeCL0PmmTlXV9b4O9QDwhKUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2Ftj5LcGNlZ5MIt9jENqnuV2kWVIpukpo/FcLTz9y6+DTr0YHhsDcrLqLkk4OYyB
         kTw7v5vGuukvDv7pSrT5ps7IWDIHBYheaNyiHbqAQYwQR1yQbqBIAG/42rXnrK/TDg
         +nzHVgkHva8kNWRl+cOPdf0GsEUkwfXA5cIhgieY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 4.19 09/81] libnvdimm/btt: Fix a kmemdup failure check
Date:   Tue,  7 May 2019 01:34:40 -0400
Message-Id: <20190507053554.30848-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053554.30848-1-sashal@kernel.org>
References: <20190507053554.30848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 486fa92df4707b5df58d6508728bdb9321a59766 ]

In case kmemdup fails, the fix releases resources and returns to
avoid the NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/btt_devs.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 795ad4ff35ca..e341498876ca 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -190,14 +190,15 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 		return NULL;
 
 	nd_btt->id = ida_simple_get(&nd_region->btt_ida, 0, 0, GFP_KERNEL);
-	if (nd_btt->id < 0) {
-		kfree(nd_btt);
-		return NULL;
-	}
+	if (nd_btt->id < 0)
+		goto out_nd_btt;
 
 	nd_btt->lbasize = lbasize;
-	if (uuid)
+	if (uuid) {
 		uuid = kmemdup(uuid, 16, GFP_KERNEL);
+		if (!uuid)
+			goto out_put_id;
+	}
 	nd_btt->uuid = uuid;
 	dev = &nd_btt->dev;
 	dev_set_name(dev, "btt%d.%d", nd_region->id, nd_btt->id);
@@ -212,6 +213,13 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
 		return NULL;
 	}
 	return dev;
+
+out_put_id:
+	ida_simple_remove(&nd_region->btt_ida, nd_btt->id);
+
+out_nd_btt:
+	kfree(nd_btt);
+	return NULL;
 }
 
 struct device *nd_btt_create(struct nd_region *nd_region)
-- 
2.20.1

