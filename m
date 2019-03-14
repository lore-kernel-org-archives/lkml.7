Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F782087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="mc33nTd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfCNHuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:50:50 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:60036 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfCNHut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:50:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 34461C43
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jeB4Ymar3-cf for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 02:50:48 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 083A096D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:50:48 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id i1so3735509ioq.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DLANtRSSRHAl4T+X5AQuykmiffSXk6BE1bjRT1gOrDw=;
        b=mc33nTd7ZZ/PlEGWW5dq7jTiyDDeuhuqTkgvkT7UUjPuf9mlfb0OYOD2WSuMx7mMYL
         k27rZu7mjFY8Hat9LMZMSNWz9ebkb88gdOs/lvkOduofrXPwfR5vW5Ppon58sXNYaFiU
         M9mGXzggJEFRBsy+yTbckhYhrxRDeUfmJW5j67LuKN9yABTKQCOUV4GR4GGjw7xnpN1c
         jdcTYMS072mAsXq8Tuu130+wKC4RsMBaNxQHHbJCUblLR/hdjPytSi09CixubKD9MY2Z
         n33Y3Vrx0Y8pxAZj7zec+DRcVbFH9iS2ZeqBFK3z5Xy08gIhYk4oMOIyHMFWtOwlIDfv
         C/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DLANtRSSRHAl4T+X5AQuykmiffSXk6BE1bjRT1gOrDw=;
        b=DwnLt1opEkOjEs6QllX1WhV5lFzc9gYHP7SqoRLriawh4JzwsvVIjWSuyDGmiBZL6P
         UjfEwl6Z3+CvK2B9dHdWMnZ00vO8t4RUCRWAckMLBwD5TuK6QOwU6iXRnQrMO/1jxw4o
         dojItA9rCQ+4tBwHn+FSqKZzTENT1sJV4l1exS1MLY9LUwgKGGAq+YbTxWeKLEdrMqZS
         fFoYb//ZORKCiqvl6VHgGaCQF9WC6kOmkiCr7Z2jh8OZ5CNWOLj92Uq9dT0SwDKwtCWf
         P4591TB1hsdYrRE7ydCWoXPIfHAjYkfZ1b8JI8BxqAMNvSg3rdzRGMaWgIogfX4FNRLX
         UlQQ==
X-Gm-Message-State: APjAAAUrSLy8izTDc9CqebxwK75GATcCSjNkuZELqcUZbnZhokj4wBWN
        G99+8zTGXGAhmAJDkYFHTkp09Gr1vyJMI69HyLlQPpAfSGb1I68ZxufJE4TSChr+9aQAvvfnv04
        8nsTdKPStAOL8QaGVHZ5XywORSUTa
X-Received: by 2002:a24:29c8:: with SMTP id p191mr1116834itp.115.1552549847615;
        Thu, 14 Mar 2019 00:50:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwkfCVvG2ptR02yE3dTQHdvKlnANoVN72gvCgb3pCVla2WLuPN1hMoGboIrjjpRk4TFMRVtmA==
X-Received: by 2002:a24:29c8:: with SMTP id p191mr1116826itp.115.1552549847379;
        Thu, 14 Mar 2019 00:50:47 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id k4sm820334itc.32.2019.03.14.00.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 00:50:46 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: fix a NULL pointer dereference
Date:   Thu, 14 Mar 2019 02:50:40 -0500
Message-Id: <20190314075041.28966-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btrfs_lookup_block_group may fail and return NULL. The fix goes
to out when it fails to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 fs/btrfs/extent-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 994f0cc41799..b1e7985bcb9d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -7303,6 +7303,8 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
 		pin = 0;
 		cache = btrfs_lookup_block_group(fs_info, buf->start);
+		if (!cache)
+			goto out;
 
 		if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
 			pin_down_extent(fs_info, cache, buf->start,
-- 
2.17.1

