Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5EEC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741C020578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207753;
	bh=XPS/MiZOtMIgHSJp+oNA54uekeK1pdD2GuaRcW64F54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FwzRNcYpHhzJt1ROu6dU4QftoWscLQ03NkiVD0Jr5e3OqZjbGBwUcpru6+qJsFrw2
	 9X/c0o53Qoa2DIgDK5EJY+gbBWnH2W0HqRFPiFxVWsrz0xXbsz1NgsUOzs4k6YGZHs
	 Cp3MOmtn5JQlN9pT5EJyYcj4BUITNUG8/GbzqhkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfEGFmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbfEGFmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:42:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86635205ED;
        Tue,  7 May 2019 05:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207743;
        bh=XPS/MiZOtMIgHSJp+oNA54uekeK1pdD2GuaRcW64F54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rbL9tsyatmpQawIUlMEbp9Tahe3ppn1uqbCpvIxoMrep/bUa8q2Wm6Ld8qaxhmF9L
         BnY44cZx/27LEfL0EckHfSWvre6alUWAhKbOw+bHq51aIKj7qa9NsvCJVOhM16aQWj
         qAhv3AjLjfGptWdwcL+7MkcFh5k0+ISMvFKRoopg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 4.4 04/14] libnvdimm/btt: Fix a kmemdup failure check
Date:   Tue,  7 May 2019 01:42:06 -0400
Message-Id: <20190507054218.340-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507054218.340-1-sashal@kernel.org>
References: <20190507054218.340-1-sashal@kernel.org>
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
index cb477518dd0e..4c129450495d 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -170,14 +170,15 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
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
@@ -192,6 +193,13 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
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

