Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12CBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85517214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412629;
	bh=a5Z8Fn9SunUQhWgFn+mvrNwSQUu9DI89wX9HGrAeA+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vko7vdMOi8Cmv1RGW9KquDj5KQI8obrYUzUUQnZLhgr8XjUe5He+1dXgdY3UuXb5L
	 6ydgzc5qgvFVo2ULqx9o1CE1iZDKQ2Tky4p942tSIfi/3OMq10LdcVGjlAyLdATJOf
	 W1C3a0CE6uuZen9C1i7YFrlRnVzjxhemZlWGt/2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfCLRns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbfCLRPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:44 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF6721741;
        Tue, 12 Mar 2019 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410943;
        bh=a5Z8Fn9SunUQhWgFn+mvrNwSQUu9DI89wX9HGrAeA+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNkUyUKK9IhV+7Iwe38Xge/OU4r6MBZaVmNDR9pEFJV36TKxcTPE20uQWZp+sdEIR
         8EvmfV2TyluvV0RlM2++6b5t/j2mEvOxELsddr3VZz4kGIex2pCTqxZOD1bTYQAXsR
         gde6eqqUExPBBALcobqQnB5UE4hX7qxn02oluwxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qing Xia <saberlily.xia@hisilicon.com>,
        Jing Xia <jing.xia@unisoc.com>,
        Yuming Han <yuming.han@unisoc.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH 4.14 007/135] staging: android: ion: fix sys heap pools gfp_flags
Date:   Tue, 12 Mar 2019 10:07:34 -0700
Message-Id: <20190312170341.841646562@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -298,10 +298,10 @@ static int ion_system_heap_create_pools(
 					bool cached)
 {
 	int i;
-	gfp_t gfp_flags = low_order_gfp_flags;
 
 	for (i = 0; i < NUM_ORDERS; i++) {
 		struct ion_page_pool *pool;
+		gfp_t gfp_flags = low_order_gfp_flags;
 
 		if (orders[i] > 4)
 			gfp_flags = high_order_gfp_flags;


