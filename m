Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEFFFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990E72084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="WoD1xaYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbfKHUHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:07:48 -0500
Received: from alln-iport-2.cisco.com ([173.37.142.89]:4873 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbfKHUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:07:48 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 15:07:46 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3146; q=dns/txt; s=iport;
  t=1573243666; x=1574453266;
  h=from:to:cc:subject:date:message-id;
  bh=DrRVxIIRXdAFmb4wXgTdIy5Gpr7D2ps+wz38/V+1l6k=;
  b=WoD1xaYxz7DhpEzNZ6ngsmK1LdUe7ZytATDVDnczxKttpR3n1Bc7HBLf
   bT7YTDVvS+QYW+0rUH7tsKYWF+T3C3m89KdPZyRUv5Q/QbHnIElJKjWf3
   C97D1dHxY01FMcwtxZH08N//1M2kNxXvy0Ymr1Y1S/7Ixu7eigZlUGyGN
   Y=;
X-IronPort-AV: E=Sophos;i="5.68,283,1569283200"; 
   d="scan'208";a="368687233"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 Nov 2019 20:00:41 +0000
Received: from zorba.cisco.com ([10.24.83.59])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id xA8K0eEc022208;
        Fri, 8 Nov 2019 20:00:40 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     "yusun2@cisco.com" <yusun2@cisco.com>, xe-linux-external@cisco.com,
        Daniel Walker <dwalker@fifo99.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fs/squashfs: Make SquashFS xz initialization mode configurable
Date:   Fri,  8 Nov 2019 12:00:39 -0800
Message-Id: <20191108200040.20259-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.83.59, [10.24.83.59]
X-Outbound-Node: alln-core-11.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "yusun2@cisco.com" <yusun2@cisco.com>

Make SquashFS xz initialization mode configurable to be either
XZ_PREALLOC or XZ_DYNALLOC. The default mode is XZ_PREALLOC.

SquashFS multi-threaded per-CPU decompressor is proven to
effectively resolve the I/O bottleneck and boost the outcome
of other boot time optimization technologies on some I/O bound
platforms. However it allocates extra memory on per-processor
per-mounted-package basis. Making XZ_DYNALLOC mode an option
for the xz decompressor initialization in SquashFS minimizes
the memory impact.

Signed-off-by: Yu Sun <yusun2@cisco.com>
Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <dwalker@fifo99.com>
---
 fs/squashfs/Kconfig      | 32 ++++++++++++++++++++++++++++++++
 fs/squashfs/xz_wrapper.c |  6 +++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/Kconfig b/fs/squashfs/Kconfig
index 916e78fabcaa..9cf2ebf89374 100644
--- a/fs/squashfs/Kconfig
+++ b/fs/squashfs/Kconfig
@@ -223,3 +223,35 @@ config SQUASHFS_FRAGMENT_CACHE_SIZE
 
 	  Note there must be at least one cached fragment.  Anything
 	  much more than three will probably not make much difference.
+
+choice
+    prompt "XZ decompressor operation mode"
+    depends on SQUASHFS_XZ
+    default SQUASHFS_XZ_DICT_PREALLOC
+    help
+      Squashfs now utilizes the two different multi-call modes of xz
+      decompression. They each exhibits various trade-offs between
+      decompression performance and memory consumption.
+
+      If in doubt, select "XZ preallocated multi-call mode"
+
+config SQUASHFS_XZ_DICT_PREALLOC
+    bool "XZ preallocated multi-call mode"
+    help
+      Traditionally Squashfs has used XZ_PREALLOC operation mode for
+      xz decompression, under which the xz dictionary buffer is allocated
+      at initialization.
+
+config SQUASHFS_XZ_DICT_DYNALLOC
+    bool "XZ dynamic-allocated multi-call mode"
+    help
+      By default Squashfs uses XZ_PREALLOC operation mode for xz decompressor.
+      This, however, potentially lead to significant increase of memory
+      consumption, especially when SquashFS per-cpu multi-threaded
+      decompressor is applied.
+
+      If the system has memory constraints, setting this option will force
+      SquashFS to use XZ_DYNALLOC mode, and thus reduce memory footprint.
+      In this case, the LZMA2 dictionary is allocated upon needed with the
+      required size.
+endchoice
diff --git a/fs/squashfs/xz_wrapper.c b/fs/squashfs/xz_wrapper.c
index 4b2f2051a6dc..6d6946bb5e4c 100644
--- a/fs/squashfs/xz_wrapper.c
+++ b/fs/squashfs/xz_wrapper.c
@@ -90,7 +90,11 @@ static void *squashfs_xz_init(struct squashfs_sb_info *msblk, void *buff)
 		goto failed;
 	}
 
-	stream->state = xz_dec_init(XZ_PREALLOC, comp_opts->dict_size);
+	if (IS_ENABLED(CONFIG_SQUASHFS_XZ_DICT_DYNALLOC)) {
+	    stream->state = xz_dec_init(XZ_DYNALLOC, comp_opts->dict_size);
+	} else {
+	    stream->state = xz_dec_init(XZ_PREALLOC, comp_opts->dict_size);
+	}
 	if (stream->state == NULL) {
 		kfree(stream);
 		err = -ENOMEM;
-- 
2.17.1

