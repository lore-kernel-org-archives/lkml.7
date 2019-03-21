Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E0CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC650218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWhjDMNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfCUH6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:58:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35751 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfCUH6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:58:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so3694327pgf.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jie9sXrP5TbUt+dDutJxDwvf3sW4lsgNQ0u1ti/esj0=;
        b=oWhjDMNo4F0mSG81rzacO8SUY9SarkFynMmVcxWzc87/3Php8UzGm1Hwl6SHBADbjw
         TbsZmGOihlXoxwj6U6sSOmrTsYb4YpbQZViNWzxm+JGZVnVlI87cyGP0g8vJyzwLJB3V
         6BbxmQXaGUMo9gJbumZQcmMvxyzM7tpxrUSjIrB8SnPP/pIvOhR43WsgcfPB5CR0nwAt
         gTzBFXzKC/qbTHtwaZoH8i/xUkMbJMwGrT0/J1svs9VCQmAqnKBqKjkbQkSRm781HKV1
         7b3seHFqmt0pAYNugsM1gCxudHlfiPHhE7VhIIQ4QX0OZ/3INcSDSH19//PDIvNVTWLC
         XC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jie9sXrP5TbUt+dDutJxDwvf3sW4lsgNQ0u1ti/esj0=;
        b=BpHp44IbMW854Ho0Nv83BKvKaPQSmWMeC25C8G1V5QQ0RF6oSIYRDlW0UlhNGNcB10
         tooQ9f7btgESQBcLT9nSo6egm80VMVod/xw3y4/Xy0BOOK4oeiNv8GZFCPvlNrg9QJRl
         CRhOmR6yWH+SkWmbqJ31Bki7luVFaT2b/F+fcwhEhHUJ9FQRD28IepyjHdM933gqUP7y
         E1WFSvHP56OdbXcI6oHFnrhMT5CD+UlNNFx0SEPd/Rpgg87IadycjTnArdGDn/6FJzxr
         UJqcnTyDH2eqfu0MZgQTK44MPIefiSeiFhjiHHa40I/tacdDZxqkzmm5SGEbGW4vJVLM
         D10A==
X-Gm-Message-State: APjAAAWbPxMZMZylGLK9XhY4+uBKH6fx3/U86gVw+8N+c1wAD43cII51
        5Fcz9D2vJ6aFexk1vkMflso=
X-Google-Smtp-Source: APXvYqy2jOUpDdUyGMRSfoI+dCnzB8Ediw/7BYiX01CnF/sjpHnNfRVZ7nMWcWcJ18o8KV93o5lP0g==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr2192539plo.85.1553155086356;
        Thu, 21 Mar 2019 00:58:06 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:58:05 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 11/18] locking/lockdep: Update comment
Date:   Thu, 21 Mar 2019 15:57:18 +0800
Message-Id: <20190321075725.14054-12-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An out-of-nowhere comment is removed. While at it, add more explanatory
comments. Such a trivial patch!

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c7aec9f..eccfb0b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2720,10 +2720,16 @@ static int validate_chain(struct task_struct *curr,
 		 * - is softirq-safe, if this lock is hardirq-unsafe
 		 *
 		 * And check whether the new lock's dependency graph
-		 * could lead back to the previous lock.
+		 * could lead back to the previous lock:
 		 *
-		 * any of these scenarios could lead to a deadlock. If
-		 * All validations
+		 * - within the current held-lock stack
+		 * - across our accumulated lock dependency records
+		 *
+		 * any of these scenarios could lead to a deadlock.
+		 */
+		/*
+		 * The simple case: does the current hold the same lock
+		 * already?
 		 */
 		int ret = check_deadlock(curr, hlock, hlock->read);
 
-- 
1.8.3.1

