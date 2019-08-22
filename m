Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B3CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FB223426
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494616;
	bh=v1qJUyEw14ffyTtAkJ2MRHYdOutA6FVC35Hnd5dLXyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZQFKnrGnrno912Z7nQCs4rjCURrrTlcCxOjpGjxLLE3ZLwXxIxQPJfun9Evno69Qy
	 92cSJlXGyGz45mkvABU+AZ3NB4PKwuL6bVT2SmdeTaYFh2yek3ddOLviaimAcmt+Uc
	 0h048crJtzLVPZElEbj7pox070o32nJodSXHimZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391564AbfHVRXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403928AbfHVRXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:23:22 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD6323405;
        Thu, 22 Aug 2019 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494602;
        bh=v1qJUyEw14ffyTtAkJ2MRHYdOutA6FVC35Hnd5dLXyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oav2r/vitdIrmKCRvSE09WZtHfC2ag8RE4bEI1aJUfiN5cvn2Qt9UYorGMC9DKea5
         OF+41jO+gCDrgNrje3uQNA7MLiDFtcSajx6R4Am7tyKjT/WSK3wgw99EAZ/Hms2PVH
         osHicVlYP8wsXfRpNqJbxbMH6+qUXhPZZRUE9wAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 024/103] ACPI/IORT: Fix off-by-one check in iort_dev_find_its_id()
Date:   Thu, 22 Aug 2019 10:18:12 -0700
Message-Id: <20190822171729.831400354@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5a46d3f71d5e5a9f82eabc682f996f1281705ac7 ]

Static analysis identified that index comparison against ITS entries in
iort_dev_find_its_id() is off by one.

Update the comparison condition and clarify the resulting error
message.

Fixes: 4bf2efd26d76 ("ACPI: Add new IORT functions to support MSI domain handling")
Link: https://lore.kernel.org/linux-arm-kernel/20190613065410.GB16334@mwanda/
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Will Deacon <will@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/arm64/iort.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 6b81746cd13c8..e5b1b3f1c2319 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -324,8 +324,8 @@ static int iort_dev_find_its_id(struct device *dev, u32 req_id,
 
 	/* Move to ITS specific data */
 	its = (struct acpi_iort_its_group *)node->node_data;
-	if (idx > its->its_count) {
-		dev_err(dev, "requested ITS ID index [%d] is greater than available [%d]\n",
+	if (idx >= its->its_count) {
+		dev_err(dev, "requested ITS ID index [%d] overruns ITS entries [%d]\n",
 			idx, its->its_count);
 		return -ENXIO;
 	}
-- 
2.20.1



