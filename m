Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C44C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DED320843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921382;
	bh=MsKpJu/rQsGhNAgoIkic8uElXoSBcNcLmOK452GreJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JQyMN3f0ESgoeP/noae3egmPwDlZbSx1qVZhSyOdXkyuua4VtwEj/nYKI61vdRN4Y
	 5hn73oqEVaY2UIhzRtPQxfYsukKz049bGL4iTYZJnKvcge9FO8LHgvnxO5LeU5AiGA
	 zTSyKjAhcgRoVY3JCaxXPtHISlisNKX2+AXU7wUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfEOL4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730721AbfEOLRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:17:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 655A320843;
        Wed, 15 May 2019 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919071;
        bh=MsKpJu/rQsGhNAgoIkic8uElXoSBcNcLmOK452GreJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3CbxytG3On8hM1kgv3p1u3fTfye4aZ7qx/XjyP9Cpgm4YOQDOpnFau5QAUALSQSO
         HIL8dRkaMF2mswO7oFKBLbSUOw9nR46ao+bYfNqEUyD5Lo4vo9yRg37a0+sFn8+QGq
         H59+IDZw/VRMirr+NQf6miSkDmRycPKpUDAtsh4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 012/115] libnvdimm/btt: Fix a kmemdup failure check
Date:   Wed, 15 May 2019 12:54:52 +0200
Message-Id: <20190515090700.176180833@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index d58925295aa79..e610dd890263b 100644
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



