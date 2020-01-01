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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D82AC32764
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AFA2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 22:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp2EwJl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgAAW0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 17:26:47 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37710 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgAAW0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 17:26:45 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so2574327pjb.2;
        Wed, 01 Jan 2020 14:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UKYzkJmn43x5CDYs8QtDG9L2pvD3Vr420sYEsSqBq+w=;
        b=Pp2EwJl63ahhLhtXbpN+WK09YsZuRYDOAILFXVLQ5q4UvREamZBJGhnJMo/rRaJS25
         /aKCJsm6MssSAtPZxxUDkpBnf0nxDGllG5LmoqZVzdWxA7lW/gUJ7hfjfEfMDk3wtEqu
         KDKsQyIUl+sIHLU4rHTdzqG0Y/PJh5BgVmuyAei8X6+Z1Q53E7wESA0qFGKXSoqeMbDO
         Xo4fJeBE+LrmlK2HWJGBQKRP4eG/foeyIJGUOqJW4YMakMmEu4TTHwNJoW4OcSEXxm8L
         btlRGzo12qe1lZGwl97fXle7c6SVqWtnXCeiNUWsOBMvrQeUV61rNd8jVcVSrJG7IYAu
         xsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKYzkJmn43x5CDYs8QtDG9L2pvD3Vr420sYEsSqBq+w=;
        b=MRwiicN1bJ0py0t5QH/HxVD59j/KyaDZAroyPnFxruJqWApNBjGSxckfwdOiOER+Gw
         TF8XZkHO0y5zSfpye6oq9t9GflGwlwaOSPR+s+GT3waoPq0P+Gni6+visPk7Gu8nntRx
         KDs6jdaikSu8OJbAR+rEE+a58Z3PGSHJBWg3zEogkgGwi8fh2i6vxUsDRrelHJoNh+do
         E1eOdraaBbbpQ+7H2DC4LkPp4dhroh1CO1EfyJbKfWpEuqlFXq/z8mYuEFpf390E7efb
         1HY8tXO7n8RzjAhi/2LY4DlGNf3CbS9r8LO2tVNIVi4H5w5sbh46z09jBbPA/3xRMGtR
         8gdQ==
X-Gm-Message-State: APjAAAWBz6HANG3DsJdzzn1THxzy0VWQFMxM9VXKc327XhwHRP6GJbPF
        GAzPS/qQWRq7d1rKovZCW/s=
X-Google-Smtp-Source: APXvYqyZ2ZXvyFl5RI+CWSphG6g3BJgl+LQIhcMI7+XYmzfm1YzM2nvipwB0leEizFXYk7tTunv3SQ==
X-Received: by 2002:a17:90a:d50:: with SMTP id 16mr15930090pju.117.1577917605044;
        Wed, 01 Jan 2020 14:26:45 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id o2sm8601008pjo.26.2020.01.01.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 14:26:44 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 6/8] Documentation: nfs: convert pnfs-block-server to ReST
Date:   Wed,  1 Jan 2020 19:26:13 -0300
Message-Id: <a9df2212dbdc479413b1b796315b2c97d914d28f.1577917076.git.dwlsalmeida@gmail.com>
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

