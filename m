Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57D0C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 01:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697F6207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 01:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOuZGoHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLOB7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 20:59:07 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34200 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfLOB7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 20:59:07 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so3295337iof.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 17:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h0fD7W5daiv6qwL/B0pVkhAvgnXRveIJ7BunMFgKkMk=;
        b=JOuZGoHQ+oXbOnTCu6GWPSpzi6EZr3yelrs8UNixeiPxeRE63yqw3d1alrlbpQsIg1
         Ukt/UMOEFypRtXDL44cdkinsSVXOwMYnSYBOgJRgQK9Yy2xfs2lEi1DrIoCvgFSwGyXg
         m26p21hvSDRQnwjxuX6zln6hguH5luvluxYVBBPJXzQ19RRnKbTx1D1b8n7SP20brMOV
         Y4tb97A4zz+LhuNxVsrOYBfl44C9vx0hE3RYIAO27rXd6jEZKHnha18QbplNrsLYTLaM
         8Yo0sTNNiYOzW2pRzmgD4Rcy6fFkerEKSeB8fIrHDMBvKqC6hYPzOmJ9+hkIwDqmGcFr
         NHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h0fD7W5daiv6qwL/B0pVkhAvgnXRveIJ7BunMFgKkMk=;
        b=UyzA0nNcNiscsTTFmzU79Rx7x0HqyyyPdlx3wsiBeaT/Ix40MG5wzLniFN4vuconIr
         EqLfFP+asXFgtVD/QPHegxKfQhKOjCBlmVAW0nW0OR12xKgEqm7CI6SUBEODQK58duvR
         PN3WGeLkgodQj6LvUO43Wi0guwLE5JUsqn7hJGkM8wpDqdaf3mRL0Tfk7cBq7qR39Qcl
         j7vjNa3YpJHNhP5/DrmAJnvn2mzrR/q8SvmYcaZTCI+xpwZT68NRnzhP0HnfA7J1Yz/h
         ea2+fEU9xf2ttTLH0/ALMCFyeEoewHDPve7qDXFZndJ/YlH9RFnvhcYsTn9dqCPsnD4S
         KzFQ==
X-Gm-Message-State: APjAAAXC5GeBgaYOIfxxC/+z60+acTpKpp2bpZ5+ZQDFKrjaKMmXgFjG
        0BnQ0GCOsXDTWnFyjO6yPns=
X-Google-Smtp-Source: APXvYqygrz5FCi0oWMKV7ndji8LS93zjryLb8n/jM89wYPvCkgqbP7Nc3UpIByYK9KTxUNfn0hn5Dg==
X-Received: by 2002:a05:6602:235b:: with SMTP id r27mr13519184iot.51.1576375146408;
        Sat, 14 Dec 2019 17:59:06 -0800 (PST)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id h3sm353493ilh.6.2019.12.14.17.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 17:59:06 -0800 (PST)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] orangefs: Fix memory leak in orangefs_mount
Date:   Sat, 14 Dec 2019 19:58:48 -0600
Message-Id: <20191215015849.23223-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of orangefs_mount() the allocated memory for sb
info should be released if op_alloc() fails. Release it via
goto free_sb_and_op.

Fixes: 482664ddba81 ("orangefs: add features op")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 fs/orangefs/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index ee5efdc35cc1..ad98b893989b 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -566,8 +566,10 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 
 	if (orangefs_userspace_version >= 20906) {
 		new_op = op_alloc(ORANGEFS_VFS_OP_FEATURES);
-		if (!new_op)
-			return ERR_PTR(-ENOMEM);
+		if (!new_op) {
+			d = ERR_PTR(-ENOMEM);
+			goto free_sb_and_op;
+		}
 		new_op->upcall.req.features.features = 0;
 		ret = service_operation(new_op, "orangefs_features", 0);
 		orangefs_features = new_op->downcall.resp.features.features;
-- 
2.17.1

