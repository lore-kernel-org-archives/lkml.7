Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A374AC10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A0F20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050464;
	bh=mAEgiU6lOXultLVdlHUThsBZjwACq3XNU2uqQ3gT52o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2qfDe78msvkybAICRn6z/+JMKMqX86byvkTRGBDoz/czlM/Al7uBy9VdnVpraD2aj
	 E/D3jJfR5IBjAWnV1Y7xtIiUbqryAkMbsuNA2/jxaktPJpQSWUJuZuB06DXDI3Segc
	 b8APcQFeN9PQljorCKc7kIlLiKzw1oZx+nm9Z9uI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfCHMxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbfCHMxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:53:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1525F20684;
        Fri,  8 Mar 2019 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049629;
        bh=mAEgiU6lOXultLVdlHUThsBZjwACq3XNU2uqQ3gT52o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxlKelpCwH/0wAOzOCrCcoC7CchvJbE0OMxdZDUalJWMpKNbPyyiLIAH2Wwo+QbHP
         Tj6Fvg+7OYeyPAjh09fHiVOBOnLR5+jkKIq/gatvhxJ8d/6auUt9vcqe51CBwkR0MQ
         Dui3q2IPmnMNtIRD9h5sdFey3pEG6nP2Wx9hMLac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qing Xia <saberlily.xia@hisilicon.com>,
        Jing Xia <jing.xia@unisoc.com>,
        Yuming Han <yuming.han@unisoc.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH 4.20 15/76] staging: android: ion: fix sys heap pools gfp_flags
Date:   Fri,  8 Mar 2019 13:49:27 +0100
Message-Id: <20190308124915.317170968@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -224,10 +224,10 @@ static void ion_system_heap_destroy_pool
 static int ion_system_heap_create_pools(struct ion_page_pool **pools)
 {
 	int i;
-	gfp_t gfp_flags = low_order_gfp_flags;
 
 	for (i = 0; i < NUM_ORDERS; i++) {
 		struct ion_page_pool *pool;
+		gfp_t gfp_flags = low_order_gfp_flags;
 
 		if (orders[i] > 4)
 			gfp_flags = high_order_gfp_flags;


