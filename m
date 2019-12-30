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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DB0C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 04:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A4E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 04:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqyeeOAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfL3E4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 23:56:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44822 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfL3E4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 23:56:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id az3so14162618plb.11;
        Sun, 29 Dec 2019 20:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UKYzkJmn43x5CDYs8QtDG9L2pvD3Vr420sYEsSqBq+w=;
        b=KqyeeOASvfyy32tYw5yo/OLxFTEbzNzO8X26K9EbBduFJRUFgGKc+EzI5NstL17vj7
         EQ3BSdovcPcfWkdl2AmUaYw3xld9d2b3Db7BZMddlP1dpkCZE9nK9rRt4LlVsTUHRvmO
         1wvHTbA8y4SrXZ2OhsSV1pOWlLnoMKMC3UJBE6lXHn4fGDqjjYrdyUog+rClsphZ+vZ3
         tu5/ugCa805B+1XlVBAHoCysAvi/dvN5sfc3+2ou5ph/rEC2So79uQwJHVc5YeJO6QY8
         piza+H/DHRqgzHZsHi1xpTYvSgtOD1NaRCSCy8LdOHikOC4UZMe+OXnGMEYpfxosyORv
         0DSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKYzkJmn43x5CDYs8QtDG9L2pvD3Vr420sYEsSqBq+w=;
        b=I/YMKC65jHESOPPtRxfYcMbeGcx1iTf7EkGZZ/D+2r4T7D8MzUAYV+y+fJj23ijKWe
         OU8aota/cckfOaReO9GdMUWKRfiPURHhFq0dx+23YoRbsybIXtGMQr3CMSG9QaJOYTif
         wFVjpTWS5RCqeARBv47YDn1xl4baMAIcty0/RMyzlE2TctsNUNxAWQN1wI2h56u/M13V
         0vp6XSk4eCaBxEeZkT1wl47J1SLgkeKtlY+WfXvzl6jqe3aqMS7bl3WyH6rgZt3nkXQu
         xgTvVyKkoOnMkgwKuJU+yETHa7iC7ulKw0wUxRRvzsxe7MScYaV/EuifQ4/veS3LtNGj
         IezA==
X-Gm-Message-State: APjAAAXwo2CBkSncM1lYjxXfE+4eVdZAETV71GQk/TUNTmjgfHrXL6BO
        NY+ZZFf/cEzog+VSzsTI6BA=
X-Google-Smtp-Source: APXvYqxVxdmvh0X/bPKt4pCt7OhiiEdzghkZ6BOH2gYZAlobIy0nn3trPdfeiGL6uRzDCjKS/KCWsA==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr45605013pje.9.1577681796767;
        Sun, 29 Dec 2019 20:56:36 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id b1sm22373189pjw.4.2019.12.29.20.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 20:56:36 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 6/8] Documentation: nfs: convert pnfs-block-server to ReST
Date:   Mon, 30 Dec 2019 01:56:00 -0300
Message-Id: <549bf486ec209a1e119b6e00b05f7034bf98b8fd.1577681164.git.dwlsalmeida@gmail.com>
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

Convert pnfs-block-server.txt to ReST and move it to admin-guide.
Content remains mostly unchanged.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/nfs/index.rst       |  1 +
 .../nfs/pnfs-block-server.rst}                | 25 +++++++++++--------
 2 files changed, 16 insertions(+), 10 deletions(-)
 rename Documentation/{filesystems/nfs/pnfs-block-server.txt => admin-guide/nfs/pnfs-block-server.rst} (80%)

diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index c90fd5ebc640..f3bfd0f5a362 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -10,4 +10,5 @@ NFS
     nfs-rdma
     nfsd-admin-interfaces
     nfs-idmapper
+    pnfs-block-server
 
diff --git a/Documentation/filesystems/nfs/pnfs-block-server.txt b/Documentation/admin-guide/nfs/pnfs-block-server.rst
similarity index 80%
rename from Documentation/filesystems/nfs/pnfs-block-server.txt
rename to Documentation/admin-guide/nfs/pnfs-block-server.rst
index 2143673cf154..b00a2e705cc4 100644
--- a/Documentation/filesystems/nfs/pnfs-block-server.txt
+++ b/Documentation/admin-guide/nfs/pnfs-block-server.rst
@@ -1,4 +1,6 @@
+===================================
 pNFS block layout server user guide
+===================================
 
 The Linux NFS server now supports the pNFS block layout extension.  In this
 case the NFS server acts as Metadata Server (MDS) for pNFS, which in addition
@@ -22,16 +24,19 @@ If the nfsd server needs to fence a non-responding client it calls
 /sbin/nfsd-recall-failed with the first argument set to the IP address of
 the client, and the second argument set to the device node without the /dev
 prefix for the file system to be fenced. Below is an example file that shows
-how to translate the device into a serial number from SCSI EVPD 0x80:
+how to translate the device into a serial number from SCSI EVPD 0x80::
 
-cat > /sbin/nfsd-recall-failed << EOF
-#!/bin/sh
+	cat > /sbin/nfsd-recall-failed << EOF
 
-CLIENT="$1"
-DEV="/dev/$2"
-EVPD=`sg_inq --page=0x80 ${DEV} | \
-	grep "Unit serial number:" | \
-	awk -F ': ' '{print $2}'`
+.. code-block:: sh
 
-echo "fencing client ${CLIENT} serial ${EVPD}" >> /var/log/pnfsd-fence.log
-EOF
+	#!/bin/sh
+
+	CLIENT="$1"
+	DEV="/dev/$2"
+	EVPD=`sg_inq --page=0x80 ${DEV} | \
+		grep "Unit serial number:" | \
+		awk -F ': ' '{print $2}'`
+
+	echo "fencing client ${CLIENT} serial ${EVPD}" >> /var/log/pnfsd-fence.log
+	EOF
-- 
2.24.1

