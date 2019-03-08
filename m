Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8070C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B37F20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049872;
	bh=65eL7LjSPHqObtQXc3xFm/NqJ+rMAglano3YBhcfnqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1VIGwT37j8o0AF8JRdZhhAa4wbgbotb3vqF7pT//dUoBDfA5TiZx10SvU4kmea+3v
	 E4flwHZbutcmmKEgGbumo1jLqndwaUMxuLNlv85X4NeZhF24YK6pt1oHuN2NXFVTXs
	 +plpEUk71LAB1iReDr2PallDBgtYwEvD9YmwvTmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfCHM5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:57:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfCHM5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:57:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D962085A;
        Fri,  8 Mar 2019 12:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049860;
        bh=65eL7LjSPHqObtQXc3xFm/NqJ+rMAglano3YBhcfnqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHshxJcMVvRa3h7YVZRoozCRWVUG1MB5BgztiZ8R7RHHyZ2+g09fUYzzy+XctaqV0
         FBxDmkzSdPyzYIijY7T7RZnfv99At1QpfI+J5I+m+2JjH3BaeX46rOlJazpRoNErwN
         jzbxi7FDGK+T90W4X1TeRV3BBRmRbUwB/5xPuCbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qing Xia <saberlily.xia@hisilicon.com>,
        Jing Xia <jing.xia@unisoc.com>,
        Yuming Han <yuming.han@unisoc.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH 4.19 10/68] staging: android: ion: fix sys heap pools gfp_flags
Date:   Fri,  8 Mar 2019 13:49:40 +0100
Message-Id: <20190308124911.293733093@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -247,10 +247,10 @@ static void ion_system_heap_destroy_pool
 static int ion_system_heap_create_pools(struct ion_page_pool **pools)
 {
 	int i;
-	gfp_t gfp_flags = low_order_gfp_flags;
 
 	for (i = 0; i < NUM_ORDERS; i++) {
 		struct ion_page_pool *pool;
+		gfp_t gfp_flags = low_order_gfp_flags;
 
 		if (orders[i] > 4)
 			gfp_flags = high_order_gfp_flags;


