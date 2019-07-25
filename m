Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF6C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B92422BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de2hdfLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390000AbfGYI5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:57:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40164 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388805AbfGYI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:57:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so23108151pla.7;
        Thu, 25 Jul 2019 01:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oZzmYnbVeA3T1k/Blnoj4JLRh8hVO63J2LZYhH68rjY=;
        b=de2hdfLVt6WQzMnVVNGjoOVU+c/cmUfyzo759Q3cohTisB8QqnMCwMkYS0qpQ2EfUp
         5Jo/P4+57CE7iulPyvb77tqkbLW8JuMQEiSfVNvmWv+n2UFwuEPfgH2sbh5Ek7RV/IA/
         NZzt6cl0ZqpTp1rVL5XidnT6clbb2vGh7dw52tXDKAOkGD7dHEhfQ61fV/LFsvLjg3Jj
         d5G7vF9iMyTJ7Zs2yMQlDDXKSAHZDrIM21xFASo3DiKCGtfmCdUPieDvG4cJZIhot0Jc
         Os3wq8E0Rc7y6n5alGUsRV3jp1Tys1RUJIOUEWZIg2FeEXHFD8tcZUTBWdLfJ+FQObjM
         EIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oZzmYnbVeA3T1k/Blnoj4JLRh8hVO63J2LZYhH68rjY=;
        b=VNnYsIKuV4sqZwPt7kCh+wFKkTUud/0sVtKBWdBZTVfC/bmOhCLdLlv8RDUmw7i97f
         aBiidsjyp7G12X28SsQivDtIjc4YD84/2tyrrhXgT6nkG/uJ6OcEqc1XlMK5W5touTLT
         NkE1WRmn37lU5SKTs9Rlz9+04bbpbJ2napqi1kZ41TUkZpDHcvWDANc1sOb9ZyfZlYip
         lW4vYEjVbKu25MLjTH9JzUuXn2nr/0+VXHQ+agp1ya4DQ2fLeWH8LledZ0/kQRfVAq89
         f6Blon6nPjngdHvc1/looQr+RAyERn0SRWGKx0NJnZNEbH1LvtTHEjMCWRM+gTwyuMqg
         Pmhw==
X-Gm-Message-State: APjAAAViIvFKttUF8Wz9KMjlBVjzxRhjegXImzFFik28NOaaXbvOvNIS
        HGjZ5SKWjrmTVeVJk17kVWLIUaGDH+c=
X-Google-Smtp-Source: APXvYqxB9rABnN1rgU+QjzV/x4v2ds9w+5Dtir+903lsYb0VR3Cvzg2XkhwftbNQOm6e9GyVPHR82A==
X-Received: by 2002:a17:902:4623:: with SMTP id o32mr88427211pld.112.1564045059699;
        Thu, 25 Jul 2019 01:57:39 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id f14sm48865966pfn.53.2019.07.25.01.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 01:57:39 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: overlayfs: Fix a possible null-pointer dereference in ovl_free_fs()
Date:   Thu, 25 Jul 2019 16:57:32 +0800
Message-Id: <20190725085732.15674-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ovl_fill_super(), there is an if statement on line 1607 to check
whether ofs->upper_mnt is NULL:
    if (!ofs->upper_mnt)

When ofs->upper_mnt is NULL and d_make_root() on line 1654 fails,
ovl_free_fs() on line 1683 is executed.
In ovl_free_fs(), ofs->upper_mnt is used on line 224:
    ovl_inuse_unlock(ofs->upper_mnt->mnt_root);

Thus, a possible null-pointer dereference may occur.

To fix this bug, ofs->upper_mnt is checked before being used in
ovl_free_fs().

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/overlayfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b368e2e102fa..1d7c3d280834 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -220,7 +220,7 @@ static void ovl_free_fs(struct ovl_fs *ofs)
 	if (ofs->workdir_locked)
 		ovl_inuse_unlock(ofs->workbasedir);
 	dput(ofs->workbasedir);
-	if (ofs->upperdir_locked)
+	if (ofs->upperdir_locked && ofs->upper_mnt)
 		ovl_inuse_unlock(ofs->upper_mnt->mnt_root);
 	mntput(ofs->upper_mnt);
 	for (i = 0; i < ofs->numlower; i++) {
-- 
2.17.0

