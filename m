Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0F4C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCBF2182B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752389;
	bh=lbCdSVHFT3quE/mQUpsrEYPOjNgjtr0f4jee3R1I3Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ETFCVmWKzysN+WPrmu355JnNA4SYMq2jNDV5Mq0DNRx0tKdegZDtAWDDCIq1BsSEH
	 zoVkMQAHfgwhq3ovEPh1hEMZDIuA4LE11ve8VLrsdDM0B1BzmReGf13KC7uLS2Wezo
	 fm85TxnELwuAzmEyItqGhKri9sHgJSbWrakMo1gM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394571AbfHBN0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391501AbfHBN0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:26:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB6F82182B;
        Fri,  2 Aug 2019 13:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752376;
        bh=lbCdSVHFT3quE/mQUpsrEYPOjNgjtr0f4jee3R1I3Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GP3LBZjohQ2kbup5Srn0eiixpOH/hIcc+FCCNUaKez7ESnviw90nZFQBDtfyKYbxu
         b1TDSFsxhOsiQjtKxUFJ2cMM1RK/tPIkhCUJdbmLQv1AV1nX6nUwqTC1vu7asJIlnD
         3qR6bGruYprzu5Nkj0hOvU/5nkloSms72Q7zz9d4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 16/22] ACPI/IORT: Fix off-by-one check in iort_dev_find_its_id()
Date:   Fri,  2 Aug 2019 09:25:40 -0400
Message-Id: <20190802132547.14517-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132547.14517-1-sashal@kernel.org>
References: <20190802132547.14517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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

