Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A342AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2E5218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946994;
	bh=nbV8niDWQzCo9PK2wHpxKwFDKLvpEBvq9S8Szap+6pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bRLBkbpe3H9QKh0m3R1TEH5QyDQR7dPfL49l2Hq3iDE4ttLbkg8IvtwQzVyN6ZhNa
	 nipCRLmdYfv5nAyIIscF19fBEEykJJOyvCNGxb6VEKIQqJ+/LqfG1S6rBB9fe/lE5c
	 Av8HJIuCJZ5W+1e9WqTA78uzcudpt6Q8TmhJ6CKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbfIHMtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731762AbfIHMtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:49:51 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395D021920;
        Sun,  8 Sep 2019 12:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946990;
        bh=nbV8niDWQzCo9PK2wHpxKwFDKLvpEBvq9S8Szap+6pA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqapvjWWJIADTCB56JXubVvS4dCEPajFvRa7sR/CdhZcGO0WO3R0agqk/9/SN0crf
         Gqiy2u+Axhlvylb7PjwHRxMkKV5xOY5pGQhhFtJuV8+DHcmwJpYAnmvLHUdRRUdTVU
         F0R8nesN8OYnOYewb+Zyzyw1iyYfegJTQTNwwshw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 20/94] batman-adv: Fix netlink dumping of all mcast_flags buckets
Date:   Sun,  8 Sep 2019 13:41:16 +0100
Message-Id: <20190908121151.017103628@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fa3a03da549a889fc9dbc0d3c5908eb7882cac8f ]

The bucket variable is only updated outside the loop over the mcast_flags
buckets. It will only be updated during a dumping run when the dumping has
to be interrupted and a new message has to be started.

This could result in repeated or missing entries when the multicast flags
are dumped to userspace.

Fixes: d2d489b7d851 ("batman-adv: Add inconsistent multicast netlink dump detection")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index ec54e236e3454..50fe9dfb088b6 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1653,7 +1653,7 @@ __batadv_mcast_flags_dump(struct sk_buff *msg, u32 portid,
 
 	while (bucket_tmp < hash->size) {
 		if (batadv_mcast_flags_dump_bucket(msg, portid, cb, hash,
-						   *bucket, &idx_tmp))
+						   bucket_tmp, &idx_tmp))
 			break;
 
 		bucket_tmp++;
-- 
2.20.1



