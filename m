Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A36CC2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7E5207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OABpaCJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgAAW1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 17:27:00 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:34704 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbgAAW0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 17:26:51 -0500
Received: by mail-pg1-f175.google.com with SMTP id r11so21051697pgf.1;
        Wed, 01 Jan 2020 14:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHonOFx9xvoaxw9VR4rjUajN0rQFPRRu1qbwdwLtluM=;
        b=OABpaCJLh1EBuWpeAkWyvsPzKFaLMZ0FLlCDhBwHaBgvL4EYxoqseoH4jdUjJyt3JT
         Kj5uQzW5C8sDpZKxIuPYEb41du4hPvVyUB+fjlnl5N2ubBdsB244drfiRq32oXpUCaE1
         EHIlWy39IslrN3t1QtrDdiMeBZ3+GZy3CelCZw/uP3M8HnTnrJTocoXoXb+N/Gbo0GsK
         K2jgiZ9BmiSSzdutJXAYmefLDMScTwvQJ6suGL4u7Fd2vYPIWCCVRVc9smjCw9CAZnE6
         YD+5OZ5CDoEfXfqCvGtrgQFE2ec6ytCdPlh1rB7v2XJ99wUV5EmMAoHaVMVIK95grs5w
         3K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHonOFx9xvoaxw9VR4rjUajN0rQFPRRu1qbwdwLtluM=;
        b=ochPBrpp6vjjNrSUd2yLW1QlahnPTQgmVKlXPcOIDCNgNSHGZJwW5eBuVKVBX7qf9K
         au2Vq9h6LwBUktESRj41VLy6JmyErLR0AJo7590hurbayOUf7QLiaQkHVWDBdfjn0ubD
         l7zXZB18hEWf8TSuhyi3bO+pGlV3UGk3xx4AlfMLCIUjReEvNXQa/OQR+R+uI6zzH81V
         lQtoKnTzDl6CzAV77ht53RAcWkvCSCLpooPb+Ugh9RiSFTC+vwpEeqyJ1iHsAIKvpKgS
         Zj5FjJi/kuTmyFJ9mkfdGbwEoZ3hiOkjt4eXvTCxrYUxj+DINF8Cv7ldIu1dbOwQ8J+8
         oTlA==
X-Gm-Message-State: APjAAAX0rpOX2AkrJmSsl+AJEyh8RnA3DqX2/16HTIqS1eTbd4HcEZfV
        Hfo+ojl7B0BExwb4Sy9oGbw=
X-Google-Smtp-Source: APXvYqyZkhcxp60vHbWJlPQszdfVwIeEwBjmwqgdvEc1vR2ZQkHUxKEqzOi0bUvLcgbzN3H5UANLVA==
X-Received: by 2002:a63:1a19:: with SMTP id a25mr87348598pga.447.1577917610832;
        Wed, 01 Jan 2020 14:26:50 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id o2sm8601008pjo.26.2020.01.01.14.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 14:26:50 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 8/8] Documentation: nfs: fault_injection: convert to ReST
Date:   Wed,  1 Jan 2020 19:26:15 -0300
Message-Id: <639820736792d7fc83fac72c8f6b1fefc848f192.1577917076.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577917076.git.dwlsalmeida@gmail.com>
References: <cover.1577917076.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert fault_injection.txt to ReST and move it to admin-guide.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 .../nfs/fault_injection.rst}                                 | 5 +++--
 Documentation/admin-guide/nfs/index.rst                      | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)
 rename Documentation/{filesystems/nfs/fault_injection.txt => admin-guide/nfs/fault_injection.rst} (98%)

diff --git a/Documentation/filesystems/nfs/fault_injection.txt b/Documentation/admin-guide/nfs/fault_injection.rst
similarity index 98%
rename from Documentation/filesystems/nfs/fault_injection.txt
rename to Documentation/admin-guide/nfs/fault_injection.rst
index f3a5b0a8ac05..eb029c0c15ce 100644
--- a/Documentation/filesystems/nfs/fault_injection.txt
+++ b/Documentation/admin-guide/nfs/fault_injection.rst
@@ -1,6 +1,7 @@
+===================
+NFS Fault Injection
+===================
 
-Fault Injection
-===============
 Fault injection is a method for forcing errors that may not normally occur, or
 may be difficult to reproduce.  Forcing these errors in a controlled environment
 can help the developer find and fix bugs before their code is shipped in a
diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index c96e93b61744..410b8ccad11b 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -12,4 +12,5 @@ NFS
     nfs-idmapper
     pnfs-block-server
     pnfs-scsi-server
+    fault_injection
 
-- 
2.24.1

