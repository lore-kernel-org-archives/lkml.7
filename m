Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A132C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E9F2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osqhW6Yi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbfCAHjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:39:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33933 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732707AbfCAHjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:39:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so11050321pgd.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 23:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ifV3V9huHyD5u8TqmYIPKoWrC3WTwwBCy7SXCckE2ss=;
        b=osqhW6YiRr3Sz+qMynvqndb8/UtqfH511IuNANtjrelzFFBLgoMa9cDUcvIedYrPSv
         11XwcCTMEiul4VCZYpTQzlB3e6lnFq4j15N01JfcopdwHq4IOVfw/qw1uURc4GbzpalF
         UBSrvjkorlLRWMlN3r2asBps94EyZHtVX4a++RJHT1iSPjC4CdFaMwpRHfI57vBWLrYj
         e4WU5NRte3y8Ru1DbqQnuWxzuiOKRVNgrxbrqLYliROQrT31MeyRfU7mj/xZZUrkooGR
         BjMGnkhFKtJ/acxME1oizYa11gfaUaC7BiTb+fWdXUw7wyDltwpt1c7tj2BQSE5NSF4R
         y4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ifV3V9huHyD5u8TqmYIPKoWrC3WTwwBCy7SXCckE2ss=;
        b=qGf8MkXwLO/9RuoUcQVCw8/xkl9epTWW49pB4gs68XwdHggrQmkQM19HG5oAn+YABr
         Qpf2BHgMh4cSY03IWtdkB7GwCxBru4r7hWki+EYVcMDrCpBYCA+YxJJjS3sjh7bB3Wv7
         Ud3ZVVv8uCTAVHO4IsV+Wys4ANd6qhey9UyPTRLIwR5tEVRNUxT7DoL8FxtIDY170VP3
         3MjzKKEU67Q7WTrdbbTboPe13VpoMrYu0hMQ1EankEk/xEDRIZEmX3V9HmtN27a7vnZ5
         gR5VWw990Pc14r4jTQzVqVoyKp7NAkmR3czCQFcyiuxWyDv6OqumtKWN11mIKgBycz4W
         nvnA==
X-Gm-Message-State: APjAAAU3Xiweg0WL3GCuXVBVjjBdIUcD3G4jqmXZTdphLMS5uXXTvYOY
        9W1Gz5V3AVSnt9Z6kvYOLvHOX7TlDr4=
X-Google-Smtp-Source: AHgI3IZ5f5upbF4ffY82LgdGfdBJHfFqYs9Rm1k9djP4PaxH8SwT6ON3nwRmRw4S0U1p3BsE0qJscg==
X-Received: by 2002:a62:1e82:: with SMTP id e124mr4175052pfe.258.1551425953284;
        Thu, 28 Feb 2019 23:39:13 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id c3sm33455385pfg.53.2019.02.28.23.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 23:39:12 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     vbabka@suse.cz, mhocko@suse.com, jrdr.linux@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] mm: vmscan: show zone type in kswapd tracepoints
Date:   Fri,  1 Mar 2019 15:38:54 +0800
Message-Id: <1551425934-28068-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we want to know the zone type, we have to check whether
CONFIG_ZONE_DMA, CONFIG_ZONE_DMA32 and CONFIG_HIGHMEM are set or not,
that's not so convenient.

We'd better show the zone type directly.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/vmscan.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index a1cb913..4c8880b 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -73,7 +73,10 @@
 		__entry->order	= order;
 	),
 
-	TP_printk("nid=%d zid=%d order=%d", __entry->nid, __entry->zid, __entry->order)
+	TP_printk("nid=%d zid=%-8s order=%d",
+		__entry->nid,
+		__print_symbolic(__entry->zid, ZONE_TYPE),
+		__entry->order)
 );
 
 TRACE_EVENT(mm_vmscan_wakeup_kswapd,
@@ -96,9 +99,9 @@
 		__entry->gfp_flags	= gfp_flags;
 	),
 
-	TP_printk("nid=%d zid=%d order=%d gfp_flags=%s",
+	TP_printk("nid=%d zid=%-8s order=%d gfp_flags=%s",
 		__entry->nid,
-		__entry->zid,
+		__print_symbolic(__entry->zid, ZONE_TYPE),
 		__entry->order,
 		show_gfp_flags(__entry->gfp_flags))
 );
-- 
1.8.3.1

