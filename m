Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305B7C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 04:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA792217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 04:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="BsO0/bHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfHZEsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 00:48:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39526 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfHZEsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 00:48:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so13924783wra.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 21:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I1X3WOpXG5XCDr09buC6cHm1zmHyPqzvS2NgnTCXAzY=;
        b=BsO0/bHVOCA6KrgOFcyhpwuwM0sXDhof1v9dGcGxaQRPyLQI1w0E3UOjivetqc6jkM
         kss2brU/g8NmgjGFUs42UGbwzNgjMBU5Kr1fS1YmGuSiRX+EzqKSaXJv2ggy5DNs00nq
         c/uM8KuuYKdSaFYBwUJ9UVInJr0FEA0NWClfF45ew6OX5wLg47V3wivuwulCiqu0+xzl
         yS4bCm+fQClVVelO+FtuxWyAb9/NOMf3rJzJ/9VhZEW72zCIOyka7LCKKeFg95HmMaOo
         LyjqSlurgShPx4UpuIsoWuflvAN13w6F0PlhkVoKrd8Tu89H3/RXhqqzFZtlCJHWlBGJ
         yhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I1X3WOpXG5XCDr09buC6cHm1zmHyPqzvS2NgnTCXAzY=;
        b=t7jVy95Un7FMqvQq/beMC2km8PLAz5s9tkECcrHa4fl0/2Gkasb9gVPluMoTQy0LDy
         3itFgxpHba1dnH28dKHkhQcHKWM8AmgmhNtAN6zRStMMt6qOk8++tQ8JeoX7Se5TteVW
         GlevYhfyuMVYL+aE5WhVWphiyEBfYpohynX1QJ3rV/ch0AyMrrLY5XxtTto4UImyuDrE
         cyU1/VX45BaaPuxkc1kSIXZOck7uS4NxSmqD5gGWUaQ7dgQBQNUCSqOTEIU0htfUqnSj
         UTprPyPdPtah8NQqFaCN1O4pwcC2dPSIbcyQ32OI/V93KRAfj/yATji2G4/UlolWhYH3
         8K0Q==
X-Gm-Message-State: APjAAAUjd4l7CWq4qmtqbR5Z5Qcy2iqcymlLARyHVQyLzUvdAHduldij
        kIrsDjYAQ9asNBN/lBfLDgnpzg==
X-Google-Smtp-Source: APXvYqwDsITf3mbd65loamqP7b0Ty+DNRnFPz243wljEeyIXMr7T5Da9pRhckNq3wv/+LrtBaJb1oQ==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr18225920wrt.213.1566794908961;
        Sun, 25 Aug 2019 21:48:28 -0700 (PDT)
Received: from localhost.localdomain (ip-89-102-174-174.net.upcbroadband.cz. [89.102.174.174])
        by smtp.googlemail.com with ESMTPSA id n9sm11799010wrp.54.2019.08.25.21.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 21:48:28 -0700 (PDT)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Remove wrong default domain comments
Date:   Mon, 26 Aug 2019 05:48:21 +0100
Message-Id: <20190826044821.27017-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These comments are wrong. request_default_domain_for_dev doesn't just
handle direct mapped domains.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ea95080372e7..3b6807e7a2d8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2179,7 +2179,6 @@ request_default_domain_for_dev(struct device *dev, unsigned long type)
 
 	mutex_lock(&group->mutex);
 
-	/* Check if the default domain is already direct mapped */
 	ret = 0;
 	if (group->default_domain && group->default_domain->type == type)
 		goto out;
@@ -2189,7 +2188,6 @@ request_default_domain_for_dev(struct device *dev, unsigned long type)
 	if (iommu_group_device_count(group) != 1)
 		goto out;
 
-	/* Allocate a direct mapped domain */
 	ret = -ENOMEM;
 	domain = __iommu_domain_alloc(dev->bus, type);
 	if (!domain)
@@ -2204,7 +2202,7 @@ request_default_domain_for_dev(struct device *dev, unsigned long type)
 
 	iommu_group_create_direct_mappings(group, dev);
 
-	/* Make the direct mapped domain the default for this group */
+	/* Make the domain the default for this group */
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
 	group->default_domain = domain;
-- 
2.20.1

