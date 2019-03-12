Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48FAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706382147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q7S9ieTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfCLITU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:19:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43068 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:19:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id l11so1222962pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=754GpwZyrAesX+qcC0sVeTqfB37HoJTOe+dmtDS1DH8=;
        b=Q7S9ieTfoklNlKizyON7nYle2kJoGMLc3cye3Opl17h66pt3TBo3hD6DrpGmb0x6Ml
         yuAsIuPsJ571B+0xk1wfu34u9zRfo4jppeQES+Tow0N6tXhiWwZehR+2lBHgxRjX80JH
         yWNLBJ5HbxvQRnjEgth7DAuQVNVUEI05vnwuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=754GpwZyrAesX+qcC0sVeTqfB37HoJTOe+dmtDS1DH8=;
        b=AvmboKnLw5HvLy1ATAVal1DEzYT+yL5HTUhSA9TswYjNY4+UrlyZa8ntMSDv/2b7II
         xQBsmNKWJpECwZmNz7hRNItlHAnItnQPkNn4E9f/xNAH+ZwChLgc1s8uOt4iaGAUrZTX
         bwAGKG+t1ymf3+PS84iQ+6LbJSHzDamMkyo1tPWSGb9La0SlwxCZMySdF+bGwEiOn6/A
         d/mdbo4BexvhXinls4xqPrqGdW160PBgAmhHEa4B/ZQkzlU1yaQVlMVsFicbFlI/h4xW
         oJoDYC3FX3Ugg+1wGRRw7fKDLjsWVV5LPYVJp8hd70Rzbb5/n5tetmN7wFDBPl6gh05I
         HV0g==
X-Gm-Message-State: APjAAAVRbIwKqJZ+eeM8kUVX+R1hrxhLWM3nollJQffmUL+n5ILbkCRB
        fn6C7++B5dA3IRhIHkzhbcfWYQ==
X-Google-Smtp-Source: APXvYqzQbgyckd8Dt8t2MBLG5YTQjtWANalnA5Pci7YtSAlwaQYK74twjTiMu1ivdLYkLuc8oVyCJQ==
X-Received: by 2002:a63:e416:: with SMTP id a22mr20187231pgi.338.1552378758415;
        Tue, 12 Mar 2019 01:19:18 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id u11sm10842564pfh.23.2019.03.12.01.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 01:19:17 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Aaron Lu <aaron.lu@intel.com>, Tejun Heo <tj@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] mm/swap: Use offsetof instead of custom __swapoffset macro.
Date:   Tue, 12 Mar 2019 16:18:59 +0800
Message-Id: <20190312081902.223764-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
In-Reply-To: <20190307094653.119425-1-pihsun@chromium.org>
References: <20190307094653.119425-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use offsetof to calculate offset of a field to take advantage of
compiler built-in version when possible, and avoid UBSAN warning when
compiling with Clang:

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
2.21.0.360.g471c308f928-goog

