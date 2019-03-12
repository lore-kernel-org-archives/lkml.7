Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E821AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64952171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411316;
	bh=s0jMhxEfY2NrpUnxK/DK8KfHvi5ZoR1Kg2cEBCpHp38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WG+E9L4M35AWs1/0k3+8WI7jw4lSYIbQLK5WWXfrMcqFNbxd8Zwi0+KtCfEdL8E1Y
	 B57IaSd9P+RQhTYofqkvezjlELbkqVQHSUlM03Zch5KfVeREpu+bBjO95H7UHHmhRL
	 B2DUVEOuTELCAuLZg1/WOH5/xqx0EmGOSUHugYWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfCLRSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729574AbfCLRRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:25 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87ACA217F5;
        Tue, 12 Mar 2019 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411044;
        bh=s0jMhxEfY2NrpUnxK/DK8KfHvi5ZoR1Kg2cEBCpHp38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMwV2yzKP4FRZEjRmHbZDTJruqps1lrswB/iIYJ0yFL8F8xa9YNAOK4TTAI6D+DE2
         KEfIcymugcYOXNq/UMWPyLUVZPKDyOq4ZrpQkKOnsxini3EYxDsC+HguNFjn7nuzFz
         HXq7Bz2xysXKWkMs2GnctHc2GTjs8NBYVbEGj+zQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qing Xia <saberlily.xia@hisilicon.com>,
        Jing Xia <jing.xia@unisoc.com>,
        Yuming Han <yuming.han@unisoc.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH 4.9 09/96] staging: android: ion: fix sys heap pools gfp_flags
Date:   Tue, 12 Mar 2019 10:09:27 -0700
Message-Id: <20190312171035.262194302@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qing Xia <saberlily.xia@hisilicon.com>

commit 9bcf065e28122588a6cbee08cf847826dacbb438 upstream.

In the first loop, gfp_flags will be modified to high_order_gfp_flags,
and there will be no chance to change back to low_order_gfp_flags.

Fixes: e7f63771b60e ("ION: Sys_heap: Add cached pool to spead up cached buffer alloc")
Signed-off-by: Qing Xia <saberlily.xia@hisilicon.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Jing Xia <jing.xia@unisoc.com>
Reviewed-by: Yuming Han <yuming.han@unisoc.com>
Reviewed-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Reviewed-by: Orson Zhai <orson.zhai@unisoc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ion/ion_system_heap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -307,10 +307,10 @@ static int ion_system_heap_create_pools(
 					bool cached)
 {
 	int i;
-	gfp_t gfp_flags = low_order_gfp_flags;
 
 	for (i = 0; i < NUM_ORDERS; i++) {
 		struct ion_page_pool *pool;
+		gfp_t gfp_flags = low_order_gfp_flags;
 
 		if (orders[i] > 4)
 			gfp_flags = high_order_gfp_flags;


