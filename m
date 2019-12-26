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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5DFC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D612080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 21:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e62A4buC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLZVUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:20:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45042 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZVUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:20:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id 195so12879335pfw.11;
        Thu, 26 Dec 2019 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dY9unxVIr1tFCym7yEPAegK01Wyg01REeRtJSgLyB00=;
        b=e62A4buCJwDHSPVeiCSxDlpKyfiiED9P87mPFxNntgvFW7UAX/wkYEkGSOSDXq5CYM
         nlHyReskbdm/Ky5tuM7JfWK9mmR/ux863AZobyvpsQ7K4v/K/SDl0YOYXeix1SHq3Mpz
         0Bf7NpLKggNvBXVqlvBsM4I36W9y2+DrBs/OZ2/b8wjCcs6p/y4F2/zXs4jQJFLiku0m
         ueXq1flKOPw3CNZUiHWwS9azyYbLvw3lDJ8r2eA9gEC+tq5O9yuj0DlPe6F/l0VMupdt
         4H7BB+JRDksC9ZUGv9nUrgOaBEYsD3ROYN1UTv+pyE1mPKk99k5Y8J0/T1dLAr1ayJvu
         pzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dY9unxVIr1tFCym7yEPAegK01Wyg01REeRtJSgLyB00=;
        b=McI1hu9zxVOEW0XZ+Mc7Cg0YGZAjNjcUIvXC4p8IHRWZz40NOKUhEYQQki7McxCY5T
         5wuM8cTaHBjyV60qU5Z8SkAn5lo4A3DgSfKqZtbWiP6XYZVazCnZjLWc/U/EmslRyWhx
         E3GgPh9e1jmIxCJubxTRFJ0FcHNHQSdyoO7swOIy0JcRjVFGK68xPRyzMOD0TQ5FIuyJ
         mp87chQPlAYEOsovsfPhj3j2nQm0gWQMLkCCofgatsPbl9EnMg69cFHhMTrP0WjiK8Nr
         BTrk5aVeoLFrMQLskOdyINi5+73MSJaK3GuusnaGAadMPAuazpFhaNh4Ht1VWBr8Imeg
         ZNiQ==
X-Gm-Message-State: APjAAAX2QZy0QduYmRwiLOEWfKdOJrauHvRLMrw/t1bWcqNyqSK20fc6
        pH4e1acQim5oFyh28TdsziU=
X-Google-Smtp-Source: APXvYqw2R+rwkvIyso94ZmcED55KP1/KUKsBv96avH2fhB1Pdu8PT26eTzifpdiF6MmgHWXBCCnfNw==
X-Received: by 2002:a63:1c64:: with SMTP id c36mr45435120pgm.302.1577395200912;
        Thu, 26 Dec 2019 13:20:00 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id b22sm35114380pft.110.2019.12.26.13.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 13:20:00 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 1/5] Documentation: convert nfs.txt to ReST
Date:   Thu, 26 Dec 2019 18:19:43 -0300
Message-Id: <ddeb8a98f4c5c24df2f36e1ce1cc5ab4da6442a1.1577394517.git.dwlsalmeida@gmail.com>
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

