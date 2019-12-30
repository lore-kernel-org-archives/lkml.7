Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745A0C2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 04:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EFC2464E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 04:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr56+Iza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfL3E4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 23:56:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44913 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfL3E4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 23:56:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id 195so16831663pfw.11;
        Sun, 29 Dec 2019 20:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2a6HXueWCHtUZD/OVDlDKAMCXfodyCrP/XbEG2O9ms=;
        b=lr56+IzaweGCX8izsJlkol5dyeiod50EjO7mDPGApbLcjZjkq8RIPHQ9HP9Xsk5/lt
         SpqWcDLSLbKrwQtnXcotRsna1OnPJH3YDXUMsl+4Zpms9u6tVCjSXTpiuBuqqW3JflOQ
         XHJV5SG5K2w2211utYCvlly7YHJU1kLUCxY+OhKSCqfgWYlJ6xznaT2uzPfrfOcWZZc/
         jkGfadib7QPF5knjAiNi/D7JnsGBnf9eMm6HgY6L9C8eL6BkLP1AE+Qh9gdw0hYJ3eGZ
         JXE2u4diWQ8Ha1bZrGtXt7aJKtYgcrTDi18yJxmLnBgDPqNOh+DE1p9+ukbMUibOFpVo
         71hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2a6HXueWCHtUZD/OVDlDKAMCXfodyCrP/XbEG2O9ms=;
        b=lzrcolflJvcIWEXzRwL24oZvS34AXU4HKQGkazsRxmbEMhWwePH4D7Fxa1fahWMA9z
         mBBmn5KluETiiSmBDK+HKGvZKMfZjxqTVvtzDUofAvJD8w5tm9Hrg6BKaZVnr9+C+o01
         7lfipedQFS/PMnfvAannYG7qkTpW2ya23iy0OFRuDp3f/MZcq/BZn7Zb3EuLNG3XuX4o
         LFjMv9nudyq2ydMvcup6zSYviEyyTX8Mrvrc/GJ2WJDgGIzeMPwg/yCjloWj3cksDqXq
         XQ+HjOXJU45xcwaWnX0avr70ITYK7pMvpXLSjXid0cS4muFBmNrpazxZaUZRbqG+IaUL
         irTQ==
X-Gm-Message-State: APjAAAUXhxcn6UH2Pm1zop98PsXH7m3yywN+Qm+VGKOozxPnQEStjkPl
        e8jWPTf3rlueXd6JhKXoMlk=
X-Google-Smtp-Source: APXvYqzFYAJXjAIEy5Egk8jmD2IpWKXwFpHHVuKMBg45DxEDNESUwHNNlqxGUirm+iExuWb+R8ZVgg==
X-Received: by 2002:aa7:96f9:: with SMTP id i25mr70440416pfq.161.1577681789132;
        Sun, 29 Dec 2019 20:56:29 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id b1sm22373189pjw.4.2019.12.29.20.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 20:56:28 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 4/8] Documentation: convert nfsd-admin-interfaces to ReST
Date:   Mon, 30 Dec 2019 01:55:58 -0300
Message-Id: <8a7e8fa26c2997d9286174da78e2d85b46e0626a.1577681164.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577681164.git.dwlsalmeida@gmail.com>
References: <cover.1577681164.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert nfsd-admin-interfaces to ReST and move it into admin-guide.
Content remains mostly untouched.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/nfs/index.rst       |  1 +
 .../nfs/nfsd-admin-interfaces.rst}            | 19 +++++++++----------
 2 files changed, 10 insertions(+), 10 deletions(-)
 rename Documentation/{filesystems/nfs/nfsd-admin-interfaces.txt => admin-guide/nfs/nfsd-admin-interfaces.rst} (70%)

diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index 498652a8b955..c73ba9c16b77 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -8,4 +8,5 @@ NFS
     nfs-client
     nfsroot
     nfs-rdma
+    nfsd-admin-interfaces
 
diff --git a/Documentation/filesystems/nfs/nfsd-admin-interfaces.txt b/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
similarity index 70%
rename from Documentation/filesystems/nfs/nfsd-admin-interfaces.txt
rename to Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
index 56a96fb08a73..7f8c64ad7632 100644
--- a/Documentation/filesystems/nfs/nfsd-admin-interfaces.txt
+++ b/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
@@ -1,5 +1,6 @@
+==================================
 Administrative interfaces for nfsd
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+==================================
 
 Note that normally these interfaces are used only by the utilities in
 nfs-utils.
@@ -13,18 +14,16 @@ nfsd/threads.
 Before doing that, NFSD can be told which sockets to listen on by
 writing to nfsd/portlist; that write may be:
 
-	- an ascii-encoded file descriptor, which should refer to a
-	  bound (and listening, for tcp) socket, or
-	- "transportname port", where transportname is currently either
-	  "udp", "tcp", or "rdma".
+	#. an ascii-encoded file descriptor, which should refer to a
+	   bound (and listening, for tcp) socket, or
+	#. "transportname port", where transportname is currently either
+	   "udp", "tcp", or "rdma".
 
 If nfsd is started without doing any of these, then it will create one
 udp and one tcp listener at port 2049 (see nfsd_init_socks).
 
-On startup, nfsd and lockd grace periods start.
-
-nfsd is shut down by a write of 0 to nfsd/threads.  All locks and state
-are thrown away at that point.
+On startup, nfsd and lockd grace periods start. nfsd is shut down by a write of
+0 to nfsd/threads.  All locks and state are thrown away at that point.
 
 Between startup and shutdown, the number of threads may be adjusted up
 or down by additional writes to nfsd/threads or by writes to
@@ -34,7 +33,7 @@ For more detail about files under nfsd/ and what they control, see
 fs/nfsd/nfsctl.c; most of them have detailed comments.
 
 Implementation notes
-^^^^^^^^^^^^^^^^^^^^
+====================
 
 Note that the rpc server requires the caller to serialize addition and
 removal of listening sockets, and startup and shutdown of the server.
-- 
2.24.1

