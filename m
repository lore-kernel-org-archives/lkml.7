Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69A0C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCE0206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO9uy19t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfLQNMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:12:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33693 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQNMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:12:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id z16so678901pfk.0;
        Tue, 17 Dec 2019 05:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u2gQDT9BoTQYVHqNCMfqXHowcwkXNSs7eSdPihh5x8o=;
        b=nO9uy19tNhfxpeeBf/iDyu4FWIypmIRyX0nL/adv0kaGPEML1CYXZXAe8S9ZM2wR2G
         8L6RcsIatBQL70rieRCJdUOqTtXoNhji++FOIyb3dj/GoB5bmQt32nDsXD2KtDP/7Yec
         SQboHy3m+Yx3zW/Agk4/FXvGmS8NjqTeUVDp6eya2szKDT6QEV7mQoX3la/crsa/wphL
         uKOZRPiaPmjux3ajd03e9eU0q+mfQDRqucRwIODUwz5KVbFm/nYgnpmglUtnfVPsSpKY
         uj3GH2UOKrFY30hGoaBK8MgJi4Pb5jTYO5BFHQCTTPJ7ZgJ9P+apfipdNMflaonm57US
         2RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u2gQDT9BoTQYVHqNCMfqXHowcwkXNSs7eSdPihh5x8o=;
        b=MDGzYIVId3EDEAKiq0WZt+1h9VcN1FNPTD1lGpjcNmQIuXbH4OdavmesJud8ucKjXE
         U8zcNax8H90z1+YqMmIRr6zVzTcQfwUsKCqAKH25M3glC5mGhoJzeWsUBVLSmRt4WPT0
         8WI/BiqzS6GfTuSOvwhW4G7TjU6OuiIMlaXYJ2i5KxMhDYz8kfN62H/lV1LIAdI91OHj
         FfXUTCBnJlRbi/e0g7xHc3ty0tG7BwdKP5fq+HSjg609Qu84lTFbCjZm35/YODXgRraW
         oZ5lAEUpuWYxHIcS4kmHTxq8haK9fNHb3TSSRejt2KdVDnJ3o+Ru0YlIbeMyeDQa6WXz
         bQtA==
X-Gm-Message-State: APjAAAWC3KEgHvQhYM3OYYy1FQEIB0FUqR2NeX6bKS7GivfZ3UrXPMsM
        Jf2H9ubXomPG26bO4qpt6+bmZnfXQjY=
X-Google-Smtp-Source: APXvYqzio5b7ZVeoF3ExORkr9Hku+099pWaUmc1E6m+Q6GSUqSLcjZQxaaFX0f9Yazz6ZWr3wGOUDQ==
X-Received: by 2002:a63:e84d:: with SMTP id a13mr25871781pgk.274.1576588352680;
        Tue, 17 Dec 2019 05:12:32 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.172])
        by smtp.gmail.com with ESMTPSA id r6sm26720976pfh.91.2019.12.17.05.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 05:12:32 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] security: apparmor: Fix a possible sleep-in-atomic-context bug in find_attach()
Date:   Tue, 17 Dec 2019 21:12:20 +0800
Message-Id: <20191217131220.11613-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel may sleep while holding a RCU lock.
The function call path (from bottom to top) in Linux 4.19 is:

security/apparmor/domain.c, 331: 
	vfs_getxattr_alloc(GFP_KERNEL) in aa_xattrs_match
security/apparmor/domain.c, 425: 
	aa_xattrs_match in __attach_match
security/apparmor/domain.c, 485: 
	__attach_match in find_attach
security/apparmor/domain.c, 484:
    rcu_read_lock in find_attach

vfs_getxattr_alloc(GFP_KERNEL) can sleep at runtime.

To fix this possible bug, GFP_KERNEL is replaced with GFP_ATOMIC for
vfs_getxattr_alloc().

This bug is found by a static analysis tool STCheck written by myself. 

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 security/apparmor/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 9be7ccb8379e..60b54ce57d1f 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -325,7 +325,7 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
 
 	for (i = 0; i < profile->xattr_count; i++) {
 		size = vfs_getxattr_alloc(d, profile->xattrs[i], &value,
-					  value_size, GFP_KERNEL);
+					  value_size, GFP_ATOMIC);
 		if (size >= 0) {
 			u32 perm;
 
-- 
2.17.1

