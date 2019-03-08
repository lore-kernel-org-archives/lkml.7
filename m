Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA74C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C51E2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049477;
	bh=UBe65DMEFErbnmhCj8b77tZCKuMKP6DSFR34N2t2YOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yA21zgUtKvtKPBCNb3oFWVvoLxcipNr5ZHLMGk/PAtjFLXba5esW6qmMg7SglPs9n
	 TUUTYldzKj/YvqCKsd7brqmVULTMk8N3GNNKTMuzVhG+UuOdjyA4ONlO8xQ8YqxS2W
	 papYDNQWB3XRIvn8F14qV0Wcfqi8U0F3JK+ynw0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfCHMvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfCHMvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:51:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D206B2085A;
        Fri,  8 Mar 2019 12:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049474;
        bh=UBe65DMEFErbnmhCj8b77tZCKuMKP6DSFR34N2t2YOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBqnXvB79IXubjLVmwvPDOfYn2azdZb/b5aYr8lowIUZb2Am9JGXalk0NuVTZTbml
         JA37b3Z4SUwEWg1JNiZ+PEg3sxjDeA/ZJjESgY6wi8/poCyM4bvZyIZ9wahDTtnmtw
         eyuTwIITXsIqtGBxqVbJDeQTuq/8JtL+HJjreFJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qing Xia <saberlily.xia@hisilicon.com>,
        Jing Xia <jing.xia@unisoc.com>,
        Yuming Han <yuming.han@unisoc.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH 5.0 14/46] staging: android: ion: fix sys heap pools gfp_flags
Date:   Fri,  8 Mar 2019 13:49:47 +0100
Message-Id: <20190308124903.168231186@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -223,10 +223,10 @@ static void ion_system_heap_destroy_pool
 static int ion_system_heap_create_pools(struct ion_page_pool **pools)
 {
 	int i;
-	gfp_t gfp_flags = low_order_gfp_flags;
 
 	for (i = 0; i < NUM_ORDERS; i++) {
 		struct ion_page_pool *pool;
+		gfp_t gfp_flags = low_order_gfp_flags;
 
 		if (orders[i] > 4)
 			gfp_flags = high_order_gfp_flags;


