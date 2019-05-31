Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A73C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9232655D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="S04+oLu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfEaIHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:07:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35641 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaIHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:07:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so2379350wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kXajL38jtroQRK1inSfA5o1UhLh96/R1VmmZLy58S0M=;
        b=S04+oLu0VvmfqkGp7cZ9u1kAzRSHW7yu4ilUH7VbdVVWbLDCJj5wi7PDEbaQPRoRJI
         /lSaJvGA0vo2VyMKD3ecGUrEhHqajrka8Hv8V3w2ZnNBdkt0d0NQzj8/BrBSU53g+I1X
         AnMp5YEE5qMJdBb3Zq6Sd6ltqUnKShQ2hrtLzYVqJuPsH17H86bJH+U4ct+b4GtHZzMS
         shPw2PdXZ3GKThkwhVvxcOoJjJ9aEqhB0pkWZIuwrylxopLnB9aAZhKspyif0uAUYFCS
         3v4npfRXbfomqE7NJymm2zNlqvhL7eWB6Lded6WQ5YkRR6fq1uyUOW/7DuhST4NFQpAS
         eouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kXajL38jtroQRK1inSfA5o1UhLh96/R1VmmZLy58S0M=;
        b=ZiTEIL2XB+xKJ9GhgD6LTOuspGO0tw1Mn5l+KDj1QVFxynlHHA/sWDkOGzlT3BS2+p
         9UQxlO6L+L6S3Rlq7AVy6lWxy9qD9BTpAlU7iKZes8Pe+HCL6gmjwJB56wdpQxDtJXG1
         07roejAUDnioSvD3xhsCdCSMb+PGpLV6RMe4YjkAZze6s7diGlV6YPJ4OOrmzExfVnoc
         wF3jK+9kh2ZRhO8taPIc8p9xfwN5z6Qe/6o48CauIIZ/7t9DFPNxHFahoafvTqfivTtY
         stDPCJ7yjvULj/wukLRg4HI1dDXSMZz3YCcnvkv4sR61XievjDGlzsRxl2NUET5Nt4bb
         CxKg==
X-Gm-Message-State: APjAAAUizaXKBoDgbsODUHcb3zZu3JCWqsahRTdZ7y518mF08D6PWH5q
        BES08r5NpwnlyvqH4sGioKLkvg==
X-Google-Smtp-Source: APXvYqztXy2WnV+tfHqRnZCIpfF56H23uNYivX8K7jrgceeZauQrsQB9mdWVtq8E17XgsWqmbGhQhg==
X-Received: by 2002:a1c:ca01:: with SMTP id a1mr4724931wmg.30.1559290023359;
        Fri, 31 May 2019 01:07:03 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id g2sm5958147wru.37.2019.05.31.01.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 01:07:02 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shuah Khan <shuah@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] media: avoid skipping MEDIA_PAD_FL_MUST_CONNECT logic
Date:   Fri, 31 May 2019 11:06:37 +0300
Message-Id: <20190531080637.4341-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current code, __media_pipeline_start() skips check of
MEDIA_PAD_FL_MUST_CONNECT logic for entity not providing link_validate()
op.

Fix that by checking for existence of link_validate() at different code
location.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/media/mc/mc-entity.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index a998a2e0ea1d..8b4912be30d1 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -449,9 +449,6 @@ __must_check int __media_pipeline_start(struct media_entity *entity,
 		if (entity->stream_count > 1)
 			continue;
 
-		if (!entity->ops || !entity->ops->link_validate)
-			continue;
-
 		bitmap_zero(active, entity->num_pads);
 		bitmap_fill(has_no_links, entity->num_pads);
 
@@ -479,6 +476,9 @@ __must_check int __media_pipeline_start(struct media_entity *entity,
 			    !(link->flags & MEDIA_LNK_FL_ENABLED))
 				continue;
 
+			if (!entity->ops || !entity->ops->link_validate)
+				continue;
+
 			ret = entity->ops->link_validate(link);
 			if (ret < 0 && ret != -ENOIOCTLCMD) {
 				dev_dbg(entity->graph_obj.mdev->dev,
-- 
2.11.0

