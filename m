Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16957C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE21C20828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrvMr218"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLZVUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:20:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43132 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfLZVUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:20:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id k197so13422160pga.10;
        Thu, 26 Dec 2019 13:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2a6HXueWCHtUZD/OVDlDKAMCXfodyCrP/XbEG2O9ms=;
        b=WrvMr218GGZ17vftqRS4wzd8C4fVynYNZMTYVLgSFvqwPyezK62JOOWOaprrOiULz0
         bgA4g5gZD8sQgHm30LrzVuVLL7D0qQmEbbu+KY1VSYnpuNaooxJ6t1lVFroWYXz9YjKI
         kEs5m9/ds6lBQK25StSg4P/ogss3E3F4XbRPEs9WLewwl0ckgQ+hQm2iLIux4nQCUHFM
         jEaDnJX7TqDAzyUkjSzt3cExhFbHWa9AixKhPGWfw+3FC93TpdznZN6p2sx6D2PzPy33
         sr98kj2cOznnKe91QQbF5f4DwykvsXS+rsT8x1Ji65tPK+KDeLtKzRyTKvzq1K8A3FnM
         nUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2a6HXueWCHtUZD/OVDlDKAMCXfodyCrP/XbEG2O9ms=;
        b=HKHAnXuPNJ1FJ78POf7lOcBujtsOXOAwETF8QcFsG78yKqP+0wpJ6erewUxI2DXku7
         14x4s42aUTXjJgV3+LVtKt79JXRGOGuptd//XqLVSnoNSMuyuLS7QvYxzwKTVqihJwyg
         UTf8e3f7dSManchfqiivg5XCatKVA6oieoPyTUp4kdrWggh82HghXaOr8jvmQu4/2Hmy
         0q6S5do7YdAL/isv8nYv+xnackQg/9vRsaTljAgiMs+g2Or+8o4uMzpuKEq1gwMkcItm
         OLKDcPHrrIH31IwRvEO05Av2P0LXV4MnyIkhYPlmtJ4A5XTGfhIrnE3ZyWBr1/8pKM+3
         mv2A==
X-Gm-Message-State: APjAAAWJRup9a32RC96fDeOzMWbcG+uSruwBER4xezOTQAZ/fjdyf09n
        ESYiUx1uCCFVIk0n0oY2KEs=
X-Google-Smtp-Source: APXvYqzn/8ev5sGy5Qr7gF2CWYNqAHBd9UUWb77RjNgGi9/fFT7r7ix4cCLhxYgYvgDVBD7/uV3n3A==
X-Received: by 2002:a63:2e07:: with SMTP id u7mr50358853pgu.295.1577395216141;
        Thu, 26 Dec 2019 13:20:16 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id b22sm35114380pft.110.2019.12.26.13.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 13:20:15 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 4/5] Documentation: convert nfsd-admin-interfaces to ReST
Date:   Thu, 26 Dec 2019 18:19:46 -0300
Message-Id: <8a7e8fa26c2997d9286174da78e2d85b46e0626a.1577394517.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577394517.git.dwlsalmeida@gmail.com>
References: <cover.1577394517.git.dwlsalmeida@gmail.com>
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

