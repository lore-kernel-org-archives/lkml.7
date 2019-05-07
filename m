Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B25C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12222054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208474;
	bh=dyoheBYe10LN6nBTsCT3WYUs9mOHV0vInXEYAm/3z94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MxyzAAf8NZxXDfa/SWmARkRKqQRxC1EJA+9QltH1i0zATCXdrTdm803TKDTXWZg+/
	 Re24xK1wG2odRug45yoUINWEuCwOHLqmNGSqgzC3X5IkPH1c7t2Vo5BWuEBbVx0vjZ
	 tDm1TSWObxT9zF8QgymIb+IwLckP1sU72gx16wTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfEGFyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfEGFi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:38:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B514206A3;
        Tue,  7 May 2019 05:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207509;
        bh=dyoheBYe10LN6nBTsCT3WYUs9mOHV0vInXEYAm/3z94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9JDcfhWGhv6T6VcgL0jhmW2c4nL+EMXq0dKOcppfeg4mGdLgoXWxOAbH9bgaOriV
         PdJ20rJ0DtjLpo6p2bJ2pEtVEknl4r+av++oWjsUspq7RzIVnvK1uj28hc8stGbgaQ
         OY0R27r/Pd5QVB5FvtYwouGPiiaOfj0ToY9lL7AI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
Subject: [PATCH AUTOSEL 4.14 02/95] libnvdimm/namespace: Fix a potential NULL pointer dereference
Date:   Tue,  7 May 2019 01:36:51 -0400
Message-Id: <20190507053826.31622-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 55c1fc0af29a6c1b92f217b7eb7581a882e0c07c ]

In case kmemdup fails, the fix goes to blk_err to avoid NULL
pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/namespace_devs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 50b01d3eadd9..e3f228af59d1 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2234,9 +2234,12 @@ struct device *create_namespace_blk(struct nd_region *nd_region,
 	if (!nsblk->uuid)
 		goto blk_err;
 	memcpy(name, nd_label->name, NSLABEL_NAME_LEN);
-	if (name[0])
+	if (name[0]) {
 		nsblk->alt_name = kmemdup(name, NSLABEL_NAME_LEN,
 				GFP_KERNEL);
+		if (!nsblk->alt_name)
+			goto blk_err;
+	}
 	res = nsblk_add_resource(nd_region, ndd, nsblk,
 			__le64_to_cpu(nd_label->dpa));
 	if (!res)
-- 
2.20.1

