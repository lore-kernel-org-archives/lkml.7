Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55298C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1443620851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoUczZgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388728AbfEXDbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:31:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38964 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387559AbfEXDbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:31:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so4226427pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 20:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LRKYo/Tg41WJvHbOGajmPW4pzDGr3pcsWkrKkayOv50=;
        b=WoUczZgQgZDQ55ACG6f3fVnPyzmz++Cf8vYhPWnpmXrkc7NoQm2X67O4zsc2hQvJO/
         4qAw9vwUkInCqjPUss0GJDj8mUFv3L4eA/z5lVLkXJBtYuuw22XA0t1jMWc7WqjdX5vO
         0Nw7xymG79C+iSX6/+X4i5F3aCZ3P/s8L5NnmMZFPLm6wLglZ3ZD6DZGzkasVM6TpQk5
         JshBlRHx3IFZWs1xNvF/zKoHs6cfxUnwBYa1rMBWJqXPgC/t5olv4LxGIswYTft+OnhZ
         i/um3vXPXJvu7mT9pO63iPgxx6tFKrSDPgaMy5tKNOprM9CikJ+MhUDnHmVNUGJr9e/f
         IKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LRKYo/Tg41WJvHbOGajmPW4pzDGr3pcsWkrKkayOv50=;
        b=LXX+UHpPYA0Ydu1rNaI956FnJ+t3yEGUvG8VB0bMHKEfKVGeH0aALwDraRZGCtrK4e
         KatVFgJ5+3xGDhPH2vjHysZ/+LrXeDX3OyWwjnElFRe/smd0xm5BlwFjWZ0cd34qcX2F
         eeLtQrq+17X9z7SfkR1cjJcW9O+MnoiQKfuFdDhUbaS3qRXIE4pNXnvnU4hl8noK4qlZ
         PEABXfKo8uvZXzIF+TTkCyk2RwdYY2qWFUm2fcCkTgUNF4xpnRlCd5hzNxRKJTtN6T+w
         IRATGe22u92pI2HMxIG3zQEjFfYaZutapO6VRPjr4i1ZxPqRtmp2or9NkGl63G3gpTdr
         +7Gw==
X-Gm-Message-State: APjAAAUhNXIkf9VjVfgJDGbV3sQYUIV0ETsJQRthA4ivMye9PNv43sXM
        7gO1gmTQmhKBYlv9yaECaIY=
X-Google-Smtp-Source: APXvYqwFdf555UMq6bAeNye5axtOxjMcpuyvryqWZ9TWgDza6t76gkWjCprLifFSy6xJWrxV3xyPZA==
X-Received: by 2002:a62:e803:: with SMTP id c3mr62918637pfi.58.1558668662118;
        Thu, 23 May 2019 20:31:02 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id q17sm913522pfq.74.2019.05.23.20.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 20:31:01 -0700 (PDT)
Date:   Fri, 24 May 2019 11:30:45 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     akpm@linux-foundation.org, rppt@linux.ibm.com,
        david.engraf@sysgo.com, steven.price@arm.com, osandov@fb.com,
        luc.vanoostenryck@gmail.com, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] initramfs: Fix a missing-chek bug in dir_add()
Message-ID: <20190524033045.GA6628@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dir_add() and do_name(), de->name and vcollected are allocated by
kstrdup(). And de->name and vcollected are dereferenced in the following
codes. However, memory allocation functions such as kstrdup() may fail. 
Dereferencing this null pointer may cause the kernel go wrong. Thus we
should check these two kstrdup() operations.
Further, if kstrdup() returns NULL, we should free de in dir_add().

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/init/initramfs.c b/init/initramfs.c
index 178130f..1421488 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -125,6 +125,10 @@ static void __init dir_add(const char *name, time64_t mtime)
		panic("can't allocate dir_entry buffer");
	INIT_LIST_HEAD(&de->list);
	de->name = kstrdup(name, GFP_KERNEL);
+	if (!de->name) {
+		kfree(de);
+		panic("can't allocate dir_entry name buffer");
+	}
	de->mtime = mtime;
	list_add(&de->list, &dir_list);
 }
@@ -340,6 +344,10 @@ static int __init do_name(void)
				if (body_len)
					ksys_ftruncate(wfd, body_len);
				vcollected = kstrdup(collected, GFP_KERNEL);
+				if (!vcollected) {
+					panic("can't allocate vcollected buffer");
+					return 0;
+				}
				state = CopyFile;
			}
		}
