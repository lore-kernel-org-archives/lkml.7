Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B237C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFBA2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKjKEJAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfEWQ40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:56:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45447 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730790AbfEWQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:56:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so3551478pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 09:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hM/FpdNSFBUxwsc/bH6HaYb2mRTwEqnM6q+pG5Opaiw=;
        b=QKjKEJAP/SopoWFpkRrkNWKTted6q6ovKsHuS/T5GyygadbPTQhqDN1eUDmUZY6nbP
         iNDTVxSZ0IVYxCNniNsid4BDCKsxfctE/l0uywvmxJS/9MiQLcQWd8JjktJ1ldZthUB6
         nrq7LNR++REjxMPKnL2efXJj+/16tP6rcfgBRp/cK13NJulzZGqk2L0K0hEmRQmu92Cz
         YwosRU/9z+rpRdt7846q0u44RuMtl0Z9qRHPMLQ1iMtX70txwdA4RBJQIFp8rGSq/zh6
         rF4tyGCFMlq752MeSgMLyxLCQbSkA9ceF/0iC/u49Ny/IL75STLonSu2USSX14ZT+bdt
         sqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hM/FpdNSFBUxwsc/bH6HaYb2mRTwEqnM6q+pG5Opaiw=;
        b=cTA0kcKTfXYKnTcQJDcbN+S/ocfQTNDOOvNj4ZGO7cjoCFnZMA7zAH9AN0N8shY0f+
         Hf6VBnGrawQ+ixdKmidsf+uhCf24t5+uUmCAVw3uvmSviLYiCc8GnAtXDjmYM0d2Hk6S
         hI5No1rFZ5vdjG9OVNbS7I/mZyJETub4RMpWQEwIaWYAvqXzA6fM/084zaHyEMhpygph
         Su4XQH3Kk9U02S63iZ9qxJmXPIZYRIg95COy7BoT5SRSdunHKo+GmZSoF8QBWyHPuIYS
         cjaMYwAY8oAWq8APrlcgXsx680QGrBVicD6F29R9OkHtPV0cKHmjg5kAiim4lzZadUy4
         SzZQ==
X-Gm-Message-State: APjAAAXYWmKY4eytSuKgAhyehLlYL8Z4VcPOB2V/meb/eU3qoY049KRV
        a9Jxvpwz43ebErgGyF+0vPA=
X-Google-Smtp-Source: APXvYqyafcu/mWXpHJw/TN+hfAfMBqUTLhHre/3ZPW/vDgWJUo0VN4xy4pAikHdSA0Un9QN7TomKsg==
X-Received: by 2002:aa7:87c3:: with SMTP id i3mr103598908pfo.85.1558630585808;
        Thu, 23 May 2019 09:56:25 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id t10sm6687147pfe.2.2019.05.23.09.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 09:56:25 -0700 (PDT)
Date:   Thu, 23 May 2019 22:26:20 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] 9p/vfs_super.c: Remove unused parameter data in
 v9fs_fill_super
Message-ID: <20190523165619.GA4209@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v9fs_fill_super has a param 'void *data' which is unused in the
function.

This patch removes the 'void *data' param in v9fs_fill_super and changes
the parameters in all function calls of v9fs_fill_super.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 fs/9p/vfs_super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 67d1b96..00f2078 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -73,7 +73,7 @@ static int v9fs_set_super(struct super_block *s, void *data)
 
 static int
 v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
-		int flags, void *data)
+		int flags)
 {
 	int ret;
 
@@ -143,7 +143,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 		retval = PTR_ERR(sb);
 		goto clunk_fid;
 	}
-	retval = v9fs_fill_super(sb, v9ses, flags, data);
+	retval = v9fs_fill_super(sb, v9ses, flags);
 	if (retval)
 		goto release_sb;
 
-- 
2.7.4

