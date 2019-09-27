Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D9BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340D621A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRa/o2tW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfI0Okx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:40:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33906 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0Okw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:40:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id k7so1192799pll.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dXLOmW7A8AY9kqUqtLB4ooSuMpsdFCH9umFAov76i/c=;
        b=jRa/o2tWjE474D4Nj+H/7+y1g+tSUqyh0YZIeu8kwcMKlHZMF/0m0mEhJbePT3M3WC
         Sh2Fp81x6wFggzorhny/pz1zeY+1oaOVm7WWHewzEZ8UUAawfdEISDKvRrJh50DxQR9u
         ZcIQcKj6MJnjjpaDu61431p5TZiwbMCjpY3kJ4yBmhVYFyA6pXNTqSSEiWtYWPIwGk6h
         EjLbP8/WKg7thqhMCunYVw6j4Xzhq1H6LUrQK8UW99mfV54Ez0uWoZgQm6/MKRkVdd4F
         klmwJdAnivCzLljBHMDnLj8Pl4yLxkIlSByenVPHJZAvkxMT8KojNNEjQ4ZSWKDIYetW
         s20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dXLOmW7A8AY9kqUqtLB4ooSuMpsdFCH9umFAov76i/c=;
        b=AQ3FV8SSnjBI9sznSMZUs25AAvpGrMflO0ZJvqeiOz0wMHrlNt3DSByxG7v1Az6Lx7
         E0pYIpKf4DqFyBhgicyD03ENa7fmyoehTZuhc2Q/xWsKEuLq/VSqmO6c7RIbHTRCrYwf
         cPjkQaiQrKulpbuM8wztscutJXCdbmP4Z/dixkOdtofrvu5HnmZXE34ed4455G8b3qjr
         MXlJiRzEefupLEyXMajGCuDoqJcivilFeq5xwV/rnDs3Vk5Qcvjp0HkDdb7F4oCIrgR7
         q5mRLJOo+6N30NlNyKzd8/OQusUUEG3fgrag+3SDXM101JFvH3dZrkT9ajU39cgxAj5A
         SO/Q==
X-Gm-Message-State: APjAAAUlJnwKBG0jK0arjmiCffYtpH7xlOq15vZt/D0IBPEUZBwAjAd7
        qRoKjI93dvCO/RZS/wzzJKY=
X-Google-Smtp-Source: APXvYqzMiWcLHdX8hR30PG/UBAVG6J5w4t0AjZITDam7d3ZJAC8RTjaFZOsVA/yhulW9hm7Wx8BR/Q==
X-Received: by 2002:a17:902:d88f:: with SMTP id b15mr4791360plz.251.1569595251797;
        Fri, 27 Sep 2019 07:40:51 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id e127sm3716819pfe.37.2019.09.27.07.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 07:40:51 -0700 (PDT)
Date:   Fri, 27 Sep 2019 14:40:49 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, dan.j.williams@intel.com, mhocko@suse.com,
        mgorman@techsingularity.net, richard.weiyang@gmail.com,
        hannes@cmpxchg.org, arunks@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, haolee.swjtu@gmail.com
Subject: [PATCH] mm: fix struct member name in function comments
Message-ID: <20190927144049.GA29622@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member in struct zonelist is _zonerefs instead of zones.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 include/linux/mmzone.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3f38c30d2f13..6d44a49b3f29 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1064,7 +1064,7 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 /**
  * for_each_zone_zonelist_nodemask - helper macro to iterate over valid zones in a zonelist at or below a given zone index and within a nodemask
  * @zone - The current zone in the iterator
- * @z - The current pointer within zonelist->zones being iterated
+ * @z - The current pointer within zonelist->_zonerefs being iterated
  * @zlist - The zonelist being iterated
  * @highidx - The zone index of the highest zone to return
  * @nodemask - Nodemask allowed by the allocator
-- 
2.14.5

