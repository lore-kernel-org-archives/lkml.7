Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06117C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C996A217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kreOTcKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfEVKrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:47:32 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15512 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfEVKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:47:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce528c30000>; Wed, 22 May 2019 03:47:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 22 May 2019 03:47:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 22 May 2019 03:47:30 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 May
 2019 10:47:30 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 May
 2019 10:47:29 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 22 May 2019 10:47:29 +0000
Received: from puneets-dt1.nvidia.com (Not Verified[10.24.229.31]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce528be0002>; Wed, 22 May 2019 03:47:29 -0700
From:   Puneet Saxena <puneets@nvidia.com>
To:     <robh+dt@kernel.org>, <pantelis.antoniou@konsulko.com>,
        <frowand.list@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <vdumpa@nvidia.com>, <snikam@nvidia.com>,
        <jonathanh@nvidia.com>, Puneet Saxena <puneets@nvidia.com>
Subject: [PATCH V2] of: reserved-memory: ignore disabled memory-region nodes
Date:   Wed, 22 May 2019 16:17:11 +0530
Message-ID: <1558522031-549-2-git-send-email-puneets@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558522031-549-1-git-send-email-puneets@nvidia.com>
References: <1558522031-549-1-git-send-email-puneets@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558522051; bh=bYO1S1zDENa+sz4IejITQwgqUFcouFoo7ioL6b2xM7c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kreOTcKfZMYl/h/nYhDavwTK5wA1Q3R/aNoYz3BOzBRVei5WhfHVQK/+3Y9z1HRKu
         Vi3k7EeH82huo1NR4KYx9+7H55iT9OmPALTjHLnU2cf6TAJw5nyU4ID3Up7OkinWQN
         j8+8X8q6ozsPKboA3zlvWiA8xUzcqdszp5uI0kbT7Ch4Tu3E80UcLl6cD1t5Ym07Zo
         pFo5SzMI3Ab+KjOxKG8FNsQWfksj8zVoboLShvRy2ADghHsk1+6XYLwWHlzhtPqE8J
         +EWmaQJHcoFDTHjKnMf/EresWPtQGO7G+Jt3nYbT/rqqNPkui77rfeq6YnemJA1Fe5
         ZXeb/NB3/+S8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krishna Reddy <vdumpa@nvidia.com>

Ignore disabled nodes in the memory-region 
nodes list and continue to initialize the rest 
of enabled nodes.

Check if the "reserved-memory" node is available
and if it's not available, return 0 to ignore the 
"reserved-memory" node and continue parsing with 
next node in memory-region nodes list.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
Signed-off-by: Puneet Saxena <puneets@nvidia.com>
---
v2:
* Fixed typo in commit message.
* Used "of_device_is_available" to check "reserved-memory"
  nodes are disabled/enabled.

 drivers/of/of_reserved_mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1977ee0adcb1..b0b7a0c4431d 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -322,6 +322,9 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 	if (!target)
 		return -ENODEV;
 
+	if (!of_device_is_available(target))
+		return 0;
+
 	rmem = __find_rmem(target);
 	of_node_put(target);
 
-- 
2.7.4

