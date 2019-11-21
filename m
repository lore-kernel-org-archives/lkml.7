Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA21C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6410820672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DZMjwBV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKUU7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:59:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40931 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfKUU7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:59:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so2340147pfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 12:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h7iBPSPjA04XWgIsictgmYiAtGLdecxKeMbrdsEqcpA=;
        b=DZMjwBV5LmZ65QwbCuZZKPoVnXXfCNnJ4TVubt8GaXoginMsXpoVcruU1OkeFGqu0s
         OKn+YshVjzGCkRBqvisUy0PRat6RSrFO8w5Hsz3cmuFPj4iBP0T0GBhCQ59WxkcgAnSC
         72YvwUPMEcrB7uuN8QUrbgxhBjE765qirm3rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h7iBPSPjA04XWgIsictgmYiAtGLdecxKeMbrdsEqcpA=;
        b=fE5ffP0yjKsvlNWiXRFypYouB0cXZ6ZfmNhaLgegNGpInSVKI5/FWjAL7I6hWW1F/L
         gKI55D1TGoiPFTlupZuoPBVaXF/B0TBvS/j5NgLJzsCcTUPyBkdxow/Zm8WG7jtdPowG
         UG//TNevFspbkskrYKOImdG3ZBycS4qJFVJccuKywO2HIV3StO2B4cv9f4CN3jGRTYKt
         y/B+BuNUuUwxYOYwZTU3Zqast40MjRPVZQm/syrfnxVURuKCOFP+xMJ/TsoVop9SG3pG
         YjzY5zdPvMk3hoaTyileDyepCoMcy9QelNhaeUMiHG5cZAdbXWfgITCd4OBmzt7CQSgR
         SA8w==
X-Gm-Message-State: APjAAAWPEV1oLSV80iNS8OZ4InGAkiwlw4H2OXjEXOK6qO3fKYxS3cN9
        NV15BOeQf1CdUZw/UaEbagPTYA==
X-Google-Smtp-Source: APXvYqxweEWdeXCl2DvMpE6eEvlcsnYZX+GCQg6j7xPv4x5iUHbZZkjMfRQXfjNzgJRSCbVtNJ3PeA==
X-Received: by 2002:a62:2942:: with SMTP id p63mr13764407pfp.110.1574369974028;
        Thu, 21 Nov 2019 12:59:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s18sm4709212pfc.120.2019.11.21.12.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 12:59:31 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] docs, parallelism: Do not leak blocking mode to other readers
Date:   Thu, 21 Nov 2019 12:59:28 -0800
Message-Id: <20191121205929.40371-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121205929.40371-1-keescook@chromium.org>
References: <20191121205929.40371-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting non-blocking via a local copy of the jobserver file descriptor
is safer than just assuming other reader processes with the same fd open
are prepared for it to be non-blocking.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Link: https://lore.kernel.org/lkml/44c01043-ab24-b4de-6544-e8efd153e27a@rasmusvillemoes.dk
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/jobserver-count | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/scripts/jobserver-count b/scripts/jobserver-count
index 6e15b38df3d0..7807bfa7dafa 100755
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
@@ -31,8 +25,12 @@ try:
 	# Parse out R,W file descriptor numbers and set them nonblocking.
 	fds = opts[0].split("=", 1)[1]
 	reader, writer = [int(x) for x in fds.split(",", 1)]
-	reader = nonblock(reader)
-except (KeyError, IndexError, ValueError, IOError):
+	# Open a private copy of reader to avoid setting nonblocking
+	# on an unexpecting process with the same reader fd.
+	reader = os.open("/proc/self/fd/%d" % (reader),
+			 os.O_RDONLY | os.O_NONBLOCK)
+except (KeyError, IndexError, ValueError, IOError, OSError) as e:
+	print(e, file=sys.stderr)
 	# Any missing environment strings or bad fds should result in just
 	# using the default specified parallelism.
 	print(default)
-- 
2.17.1

