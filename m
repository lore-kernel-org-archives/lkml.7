Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A082C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C32207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 15:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n56ltWAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfCJPpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 11:45:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40185 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfCJPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 11:45:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id h1so1826023pfo.7;
        Sun, 10 Mar 2019 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lXL4q7PcJlEZ74wStQQP5p25HvC2ZKiYp3OU6eWDYxA=;
        b=n56ltWAy1Kz5QUWh8QpxWH0WZQwbobxHP98tMwKa4yOo8tbJNUy673Recv+cqjYxS3
         jqu8XimB/vJhJ3CCJ4CPnHh+HP5F+2dZ3EefOyh4dRD/HVMoF3YQw1P1giJtpSQPWsF0
         y9RizId8AgCpv/sFs+DjElHQFVDuh3Qhyyj+nTX7dtKRibUbEMZ812eI7Yh88LsV5fV4
         MJrpftNdfzvruzhC564NKtsg43E8KYJQzvXNAO/KPm310DZUUAjmR3uUIeRUGtcth5uh
         k3imEkpKJdqOb/5oWYGNa7sU1nRsiYrUWU3yyHcDPkP1Ab6gjrR1w9U/noi7SB5L4ByZ
         XBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lXL4q7PcJlEZ74wStQQP5p25HvC2ZKiYp3OU6eWDYxA=;
        b=j0GHXsmE5bdGktOtbFffdnqlhE1Nc6xDFUt/CFOB5BHrJCJ37Zx4cTouNOSDGPGRgf
         jWm4LHd41NZTAKNYBH9maQnYGg5Y7Siaik06WbUD8ItHh8v1oKivcUEorZMIKKY18XR7
         +V4/YBVYjzWw+Lr3PmKXEO10dRHYxUe9SoPiO11T59zeguLMyZlHD3L2hek7CrDSUjCK
         tw5oGl+Slr8dzjv6c8lKpphDOd5+VnDJYItptrIuz+aee0UDaRDrhHVl46r+g23B6sSZ
         6JmKvaki7Pi7xHPRXkJXaCAGanKzCdMFME6DTmqdr99YMETpeIFJ5Sohrky1aejSbO26
         NrQg==
X-Gm-Message-State: APjAAAVJB9FpFwEs9B7fa6JqsR5U7fbjKItitQEzXow6mK7WkSQhIGU1
        vsBuS/gFEhtFHIYLBulsQjU=
X-Google-Smtp-Source: APXvYqxOTKQHlZ2SNeK3Vzb4Ir44Z0bTQJcHlpHnx3zxGMHFwtiFWGBfYu50WT+zZsZTfvWttoIqYg==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr29183798plp.118.1552232705032;
        Sun, 10 Mar 2019 08:45:05 -0700 (PDT)
Received: from localhost.localdomain ([220.116.27.194])
        by smtp.gmail.com with ESMTPSA id n6sm5277248pfa.3.2019.03.10.08.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 08:45:04 -0700 (PDT)
From:   Youngjun Park <her0gyugyu@gmail.com>
X-Google-Original-From: Youngjun Park <her0gyu@naver.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Youngjun Park <her0gyu@naver.com>
Subject: [PATCH] fs: file: fixed a long comment style issue.
Date:   Sun, 10 Mar 2019 08:44:43 -0700
Message-Id: <20190310154443.38827-1-her0gyu@naver.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a long comment style issue.

Signed-off-by: Youngjun Park <her0gyu@naver.com>
---
 fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9d103d..1d2ae917424d 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -154,7 +154,8 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	spin_unlock(&files->file_lock);
 	new_fdt = alloc_fdtable(nr);
 
-	/* make sure all __fd_install() have seen resize_in_progress
+	/* 
+	 * make sure all __fd_install() have seen resize_in_progress
 	 * or have finished their rcu_read_lock_sched() section.
 	 */
 	if (atomic_read(&files->count) > 1)
-- 
2.17.1

