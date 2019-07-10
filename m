Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACB2C73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 03:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA10A20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 03:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqdRCY7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfGJDpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 23:45:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34229 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfGJDpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 23:45:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so492266plt.1;
        Tue, 09 Jul 2019 20:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WD/fo/n7/D6683C31qtV50svSB0NMLB2BP0a6l6ucK0=;
        b=KqdRCY7oxdEUGZpL32XoMBrdBzXqlBCLGBYYsRMDGof5ivoIwj6lDDynGcfHuKLaFi
         U2nfRHDjbkuK+4JdkDOzizbkrtz03G57Lc7Gw2xpYPNxPAdw34WcQteRtIJL7J5bbRfu
         9dZIjWbNjp3RDDzSLuAzElT+hKk7iV2lzQ1j1OmYyc0uXATGuN1e2nfes6c7hA1Gw6nu
         sOepJFhlc4vt/E5T+ur/aU5oJxj2ybpWVK6IijNXp5hTEArpygvW7qe+FqZG1lztO3Vm
         jaPJmBxIQcm+t8IJ1V5RvKX1etuKfIcJh7uH1LsmTR15ij3lqJz8mHiOATYRKE1Uuqhw
         c5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WD/fo/n7/D6683C31qtV50svSB0NMLB2BP0a6l6ucK0=;
        b=Fn9ClcuhY4aTLiM5Pvl+9gqtuWSfiJj1hi6BvYc8oao6RBVwgFU8AY8j+H+1bSyHRE
         LcapqEoNKGxP1WwRcLzpW25d3n4h7n5/sNMaHRXVDjCJD9KHLgEQ088AH9sOt8XCKGpS
         BJuEfouYWMfEkpBKeLiCaWm/CQN2wI1QtK6xBnX+MJWfu4XbfxxE8P4IS14GTt735Lmk
         uhrlk3f4wP5dL4kzxrax5lLZMIdD1Bb0uqwCKCesiVCSZHF2kkLTbshy/QjL78M4qOOU
         FricxCPsrjDqrfAfSWHK4eoTcTfdgdvlDJehET6a6aKmx4boPA71k325SWtgIXsGYj+f
         LwQA==
X-Gm-Message-State: APjAAAXZk7al7Ya3R9FaDqoQyOXTm2KSSAv8bgRrD93u6fwVIJRor73b
        BHLyZbJFTSBmMErlu3R2wsUa9lsbK9M=
X-Google-Smtp-Source: APXvYqzixhYKzVnlTCpnOtm6iSR+wLXr/ihBjtg3FHALp8sDsQmi7Bx9Q8l7B1zS7X7Tm3z5LcfHdg==
X-Received: by 2002:a17:902:c509:: with SMTP id o9mr36800677plx.222.1562730298861;
        Tue, 09 Jul 2019 20:44:58 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id l124sm513500pgl.54.2019.07.09.20.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Jul 2019 20:44:58 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH v2] Documentation: filesystems: Convert ufs.txt to reStructuredText format
Date:   Tue,  9 Jul 2019 20:42:42 -0700
Message-Id: <1562730162-2116-1-git-send-email-shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190707013947.GA10663@t-1000>
References: <20190707013947.GA10663@t-1000>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation of ufs.txt to reStructuredText format.
Added to documentation build process and verified with make htmldocs

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
Changes in v2:
	1. Removed flat-table
	2. Moved ufs.rst to admin-guide
	
 Documentation/admin-guide/index.rst |  1 +
 Documentation/admin-guide/ufs.rst   | 48 +++++++++++++++++++++++++++++
 Documentation/filesystems/ufs.txt   | 60 -------------------------------------
 3 files changed, 49 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/admin-guide/ufs.rst
 delete mode 100644 Documentation/filesystems/ufs.txt

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 2871b79..9bfb076 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -71,6 +71,7 @@ configure specific aspects of kernel behavior to your liking.
    bcache
    ext4
    jfs
+   ufs
    pm/index
    thunderbolt
    LSM/index
diff --git a/Documentation/admin-guide/ufs.rst b/Documentation/admin-guide/ufs.rst
new file mode 100644
index 0000000..20b9c56
--- /dev/null
+++ b/Documentation/admin-guide/ufs.rst
@@ -0,0 +1,48 @@
+=========
+USING UFS
+=========
+
+mount -t ufs -o ufstype=type_of_ufs device dir
+
+UFS OPTIONS
+===========
+
+ufstype=type_of_ufs
+	UFS is a file system widely used in different operating systems.
+	The problem are differences among implementations. Features of
+	some implementations are undocumented, so its hard to recognize
+	type of ufs automatically. That's why user must specify type of 
+	ufs manually by mount option ufstype. Possible values are:
+
+	**old**	        old format of ufs default value, supported as read-only
+
+	**44bsd**       used in FreeBSD, NetBSD, OpenBSD supported as read-write
+
+	**ufs2**        used in FreeBSD 5.x supported as read-write
+
+	**5xbsd**       synonym for ufs2
+
+	**sun**         used in SunOS (Solaris)	supported as read-write
+
+	**sunx86**      used in SunOS for Intel (Solarisx86) supported as read-write
+
+	**hp**  used in HP-UX supported as read-only
+
+	**nextstep**    used in NextStep supported as read-only
+
+	**nextstep-cd** 	used for NextStep CDROMs (block_size == 2048) supported as read-only
+
+	**openstep**    used in OpenStep supported as read-only
+
+
+POSSIBLE PROBLEMS
+-----------------
+
+See next section, if you have any.
+
+
+BUG REPORTS
+-----------
+
+Any ufs bug report you can send to daniel.pirkl@email.cz or
+to dushistov@mail.ru (do not send partition tables bug reports).
diff --git a/Documentation/filesystems/ufs.txt b/Documentation/filesystems/ufs.txt
deleted file mode 100644
index 7a602ad..0000000
--- a/Documentation/filesystems/ufs.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-USING UFS
-=========
-
-mount -t ufs -o ufstype=type_of_ufs device dir
-
-
-UFS OPTIONS
-===========
-
-ufstype=type_of_ufs
-	UFS is a file system widely used in different operating systems.
-	The problem are differences among implementations. Features of
-	some implementations are undocumented, so its hard to recognize
-	type of ufs automatically. That's why user must specify type of 
-	ufs manually by mount option ufstype. Possible values are:
-
-	old	old format of ufs
-		default value, supported as read-only
-
-	44bsd	used in FreeBSD, NetBSD, OpenBSD
-		supported as read-write
-
-	ufs2    used in FreeBSD 5.x
-		supported as read-write
-
-	5xbsd	synonym for ufs2
-
-	sun	used in SunOS (Solaris)
-		supported as read-write
-
-	sunx86	used in SunOS for Intel (Solarisx86)
-		supported as read-write
-
-	hp	used in HP-UX
-		supported as read-only
-
-	nextstep
-		used in NextStep
-		supported as read-only
-
-	nextstep-cd
-		used for NextStep CDROMs (block_size == 2048)
-		supported as read-only
-
-	openstep
-		used in OpenStep
-		supported as read-only
-
-
-POSSIBLE PROBLEMS
-=================
-
-See next section, if you have any.
-
-
-BUG REPORTS
-===========
-
-Any ufs bug report you can send to daniel.pirkl@email.cz or
-to dushistov@mail.ru (do not send partition tables bug reports).
-- 
2.7.4

