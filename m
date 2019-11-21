Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81D9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00832075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m9XUuPcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKUADN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:03:13 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35099 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfKUADM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:03:12 -0500
Received: by mail-pj1-f68.google.com with SMTP id s8so581428pji.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 16:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xi3KRlSdFLMcd3fOocBKXtSC+7KVxz8BH0njDxz/f8Q=;
        b=m9XUuPcCYx/m0d7JrFXRJrUqj8L/gJ4SWov2KoHVTan86El4s7b3jX8TSU8MVepl+r
         n7VwRQVX/KTuJZUdMZPr4mWEBFjr4kVjy0CQ2d20AGtlpvdDoJRV0dGxoA5nRbEW4g9b
         kH7R52zMn6svW+97e9kWbTez5yBYyjC4vIvBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xi3KRlSdFLMcd3fOocBKXtSC+7KVxz8BH0njDxz/f8Q=;
        b=oVREREAMmkZUo1+SFopEt0L80ZDPpEKmFeQJ7o3yYfAW/8sGcS2CV370GIhLg/FvjR
         1fHhshx4BrJSLHHOi0C5+Mmpq0i5dgZhK5zdnidGnjTbNw0aqOY4op/3aLpcY/TBWXA0
         RN1MvA4Ogx+fEttk5LYFyr4uMLbcEQqTeqE97pefBIt819MCa+Hr4BJ9U9mWNEiMZL1F
         ILz1H+qvvcM9ShwYkHx3rS47X6EC+F/IXa0YKsE4m3SdO9C13SFDYRo3Puu31WVirG5D
         kcV2miOmiEVvKp9OWoEug/bMt1itFuftrMgb6JQf+xKcJfU/LPinF/SXv5LX4VwbXYFN
         36Dg==
X-Gm-Message-State: APjAAAWwr+Y7/qBljoAka6LJrVLSjiUtpCexGmxviWVk5aZzLW9jq7AE
        /xwRt6bgDDhrxTQ5uW25l1euaw==
X-Google-Smtp-Source: APXvYqzXage3fd0hSjL8ZKImr7HsDh14K4z1PkgezlYcLvIxzXeADl1KAtX5FExxhsXry7NmKBDaRw==
X-Received: by 2002:a17:90a:1089:: with SMTP id c9mr7603758pja.8.1574294591370;
        Wed, 20 Nov 2019 16:03:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a23sm371220pjv.26.2019.11.20.16.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:03:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] docs, parallelism: Do not leak blocking mode to writer
Date:   Wed, 20 Nov 2019 16:03:03 -0800
Message-Id: <20191121000304.48829-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121000304.48829-1-keescook@chromium.org>
References: <20191121000304.48829-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting non-blocking via a local copy of the jobserver file descriptor
is safer than just assuming the writer on the original fd is prepared
for it to be non-blocking.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Link: https://lore.kernel.org/lkml/44c01043-ab24-b4de-6544-e8efd153e27a@rasmusvillemoes.dk
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/jobserver-count | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/scripts/jobserver-count b/scripts/jobserver-count
index 6e15b38df3d0..a68a04ad304f 100755
--- a/scripts/jobserver-count
+++ b/scripts/jobserver-count
@@ -12,12 +12,6 @@ default="1"
 if len(sys.argv) > 1:
 	default=sys.argv[1]
 
-# Set non-blocking for a given file descriptor.
-def nonblock(fd):
-	flags = fcntl.fcntl(fd, fcntl.F_GETFL)
-	fcntl.fcntl(fd, fcntl.F_SETFL, flags | os.O_NONBLOCK)
-	return fd
-
 # Extract and prepare jobserver file descriptors from envirnoment.
 try:
 	# Fetch the make environment options.
@@ -31,8 +25,13 @@ try:
 	# Parse out R,W file descriptor numbers and set them nonblocking.
 	fds = opts[0].split("=", 1)[1]
 	reader, writer = [int(x) for x in fds.split(",", 1)]
-	reader = nonblock(reader)
-except (KeyError, IndexError, ValueError, IOError):
+	# Open a private copy of reader to avoid setting nonblocking
+	# on an unexpecting writer.
+	reader = os.open("/proc/self/fd/%d" % (reader), os.O_RDONLY)
+	flags = fcntl.fcntl(reader, fcntl.F_GETFL)
+	fcntl.fcntl(reader, fcntl.F_SETFL, flags | os.O_NONBLOCK)
+except (KeyError, IndexError, ValueError, IOError, OSError) as e:
+	print(e, file=sys.stderr)
 	# Any missing environment strings or bad fds should result in just
 	# using the default specified parallelism.
 	print(default)
-- 
2.17.1

