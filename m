Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCCDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCE020862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpL/qYsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbfEVTpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:45:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42226 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbfEVTp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:45:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id go2so1555064plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xu8Xfz1//w2ZzNsfNUbcmqz00XlQNm2CX6twe7k5oB4=;
        b=SpL/qYsNz/7q6yoXxeofhfKWNOeNxFM1wJhkF4xMyF+ND93xkfki/hHZGqtDiecjIq
         y3DDItEF+vWU5Weezwz+uASTJ8v8ibnAJOLjqf6UvHIEYtY0/dADtQvD23ldraYPKZw1
         Rm32W/+3NgSUAGEFyEp4C3PD7eqEaUlg1i89S+la0C5kj9IP+2anERQj9IHdC2nO9ReQ
         m+fvLw318OegoJ+pxP0vvH6oB5+WGfztfIHn8uOG+7E4tIqcstc2paaL7/mnukMkj25Q
         KodbhaLgeJxTW1sY7k3WHz1a8iyZJZKmla7Fg/HdyUYH6LNJL0dKVQix6snM7q/fsMbm
         jxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xu8Xfz1//w2ZzNsfNUbcmqz00XlQNm2CX6twe7k5oB4=;
        b=kyk4AO/lymb9wd8y9yD/XSj5zO+xtWNZarEcH0PYsX8NZqDreXUuE7eetdYybDKCXz
         0cz//Ljye4BumgJimKfU4dSx0gzHr4cW9NhMBk3L45txHXqbIKpz4J8AQtMqicXJTGcY
         10yOMuGNjTCGNLdTk7trFj4ErE+Ec4pAVXCSPRjCGZ3U95GSk+Jff6HYQrBWG6ew2yvt
         K8Mm0/cS+tfZ7e0nNVDWevMO+Fv4HHq9ih/yBH5o+h0seVBlBbsXHFUs87bzSlhRw7tt
         PxYkMf+b9LZKeLoP+lH9iCEebOs4BA6KfdDE2M4XnXBnHUZhSw96bAyCCCPzyi4prfsf
         +izA==
X-Gm-Message-State: APjAAAUSBLsJ4m0cK0N5+iP5IeswfAg0jTjCwXVU2gnV3oKsVHldJwtz
        3VqotdrP0DPpRBrJmWEawWU=
X-Google-Smtp-Source: APXvYqxJl7eiZaUNXlyUGE1f1J9ER3gIBLLVf+MUPh3VvOxDZh0pS0eJUedewgdXa8RgYUhJuy0rkA==
X-Received: by 2002:a17:902:b095:: with SMTP id p21mr40903202plr.270.1558554326511;
        Wed, 22 May 2019 12:45:26 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.31])
        by smtp.gmail.com with ESMTPSA id v16sm11490421pfc.26.2019.05.22.12.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:45:25 -0700 (PDT)
Date:   Thu, 23 May 2019 01:15:19 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     ericvh@gmail.com, asmadeus@codewreck.org, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux.bhar@gmail.com
Subject: [PATCH v2] 9p/cache.c: Fix memory leak in
 v9fs_cache_session_get_cookie
Message-ID: <20190522194519.GA5313@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v9fs_cache_session_get_cookie assigns a random cachetag to v9ses->cachetag,
if the cachetag is not assigned previously.

v9fs_random_cachetag allocates memory to v9ses->cachetag with kmalloc and uses
scnprintf to fill it up with a cachetag.

But if scnprintf fails, v9ses->cachetag is not freed in the current
code causing a memory leak.

Fix this by freeing v9ses->cachetag it v9fs_random_cachetag fails.

This was reported by syzbot, the link to the report is below:
https://syzkaller.appspot.com/bug?id=f012bdf297a7a4c860c38a88b44fbee43fd9bbf3

Reported-by: syzbot+3a030a73b6c1e9833815@syzkaller.appspotmail.com
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>

---
Changes since v2
	- Made v9ses->cachetag NULL after freeing to avoid any
	  side effects.
---
 fs/9p/cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/9p/cache.c b/fs/9p/cache.c
index 9eb3470..baf72da 100644
--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -66,6 +66,8 @@ void v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses)
 	if (!v9ses->cachetag) {
 		if (v9fs_random_cachetag(v9ses) < 0) {
 			v9ses->fscache = NULL;
+			kfree(v9ses->cachetag);
+			v9ses->cachetag = NULL; 
 			return;
 		}
 	}
-- 
2.7.4

