Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E84AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DD320700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKv5y01A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbfCZS3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:29:06 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:50515 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732899AbfCZS26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:28:58 -0400
Received: by mail-oi1-f202.google.com with SMTP id x125so857811oix.17
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IoXKM0YaE9Y+1YAYJ3jkE86oI9WuPOYgAsUS7wsInCs=;
        b=kKv5y01A21+36GWT1D4YyTFV1FMwIxaRgmZ3DkG7OUNg1kOgHEFkifuJwfBADEAl9r
         UlrestlL5PTDbdz6BL4gJKhnoOiL1vt6dr3ZdGRhdBSNCWdatU+k6Gy8qNWZ8Fgoq+cp
         kt6JGA6vd9D1HMp1m015CDo9jp4DqGO8Z74WjSl6r2+IwhvaZfdS/iDxhepP7yVB2vYB
         pZ2hOElr5UfIyrvrEG3cWvVCW8h/vbp0iVdw4EvRzjyGPIHw2gzZ9ejJQczvsuqGkRn4
         k3vQ6Ka5ApjuDBzlYiMO2QHGnjvPuRgtounl5Od9RHGDOsC40Fg7QEqqHostyWFT5ZvV
         VewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IoXKM0YaE9Y+1YAYJ3jkE86oI9WuPOYgAsUS7wsInCs=;
        b=tU35xsIMncbwyZiZQplJVzlDx3b6aDqL3zqkUopK3YZYE0lhMlrQGXZ2dukEWdY8Mt
         biPO+BEgamIk2MEdehogPgC29xa70oGki53RaIRjT/N3Y6EtiWFPJVksZqrmn7KBT4P6
         04AiO/rm03XuzrV65s176n5uMzDSsodZVG8KlTqSdJu6L8SVOVDMCEUmyVqtJbgnPf43
         y1FQ+mqwSyWwII9rjSRiqIlJQ1PL1Ye+J+tiER8KSBdAT/2nDqhhEZvt3zDhgJa2AyOZ
         0A5ix5eDkpdlSNfJZ/1KTYxlQE0ASH7adByhaMB5esg9YB4Mx3qM+Si6uytCZuj9RTsb
         bOlA==
X-Gm-Message-State: APjAAAXxmlWEyQf9OVd47GVT8NcZOM/hsTJovX/p8kSRCV3skKig7N6v
        GgFFzgNLiKj96ANqVRzYFFW5bnJFFcTKW4cbtC//4A==
X-Google-Smtp-Source: APXvYqyjNbwetsmBZSAi0gFELSpsFCAArafwfWaxUI3YirST+VOWV22o0s3zFRN5vHlTvkKDMRzgm8tVZfCAaQC6/Njgyg==
X-Received: by 2002:aca:4b56:: with SMTP id y83mr16163700oia.63.1553624937594;
 Tue, 26 Mar 2019 11:28:57 -0700 (PDT)
Date:   Tue, 26 Mar 2019 11:27:41 -0700
In-Reply-To: <20190326182742.16950-1-matthewgarrett@google.com>
Message-Id: <20190326182742.16950-26-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@google.com>, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

debugfs has not been meaningfully audited in terms of ensuring that
userland cannot trample over the kernel. At Greg's request, disable
access to it entirely when the kernel is locked down. This is done at
open() time rather than init time as the kernel lockdown status may be
made stricter at runtime.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: gregkh@linuxfoundation.org
---
 fs/debugfs/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 4fce1da7db23..9ae12ef29ba0 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -142,6 +142,9 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
 	const struct file_operations *real_fops = NULL;
 	int r;
 
+	if (kernel_is_locked_down("debugfs", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	r = debugfs_file_get(dentry);
 	if (r)
 		return r == -EIO ? -ENOENT : r;
@@ -267,6 +270,9 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 	struct file_operations *proxy_fops = NULL;
 	int r;
 
+	if (kernel_is_locked_down("debugfs", LOCKDOWN_INTEGRITY))
+		return -EPERM;
+
 	r = debugfs_file_get(dentry);
 	if (r)
 		return r == -EIO ? -ENOENT : r;
-- 
2.21.0.392.gf8f6787159e-goog

