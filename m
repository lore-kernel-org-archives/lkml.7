Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA86C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF412339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4427tlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfHUASy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:18:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46239 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfHUASw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:18:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so287784plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 17:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wYmP7l7xYXEkpyG7dJwFSke/FRHdQ6zd7wLrtCe0Nro=;
        b=k4427tlhkbAql47p/Igzqz9qG7iGY4VAjnTQCSvYQF2yNIuU9dyzJC4kHtm0M4r5eR
         sqY80jG2mnHwORi1nDP7JqJPuHA2FqonA4I3Rp8wmASaosWeQg4MUwiQfW+HIqn2T8Nh
         xORTETo+y/tIN3brE8Y+v2OMPBAiaQaX1f3NP23rJCEZRPPOvnvwCfuJnK57bBcfwqV/
         7ixqGAQnp8uQnxqAZ9d2Fawi6vDDSM45A2MJPObeCosJZLGdPRdq3pING/UyJWnltOHt
         PnAUEVlSqR4ZDKjlLk5bYhYAZ0+EUbNrV2O0aVunvGz3l6+AhIFtwuRVz0siuG1io3cP
         Gx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wYmP7l7xYXEkpyG7dJwFSke/FRHdQ6zd7wLrtCe0Nro=;
        b=hRce1P2fzEZ+AnrL98gcabGBM0CQdcGCcGiuXMm1jfuK+KEpiDDes+oVVhbq26TaWa
         vd2E25NMZWyXEUOAprvrUXO625NO7f5ekChCQVcRPs94wBX3p0NtcpD0b2r0mJBU6tvK
         xssPxsJkS4hs7OdAif2IvuhIVL05LBuy1vbSALOsEXWv9zKbf7zgAtE9WnBHimrr1K2U
         +ZdjebrsZW8PTIRtQyjA/YgxGwcq1xE4UNseyBbdc5vB9ZKM15pVkxNexBqn/YQMIBD3
         aqeRLs46Nl5UHL9EaGbFTKaxJlP3AFA9Uo+o/ol9JBCTcp6f0+Zt34O1uW6oNswDw36B
         GniQ==
X-Gm-Message-State: APjAAAXlYd1vUoY2m4Z7IGUsNuoys6iYFoaFbckYb/QoBvKhhEzPp+uZ
        AOydyiDrtooIbPZV8uAeuqA=
X-Google-Smtp-Source: APXvYqy4XOtwQD0YpAxEXf3o3I+klcEKkKhlauOgufGqS5op00QX4mOatNkI/mvUJE8aQ6wDXxuCsA==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr30180035plk.180.1566346731539;
        Tue, 20 Aug 2019 17:18:51 -0700 (PDT)
Received: from localhost.localdomain (wsip-184-188-36-2.sd.sd.cox.net. [184.188.36.2])
        by smtp.googlemail.com with ESMTPSA id g2sm18806323pfm.32.2019.08.20.17.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Aug 2019 17:18:51 -0700 (PDT)
From:   Caitlyn <caitlynannefinn@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Caitlyn <caitlynannefinn@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging/erofs: Balanced braces around a few conditional statements.
Date:   Tue, 20 Aug 2019 20:18:20 -0400
Message-Id: <1566346700-28536-3-git-send-email-caitlynannefinn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balanced braces to fix some checkpath warnings in inode.c and
unzip_vle.c

Signed-off-by: Caitlyn <caitlynannefinn@gmail.com>
---
 drivers/staging/erofs/inode.c     |  4 ++--
 drivers/staging/erofs/unzip_vle.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 4c3d8bf..8de6fcd 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -278,9 +278,9 @@ struct inode *erofs_iget(struct super_block *sb,
 		vi->nid = nid;
 
 		err = fill_inode(inode, isdir);
-		if (likely(!err))
+		if (likely(!err)) {
 			unlock_new_inode(inode);
-		else {
+		} else {
 			iget_failed(inode);
 			inode = ERR_PTR(err);
 		}
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index f0dab81..f431614 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -915,21 +915,21 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	mutex_lock(&work->lock);
 	nr_pages = work->nr_pages;
 
-	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES))
+	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES)) {
 		pages = pages_onstack;
-	else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
-		 mutex_trylock(&z_pagemap_global_lock))
+	} else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
+		 mutex_trylock(&z_pagemap_global_lock)) {
 		pages = z_pagemap_global;
-	else {
+	} else {
 repeat:
 		pages = kvmalloc_array(nr_pages, sizeof(struct page *),
 				       GFP_KERNEL);
 
 		/* fallback to global pagemap for the lowmem scenario */
 		if (unlikely(!pages)) {
-			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES)
+			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES) {
 				goto repeat;
-			else {
+			} else {
 				mutex_lock(&z_pagemap_global_lock);
 				pages = z_pagemap_global;
 			}
-- 
2.7.4

