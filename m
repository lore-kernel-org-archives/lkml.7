Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E20AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AB520843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921650;
	bh=KRNbchKjvaq9cxfAHE0Ungleyk2I7CgG96cii6I6HJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=frbUfmZdFQ8v0aW/ls8OQyIBNjHYAjf9/hEOyZTjM9iZc9UuntvlrZBmPSes4H/I8
	 FU3q7pOzMToEUOr6LrzA7B41OzoSEojf4OgjDgrpEtxHH2pwmw4tyFaAXSfRLBarSZ
	 +TTO9JfBCfdajbqn7QeIKYTBzB480pkqkDte6GGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfEOMAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729914AbfEOLO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:14:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A15F1216FD;
        Wed, 15 May 2019 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918869;
        bh=KRNbchKjvaq9cxfAHE0Ungleyk2I7CgG96cii6I6HJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mW7VAdvsLLGqf1MIuw4DSYHgJ0VYiZQyP4YvG+W6EAEuwtJvjOmK3FR3Aj7BZJ4GA
         umxDNFLpftAsgFiYdEOMgHOuyV5HcMUOtYiAF5A0/+lrA045oCqmgkb4vZkHYkzaST
         wjhy/OmpQBTCYsMwI/xpVFJE8ifH5NvcmAK3fqF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 07/51] libnvdimm/namespace: Fix a potential NULL pointer dereference
Date:   Wed, 15 May 2019 12:55:42 +0200
Message-Id: <20190515090619.522764942@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.669619870@linuxfoundation.org>
References: <20190515090616.669619870@linuxfoundation.org>
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
index 9bc5f555ee686..cf4a90b50f8b8 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2028,9 +2028,12 @@ struct device *create_namespace_blk(struct nd_region *nd_region,
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



