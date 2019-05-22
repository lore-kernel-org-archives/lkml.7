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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA99AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F49920879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmr3ha07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfEVTRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:17:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37959 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfEVTRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:17:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so1527821plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xjRRu/ivm7yiZ1o3qLhgJ4zcxl0tGsUkhCktbB4oPNk=;
        b=kmr3ha07KpLkWeRssggZMzNfIFypCwymg1J4nTFghrFy8RSWvb3aiGxfhwvabLkGM+
         U1zIRTCWWooqE6joJmhCmD9bcMLrg4tJ3Feh87C6AYzeItu0W+3nJFE59XHF/M+mk/Ff
         s6zQOjHxfMsMPrYqQmVzLCH5g0jfXAX3IfYnQfMWZeHWM3rNVJfh3UnMb5ump5GBBLJS
         jRUbPqFdOYrutU6esuhD6YokgysymCKp9gN/2lXVmMr6Ea2T4e9+wQIoh8pd9mxhEZcB
         2Pgnr2z/Cq5ZbP7cmsoDiY4RFV4NTDqjgV8u35XKsria13ZFThv0oDq6Q80bkJl8M8Iv
         o4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xjRRu/ivm7yiZ1o3qLhgJ4zcxl0tGsUkhCktbB4oPNk=;
        b=X4RmeNFQxyYEX1cd2+mg+QInm7ct8h7mcIht467CuBEAynIoyeMBghAseRix+b0nat
         1UfpuWRVT9UlkMb3i1IWpcE/lo04kWr7x1WC5dj60kb6KT9qQbQRzJYUNEEPwdG+J08k
         x6dX/gOsXkke/s51XoxySvhEZ+qJt8sNv+myRLGa4cftCU7zKJL8A8QVcQm8Qsc35VNZ
         lacG8ubjicO45xT6dkkh8YsHKeLPvGxC8l79T/Q3kaOyJ924iPyiWG74P4HSDSjT2q6m
         MqT44z4QHH8/c8H14Ok079MdSVbp05xvjs8+ZWaylSmFICmiWXWb8Wxgy26MrVHS6mqr
         aA3A==
X-Gm-Message-State: APjAAAWTTKHGTgZxJPjsbgqmc2aYjoHXPSQ+1ko0oTxH7xWWeqjZlbe0
        ENKu67AWzlqim6DxdoXE6poYCbhb
X-Google-Smtp-Source: APXvYqxL3L0PS2t9QZj3d3yI+U1/rV4N9iz0LNF8aUN431cwGdSl5qdl5xQOwa0BHj4AsTmmTEFNmQ==
X-Received: by 2002:a17:902:aa97:: with SMTP id d23mr92521131plr.313.1558552620844;
        Wed, 22 May 2019 12:17:00 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id l68sm38347744pfb.20.2019.05.22.12.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:17:00 -0700 (PDT)
Date:   Thu, 23 May 2019 00:46:55 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] 9p/cache.c: Fix memory leak in v9fs_cache_session_get_cookie
Message-ID: <20190522191655.GA4657@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v9fs_cache_session_get_cookie assigns a random cachetag to
v9ses->cachetag, if the cachetag is not assigned previously.

v9fs_random_cachetag allocates memory to v9ses->cachetag with kmalloc
and uses scnprintf to fill it up with a cachetag.

But if scnprintf fails, v9ses->cachetag is not freed in the current code causing a memory leak.

Fix this by freeing v9ses->cachetag it v9fs_random_cachetag fails.

This was reported by syzbot, the link to the report is below:
https://syzkaller.appspot.com/bug?id=f012bdf297a7a4c860c38a88b44fbee43fd9bbf3

Reported-by: syzbot+3a030a73b6c1e9833815@syzkaller.appspotmail.com 
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 fs/9p/cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/cache.c b/fs/9p/cache.c
index 9eb3470..4463b91 100644
--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -66,6 +66,7 @@ void v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses)
 	if (!v9ses->cachetag) {
 		if (v9fs_random_cachetag(v9ses) < 0) {
 			v9ses->fscache = NULL;
+			kfree(v9ses->cachetag);
 			return;
 		}
 	}
-- 
2.7.4

