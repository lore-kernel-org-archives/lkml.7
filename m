Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152C7C2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51FE206E4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/J3wKOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfL3FFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 00:05:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34813 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfL3FE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 00:04:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id x17so14189204pln.1;
        Sun, 29 Dec 2019 21:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bGFOBTnjumQZE2kID8F6RH3CwsaMKHdPP5Y224cXIg=;
        b=A/J3wKOK3L5WTy8mt5B7Bn2RTq7etw1YqjFgPdqpMGjSc/oKafJ6pPosZdJK538zV0
         ZvZZXULnpWdMnsa5Et6ZLWsEVggxGCkghGxcpvypkk4rHzlgeAJIE0d1OTiOD1QZeUi1
         BtzDBu8Nnecvdt3IIXqMRXifQAhvj3VclAk7m+IKr/eaPWh1XSB/EJYIW+eNPZd88bO6
         m0pn6yiGBRwGPKc41wJaggZ4ddi5afNFmayqyhTBp9S/9JFrEWuclWmkEaVVrinX7dLu
         N2vQcZIZCe0j80NSnb9Jjf5ikWaqXvER/7Or/PRB/RM4EzBX0NKpeVj3HFPRMbgoR7Fu
         S92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bGFOBTnjumQZE2kID8F6RH3CwsaMKHdPP5Y224cXIg=;
        b=ovczHdLdUmcPBBWnpsYJBvcJXPreKaBM0zBFFVlkAegDchNnyGgdQTDTb4TFyc7cm/
         8dFszo/BNF+BjwxnbyBuw9mmanhMoZGNTwG+Wkjfc0ziTscRxU1PvWVj2ZVsbs11Gtre
         e+STyPPSGC+kVPa7ytHkE10QmOe0rlwjNtaJlmQyUzzyY4zC2zkhCtLO56b9iJ6K7uBX
         J/g6cwV0h3b7k5/BTn3RlG7VKUVIlWHwkZCWFWj9cVTOptahVBaEdUmgZ+0iqn0f00tO
         OsLttQcFuc4p9pSc3asJj4wjYvApFt0Jakw9tgSzn0Cr/WMryewT9w5P6AlLEFIrxOkV
         LgLQ==
X-Gm-Message-State: APjAAAX2RUnPfKMWkRnNAWVkPntjSJVtxdKa8DAXxClvhj0EcXBxk/ZM
        4mM5cXAsMxfqZpgRTlh0tbU=
X-Google-Smtp-Source: APXvYqwyDvbObIx9HmuX7qwlep0GnZzAKgwzOP+Xd5qu3gfwnklrFxw2msL5DLrJBLXw9Vlr8p05qA==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4mr66088386plo.291.1577682298168;
        Sun, 29 Dec 2019 21:04:58 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id r2sm45054727pgv.16.2019.12.29.21.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 21:04:57 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 1/5] Documentation: nfs: convert pnfs.txt to ReST
Date:   Mon, 30 Dec 2019 02:04:43 -0300
Message-Id: <1523c9b99c383c789c3ae943987b2d700377b979.1577681894.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577681894.git.dwlsalmeida@gmail.com>
References: <cover.1577681894.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert pnfs.txt to ReST. Content remains mostly unchanged.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/filesystems/index.rst           |  1 +
 Documentation/filesystems/nfs/index.rst       |  9 +++++++
 .../filesystems/nfs/{pnfs.txt => pnfs.rst}    | 25 +++++++++++--------
 3 files changed, 25 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/index.rst
 rename Documentation/filesystems/nfs/{pnfs.txt => pnfs.rst} (87%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index ad6315a48d14..801d773a44b9 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -48,3 +48,4 @@ Documentation for filesystem implementations.
 
    autofs
    virtiofs
+   nfs/index
diff --git a/Documentation/filesystems/nfs/index.rst b/Documentation/filesystems/nfs/index.rst
new file mode 100644
index 000000000000..d19ba592779a
--- /dev/null
+++ b/Documentation/filesystems/nfs/index.rst
@@ -0,0 +1,9 @@
+===============================
+NFS
+===============================
+
+
+.. toctree::
+   :maxdepth: 1
+
+   pnfs
diff --git a/Documentation/filesystems/nfs/pnfs.txt b/Documentation/filesystems/nfs/pnfs.rst
similarity index 87%
rename from Documentation/filesystems/nfs/pnfs.txt
rename to Documentation/filesystems/nfs/pnfs.rst
index 80dc0bdc302a..7c470ecdc3a9 100644
--- a/Documentation/filesystems/nfs/pnfs.txt
+++ b/Documentation/filesystems/nfs/pnfs.rst
@@ -1,15 +1,17 @@
-Reference counting in pnfs:
+==========================
+Reference counting in pnfs
 ==========================
 
 The are several inter-related caches.  We have layouts which can
 reference multiple devices, each of which can reference multiple data servers.
 Each data server can be referenced by multiple devices.  Each device
-can be referenced by multiple layouts.  To keep all of this straight,
+can be referenced by multiple layouts. To keep all of this straight,
 we need to reference count.
 
 
 struct pnfs_layout_hdr
-----------------------
+======================
+
 The on-the-wire command LAYOUTGET corresponds to struct
 pnfs_layout_segment, usually referred to by the variable name lseg.
 Each nfs_inode may hold a pointer to a cache of these layout
@@ -25,7 +27,8 @@ the reference count, as the layout is kept around by the lseg that
 keeps it in the list.
 
 deviceid_cache
---------------
+==============
+
 lsegs reference device ids, which are resolved per nfs_client and
 layout driver type.  The device ids are held in a RCU cache (struct
 nfs4_deviceid_cache).  The cache itself is referenced across each
@@ -38,24 +41,26 @@ justification, but seems reasonable given that we can have multiple
 deviceid's per filesystem, and multiple filesystems per nfs_client.
 
 The hash code is copied from the nfsd code base.  A discussion of
-hashing and variations of this algorithm can be found at:
-http://groups.google.com/group/comp.lang.c/browse_thread/thread/9522965e2b8d3809
+hashing and variations of this algorithm can be found `here.
+<http://groups.google.com/group/comp.lang.c/browse_thread/thread/9522965e2b8d3809>`_
 
 data server cache
------------------
+=================
+
 file driver devices refer to data servers, which are kept in a module
 level cache.  Its reference is held over the lifetime of the deviceid
 pointing to it.
 
 lseg
-----
+====
+
 lseg maintains an extra reference corresponding to the NFS_LSEG_VALID
 bit which holds it in the pnfs_layout_hdr's list.  When the final lseg
 is removed from the pnfs_layout_hdr's list, the NFS_LAYOUT_DESTROYED
 bit is set, preventing any new lsegs from being added.
 
 layout drivers
---------------
+==============
 
 PNFS utilizes what is called layout drivers. The STD defines 4 basic
 layout types: "files", "objects", "blocks", and "flexfiles". For each
@@ -68,6 +73,6 @@ Blocks-layout-driver code is in: fs/nfs/blocklayout/.. directory
 Flexfiles-layout-driver code is in: fs/nfs/flexfilelayout/.. directory
 
 blocks-layout setup
--------------------
+===================
 
 TODO: Document the setup needs of the blocks layout driver
-- 
2.24.1

