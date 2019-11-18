Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C86C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34981208CE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XQ6hYXLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKRVJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:09:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37284 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfKRVJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:09:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id p24so10989709pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 13:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=brNqL6zVPSQ5JwzRtAwRvqEQVxU2P5eqAvSAOt7aHtM=;
        b=XQ6hYXLYNFdMJoP1GZVRliyiJQVEbteGvbXFZF1JTflyx/WMljc3NDpIeLFmJ3DWmp
         GG/P3cyqEgHEmUYIP3yH6SudKNm86c9ObEHQYLbq6Y+oKpxKqSBjL5rxns0mO231ltlx
         5EddBxhbWUcKPvULCBAfpmVdBQtRNgw5I9ezk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=brNqL6zVPSQ5JwzRtAwRvqEQVxU2P5eqAvSAOt7aHtM=;
        b=Uz8n/lXEaxzCEw6oD4m3AhzxQvDX27cFxatN2/m35ToZJlfTPJix2GP2kPx/Aekrgo
         x7yufMf5+nxyPwM4pvjctfBViBBeyPv1rC6UbAieE3VKMT6fTzgIkLV1WTaLtXLhMxiT
         9qlcqdwvEk6CUcvPh+eGoAxczbkTu8ul8e0ihuRu9XWjiQA9BnEfJTJI9YXFPSFFUtn7
         JNZ7Wkyxi84sDgYev2VW+BFxyUz5A76r4/rfS073YoZnKp3QW0vjSGzUodRttl0RENbH
         DpCWv5On2wNZ/sG9rYuoma420pBlZB5oexHYSTDSl/o0O8f4ROLfcB0eqL9kNKjVsBIL
         /0Pw==
X-Gm-Message-State: APjAAAXxC3VW8uUPePMR8HAWo2cnHU6tDs0tx5OvgQyP/c88/+ev9DA/
        PMELbZsn6/S5gAfDWEevWm1lQg==
X-Google-Smtp-Source: APXvYqxwXeAUBUepsAEyBkqI42nmhRb0cKtGnZWmzakoUDnAD+nn1I2/bwkDIrKBj6rjEJFhXiDckg==
X-Received: by 2002:a63:731a:: with SMTP id o26mr1504137pgc.108.1574111363777;
        Mon, 18 Nov 2019 13:09:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i11sm8346900pgl.73.2019.11.18.13.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 13:09:22 -0800 (PST)
Date:   Mon, 18 Nov 2019 13:09:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        tyhicks@canonical.com, colin.king@canonical.com,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH] x86/mtrr: Require CAP_SYS_ADMIN for all access
Message-ID: <201911181308.63F06502A1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang Xiaoxu noted that physical address locations for MTRR were
visible to non-root users, which could be considered an information
leak. In discussing[1] the options for solving this, it sounded like
just moving the capable check into open() was the first step. If this
breaks userspace, then we will have a test case for the more conservative
approaches discussed in the thread. In summary:

- MTRR should check capabilities at open time (or retain the
  checks on the opener's permissions for later checks).

- changing the DAC permissions might break something that expects to
  open mtrr when not uid 0.

- if we leave the DAC permissions alone and just move the capable check
  to the opener, we should get the desired protection. (i.e. check
  against CAP_SYS_ADMIN not just the wider uid 0.)

- if that still breaks things, as in userspace expects to be able to
  read other parts of the file as non-uid-0 and non-CAP_SYS_ADMIN, then
  we need to censor the contents using the opener's permissions. For
  example, as done in other /proc cases, like commit 51d7b120418e
  ("/proc/iomem: only expose physical resource addresses to privileged
  users").

[1] https://lore.kernel.org/lkml/201911110934.AC5BA313@keescook/

Reported-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/cpu/mtrr/if.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 4d36dcc1cf87..9c86aeae1b14 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -101,9 +101,6 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	int length;
 	size_t linelen;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	memset(line, 0, LINE_SIZE);
 
 	len = min_t(size_t, len, LINE_SIZE - 1);
@@ -226,8 +223,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_ADD_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
 				  file, 0);
@@ -236,24 +231,18 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_SET_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_add(sentry.base, sentry.size, sentry.type, false);
 		break;
 	case MTRRIOC_DEL_ENTRY:
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_DEL_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 0);
 		break;
 	case MTRRIOC_KILL_ENTRY:
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_KILL_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_del(-1, sentry.base, sentry.size);
 		break;
 	case MTRRIOC_GET_ENTRY:
@@ -279,8 +268,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_ADD_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_file_add(sentry.base, sentry.size, sentry.type, true,
 				  file, 1);
@@ -289,8 +276,6 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_SET_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err =
 		    mtrr_add_page(sentry.base, sentry.size, sentry.type, false);
 		break;
@@ -298,16 +283,12 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigned long __arg)
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_DEL_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_file_del(sentry.base, sentry.size, file, 1);
 		break;
 	case MTRRIOC_KILL_PAGE_ENTRY:
 #ifdef CONFIG_COMPAT
 	case MTRRIOC32_KILL_PAGE_ENTRY:
 #endif
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		err = mtrr_del_page(-1, sentry.base, sentry.size);
 		break;
 	case MTRRIOC_GET_PAGE_ENTRY:
@@ -381,6 +362,8 @@ static int mtrr_open(struct inode *inode, struct file *file)
 		return -EIO;
 	if (!mtrr_if->get)
 		return -ENXIO;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
 	return single_open(file, mtrr_seq_show, NULL);
 }
 
-- 
2.17.1


-- 
Kees Cook
