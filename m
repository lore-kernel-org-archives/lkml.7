Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F6CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 07:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE7C21848
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 07:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="Vw/993Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfHYHZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 03:25:14 -0400
Received: from sender-pp-o92.zoho.com ([135.84.80.237]:25499 "EHLO
        sender-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfHYHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 03:25:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566717906; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Yjj9Rt7PSlWq0HPfmzbLhvQKdcqom6NrNe9llRsWF7aVQMOXiV8AjiXUqO365DJ9eM5icwuJWFKadheAf2j1bbMRrISZ5aPec/WihxbFFM1SA4mheQvWpQNvDfmn5Py6jhON/AcmRR+EbqFSGXLOnuZsQGqE2FH//NHhiDwTPH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566717906; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Ll1ddxjlpuzcBFEPUI7g0gZvBDFbmDed0ou/3799LFI=; 
        b=hV8XNvO8xGgJRInjwl3m2YHfosYI13JUkRBMtglehScoNS+VOAmXYwTDqdd5VonySa4+AaQMgUn2w7Aen9/IkxVysyGe9FlPM+ceTNhX23fbUHrLAKPF9ixlr6CJS/TFRWvweZmsQuZkn61eeZzM59Ryw1QcYCMwbkxmRdbyztQ=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=h8bNdcwCOcnyX9C96B/SV8Gcd5TJBr05qUyw+Ya95aHltSrT1fEdPfZBFfOUDhsk0JNlQNoucCBy
    uQVk6ioHUUH5IrAkKeo+LAKHbthlCpewJJEAvjU3X6Pec2VdIkB1  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566717906;
        s=zm2019; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1017; bh=Ll1ddxjlpuzcBFEPUI7g0gZvBDFbmDed0ou/3799LFI=;
        b=Vw/993Q/FtiTHaRCQNPB36qpst0AacARkWXRYwkz9T3O0WqHYSAzmlfJqcIZWhz4
        SwNI6wUdgoDjY4VwlCg0A2BmT166xBAlA32FGQnasKVw/LH9xNoyLcuG7KDEhkGzYtL
        UTrv4SIHrXYIWpaCtVHbsFjjcVJkbQKFlQIsnVVU=
Received: from YEHS1XR3054QMS.lenovo.com (123.120.58.107 [123.120.58.107]) by mx.zohomail.com
        with SMTPS id 1566717905963339.9025705087869; Sun, 25 Aug 2019 00:25:05 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, tyu1@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH 2/3] dm writecache: add unlikely for getting two block with same LBA
Date:   Sun, 25 Aug 2019 15:24:32 +0800
Message-Id: <20190825072433.2628-3-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190825072433.2628-1-yehs2007@zoho.com>
References: <20190825072433.2628-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

In function writecache_writeback, entries g and f has same original
sector only happens at entry f has been committed, but entry g has
NOT yet.

The probability of this happening is very low in the following
256 blocks at most of entry e.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/md/dm-writecache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 5c7009d..3643084 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1628,8 +1628,8 @@ static void writecache_writeback(struct work_struct *work)
 			if (unlikely(!next_node))
 				break;
 			g = container_of(next_node, struct wc_entry, rb_node);
-			if (read_original_sector(wc, g) ==
-			    read_original_sector(wc, f)) {
+			if (unlikely(read_original_sector(wc, g) ==
+			    read_original_sector(wc, f))) {
 				f = g;
 				continue;
 			}
-- 
1.8.3.1


