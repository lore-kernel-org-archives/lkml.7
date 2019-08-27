Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9720C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA305206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893243;
	bh=bIUiQfUrAfiyzT/EZEz2yoa3/JD/aDxkK+xgJWgp3uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0n/4cKMSmBwjxboZe57kDthmDEtrxfc+nkKQnvwxgYoIV19vvSLAO7V3jGncZpajx
	 DSgpQmeqetnb+bY32d3SpahJ3Ytda9nv+FuKWFYXW0jHZEbzcMUUYpxsY037m8v+DA
	 EmmOl1U0c36Jh++yCUd1qE87ll5DXsC6hZ/XXc7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733172AbfH0IHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730471AbfH0IHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:07:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A79206BA;
        Tue, 27 Aug 2019 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893237;
        bh=bIUiQfUrAfiyzT/EZEz2yoa3/JD/aDxkK+xgJWgp3uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CU/w/lzPKqa5QGIF4ZIQGpmaw8m/VzIj4N+Q7/sXOfKnFqdW6QTaKAflonuRcpfcl
         bDYl8a7uFCXZEn8TpgQdYuEf2qgu9APcNIb/YnhfX81Z+Aaw3yzE7pikdc6Ud3nLVG
         6qtDEcc3E+BAwc1KTEnAJApa9CUsNd9akJf5ro5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 156/162] dm zoned: fix potential NULL dereference in dmz_do_reclaim()
Date:   Tue, 27 Aug 2019 09:51:24 +0200
Message-Id: <20190827072744.239419615@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e0702d90b79d430b0ccc276ead4f88440bb51352 ]

This function is supposed to return error pointers so it matches the
dmz_get_rnd_zone_for_reclaim() function.  The current code could lead to
a NULL dereference in dmz_do_reclaim()

Fixes: b234c6d7a703 ("dm zoned: improve error handling in reclaim")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-zoned-metadata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 00e7a343eacf1..7e8d7fc99410d 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -1579,7 +1579,7 @@ static struct dm_zone *dmz_get_seq_zone_for_reclaim(struct dmz_metadata *zmd)
 	struct dm_zone *zone;
 
 	if (list_empty(&zmd->map_seq_list))
-		return NULL;
+		return ERR_PTR(-EBUSY);
 
 	list_for_each_entry(zone, &zmd->map_seq_list, link) {
 		if (!zone->bzone)
@@ -1588,7 +1588,7 @@ static struct dm_zone *dmz_get_seq_zone_for_reclaim(struct dmz_metadata *zmd)
 			return zone;
 	}
 
-	return NULL;
+	return ERR_PTR(-EBUSY);
 }
 
 /*
-- 
2.20.1



