Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE30C2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA242073D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZAIxjjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgAAW0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 17:26:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33546 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgAAW0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 17:26:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so21034803pgk.0;
        Wed, 01 Jan 2020 14:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vvp0BLAgFmMstADpwknIGqQeBNz6XeE37rhf2QOsEEA=;
        b=vZAIxjjQV8gkhnAAQl7V2yA2SnUFQ4KkbF/xOnGu4VPVkVq38ZX8R1e0mE3XOnUL7b
         ihTfrwevnvDOaO24DR0d38ILCyxoNNpdwkXiVHcLXmRn4sXFr0vrpDF/EG6lMbCXpWUG
         92Ha0/cWkQn6SsajB4/4HDDcaJqsS88mitBHDtPLbwOoCgOAME3tQ6HH+nFVDgdEGPCc
         KDG47dsrIlkBWWxnGO/8d4kNs9K/iSHPpKrzPV8LnCYUSunqbyW71TbHZMIUmbtvp7FM
         gJohMatXVk5PBBz+KHfMHDiHTy53QHVvW9QTXuCi8EWRD4C3fdLlWEK2RuxrOUdqCu7Z
         K7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvp0BLAgFmMstADpwknIGqQeBNz6XeE37rhf2QOsEEA=;
        b=kderMYwBf4Jc78jhMwToFK0WfPU+WpssLp6dXeEWBN9Qw969oEXip/81UU1vkZoQrF
         mzHRuY7kRj5EaMYpN9fsmibSsgiTbl4yIKdsh/nfaD4ftMQpn72aST+pSiRqMrThe0Rh
         x0q+ZvDs9krMWqEsJxHYWgAsnVsh+b/+jX+zv0TS6/K5Z3KXRWzvXiG3s55ihYsoihFg
         4w+JvJqBT9d33GSWTJE8WuGv5dKcKiopOiSaSUJBIFNRzpfk5fG8KOM6cLYS61ygdCuW
         5Hbp0f0R5Q2/iQSb525cE7NMCB5lpaiiibSt6L6UrLH0QyYrDrDtJcVKMLcEdp1xt/s0
         neQg==
X-Gm-Message-State: APjAAAVn6SSXdm8gc0TP5d2qExg8PnSQTj8tovg67W8tqeHR/QD0FU0y
        hupaiuaqO+nqydFChHcZTNo=
X-Google-Smtp-Source: APXvYqw14kQc32Mxm2YZY+VI67AeiNvEeDPUD95vlraB+nYfY3DEW88MiMwQL082JTIbub/cwOCg0A==
X-Received: by 2002:a63:7985:: with SMTP id u127mr84556151pgc.169.1577917598239;
        Wed, 01 Jan 2020 14:26:38 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id o2sm8601008pjo.26.2020.01.01.14.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 14:26:37 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 4/8] Documentation: convert nfsd-admin-interfaces to ReST
Date:   Wed,  1 Jan 2020 19:26:11 -0300
Message-Id: <fc0b54cbbd0afb020af5d979593c8e78f9b5cf6b.1577917076.git.dwlsalmeida@gmail.com>
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
index 56a96fb08a73..c05926f79054 100644
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
+	-  an ascii-encoded file descriptor, which should refer to a
+	   bound (and listening, for tcp) socket, or
+	-  "transportname port", where transportname is currently either
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

