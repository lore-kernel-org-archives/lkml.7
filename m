Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44828C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F151218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="mUmeIE5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732760AbfB1Qaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:30:46 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42922 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbfB1Qam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:30:42 -0500
Received: by mail-yw1-f67.google.com with SMTP id v201so11530439ywa.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSVRB4KCxOzLiCcKtVzLdp3bqBiDRMqjw6+T+tZutHo=;
        b=mUmeIE5tnpsUGSnPqHmhaPEa7lf70tbLRHRnTncX97PvuH/o83yraWIA5zNr2rhiIp
         mpkAWKlqywdH7kW6UpgZyAHXZCyBpYNS+SG54JVKSe2fLL5wNcgjH9Q97zxt1D5RpII1
         WeWjuyR4YDKC3jKLczUULysqQOcc+yP8bzEynWwg3HCg5WHMxRZlTti0KtykiQuvv3kq
         YROup6kl8Iuyzca2iPVlj3322bMupx6H73LQkPOdGiwtgd6ZjWn0XHKo9doJy1JuxVuG
         Mo2SA/F1rgT6zxF9PDEGAuC8LLHWA/fy6BG5ikjx7h55H5U7V9xL4eH3UKlRj6MnSuI2
         /XsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSVRB4KCxOzLiCcKtVzLdp3bqBiDRMqjw6+T+tZutHo=;
        b=APhNNaKYFlyVovE6NpPmXj7UK2iBLPr8VaEeekvg6lSFwawbgBygbmzkuC1/l9lE3D
         Ez1W+upA9rgRxCG5UDzeR+QkKYMq/u5NhUKuo5VRHA1wTzmhBqd6Bd4lsTINizd/F22M
         0AFsy5yXqMBfXINQpfSbfrdSt08Khy6lqqK+cafpjlsPjIOvMfYZxSas0rYQFXetHk1+
         uoCx4vYpPn3OHi82LTCEOs6W3/uXco35Rj/BMg+wsxN1FutqsPDxqXJgt1YmyQ4EPwZp
         WQaHjfhbOolA0MGgMrS9iiQQQx2/qSEi9Y4s0+kBGCHvuytQCnVXEpsZUzjOAQyz72NP
         RA8g==
X-Gm-Message-State: APjAAAUcMjXCQbxtvJnaSD54Bo8a24kpfn/S6XycuYpeXXfD9UDY/eL7
        TV9ry2bUrWOSbBuCXjbwWhd46OsgncA=
X-Google-Smtp-Source: APXvYqxewDo9FoX7nVCKQojbWSDBBLdU+jLrQJ05GmxyJbsxGjn1zJNbtkW8/KWmBzXl7+uvezlSOw==
X-Received: by 2002:a25:c0cc:: with SMTP id c195mr229095ybf.166.1551371441698;
        Thu, 28 Feb 2019 08:30:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::3:da64])
        by smtp.gmail.com with ESMTPSA id l202sm4189121ywb.72.2019.02.28.08.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 08:30:40 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/6] mm: memcontrol: track LRU counts in the vmstats array
Date:   Thu, 28 Feb 2019 11:30:15 -0500
Message-Id: <20190228163020.24100-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228163020.24100-1-hannes@cmpxchg.org>
References: <20190228163020.24100-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg code currently maintains private per-zone breakdowns of the
LRU counters. This is necessary for reclaim decisions which are still
zone-based, but there are a variety of users of these counters that
only want the aggregate per-lruvec or per-memcg LRU counts, and they
need to painfully sum up the zone counters on each request for that.

These would be better served using the memcg vmstats arrays, which
track VM statistics at the desired scope already. They just don't have
the LRU counts right now.

So to kick off the conversion, begin tracking LRU counts in those.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mm_inline.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 04ec454d44ce..6f2fef7b0784 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -29,7 +29,7 @@ static __always_inline void __update_lru_size(struct lruvec *lruvec,
 {
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	__mod_node_page_state(pgdat, NR_LRU_BASE + lru, nr_pages);
+	__mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
 	__mod_zone_page_state(&pgdat->node_zones[zid],
 				NR_ZONE_LRU_BASE + lru, nr_pages);
 }
-- 
2.20.1

