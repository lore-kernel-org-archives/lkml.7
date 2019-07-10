Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC04C73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 03:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFAC2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 03:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/6ObEsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfGJDZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 23:25:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45020 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfGJDZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 23:25:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so360989pfe.11;
        Tue, 09 Jul 2019 20:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=15M7WtsSmQl2ff1icum2yjGhSPOxTksf56SOBnOQIjo=;
        b=b/6ObEsHY/DVy/UVBK+q8Hpl1DC+wb4ckyoA/WVfMgoVSOA0mKm9aEdGQXWCp0kQdO
         mSV/fQCu8ilEg2AWjEftgS9jyJN8VK/ObTvdIKJb89/J9BtS7hCeLADH7K/Ojv8KP7Q0
         Ihvi+evIgxeY5Cwzbs9W+ITvmZ0wBBgLrL8HXwkBWvRxfAeooycV9KiIBq5adtIWzQ+S
         ZUnoF/6Mu8ZifUskgrBn9TVYFKA3oebIAwVC1PAdfjDrog49hIzxDXtNkHBAR5G32tWF
         pu/YJT6KB53hSM2lfWOyxRwnZZmmZQKZmAiXGhUI8kh7kM6IEEM4ZQTk7zLt3v/cF3aw
         9A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=15M7WtsSmQl2ff1icum2yjGhSPOxTksf56SOBnOQIjo=;
        b=LfZCGYiRA/fs41ORSpOQuP+uJr/cQnJXIFga8rGenHLtmobsmsmTrpB46OG4FyQ+vF
         FJ5RVpa31RuZMPq/NtnTpbyoAjaSc5W7CeJoKv9OsfMEUQe5NGdUkSntDTNvoUCpOSW7
         iMsJyME/hNTCU+fJfwSB643Ao60WNgP7Kh9n49+MPXrbthjMLcJRuB4rB/JAqTCNhGmv
         wjBFna9ddVKTbqbx2XTvl6EaIoBGr8jle/CeSIXCnhrey59hMQGIpeXOmubMbHDL265B
         Hk1iMVC7SqkOSAvSpY1ribb21/cZGIV75osTBil0paAzx58Hf3JKuYjLnZU/RQc/sA9Q
         8iNw==
X-Gm-Message-State: APjAAAVho0ooG1ujffntTItzzEcK8viRxQtnIyoFrfzkaP3zwgJZA8WX
        oil6hUQOoG3CO2RdoyiFa3j1g8pM5M8=
X-Google-Smtp-Source: APXvYqwhNGncyF/X54VTPqKF4dc6/bWvETlP0smj9mmziDh9oZGzb2vSDT9HGLgGJtHX3e+9oz79Yw==
X-Received: by 2002:a63:231a:: with SMTP id j26mr33742246pgj.389.1562729154131;
        Tue, 09 Jul 2019 20:25:54 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id a1sm459002pfc.97.2019.07.09.20.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Jul 2019 20:25:53 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     willy@infradead.org, Jonathan Corbet <corbet@lwn.net>,
        skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH v2] Documentation: filesystems: Convert jfs.txt to
Date:   Tue,  9 Jul 2019 20:25:25 -0700
Message-Id: <1562729125-31475-1-git-send-email-shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190708195717.GG32320@bombadil.infradead.org>
References: <20190708195717.GG32320@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation of jfs.txt to reStructuredText format.
Added to documentation build process and verified with make htmldocs

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
Changes in v2:
        1. Removed flat-table.
        2. Moved jfs.rst from filesystem to admin-guide

 Documentation/admin-guide/index.rst |  1 +
 Documentation/admin-guide/jfs.rst   | 50 +++++++++++++++++++++++++++++++++++
 Documentation/filesystems/jfs.txt   | 52 -------------------------------------
 3 files changed, 51 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/admin-guide/jfs.rst
 delete mode 100644 Documentation/filesystems/jfs.txt

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 8001917..2871b79 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -70,6 +70,7 @@ configure specific aspects of kernel behavior to your liking.
    ras
    bcache
    ext4
+   jfs
    pm/index
    thunderbolt
    LSM/index
diff --git a/Documentation/admin-guide/jfs.rst b/Documentation/admin-guide/jfs.rst
new file mode 100644
index 0000000..a0a95e5
--- /dev/null
+++ b/Documentation/admin-guide/jfs.rst
@@ -0,0 +1,50 @@
+===========================================
+IBM's Journaled File System (JFS) for Linux
+===========================================
+
+JFS Homepage:  `<http://jfs.sourceforge.net/>`_
+
+The following mount options are supported:
+(*) == default
+
+**iocharset=name**      Character set to use for converting from Unicode to ASCII. The default is to do no conversion.
+
+**iocharset=utf8**      Use for UTF-8 translations. This requires CONFIG_NLS_UTF8 to be set in the kernel .config file.
+
+**iocharset=none**      specifies the default behavior explicitly.
+
+**resize=value**        Resize the volume to <value> blocks. JFS only supports growing a volume, not shrinking it.
+This option is only valid during a remount, when the volume is mounted read-write. The resize keyword with no value 
+will grow the volume to the full size of the partition.
+
+
+**nointegrity**	        Do not write to the journal. The primary use of this option is to allow for higher performance 
+when restoring a volume from backup media. The integrity of the volume is not guaranteed if the system abnormally abends.
+
+**integrity(*)**	Commit metadata changes to the journal. Use this option to remount a volume where the nointegrity 
+option was previously specified in order to restore normal behavior.
+
+**errors=continue**	Keep going on a filesystem error.
+
+**errors=remount-ro(*)**	Remount the filesystem read-only on an error.
+
+**errors=panic**	Panic and halt the machine if an error occurs.
+
+**uid=value**	Override on-disk uid with specified value
+
+**gid=value**	Override on-disk gid with specified value
+
+**umask=value**	Override on-disk umask with specified octal value. For directories, the execute bit will be set if the 
+corresponding  read bit is set.
+
+**discard=minlen, discard, nodiscard(*)**
+
+This enables/disables the use of discard/TRIM commands. The discard/TRIM 
+commands are sent to the underlying block device when blocks are freed. This is useful for SSD devices and 
+sparse/thinly-provisioned LUNs. The FITRIM ioctl command is also available together with the nodiscard option.
+The value of minlen specifies the minimum blockcount, when a TRIM command to the block device is considered useful.
+When no value is given to the discard option, it defaults to 64 blocks, which means 256KiB in JFS. The minlen value 
+of discard overrides the minlen value given on an FITRIM ioctl().
+
+The JFS mailing list can be subscribed to by using the link labeled
+"Mail list Subscribe" at our web page `<http://jfs.sourceforge.net/>`_
diff --git a/Documentation/filesystems/jfs.txt b/Documentation/filesystems/jfs.txt
deleted file mode 100644
index 41fd757..0000000
--- a/Documentation/filesystems/jfs.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-IBM's Journaled File System (JFS) for Linux
-
-JFS Homepage:  http://jfs.sourceforge.net/
-
-The following mount options are supported:
-(*) == default
-
-iocharset=name	Character set to use for converting from Unicode to
-		ASCII.  The default is to do no conversion.  Use
-		iocharset=utf8 for UTF-8 translations.  This requires
-		CONFIG_NLS_UTF8 to be set in the kernel .config file.
-		iocharset=none specifies the default behavior explicitly.
-
-resize=value	Resize the volume to <value> blocks.  JFS only supports
-		growing a volume, not shrinking it.  This option is only
-		valid during a remount, when the volume is mounted
-		read-write.  The resize keyword with no value will grow
-		the volume to the full size of the partition.
-
-nointegrity	Do not write to the journal.  The primary use of this option
-		is to allow for higher performance when restoring a volume
-		from backup media.  The integrity of the volume is not
-		guaranteed if the system abnormally abends.
-
-integrity(*)	Commit metadata changes to the journal.  Use this option to
-		remount a volume where the nointegrity option was
-		previously specified in order to restore normal behavior.
-
-errors=continue		Keep going on a filesystem error.
-errors=remount-ro(*)	Remount the filesystem read-only on an error.
-errors=panic		Panic and halt the machine if an error occurs.
-
-uid=value	Override on-disk uid with specified value
-gid=value	Override on-disk gid with specified value
-umask=value	Override on-disk umask with specified octal value.  For
-		directories, the execute bit will be set if the corresponding
-		read bit is set.
-
-discard=minlen	This enables/disables the use of discard/TRIM commands.
-discard		The discard/TRIM commands are sent to the underlying
-nodiscard(*)	block device when blocks are freed. This is useful for SSD
-		devices and sparse/thinly-provisioned LUNs.  The FITRIM ioctl
-		command is also available together with the nodiscard option.
-		The value of minlen specifies the minimum blockcount, when
-		a TRIM command to the block device is considered useful.
-		When no value is given to the discard option, it defaults to
-		64 blocks, which means 256KiB in JFS.
-		The minlen value of discard overrides the minlen value given
-		on an FITRIM ioctl().
-
-The JFS mailing list can be subscribed to by using the link labeled
-"Mail list Subscribe" at our web page http://jfs.sourceforge.net/
-- 
2.7.4

