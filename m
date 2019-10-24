Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF93CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E175920679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssv4tSdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502997AbfJXPQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:16:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37977 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502987AbfJXPQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:16:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3so14433546pgt.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bMFXyQ/ifc5BgLePO0qu5uaO9duXO+csQegjA52St2E=;
        b=Ssv4tSdBz1gNM3jm5CtPdWMpyQ5Nc2nE8PeqfbVFhZK9+au2mV+Kw3+KUQeN3vyW/d
         AQE3+s702YnsYLm311x5YmqoPWspLhieXwmPD9ECBDvWfZS1mO7M3sdIBKl9ZYS4jKSr
         BmHPFeoqZhLJzF0xgEiD+WQJYbZV2IDvow8/1ZrjAAM8mn1AMekbcdDhY/9PKXOSXA6i
         IvF89GzYBjAcJMHDiHVsC5cT8xVnjXNHISqTcS3/g2x6ZI4c/zKABCx4mvzOZbbBrxQE
         kUN2G/q6DQel2kR+qoEZ2c9ZlxPT2gs+gxLkpZtcPuoJPrt9h+yVSp+r460ymf8luvw6
         Pe0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bMFXyQ/ifc5BgLePO0qu5uaO9duXO+csQegjA52St2E=;
        b=hywH4Dfon+pqZLolstPkfHBKDJAKZnZoam0DBZb+KfyxuSGjZrgaVNzulX78Sq9DfT
         yOWAYK8Fx3nFhlc+M4/f5PXTJO4PjLyVbmJVBssDeC5lAhKKq9WqVtQ3znY9truZJjVx
         yOJXSAcYAUkOMnbnM+yGqGt/JMqj/6cETGTzFg9qFAOTp1NIKOu1rGIP2AGgZgdTknJz
         HSLxk+GlWd+kuVVnQ3sp2LD8GxKciPHSNU8Wp5o7t8qf796ca0005R5Wv1GBM3IKY31e
         CjjshhJrq2IfoMcChiUfyVX10bru26v5qj4H8hHoYRGpm7nFlJ+K+aGQVr/9iFBY7r9T
         Y7/g==
X-Gm-Message-State: APjAAAUk4yX8jI0cGy1Nna1hHIZJy/CzWFOo7T9ucnLhY2EHF/bSFWZJ
        to1werkcsLYndDMJZwD4y/k=
X-Google-Smtp-Source: APXvYqzzBxfRJrFVdFUjbK6204dZsCCoLPuQUSZ47XTvqkAJFRij5GfgwfIQLObYB+ZDuVA1BO783A==
X-Received: by 2002:a63:4c5:: with SMTP id 188mr3506271pge.359.1571930184529;
        Thu, 24 Oct 2019 08:16:24 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id e184sm29078262pfa.87.2019.10.24.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:16:23 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:16:21 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, dan.j.williams@intel.com, mhocko@suse.com,
        richard.weiyang@gmail.com, mgorman@techsingularity.net,
        hannes@cmpxchg.org, arunks@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, haolee.swjtu@gmail.com
Subject: [PATCH] mm: fix comment for ISOLATE_UNMAPPED macro
Message-ID: <20191024151621.GA20400@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both file-backed pages and anonymous pages can be unmapped.
ISOLATE_UNMAPPED is not just for file-backed pages.

Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
---
 include/linux/mmzone.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b1f274b6d3c3..9e47289a4511 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -308,7 +308,7 @@ struct lruvec {
 #endif
 };
 
-/* Isolate unmapped file */
+/* Isolate unmapped pages */
 #define ISOLATE_UNMAPPED	((__force isolate_mode_t)0x2)
 /* Isolate for asynchronous migration */
 #define ISOLATE_ASYNC_MIGRATE	((__force isolate_mode_t)0x4)
-- 
2.14.5

