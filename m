Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EDAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E91206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rkOpuqbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfDPMRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:17:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37317 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPMRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:17:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so25118499wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7ZNllMz7MPbKT3zJFRifUglXG41JoglLyQCD815xybo=;
        b=rkOpuqblNViqHK9WKaXeM7eyZbbTG+/47wiv9sZ+6lwWnGUugYwLvwLiJe3g/jerdm
         qQoz8AZANgdc/ziRNTqDCXutZqOIZ4nF6qMoOoqqtInr8TQq3r4NxhgAenF+wWr38BVX
         6mxJWZxCqKN+KeJDMvLGl6o98DptFDfolIBdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7ZNllMz7MPbKT3zJFRifUglXG41JoglLyQCD815xybo=;
        b=iPdm2oVqWnsED8muaAvyBNmz0H3qlB1sION++cK+FhVFqkBzjVa7EsaXOrzEPzhQlp
         6NLNPnREtFOLVEEKyorD+Y5FPezjJkn1I1EQalBZrH/d9dDHSwEaZDNF3/KXe3kkAF7u
         ca4uisQRo+g9MKTQ8ivbHqnNE/Ouw6q1sBaUwsVgSI7k1bXs39+xZzWOWI0nvUzf+Le8
         GMfHEVPUF8EimGP+593XAAAa8rY6m2d4J9OiKeCiw1VyG9iMBHkvnolMLcIU2+IzbQIA
         tI0nhe3dW9pJWi13oPgBNNTpBBGHlAKNLjErZ7lXD5EUlhts0z7bcnJkkiDdO0tZ3SwX
         VlaQ==
X-Gm-Message-State: APjAAAWda+tLzXzjbypUgiX0okPreafMFMULyg5DKy0EcXjUkIfau2ds
        /2+DEDx6oS96gt79v1FA42DEpg==
X-Google-Smtp-Source: APXvYqxwsq0whPkufsZPEYwrbvhSOxQeMvIPpGcziiV0y5GqqNc0zDoEbnNYhMRcoJ5JbS6b1l9fDg==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr28315308wmi.57.1555417039668;
        Tue, 16 Apr 2019 05:17:19 -0700 (PDT)
Received: from localhost.localdomain (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id 13sm23032823wmf.23.2019.04.16.05.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Apr 2019 05:17:18 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernfs: fix barrier usage in __kernfs_new_node()
Date:   Tue, 16 Apr 2019 14:17:11 +0200
Message-Id: <1555417031-27356-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_mb__before_atomic() can not be applied to atomic_set().  Remove the
barrier and rely on RELEASE synchronization.

Fixes: ba16b2846a8c6 ("kernfs: add an API to get kernfs node from inode number")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 fs/kernfs/dir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index b84d635567d38..1e7a74b8e0647 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -650,11 +650,10 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	kn->id.generation = gen;
 
 	/*
-	 * set ino first. This barrier is paired with atomic_inc_not_zero in
+	 * set ino first. This RELEASE is paired with atomic_inc_not_zero in
 	 * kernfs_find_and_get_node_by_ino
 	 */
-	smp_mb__before_atomic();
-	atomic_set(&kn->count, 1);
+	atomic_set_release(&kn->count, 1);
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
 	RB_CLEAR_NODE(&kn->rb);
 
-- 
2.7.4

