Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF863CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F506218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="G6GQH0AR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389334AbfJVUPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:15:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40939 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387999AbfJVUPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:15:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id y81so13672752qkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6k43Ins8ShDUccC1LdBvMXrfhZMN86K2kUQuaiv7Mo=;
        b=G6GQH0AR0jPSft2ppe6Krr/rZ5GlNjjcDjh8uq21Mch7IOkfMJPJ6y8CGYHqjeZnRv
         Z82dyGlkUmpnrQUBDNlEbomTWJFZjTonGAtP+KWs1/C1lYr5lpWixX5fS4x8g1/pnjaI
         l+2sZb8+h8PVY95WqVGA2Z3wHkTZ5GJmzwN6p8slt1PJfa3X9acHSQ9TwJh6O9hoz8yK
         QoDS9inHtGfOdYETaFcmImy68omaIjrSwXUv00ynL3dDOGxlMHQeZN4xH1DKUj15Seb/
         4B+CZLYcbnEkE5LYhr+FWPasz/NfM9n5wmSZzFIvbKNULO+4fsvtj9SnmUeuv1klLi0C
         eunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6k43Ins8ShDUccC1LdBvMXrfhZMN86K2kUQuaiv7Mo=;
        b=twTpT4UsV1aYkOmCeHV4maE71UUOpzqa00JEcdh65vhif35vMT8asOfyzT6PuhHtFB
         JZiGePrVrTd1tmD4X7KcFCMsOalg/XYaKipbLHF42v12o8gxOipM0HOU6hSQMLUyoz88
         guRGGZfUfc6pMYq87/3DmB7/Lx61hNFg4uQS5ORii6wERlfIQVvOOIU+o7tu6oAQtDZv
         7gHtB1SYu9Z/DWpS6oa0XuUmsFCoR6XQQOtCsP2kbd5+HHJDDLHaVa74jkx2QXi6Ji2+
         zj2gulMdgysqOSJaQ3mNt1G0fBqRPbDUnzoo6CVi1+5TI4pFmBf9E+Jtiuo7bg6zMtPH
         sgcg==
X-Gm-Message-State: APjAAAWFxBaTvnSS6ZCMFN0YYa8qzk8limpHyNmaCN41N0yKw0/yKVgM
        FgoM8qmOUxn+5oi2IcZ8/7kTjQ==
X-Google-Smtp-Source: APXvYqwf83Q3oMgxGQXXVkIgEXOw8vw6FhbO2OSQt0mKSX9kQGxr6dmirL8tHiP1nzutNQLLmqtnhw==
X-Received: by 2002:a37:f70f:: with SMTP id q15mr4521717qkj.428.1571775319334;
        Tue, 22 Oct 2019 13:15:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:869e])
        by smtp.gmail.com with ESMTPSA id d205sm11273855qke.96.2019.10.22.13.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:15:18 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/2] mm: memcontrol: remove dead code from memory_max_write()
Date:   Tue, 22 Oct 2019 16:15:17 -0400
Message-Id: <20191022201518.341216-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the reclaim loop in memory_max_write() is ^C'd or similar, we set
err to -EINTR. But we don't return err. Once the limit is set, we
always return success (nbytes). Delete the dead code.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 055975b0b3a3..ff90d4e7df37 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6122,10 +6122,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 		if (nr_pages <= max)
 			break;
 
-		if (signal_pending(current)) {
-			err = -EINTR;
+		if (signal_pending(current))
 			break;
-		}
 
 		if (!drained) {
 			drain_all_stock(memcg);
-- 
2.23.0

