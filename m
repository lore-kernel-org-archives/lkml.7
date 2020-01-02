Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B67FC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C00D20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSztRpVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgABHUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:20:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33399 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgABHUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:20:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id c13so17513404pls.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 23:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cml0t0YxNWYg8r++2sRcks91RdsbKE44NnA5x7kzm6c=;
        b=uSztRpVzjvC5aOabIn3Spd6tDWwuuS93WV+yqGSbHeB264lTwkTUCXoCoxUJYlWrYR
         gGVRqNiojlZY8tk3TNbSCZV0f4r2RWly6T0sD7YhBey1MiBKXoiZa4kkBJ2Y6iufhlhi
         E7YiCit2Vu/7/6ne7eD7kPz33RtMl6zWiTZ22E2BhtMvcTBizJp+PrPKoGi1xQ9sUnGu
         iyLLbzhDkhe0J3LBMlfs7y+F/NO945x/89TiAcKqq+tZAaplM3N+tLR1k3zaknCUJMDt
         scZo6BbZ+aRPHznBOOSYoWhl4kcdhP2oTj56FHHRmfDrjbrQSMm278ncqDEWz3h4Liaq
         wv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cml0t0YxNWYg8r++2sRcks91RdsbKE44NnA5x7kzm6c=;
        b=kGEfL4g+PmZNjfPIuazc75gTHEeGEWzQJ2ang0OlCkf7eGw/xR7qpVIb4JzC3Hq96o
         xLCUnXrbB1cqvDIWZ+B+cHIG8C8kqYXAaPbLi+3B+HxDrZtH9mNifn1XzPLlmCqnPOQs
         H1Aet0109OscB0Y4QEumM6QX/OU+TbVntDQrXy+wVJ6hElukYTvxz8MhYNH59MM+4mu/
         lOTkx0x+bFDIJwjoScHkr7qpH4UJ5XaVFNSaMD/JQwRkLwzBk3BLCLDDSHCVvAlOulY2
         zArCUcyhIcDbXxCsaPWKlH7gydqWp21LlghX7+nTQ7fXktUD/9kfmJMBpNFhI6x3iDQv
         9pfw==
X-Gm-Message-State: APjAAAUoBrXnC5vT5TwrIuu3yX77mUotb7i3F3dKhzAc6i2xUhotZmVr
        QMYLqxRWINGxEi11F8thMxQ=
X-Google-Smtp-Source: APXvYqzYKl5dMWeu8PSI5P1FF0ESSw1IDdqOUFg5t4QsETD7lPP7YvZNO5y3XrX5fsWOR+dvNBgyJA==
X-Received: by 2002:a17:90a:8c8c:: with SMTP id b12mr18163092pjo.119.1577949621334;
        Wed, 01 Jan 2020 23:20:21 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id m6sm9525644pjv.23.2020.01.01.23.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jan 2020 23:20:20 -0800 (PST)
From:   Junyong Sun <sunjy516@gmail.com>
X-Google-Original-From: Junyong Sun <sunjunyong@xiaomi.com>
To:     rostedt@goodmis.org, mingo@redhat.com, akpm@linux-foundation.org,
        joel@joelfernandes.org, changbin.du@intel.com,
        timmurray@google.com, sunjunyong@xiaomi.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm, tracing: Print symbol name for kmem_alloc_node call_site events
Date:   Thu,  2 Jan 2020 15:19:28 +0800
Message-Id: <1577949568-4518-1-git-send-email-sunjunyong@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

print the call_site ip of kmem_alloc_node using '%pS' to improve
the readability of raw slab trace points.

Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>
---
 include/trace/events/kmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index ad7e642b..f65b1f6 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -88,8 +88,8 @@ DECLARE_EVENT_CLASS(kmem_alloc_node,
 		__entry->node		= node;
 	),
 
-	TP_printk("call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
-		__entry->call_site,
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d",
+		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
 		__entry->bytes_alloc,
-- 
2.7.4

