Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964D1CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4100D21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NFnOnCss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393067AbfJRHzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:55:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53912 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfJRHzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:55:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so5101014wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=I77rKJPCs2BmaC+W7WkYB32uyg139YK/7J+1ocFiBeU=;
        b=NFnOnCssVKrpdruLY99Y0HTP27Dh9nZMRBEIoc260EAdSUJlkdQhrvqLWiHoOWGCfn
         EDW11cne4VSAWJ5ZZfmkRjbgP06miX6HEc78GScSxvJMqievcMPr914ShvgqhqA/S4i5
         iMEHTjBtEdQ/PHdl5VDvw3xRX72nSgGgeLz2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=I77rKJPCs2BmaC+W7WkYB32uyg139YK/7J+1ocFiBeU=;
        b=r/q0JJvreV3AdynSNculP/oFhFdyi7Vn7jfq+J7gG1k/EGpzOenVyjUh76QMP04/hh
         btQZJylkZxqk3HI7ovBavevNdLT7XZtDLSqyBgUTuE8Vzo28p4Mh5lfzix2yODjZ1IXH
         STFHPdzhtioYdbrrf/Z8yAiT7BSnXpLCq7zYiNlGaYoJHrNanXq9/5LtrlQ/t82XLN+Z
         h7rqWJamv5v4wshyXOWbDjfZGi3NZ8diNksFuRVll0kfx/TNl1VsyBEv3To2xLCj9ILF
         8yjKT4XbxjfcILUB5ulajCDC0JBD3y+udfgw/qVsTlDm57TlF/ibdEWGRWNR7Of+8ERx
         +XEw==
X-Gm-Message-State: APjAAAUXjzt20R7X73pGH0vY72Eoub7EQCiJAbB64GJaBcZOqeVgcfiI
        pYJ8V1NrKSmV+AV1UfGhtI582w==
X-Google-Smtp-Source: APXvYqwEWXjktiX8T2DmtOUPiAjrE/qKQMg3I338FWYfk7AwYVhFcx+yWJvHi1+BMygr1Bzrgk0VWg==
X-Received: by 2002:a7b:c449:: with SMTP id l9mr2646634wmi.43.1571385319385;
        Fri, 18 Oct 2019 00:55:19 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (178-164-242-26.pool.digikabel.hu. [178.164.242.26])
        by smtp.gmail.com with ESMTPSA id f83sm4704537wmf.43.2019.10.18.00.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 00:55:18 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:55:12 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] f*xattr: allow O_PATH descriptors
Message-ID: <20191018075512.GA2075@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

This allows xattr ops on symlink/special files referenced by an O_PATH
descriptor without having to play games with /proc/self/fd/NN (which
doesn't work for symlinks anyway).

This capability is the same as would be given by introducing ...at()
variants with an AT_EMPTY_PATH argument.  Looking at getattr/setattr type
syscalls, this is allowed for fstatat() and fchownat(), but not for
fchmodat() and utimensat().  What's the logic?

While this carries a minute risk of someone relying on the property of
xattr syscalls rejecting O_PATH descriptors, it saves the trouble of
introducing another set of syscalls.

Only file->f_path and file->f_inode are accessed in these functions.

Current versions return EBADF, hence easy to detect the presense of this
feature and fall back in case it's missing.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/xattr.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -495,7 +495,7 @@ SYSCALL_DEFINE5(lsetxattr, const char __
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 		const void __user *,value, size_t, size, int, flags)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	int error = -EBADF;
 
 	if (!f.file)
@@ -587,7 +587,7 @@ SYSCALL_DEFINE4(lgetxattr, const char __
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	ssize_t error = -EBADF;
 
 	if (!f.file)
@@ -662,7 +662,7 @@ SYSCALL_DEFINE3(llistxattr, const char _
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	ssize_t error = -EBADF;
 
 	if (!f.file)
@@ -727,7 +727,7 @@ SYSCALL_DEFINE2(lremovexattr, const char
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	int error = -EBADF;
 
 	if (!f.file)
