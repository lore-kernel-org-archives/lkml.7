Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D25C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37829217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919023;
	bh=5HYz9HySdQVq5lrlDIP7Oc+D4/aGmMSuIKtiSyv+qRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uRlrd2733bDH2X2NYWL0UYN3sxTgXLruzzaPV8FM3wr0BUrp8DdGMgoJVJooDoRpY
	 o/vJA/V8WhkYFA9wz5pw15a4AGM3SF6eP0nCG9SSd90t1abz1w7BIJ/RHkK3PWXAZs
	 +QOd2RhNVmXnpDD93WogaMdcwfB9FI9V2/8WBh/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfEOLRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730304AbfEOLQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:16:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2532084E;
        Wed, 15 May 2019 11:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919016;
        bh=5HYz9HySdQVq5lrlDIP7Oc+D4/aGmMSuIKtiSyv+qRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzPAf8Q4nCtuMy5hN70v+2lTPxsp6ucrKxEiaUl05VLrmSIqZp7Vo0hD1abLEgKeG
         v7bhzvS9j0vGeMQ3B8+9CTWghdfTKKAJE1MZED1QQ2+XkHPxMZZ4Iq2cTlwQsLPq0W
         E4krrYGZ4Yn+VlL6YXdXBSoONjq7DYyoUMGmIn2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 008/115] libnvdimm/namespace: Fix a potential NULL pointer dereference
Date:   Wed, 15 May 2019 12:54:48 +0200
Message-Id: <20190515090659.866818790@linuxfoundation.org>
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
index 50b01d3eadd9c..e3f228af59d1e 100644
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



