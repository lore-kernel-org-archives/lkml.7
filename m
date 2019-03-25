Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED72C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D21C206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jK7dofdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfCYVzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:55:32 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:42652 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfCYVzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:55:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id EC50CB55
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 21:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lWVuwLDLNXhC for <linux-kernel@vger.kernel.org>;
        Mon, 25 Mar 2019 16:55:30 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id B7D4AB02
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:55:30 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id k8so1935367itd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2vvXSIdAxQjf8zb5u5UoWxHhBu1vws6yCvjtMUWtbhw=;
        b=jK7dofdTbzt0PVPksd4nGjIDfty/wZQw62qHgniNwG7nFRxsyNl7S1fciiQNXZrLul
         15T4mi3ssFF45KgcEdJlBUIxcm07FZTaoaANhf3B93YLgSKxZTctulLY6uQpIDkgbbkd
         De2B/AMDNU1LDyZi+Epb7O1PrSkryO5saUZLjcTFkPZdx3kZVDyFlnk3GrHII1DtTckd
         yuLPWlUovw6XDi2+usr88S5tpGpH+rkP9fwqHnDK1KbfL5qL/5y0V8hczrIPPWqGtgzH
         OeZcWjDCuKpQuLJgPQcAq2V9yxizkVFBgw1Nkl289+MKGEEbvv3CABYXdLUIs8+t7CH+
         iW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2vvXSIdAxQjf8zb5u5UoWxHhBu1vws6yCvjtMUWtbhw=;
        b=RJ/t1RQhTTWIdy0CwbwF6FeaQDUPVmWCDoi2cn0jAZDHaLb0GUPJsANEEdGDp77tfb
         GAjUe8j9ROYcIwItLnWytohVNHbl/3CNnVpCCDdRD5vL3S3X3hV9QATsreTExojz2sh3
         tiKUFh0Xp+PD0TxxdW5GmyCMYWilLMZ/H2AN7tkyl5Q9c8Qf83UcAaojpQ6yUfIs3UXf
         sTolxQ65x1HUnCSIfdtN+jVclqMGe68JU0NLlpieQhwANyklZSDDZRAASJQ1w38k7a9D
         Qh8J+LzlOp7r4xxoJAZczcJiV3ywZft1qTEOpXznU1s/Qv1JTf0SHyUIOaoz+wSvDwDh
         COlg==
X-Gm-Message-State: APjAAAW987CEhNDk8sDTtSulvYa4Ba0KE7Ms/QyNs8vd90lOMIr08I5a
        xvWnjV/9+ypPItuuUHu5Hg9uI7l7ZNN5sZomXdQxPrEGEiR4htqEb56Ytn4zrSqmXyhzhymCvnq
        5CCmuQVa/X5e0eWmGRvh4iZnEEDGg
X-Received: by 2002:a24:35c9:: with SMTP id k192mr11440807ita.156.1553550930125;
        Mon, 25 Mar 2019 14:55:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzPtSwjk5EA9avAfKKFxeoRVTGKKoy3sPWM8w5JrkwwHVfkRP5R4rXHSsM1s+AGpMd2avMDA==
X-Received: by 2002:a24:35c9:: with SMTP id k192mr11440794ita.156.1553550929849;
        Mon, 25 Mar 2019 14:55:29 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id g10sm7492444itc.36.2019.03.25.14.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:55:29 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] nvdimm: btt_devs: fix a NULL pointer dereference
Date:   Mon, 25 Mar 2019 16:55:27 -0500
Message-Id: <20190325215527.12574-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kmemdup fails, the fix releases resources and returns to
avoid the NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v3: Move kfree(nd_btt) to goto block.
v2: Replace incorrect kfree with ida_simple_remove, suggested by
Johannes Thumshirn
v1: Free nd_btt->id in case of failure and avoid double free, suggested
by Dan Williams
---
 drivers/nvdimm/btt_devs.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index b72a303176c7..9486acc08402 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -198,14 +198,15 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
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
@@ -220,6 +221,13 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
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
2.17.1

