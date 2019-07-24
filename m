Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C84C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6411B20651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ny3XLJRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfGXCWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:22:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45305 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfGXCWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:22:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so20080564pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 19:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zCkVmPbh59KCISPin/jSrbVrReqet2sJstHQ5eGtR7U=;
        b=ny3XLJRQPf+Dw89nJqn0yxwGVvyEo+yw4aHhY8LRHUveZBGnduMWeK0Ehv2ch0PjKQ
         Jb2P72uIbMz9NVBbwlhwqECG7b0REQ/mdjFEpyQJW073+Zvg1XvqPK2ePDQ5CR1I8NjS
         WW4L1d01yl/Oqdy65mhRYJCuCdb9vjMxFNtRmcowu6+iucEQz+ZYCnrrxygP1cwxx1x5
         BBDIpCzGV/FuE4VhYPltQgUB10x00dierMso/k1yvpXtD4hVt33Xs+QBHc9tQTxkYNIq
         TddX0oHMwlbsie/++xpGkHkLXxlg0uvuLxF/Z8BsLjPuGefVILH3B6SZ2pj5eu8GrotT
         fx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zCkVmPbh59KCISPin/jSrbVrReqet2sJstHQ5eGtR7U=;
        b=sVJ6fhG165reMmD+IOwz6voRnXvqQqisaGBNXc/GGl9zGD+plblGgZJyxU0gVHPYUF
         Jaw6jJgxnxsG99xnH6zBhqBJ+v37vMF0bU9kl0BZX8csHaewqSB0oN47wjq8+TMhjRLk
         wD480p/NGqIoGosryfkewLRkrx+AHl3QLfFQ6/Myuklyd2cEU+sTAwtI26SPWjz1Le66
         7M+4gf/JPxzGZRTAlyobxR05qx9Ge7e6gI3lQsJWpJvhzaOxTGGq5TyNTys/QGnv2dMo
         3BoLINHOiYFHNPvr93qck+DlUe/uSEUEeo0vQ78tHrdx2dYttMgvrJr939jpehyjQaW+
         hU/A==
X-Gm-Message-State: APjAAAVLL18yQ13krOAZCcALKCePlwkjwiNfUqfY+xcYWrYKwV0E/Nfu
        +6hfLOB60g6Lc8BUiXLpzpF/sQ5g
X-Google-Smtp-Source: APXvYqwDrVnSUej97+YGzUvpD6N7/FnuDIHjm9Djc3+tJpULk9Wo2hMToqGaWbdrLvn8dV6D0ckEtg==
X-Received: by 2002:a63:484a:: with SMTP id x10mr21098240pgk.430.1563934969055;
        Tue, 23 Jul 2019 19:22:49 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id 137sm54994150pfz.112.2019.07.23.19.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 19:22:48 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: kernfs: Fix possible null-pointer dereferences in kernfs_path_from_node_locked()
Date:   Wed, 24 Jul 2019 10:22:42 +0800
Message-Id: <20190724022242.27505-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kernfs_path_from_node_locked(), there is an if statement on line 147
to check whether buf is NULL:
    if (buf)

When buf is NULL, it is used on line 151:
    len += strlcpy(buf + len, parent_str, ...)
and line 158:
    len += strlcpy(buf + len, "/", ...)
and line 160:
    len += strlcpy(buf + len, kn->name, ...)

Thus, possible null-pointer dereferences may occur.

To fix these possible bugs, buf is checked before being used.
If it is NULL, -EINVAL is returned.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/kernfs/dir.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index a387534c9577..9b01f6ce1d79 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -137,6 +137,9 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	if (kn_from == kn_to)
 		return strlcpy(buf, "/", buflen);
 
+	if (!buf)
+		return -EINVAL;
+
 	common = kernfs_common_ancestor(kn_from, kn_to);
 	if (WARN_ON(!common))
 		return -EINVAL;
@@ -144,8 +147,7 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	depth_to = kernfs_depth(common, kn_to);
 	depth_from = kernfs_depth(common, kn_from);
 
-	if (buf)
-		buf[0] = '\0';
+	buf[0] = '\0';
 
 	for (i = 0; i < depth_from; i++)
 		len += strlcpy(buf + len, parent_str,
-- 
2.17.0

