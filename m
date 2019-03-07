Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FBC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B234120675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gJHAGcpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfCGJri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:47:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41399 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGJrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:47:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id k11so9854720pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 01:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jPfiCleF3bjVjjATgBhjBOFQh99VX5DtV+OrPYgQRig=;
        b=gJHAGcpJzj2U23/8RXnceWsRsVWyqQyioKEgnlRcMl9wM7CTAerp62E32UiFEWqjV2
         e+zeesQep/z9f2/uFPCq7VBS7XEFWBpWElmOYQp5maiPpVFIYpp4lCMFJg43ro0Wq+89
         1kWBdFkm0rVa0JWBssFagrG6oisvYAcIcAfS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jPfiCleF3bjVjjATgBhjBOFQh99VX5DtV+OrPYgQRig=;
        b=fzQ29N8aj0we5CKdFdSIDP6Bwe6jMRRH0HDm2VIY094I3CgFjLeiw5n8dY9vhH6GzM
         rCfcC+kHudlXpAPbmla2c7ShJIP6GR1yFEA0cf8wOf2gNF3nRHOLW3XabUQ5Cs/1mHSx
         5oq6Sj6TEzjMHe/1tHuiogrsvZycl6bovsz3e7ZVbeC9w3K2AXf8PYSkiO3GfajkSErb
         elO5ng5wVuum8s0etpALnV/35Mis+//F/WCOXWAczcRjF9hNQ68dXk5yFHZBliniH51H
         R8XVgsPrxY5iKWq4peiKCA5jXV8v10QfyJb4EUAgBW7G9u3vOShaRTJgsQ7NXSfaL3pV
         RrTw==
X-Gm-Message-State: APjAAAU1FcJij9TLD3eOHT5T1LEN87mx9pbJfGtsuUaeiMvICCQiRG3M
        6mUTwHAyiVpHKA+GJJYle9P1HWWgaGE=
X-Google-Smtp-Source: APXvYqwQqtznP/sKqSi0qVmXrhAmAoezyxx2EKugmDcYaQAvobU+lIRZpgaJeZc3jAaZ34p3Fp5hxg==
X-Received: by 2002:a63:5a49:: with SMTP id k9mr3355143pgm.14.1551952056240;
        Thu, 07 Mar 2019 01:47:36 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id n23sm4902288pgv.86.2019.03.07.01.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 01:47:35 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, Tejun Heo <tj@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mm/swap: Avoid undefined behavior in __swapoffset
Date:   Thu,  7 Mar 2019 17:46:50 +0800
Message-Id: <20190307094653.119425-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use offsetof to calculate offset of a field to avoid UBSAN warning like:

===================================================================
UBSAN: Undefined behaviour in mm/swapfile.c:3010:38
member access within null pointer of type 'union swap_header'
CPU: 6 PID: 1833 Comm: swapon Tainted: G S                4.19.23 #43
Call trace:
 dump_backtrace+0x0/0x194
 show_stack+0x20/0x2c
 __dump_stack+0x20/0x28
 dump_stack+0x70/0x94
 ubsan_epilogue+0x14/0x44
 ubsan_type_mismatch_common+0xf4/0xfc
 __ubsan_handle_type_mismatch_v1+0x34/0x54
 __se_sys_swapon+0x654/0x1084
 __arm64_sys_swapon+0x1c/0x24
 el0_svc_common+0xa8/0x150
 el0_svc_compat_handler+0x2c/0x38
 el0_svc_compat+0x8/0x18
==================================================================

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 include/linux/swap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index fc50e21b3b88..4bfb5c4ac108 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -157,9 +157,9 @@ struct swap_extent {
 /*
  * Max bad pages in the new format..
  */
-#define __swapoffset(x) ((unsigned long)&((union swap_header *)0)->x)
 #define MAX_SWAP_BADPAGES \
-	((__swapoffset(magic.magic) - __swapoffset(info.badpages)) / sizeof(int))
+	((offsetof(union swap_header, magic.magic) - \
+	  offsetof(union swap_header, info.badpages)) / sizeof(int))
 
 enum {
 	SWP_USED	= (1 << 0),	/* is slot in swap_info[] used? */
-- 
2.21.0.352.gf09ad66450-goog

