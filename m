Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7628CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC1921871
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSyzwzUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfCPLaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 07:30:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40708 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfCPLaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 07:30:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so8214495pgo.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 04:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0wH5Xjkjg/F0FX4qAlxeFssX7bZx2g7hSqnx2ks9qiw=;
        b=PSyzwzUl/sxQMCNjA7lE16hKlrZzZxXRqyJ8rdtTbq1x7zkl0FFLuNN0OpoUQiDxOx
         0ITs16PiZv2kSQSpLMB6aDstGhIGUIzwXw3W1ULKKxdZpClc7Jki5t/RjyQkwmeMXYAU
         kXkCKj1HTIBOsbEUbAwI9o75keq7KrVIfES3TLqU10PLRuo33LLnBYy+kjfmu2MkwqHj
         Dp7sh8paN+aSQrFgUnEaDERz4vQuTaMhqXyIjSboS4xYW10wkhE3r3CIQv6p7RTDmYGR
         un6ACD6GfKQgRWzfx3BwswjFycLxKBh0LIXgWZqfqnhDkhhqX6BSL7gRCC9/6E+5y+9p
         VBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0wH5Xjkjg/F0FX4qAlxeFssX7bZx2g7hSqnx2ks9qiw=;
        b=PA44diDACj3Gv8JOOpmeh5ri/R0EvZaJFQ51drO/FSgVcdihVKTFBX70amXxkflk/v
         HLzPS7OxDHmJ41VtTzOKPZvAg8fzaKh72UU6MGPTLRXKF7s3xVx2zjmXnXDqP/CfJgIa
         q0xlIsZYPzAORn5DUsbZEHOWwuZrd/S6JIYBl7LShQDWwzttLPmAxJ0foiBRMcnkO4RB
         fivIEVM1hnwBGHzPBxPU561yTM7NfOgFD4CLB2ap4WwbBgHp+7LawQ/+UHAOSb+pbExh
         p/a/dlkwWoA8gwntKgJNBysOeHq8txg/uptDw6885ma+gbGD4CyfpP/sNVmeBh7sMV2e
         nJ4w==
X-Gm-Message-State: APjAAAXNqp5kqHYXk2uu5GwZqX78/03Onl3ZNa1bID6e6zr0ANZ6Gv5b
        nVKwnOCoRF+L2SzR/iV98ko=
X-Google-Smtp-Source: APXvYqykxMCHdYWXddFj/cYArKXjTzqTQT4+Xdz2VVUC9t9ifKifs8ONln8Czc/d0zYEZPUXQP+PCQ==
X-Received: by 2002:a63:9dc1:: with SMTP id i184mr8199718pgd.244.1552735810882;
        Sat, 16 Mar 2019 04:30:10 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.35])
        by smtp.gmail.com with ESMTPSA id b7sm8598997pff.136.2019.03.16.04.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 04:30:10 -0700 (PDT)
Date:   Sat, 16 Mar 2019 16:59:58 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: erofs: Add whitespace after declaration
Message-ID: <20190316112958.GA29023@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the checkpatch.pl warning to add a whitespace after declaration
statements.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
Changes since v2
	- Mutt was giving me a few problems. I apologise for the
	  previous poor patches.
---
 drivers/staging/erofs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 924b8df..9a36a1f 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -270,8 +270,8 @@ struct inode *erofs_iget(struct super_block *sb,
 	if (inode->i_state & I_NEW) {
 		int err;
 		struct erofs_vnode *vi = EROFS_V(inode);
-		vi->nid = nid;
 
+		vi->nid = nid;
 		err = fill_inode(inode, isdir);
 		if (likely(!err))
 			unlock_new_inode(inode);
@@ -305,4 +305,3 @@ const struct inode_operations erofs_fast_symlink_iops = {
 #endif
 	.get_acl = erofs_get_acl,
 };
-
-- 
2.7.4

