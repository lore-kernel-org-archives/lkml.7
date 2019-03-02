Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AFFC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D802D20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTCUa43Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfCBEjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:39:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34147 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfCBEjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:39:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id i130so12422514pgd.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 20:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E8xVMa3UyuhomxW571zy6yHj+BYk0T3qqrgE0C01lI8=;
        b=QTCUa43Qqn46xL2GJEFIy3N7UKDlwEPNFPIMLCF62SXxWkUAvnVEtC/sHcpVsqXRJF
         gTaiwkPOaM800+E4W+uo9eGPjv/lRcx9KLrnL2T/QxyXTojp5WmCbl3Ww+jFL55/kqs3
         2Xi8cYJuB1oQgCzTgD5YDG1oE1ecIKs8VIFvERZ9GjGQFfKUMNPVJBwtX+ek8PjA2sPC
         hsI6GWwQLGpkg/MD+Yy0QZ/Xjg50F84/Rnl08tagz0ExUwUT33hC43nTEoUcOh/5JLPf
         e1Qgfa5VmDcV8S6B85KZkzBCzaKoXxs54o3GQDdLSSRW+nY9lWtWA1TlzwaFut/TCNwG
         tvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E8xVMa3UyuhomxW571zy6yHj+BYk0T3qqrgE0C01lI8=;
        b=HSCGcZS12ONSofjWT5Ix2bwAEl8pYsRS69NXvj5bM0jTqs0qm1y2vYP25Nk59WAR6I
         fBzYjSCu/avj5kc2oZADl7Luzrr8N8wNVGrJ8vVK6bFJPm8vGL1jgYTiKcAhSQsVRYde
         Xabl9hYWORDpkhb9oVp5SvuqIJXeyAYPY0NJpqaCA4IFpscIGQWIpXGKeueIR2yuyd8F
         ymGZbVCfnZB+k/XiI4X3/yOD15e6RXk4f+rmDyVAAByIReQ7GOS3L/6j6cej2TQC+Oev
         PjoR3dDB3NR2h349ckXa5aCP5x7N7I13+QRs3LtjuPv/+kB2qJVwFkIkM70ad1UxlZOH
         j3rw==
X-Gm-Message-State: APjAAAWmCKrSEz+vGzWPdhLzNqLhF35j/hJmtfT7IQk6Y9FIFu6s4eNp
        nq+3sLysgGS/wDVP8igx9lY=
X-Google-Smtp-Source: APXvYqyfVorxlZUwAAT9aEX4cV0VaLDj91iyCjHgIS5j2y9UZvsAX25pp8fFaFh2TeAiWHrhAHE4Sg==
X-Received: by 2002:a63:2b82:: with SMTP id r124mr8310326pgr.214.1551501556456;
        Fri, 01 Mar 2019 20:39:16 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id a24sm29102508pfo.160.2019.03.01.20.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 20:39:15 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     vbabka@suse.cz, mhocko@suse.com, jrdr.linux@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] mm: compaction: show gfp flag names in try_to_compact_pages tracepoint
Date:   Sat,  2 Mar 2019 12:38:57 +0800
Message-Id: <1551501538-4092-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show the gfp flag names instead of the gfp_mask could make the trace
more convenient.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/compaction.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index 6074eff..e66afb818 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -189,9 +189,9 @@
 		__entry->prio = prio;
 	),
 
-	TP_printk("order=%d gfp_mask=0x%x priority=%d",
+	TP_printk("order=%d gfp_mask=%s priority=%d",
 		__entry->order,
-		__entry->gfp_mask,
+		show_gfp_flags(__entry->gfp_mask),
 		__entry->prio)
 );
 
-- 
1.8.3.1

