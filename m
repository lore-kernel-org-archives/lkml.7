Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE40C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF1B20652
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="BtkK5IuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfDYNcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:32:36 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25544 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDYNcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:32:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556199127; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=a6S501wnq0WxXo5JP1mk9blEP9wWdxvfLkrAgJ4PBLcYoDgejfkStul6vH8IEyXTAYtjRyMJTYev6i3MULyHzMOoGzM6ap7e4jyOBls9FG68ShRKxyGhMETU7ucTipHhNI4OzfyJyKRsMMjWKi1VsnMEJe3JwWvw0zVous7Xdhw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1556199127; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=FyEDAx0dBD84M+NBbPh51XO5Ixmi4K5yOWlO3BekT1Y=; 
        b=Cr9MfuwQxdAUqwurmo/vWNXgs47vuYDp8xTbwj4rMqiRkMp64lgIvMOGZCrBcw6HulFpEezubEDD7R+vHVmdv80XjH66yiPgZLKdLRnLoxcXYZjWuru+vNYSubyZOdvhZgxuEC9Hn0DZ90LHHrQGAYA+wjFbObRs+QrNKyHZDPs=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=oOlHQabxwPZPe9eqdhl78i9rU5RXbSUKXrUvLgT9IpL2SQ8gT0Uv3YpRlYAeMOUrdltC8EzjZ9cs
    dym2llJBlXdT0YcaRklsbtWT7Qb95guYkMYFR9vssHr46nm7CDLl  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1556199127;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1206; bh=FyEDAx0dBD84M+NBbPh51XO5Ixmi4K5yOWlO3BekT1Y=;
        b=BtkK5IuR3pAUKiy/7blmxkaebOjFjTgHK+ADvGv4dpgPlT2f0pf4o8p3BZBnCXN3
        qxXKmY+JkJIqB4cC9VgrndqyNld/ma8aIpVsB4Vwkir2nGi/DFpEd6TKm7oD/G39bSd
        eNDAeSDfl/HCRg9d2QT8boqWDJHkoZunFB3YS5Wc=
Received: from YEHS1XR3054QMS.lenovo.com (123.120.108.196 [123.120.108.196]) by mx.zohomail.com
        with SMTPS id 155619912704786.25566430035269; Thu, 25 Apr 2019 06:32:07 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, chengnt@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v2 2/4] dm writecache: add unlikely for returned value of rb_next/prev
Date:   Thu, 25 Apr 2019 21:31:18 +0800
Message-Id: <20190425133120.13088-3-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190425133120.13088-1-yehs2007@zoho.com>
References: <20190425133120.13088-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

In functions writecache_discard() and writecache_find_entry() there is a
high probablity that the pointer of structure rb_node won't equal NULL.
Add unlikely for the pointer node NULL.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-writecache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 5b4d1c1..cfbbfbc 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -571,7 +571,7 @@ static struct wc_entry *writecache_find_entry(struct dm_writecache *wc,
 			node = rb_prev(&e->rb_node);
 		else
 			node = rb_next(&e->rb_node);
-		if (!node)
+		if (unlikely(!node))
 			return e;
 		e2 = container_of(node, struct wc_entry, rb_node);
 		if (read_original_sector(wc, e2) != block)
@@ -804,7 +804,7 @@ static void writecache_discard(struct dm_writecache *wc, sector_t start, sector_
 			writecache_free_entry(wc, e);
 		}
 
-		if (!node)
+		if (unlikely(!node))
 			break;
 
 		e = container_of(node, struct wc_entry, rb_node);
-- 
1.8.3.1


