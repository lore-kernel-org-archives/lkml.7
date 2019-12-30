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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB84C2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 04:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C748C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 04:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhx9yGrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfL3E4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 23:56:18 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38311 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfL3E4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 23:56:17 -0500
Received: by mail-pj1-f68.google.com with SMTP id l35so7606500pje.3;
        Sun, 29 Dec 2019 20:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dY9unxVIr1tFCym7yEPAegK01Wyg01REeRtJSgLyB00=;
        b=Nhx9yGrk/hiwe8aILWqRgvfXThj0aKHy6BnIgETzV8XYxGFzZsHf9Brvb3qiEBJRUs
         TZhr3vPPWJUyUYpN0XxRHZ0uk00jr0PjXAdNqN6A1hdDpDPMByZrSAKdfC2HbxiXGPQG
         Q1gv28vYYIBpJpeOAjuPWDOE3O9HblDrJsofmjqhnZ+3TsWZwOR2c47U1GS7w0yHKXDf
         B8vcN44BZmbpNy2HqH2plxG+lPTRomP4jAJfil19YGL3vbAmlN/dkl7nHi0OXAUOfVOK
         7as00zT1BawyjhX99PFgKqiA5EmxTD1pfkEdBI0FJiZ/1TH0meiXqUoWZbCK5h5BhENz
         yzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dY9unxVIr1tFCym7yEPAegK01Wyg01REeRtJSgLyB00=;
        b=g7oTqSyllJngtTmhl4bDFpeKZ0xFiFQ+rkiTm+ZGpXUo8XBQCRhgIHbrWS0emJ6uJH
         u9i78/mFWk3PxdOEGYjCAnmD1/EECAN8GYvTWQvAECPa7nuAqJlOBM1Rt0RlibCTA2mU
         oGe7lg8htRhoXTNFnTLPJSFGno94qQl4swJFLEThq5xS6kzp3F5v9dklEa0PgAoEvQUl
         XR+HvEQ77KoGm9elS3AemkBZXc5+rBjAla1Pe5aQP7LEeLHMkLDc1sBc78PFzGjxFU9H
         j6Qhd6y8yB16/ly35Ft87v6NDr24CspDB4glj7ZbqVHgjYXkcIdQDAAsTfpejLI3F5d6
         fq3Q==
X-Gm-Message-State: APjAAAUJmPMlkgTmkkd9ci3+0eOWKJslW8RNQDBQpS012WXcvoA6omCV
        RwIFeY5C3MamABMSl1wlXV8=
X-Google-Smtp-Source: APXvYqxH3MqnmjsN2hFwerrUYmPPPY8LNaFO92h/3dT3MlrFw03H7ieID0ljV03KUaP/PmilRPipNg==
X-Received: by 2002:a17:90b:142:: with SMTP id em2mr43611360pjb.4.1577681776431;
        Sun, 29 Dec 2019 20:56:16 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id b1sm22373189pjw.4.2019.12.29.20.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 20:56:16 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 1/8] Documentation: convert nfs.txt to ReST
Date:   Mon, 30 Dec 2019 01:55:55 -0300
Message-Id: <ddeb8a98f4c5c24df2f36e1ce1cc5ab4da6442a1.1577681164.git.dwlsalmeida@gmail.com>
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

This patch converts nfs.txt to RST. It also moves it to admin-guide.
The reason for moving it is because this document contains information
useful for system administrators, as noted on the following paragraph:

'The purpose of this document is to provide information on some of the
special features of the NFS client that can be configured by system
administrators'.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/index.rst           |  1 +
 Documentation/admin-guide/nfs/index.rst       |  9 ++
 .../nfs/nfs-client.rst}                       | 91 ++++++++++---------
 3 files changed, 58 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/admin-guide/nfs/index.rst
 rename Documentation/{filesystems/nfs/nfs.txt => admin-guide/nfs/nfs-client.rst} (72%)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 4405b7485312..4433f3929481 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -76,6 +76,7 @@ configure specific aspects of kernel behavior to your liking.
    device-mapper/index
    efi-stub
    ext4
+   nfs/index
    gpio/index
    highuid
    hw_random
diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
new file mode 100644
index 000000000000..f5c0180f4e5e
--- /dev/null
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -0,0 +1,9 @@
+=============
+NFS
+=============
+
+.. toctree::
+    :maxdepth: 1
+
+    nfs-client
+
diff --git a/Documentation/filesystems/nfs/nfs.txt b/Documentation/admin-guide/nfs/nfs-client.rst
similarity index 72%
rename from Documentation/filesystems/nfs/nfs.txt
rename to Documentation/admin-guide/nfs/nfs-client.rst
index f2571c8bef74..f01bf6a6c207 100644
--- a/Documentation/filesystems/nfs/nfs.txt
+++ b/Documentation/admin-guide/nfs/nfs-client.rst
@@ -1,3 +1,6 @@
+==========
+NFS Client
+==========
 
 The NFS client
 ==============
@@ -59,10 +62,11 @@ The DNS resolver
 
 NFSv4 allows for one server to refer the NFS client to data that has been
 migrated onto another server by means of the special "fs_locations"
-attribute. See
-	http://tools.ietf.org/html/rfc3530#section-6
-and
-	http://tools.ietf.org/html/draft-ietf-nfsv4-referrals-00
+attribute. See `RFC3530 Section 6: Filesystem Migration and Replication`_ and
+`Implementation Guide for Referrals in NFSv4`_.
+
+.. _RFC3530 Section 6\: Filesystem Migration and Replication: http://tools.ietf.org/html/rfc3530#section-6
+.. _Implementation Guide for Referrals in NFSv4: http://tools.ietf.org/html/draft-ietf-nfsv4-referrals-00
 
 The fs_locations information can take the form of either an ip address and
 a path, or a DNS hostname and a path. The latter requires the NFS client to
@@ -72,16 +76,16 @@ upcall to allow userland to provide this service.
 Assuming that the user has the 'rpc_pipefs' filesystem mounted in the usual
 /var/lib/nfs/rpc_pipefs, the upcall consists of the following steps:
 
-   (1) The process checks the dns_resolve cache to see if it contains a
+   #.  The process checks the dns_resolve cache to see if it contains a
        valid entry. If so, it returns that entry and exits.
 
-   (2) If no valid entry exists, the helper script '/sbin/nfs_cache_getent'
+   #.  If no valid entry exists, the helper script '/sbin/nfs_cache_getent'
        (may be changed using the 'nfs.cache_getent' kernel boot parameter)
        is run, with two arguments:
-		- the cache name, "dns_resolve"
-		- the hostname to resolve
+       - the cache name, "dns_resolve"
+       - the hostname to resolve
 
-   (3) After looking up the corresponding ip address, the helper script
+   #.  After looking up the corresponding ip address, the helper script
        writes the result into the rpc_pipefs pseudo-file
        '/var/lib/nfs/rpc_pipefs/cache/dns_resolve/channel'
        in the following (text) format:
@@ -94,43 +98,44 @@ Assuming that the user has the 'rpc_pipefs' filesystem mounted in the usual
        script, and <ttl> is the 'time to live' of this cache entry (in
        units of seconds).
 
-       Note: If <ip address> is invalid, say the string "0", then a negative
-       entry is created, which will cause the kernel to treat the hostname
-       as having no valid DNS translation.
+       .. note::
+            If <ip address> is invalid, say the string "0", then a negative
+            entry is created, which will cause the kernel to treat the hostname
+            as having no valid DNS translation.
 
 
 
 
 A basic sample /sbin/nfs_cache_getent
 =====================================
-
-#!/bin/bash
-#
-ttl=600
-#
-cut=/usr/bin/cut
-getent=/usr/bin/getent
-rpc_pipefs=/var/lib/nfs/rpc_pipefs
-#
-die()
-{
-	echo "Usage: $0 cache_name entry_name"
-	exit 1
-}
-
-[ $# -lt 2 ] && die
-cachename="$1"
-cache_path=${rpc_pipefs}/cache/${cachename}/channel
-
-case "${cachename}" in
-	dns_resolve)
-		name="$2"
-		result="$(${getent} hosts ${name} | ${cut} -f1 -d\ )"
-		[ -z "${result}" ] && result="0"
-		;;
-	*)
-		die
-		;;
-esac
-echo "${result} ${name} ${ttl}" >${cache_path}
-
+.. code-block:: sh
+
+    #!/bin/bash
+    #
+    ttl=600
+    #
+    cut=/usr/bin/cut
+    getent=/usr/bin/getent
+    rpc_pipefs=/var/lib/nfs/rpc_pipefs
+    #
+    die()
+    {
+        echo "Usage: $0 cache_name entry_name"
+        exit 1
+    }
+
+    [ $# -lt 2 ] && die
+    cachename="$1"
+    cache_path=${rpc_pipefs}/cache/${cachename}/channel
+
+    case "${cachename}" in
+        dns_resolve)
+            name="$2"
+            result="$(${getent} hosts ${name} | ${cut} -f1 -d\ )"
+            [ -z "${result}" ] && result="0"
+            ;;
+        *)
+            die
+            ;;
+    esac
+    echo "${result} ${name} ${ttl}" >${cache_path}
-- 
2.24.1

