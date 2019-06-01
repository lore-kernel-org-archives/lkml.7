Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57451C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DB424C2E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395361;
	bh=ySSBzNCHE8z5+w8tkOcIZjG4dIlaAl6/E1llUlc4oNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XD29rOLc8Uv0nE50/VnCjXHE9KndQpHBDlZbzt6okXXNqWQj+wDpL66ch/vraCYIt
	 H6uRHyo/f4Z8MQWja56wLvFEygA4V5YZb3b9g8zV6UhC0uBJkm/g7snys4Fm0O+sAP
	 JWN1B3jCEJ4Qi3rJ6ebq/IaecSfrHJD0YqzbeYp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfFANWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfFANWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:22:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CAD72409B;
        Sat,  1 Jun 2019 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395357;
        bh=ySSBzNCHE8z5+w8tkOcIZjG4dIlaAl6/E1llUlc4oNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GaSzDOR/Ecbas0BxXtfHXWqB8s3zDfxnb2HGcARJnTzJhisfuH++MMbAfZB+aMbCK
         0W/sC9uYymAtrwc61A97eELQhCStJx9BxBfqvnrzAdCgVCEFOE4FaAcKZxbEZ+W9Du
         Di0Z2GxwiTaJylq7Ujyc7/RJe76OJrRR/XwNLqOM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yue Hu <huyue2@yulong.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Joe Perches <joe@perches.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Safonov <d.safonov@partner.samsung.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 014/141] mm/cma_debug.c: fix the break condition in cma_maxchunk_get()
Date:   Sat,  1 Jun 2019 09:19:50 -0400
Message-Id: <20190601132158.25821-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

[ Upstream commit f0fd50504a54f5548eb666dc16ddf8394e44e4b7 ]

If not find zero bit in find_next_zero_bit(), it will return the size
parameter passed in, so the start bit should be compared with bitmap_maxno
rather than cma->count.  Although getting maxchunk is working fine due to
zero value of order_per_bit currently, the operation will be stuck if
order_per_bit is set as non-zero.

Link: http://lkml.kernel.org/r/20190319092734.276-1-zbestahu@gmail.com
Signed-off-by: Yue Hu <huyue2@yulong.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Joe Perches <joe@perches.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dmitry Safonov <d.safonov@partner.samsung.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/cma_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index ad6723e9d110a..3e0415076cc9e 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -58,7 +58,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
 	mutex_lock(&cma->lock);
 	for (;;) {
 		start = find_next_zero_bit(cma->bitmap, bitmap_maxno, end);
-		if (start >= cma->count)
+		if (start >= bitmap_maxno)
 			break;
 		end = find_next_bit(cma->bitmap, bitmap_maxno, start);
 		maxchunk = max(end - start, maxchunk);
-- 
2.20.1

