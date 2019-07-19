Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E475BC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFDA21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563511035;
	bh=/TZCDMO7PmrUqAcLJZ0HPzkEVQDWNzyulwyt0GEmmqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kvMjPwC8ro5w6uP9bf3tKjk1m6HG32SVJs8ryXZV9FI5zdK8IQdAwjSUSqckkEQDW
	 leaHCdm6O9qd4pj6LrZzz4PQgIOMpHYBc4jscsg3cIYwOsnmiqgHBryaXRuO1z42YA
	 53VMLtLdcHloouX2liiL45eGOzsty/uAAeO6tXRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfGSEAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfGSEAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:00:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 078AC21882;
        Fri, 19 Jul 2019 04:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508804;
        bh=/TZCDMO7PmrUqAcLJZ0HPzkEVQDWNzyulwyt0GEmmqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k0Uxg2zULNrvAeuQfNtRdr0/Biivoii9eUXyTxbxVlGyPh7hicFdLgCEIRqH3TcSl
         5SZkBgA1H1IBXE7NVxzik0G251fdNGsCbMJHkc4sU/YCqMcY1LOr/FY/ZcXw0QqeNR
         D32WfSRsuFSPylnKdlSmT3Hpgyv5tzrGl55ZY32Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robert Hancock <hancock@sedsystems.ca>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 099/171] mfd: core: Set fwnode for created devices
Date:   Thu, 18 Jul 2019 23:55:30 -0400
Message-Id: <20190719035643.14300-99-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Hancock <hancock@sedsystems.ca>

[ Upstream commit c176c6d7e932662668bcaec2d763657096589d85 ]

The logic for setting the of_node on devices created by mfd did not set
the fwnode pointer to match, which caused fwnode-based APIs to
malfunction on these devices since the fwnode pointer was null. Fix
this.

Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/mfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index dbf684c4ebfb..23276a80e3b4 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -175,6 +175,7 @@ static int mfd_add_device(struct device *parent, int id,
 		for_each_child_of_node(parent->of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
 				pdev->dev.of_node = np;
+				pdev->dev.fwnode = &np->fwnode;
 				break;
 			}
 		}
-- 
2.20.1

