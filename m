Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B23C49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421C1206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393836AbfIJPMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:12:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393533AbfIJPMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:12:14 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 724246B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 15:12:13 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j3so9125820wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 08:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSOkXb+4n41IQ7rb1yCCg1lplHz8vVOIe/36QDFuHJ4=;
        b=ICh+fclT42/PDFlSGwixRXsvXY0zTDXVjenV/LDH7QRLM0qwNGEeVhBOIPgJAFH3td
         H8Qbwk9WfnQ8Ba/Xgtv0kJkBwERpSqoebMukKbVZwJg6/s7x7saExYVT4HbDmsjl9juI
         dd5US1OXka+HXUg5zZJq7nt2iyyB5jpq0eBt1q3t84QjQaDmcWbjUcAWq6bgsIA9J5qQ
         jTRab8b77EFWFvV16joomYBwU9Yg1Ji/2eBuzngbpidp0ilu8cEbVjqqeUlZxjRDozXq
         nZ0lNIxYpSrK8UIH4JgjkYK2frZAJnjvSNSs8OaIV8f8S4mxze1HX/oU4EPMHDoPf8NM
         gGBg==
X-Gm-Message-State: APjAAAWbmFkLk93M34wsvVb3AS8Xwu33fxJtKlwdYs4Lp4dnNO7tj+Wa
        qcmbmbO9vOAoDD7OXPVoLDW0+YsyHmizsjweX+ZZdB+dmnpwmIsjthsTSG3Mfos++L30w32+Fdg
        +kguIJ/Km7URYD8Y9+QGEtmob
X-Received: by 2002:a5d:6506:: with SMTP id x6mr7281381wru.22.1568128332244;
        Tue, 10 Sep 2019 08:12:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwXr+uOzJ0xtcZ7H7FinsN7Gy/CfXxo3LAxAJTWISvP2sJ8X1DYredCAefZDN1iOTnXkIYDRA==
X-Received: by 2002:a5d:6506:: with SMTP id x6mr7281363wru.22.1568128332063;
        Tue, 10 Sep 2019 08:12:12 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id g185sm12803wme.10.2019.09.10.08.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 08:12:11 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH v5 2/4] fuse: reserve values for mapping protocol
Date:   Tue, 10 Sep 2019 17:12:04 +0200
Message-Id: <20190910151206.4671-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910151206.4671-1-mszeredi@redhat.com>
References: <20190910151206.4671-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

SETUPMAPPING is a command for use with 'virtiofsd', a fuse-over-virtio
implementation; it may find use in other fuse impelementations as well in
which the kernel does not have access to the address space of the daemon
directly.

A SETUPMAPPING operation causes a section of a file to be mapped into a
memory window visible to the kernel.  The offsets in the file and the
window are defined by the kernel performing the operation.

The daemon may reject the request, for reasons including permissions and
limited resources.

When a request perfectly overlaps a previous mapping, the previous mapping
is replaced.  When a mapping partially overlaps a previous mapping, the
previous mapping is split into one or two smaller mappings.

REMOVEMAPPING is the complement to SETUPMAPPING; it unmaps a range of
mapped files from the window visible to the kernel.

The map_alignment field communicates the alignment constraint for
FUSE_SETUPMAPPING/FUSE_REMOVEMAPPING and allows the daemon to constrain the
addresses and file offsets chosen by the kernel.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/uapi/linux/fuse.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index df2e12fb3381..802b0377a49e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -133,6 +133,8 @@
  *
  *  7.31
  *  - add FUSE_WRITE_KILL_PRIV flag
+ *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
+ *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -274,6 +276,7 @@ struct fuse_file_lock {
  * FUSE_CACHE_SYMLINKS: cache READLINK responses
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
+ * FUSE_MAP_ALIGNMENT: map_alignment field is valid
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -301,6 +304,7 @@ struct fuse_file_lock {
 #define FUSE_CACHE_SYMLINKS	(1 << 23)
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
+#define FUSE_MAP_ALIGNMENT	(1 << 26)
 
 /**
  * CUSE INIT request/reply flags
@@ -422,6 +426,8 @@ enum fuse_opcode {
 	FUSE_RENAME2		= 45,
 	FUSE_LSEEK		= 46,
 	FUSE_COPY_FILE_RANGE	= 47,
+	FUSE_SETUPMAPPING	= 48,
+	FUSE_REMOVEMAPPING	= 49,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -656,7 +662,7 @@ struct fuse_init_out {
 	uint32_t	max_write;
 	uint32_t	time_gran;
 	uint16_t	max_pages;
-	uint16_t	padding;
+	uint16_t	map_alignment;
 	uint32_t	unused[8];
 };
 
-- 
2.21.0

